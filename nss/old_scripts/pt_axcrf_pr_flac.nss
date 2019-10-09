//Процесс производства используя крафтовые скилы экзиса

#include "pt_axcrf_include"


const string pt_SKILL_VALUES_ROW = "00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25" ;
const string pt_SKILL_LIMITS_ROW = "05 10 15 18 20 22 25 27 30 35 40 45 50 55 60 65 70 75 80 85 90 95 97 98 99 100" ;


void pt_CreateItemFLAC(object oActivator, object oItem)
{
    if(!GetLocalInt(oActivator, "pt_curCraftProcess_Mode")) return;
    if(!pt_HasAllCraftConditions(oActivator,  oItem)) return;
    if(!pt_HasRaw(oActivator,  oItem)) return;


    float fWeary=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_WEARY");

    string sSkills=GetLocalString(oItem, "pt_CRAFT_SKILL_ID");
    int iSkillsLen=pArrayLength(sSkills);
    string sSkillsVal=GetLocalString(oItem, "pt_CRAFT_SKILL_VALUE");
    int iSkillsValLen=pArrayLength(sSkillsVal);
    string sRaws=GetLocalString(oItem, "pt_CRAFT_RAW");
    string sRawsCost=GetLocalString(oItem, "pt_CRAFT_RAW_COST");
    string sTools=GetLocalString(oItem, "pt_CRAFT_TOOL");

    int iChanceToCreate=GetLocalInt(oItem, "pt_CRAFT_PROCESS_CHANCE");
    float fK=1.0;



    //Обсчет повышения навыков и их повышение (повышение будет осуществляться только до определенных границ которые определяют константы выше)
    int i, j;
    int iMaxItem=GetLocalInt(GetModule(), "pt_CraftItemBoxArray_Length");
    object oSkin=SKIN_SupportGetSkin(oActivator);
    float fActivatorWeary=GetLocalFloat(oSkin, "pt_craft_weary_value");
    for(i=0; i<iSkillsLen; i++)
        {
        int iValI=(i<=(iSkillsValLen-1)?i:iSkillsValLen-1);
        string sSkillID=pArray(sSkills, i);
        sSkillID=GetStringLeft(sSkillID, 35);
        if(sSkillID=="") continue;
        int iActivatorSkill=0;
        //
        if (sSkillID==""){}//Соответствие наименований скилов в системе и их значений в чарлисте
        else if(sSkillID=="[SKILL] Плотник") {iActivatorSkill=GetSkillRank(41, oActivator);}
        else if(sSkillID=="[SKILL] Охотник") {iActivatorSkill=GetSkillRank(42, oActivator);}
        else if(sSkillID=="[SKILL] Фермер") {iActivatorSkill=GetSkillRank(43, oActivator);}
        else if(sSkillID=="[SKILL] Рыбак") {iActivatorSkill=GetSkillRank(44, oActivator);}
        else if(sSkillID=="[SKILL] Ювелир") {iActivatorSkill=GetSkillRank(45, oActivator);}
        else if(sSkillID=="[SKILL] Горняк") {iActivatorSkill=GetSkillRank(46, oActivator);}
        else if(sSkillID=="[SKILL] Моряк") {iActivatorSkill=GetSkillRank(47, oActivator);}
        else if(sSkillID=="[SKILL] Кузнец") {iActivatorSkill=GetSkillRank(48, oActivator);}
        else if(sSkillID=="[SKILL] Инженер/зодчий") {iActivatorSkill=GetSkillRank(49, oActivator);}
        else if(sSkillID=="[SKILL] Повар") {iActivatorSkill=GetSkillRank(50, oActivator);}
        else if(sSkillID=="[SKILL] Кожевник/портной") {iActivatorSkill=GetSkillRank(51, oActivator);}
        else if(sSkillID=="[SKILL] Учитель/наставник") {iActivatorSkill=GetSkillRank(52, oActivator);}
        else if(sSkillID=="[SKILL] Ловушки") {iActivatorSkill=GetSkillRank(22, oActivator);}
        else if(sSkillID=="[SKILL] Броня") {iActivatorSkill=GetSkillRank(25, oActivator);}
        else if(sSkillID=="[SKILL] Оружие") {iActivatorSkill=GetSkillRank(26, oActivator);}


        //Переменные, которые учитываются при начислении опыта и повышении навыков
        int iActivatorLevel=GetLevelByPosition(1, oActivator)+GetLevelByPosition(2, oActivator)+GetLevelByPosition(3, oActivator);
        float fActivatorLevel=IntToFloat(iActivatorLevel);
        int iCraftItemCost=GetGoldPieceValue(oItem);
        float fCraftItemCost=IntToFloat(iCraftItemCost);



        ///////////////////////////XP
        //Функция зависит от стоимости вещи и текущего уронвя крафтера
        //Общая идея такая - на первом уровне крафтер  может получить 25-500 очков опыта (500 это при стоимости предмета более 10к)
        //Далее с ростом уровня экспоненциально величина опыта уменьшается, вообщем значение 500(10к золотых) на 20м левеле трансформируется где-то в ~120
        //Если навык не может повысится у крафтера - то и опыт не дастся - совсем..
        float fXPforCraft=(((1000.0*(fActivatorLevel+0.5)-500.0)*0.05)/(pow(fActivatorLevel, 1.5))+1.0)*((fCraftItemCost/10000.0<1.0?1.0:fCraftItemCost/10000)-(fCraftItemCost/10000.0>10.0?fCraftItemCost/10000.0-10.0:1.0)+1.0)/2.0;
        ////////////////////////////



        string sItSkillVal=pArray(sSkillsVal, iValI);
        float fItSkillVal=StringToFloat(sItSkillVal);

        float fBonPen=GetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_DMbonpen");
        float fActivatorSkill=GetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_value")+fBonPen;

        //Переменный для итема коэффициент успешности. Определяется отношениями навыков крафтера
        //к соответствующим навыкам процесса
        fK*=(fActivatorSkill/(fItSkillVal+0.01));



        /////////////////////////////Skill
        //Увеличение скила, общая идея такая - от одного процесса (применительно к максимальной границе 100.0)
        //который требует 15.0 значений навыка можно развивать навык гдето до ~19.0
        //Еще учитывается "общая сложность" системы крафта на шарде, однако значение повышения не может быть меньше 0.25
        float fSkillInc=fabs(100.0-(fActivatorSkill-fBonPen))/(IntToFloat(iMaxItem)+0.01)+0.01;
        fSkillInc = fSkillInc>0.25?0.25:fSkillInc;


        //////////////////////////////
        //Вычисляем лимит скила (прокачиваемого) исходя из значения скила (в чарфайле)
        int iLimitsLen = pArrayLength(pt_SKILL_LIMITS_ROW, " ");   //Массив-константа
        float fSkillSkillLimit=0.0;
        for(j=0; j<iLimitsLen; j++)
            {
            int iCurLimSkill = StringToInt(pArray(pt_SKILL_VALUES_ROW, j, "*", " "));
            float fCurLimSkillLim = StringToFloat(pArray(pt_SKILL_LIMITS_ROW, j, "*", " "));

            if (iActivatorSkill>=iCurLimSkill) fSkillSkillLimit=fCurLimSkillLim; //Сравнение чарфайловского навыка с константным
            };
        if((fActivatorSkill-fBonPen)+fSkillInc > fSkillSkillLimit) FloatingTextStringOnCreature( "Необходимо повысить значение навыка при получении нового уровня чтобы продолжить развитие из крафтовых процессов..",   oActivator,   FALSE  );
        fSkillInc = ((fActivatorSkill-fBonPen)+fSkillInc > fSkillSkillLimit) ? fSkillSkillLimit-(fActivatorSkill-fBonPen) : fSkillInc;
        fSkillInc = (fSkillInc<0.0) ? 0.0 : fSkillInc;
        float fBackupInc=fSkillInc;
        //////////////////////////////



        //Навык не может увеличиваться от одного процесса вечно
        if(fActivatorSkill+fSkillInc > ((fItSkillVal<12.0)?12.0:fItSkillVal)+((fItSkillVal<12.0)?12.0:fItSkillVal)/4.0)
            {
            fSkillInc=fSkillInc-((fActivatorSkill+fSkillInc)-(((fItSkillVal<12.0)?12.0:fItSkillVal)+((fItSkillVal<12.0)?12.0:fItSkillVal)/4.0));
            };
        //Сообщим об этом
        if(fSkillInc<=0.0)
            {
            fSkillInc=0.0; fXPforCraft=0.0;
            //FloatingTextStringOnCreature("Ваш навык стал слишком высок для полноценного обучения из этого процесса. ("+FloatToString((fActivatorSkill-fBonPen), 2, 2)+")", oActivator, FALSE);
            FloatingTextStringOnCreature("Вы не узнали ничего нового..", oActivator, FALSE);
            }
            else if(fSkillInc<=fBackupInc/4.0)
            {
            //FloatingTextStringOnCreature("Ваш навык сложно улучшить с помощью этого процесса. Ваш навык '"+sSkillID+"' увеличился с "+FloatToString((fActivatorSkill-fBonPen), 2, 2)+" до "+FloatToString((fActivatorSkill-fBonPen)+fSkillInc, 2, 2), oActivator, FALSE);
            FloatingTextStringOnCreature(StringToRGBString("Вам сложно узнать что-то новое из этого процесса..", "700"), oActivator, FALSE);
            fXPforCraft*=0.5;
            }
            else if(fSkillInc<=fBackupInc/2.0)
            {
            //FloatingTextStringOnCreature("Ваш навык нелегко улучшить с помощью этого процесса. Ваш навык '"+sSkillID+"' увеличился с "+FloatToString((fActivatorSkill-fBonPen), 2, 2)+" до "+FloatToString((fActivatorSkill-fBonPen)+fSkillInc, 2, 2), oActivator, FALSE);
            FloatingTextStringOnCreature(StringToRGBString("Вам нелегко узнать что-то новое из этого процесса..", "700"), oActivator, FALSE);
            fXPforCraft*=0.75;
            }
            else
            {
            FloatingTextStringOnCreature(StringToRGBString("Ваш навык '"+sSkillID+"' увеличился до "+FloatToString((fActivatorSkill-fBonPen)+fSkillInc, 2, 2), "070"), oActivator, FALSE);
            };
        //
        SetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_value", (fActivatorSkill-fBonPen)+fSkillInc);
        //
        GiveXPToCreature(oActivator, FloatToInt(fXPforCraft));
        };


    //Исходы процесса
    if(pResponse(FloatToInt(IntToFloat(iChanceToCreate)*fK)))
        {
        //FloatingTextStringOnCreature(StringToRGBString("Вы удачно провели процесс и получили ожидаемый результат.", "070"), oActivator, FALSE);

        int iMinQuant=GetLocalInt(oItem, "pt_CRAFT_MINQUANT");
        int iMaxQuant=GetLocalInt(oItem, "pt_CRAFT_MAXQUANT");
        int iQuant=iMinQuant+Random(1+iMaxQuant-iMinQuant);
        iQuant=(iQuant<1)?1:iQuant;

        //В flac версии сырье убирается только при удачном исходе
        pt_TakeRawFromPC(oActivator, oItem);
        int iQ; for(iQ=1; iQ<=iQuant; iQ++) {CopyItem(oItem, oActivator, TRUE);};
        }
        else
        {
        FloatingTextStringOnCreature(StringToRGBString("Ваших навыков оказалось недостаточно для успешного проведения этого процесса.", "700"), oActivator, FALSE);
        };


    //Очистка служебных переменных и локации
    pt_ClearVarsWhithNumuses(oActivator);

}










void pmainFLAC(int iIteraNum=1)
{
    object oModule=GetModule();
    object oActivator=OBJECT_SELF;
    object oSkin=SKIN_SupportGetSkin(oActivator);

    int iMode=GetLocalInt(oActivator, "pt_curCraftProcess_Mode");
    object oItem=GetLocalObject(oActivator, "pt_curCraftProcess_Object");


    int iChance=GetLocalInt(oItem, "pt_CRAFT_PROCESS_CHANCE");
    float fTime=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_TIME");
    fTime=(fTime<5.0?5.0:fTime);
    string sSkills=GetLocalString(oItem, "pt_CRAFT_SKILL_ID");
    string sSkillsVal=GetLocalString(oItem, "pt_CRAFT_SKILL_VALUE");
    string sRaws=GetLocalString(oItem, "pt_CRAFT_RAW");
    string sRawsCost=GetLocalString(oItem, "pt_CRAFT_RAW_COST");
    string sTools=GetLocalString(oItem, "pt_CRAFT_TOOL");


    if(iMode)
        {
        int iScriptMode=GetLocalInt(oActivator, "pt_curCraftProcess_ScriptMode");

        //
        if(!iScriptMode)  //Начальный режим
            {
            DeleteLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake");

            SetLocalInt(oActivator, "pt_curCraftProcess_ScriptMode", 1);

            SetLocalLocation(oActivator, "pt_craft_PClocation", GetLocation(oActivator));

            DeleteLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft");
            DelayCommand(fTime/2, SetLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft", 1));


            //Процесс исходя из индивидуальных особенностей всегда может фейкнуться вне зависимости от навыков
            if(pResponse(iChance))
                {
                DelayCommand(fTime, pt_CreateItemFLAC(oActivator, oItem));
                }
                else
                {
                SetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake", 1);
                DelayCommand(fTime, SetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake", 2));
                };
            //Обновление функции
            DelayCommand(pt_REFRATE, pmainFLAC(iIteraNum+1));
            return;
            }

            //
            else if(iScriptMode==1)  //Режим обновления
            {
            //Если прошло время фейкового процесса то прерываем его и сообщаем о провале
            if(GetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake")==2)
                {
                FloatingTextStringOnCreature(StringToRGBString("Печально, но по непонятным причинам процесс не удался.", "700"), oActivator, FALSE);
                pt_TakeRawFromPC(oActivator, oItem);
                DeleteLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake");

                DeleteLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft");
                //Очистка служебных переменных и локации
                pt_ClearVarsWhithNumuses(oActivator);
                return;
                };

            //Проверка усталости(не в данном(flac) случае) и остальных условий и прерывание или продолжение процесса исходя из этого
            if(!pt_HasAllCraftConditions(oActivator,  oItem))
                {
                FloatingTextStringOnCreature(StringToRGBString("Вы нарушили условия процесса.", "700"), oActivator, FALSE);


                if(GetLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft"))
                    {
                    //Если фейковый процесс - сообщить
                    if(GetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake"))
                        {
                        FloatingTextStringOnCreature(StringToRGBString("Печально, но по непонятным причинам процесс не удался.", "700"), oActivator, FALSE);
                        DeleteLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake");
                        };
                    //
                    pt_TakeRawFromPC(oActivator, oItem);
                    //
                    DeleteLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft");
                    };
                //Очистка служебных переменных и локации
                pt_ClearVarsWhithNumuses(oActivator);
                return;
                }
                else
                {
                //Обновление
                DelayCommand(pt_REFRATE, pmainFLAC(iIteraNum+1));
                return;
                };
            };
        };

}














void main()
{
    object oModule=GetModule();
    object oActivator=OBJECT_SELF;

    object oItem=GetLocalObject(oActivator, "pt_curCraftProcess_Object");
    float fTime=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_TIME");



    //if(iMode)
    //    {
    //    int iScriptMode=GetLocalInt(oActivator, "pt_curCraftProcess_ScriptMode");
    //    if(!iScriptMode)  //Begin mode
    //        {

    //Анимация для процесса
    PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, fTime);

    //        }
    //        else if(iScriptMode==1)  //Refresh mode
    //        {
    //        };
    //    };


    //Функция для процесса
    pmainFLAC();
}
