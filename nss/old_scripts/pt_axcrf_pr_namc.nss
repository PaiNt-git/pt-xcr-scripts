//Процесс производства. развитие скилов зависит от уровня. Если навык не больше равен значению в итеме - процесс неудачен в 90% случаев минимум.

#include "pt_axcrf_include"

//Константы ограничений навыков за уровень
const string pt_SKILL_LEVEL_ROW =  "000 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040" ;
const string pt_SKILL_LIMITS_ROW = "002 003 004 005 008 010 012 015 016 018 020 022 025 030 032 035 040 045 050 055 060 065 070 075 080 085 090 092 092 096 100 110 120 130 140 150 160 170 180 190 200" ;


void pt_CreateItemNAMC(object oActivator, object oItem)
{
    if(!GetLocalInt(oActivator, "pt_curCraftProcess_Mode")) return;
    if(!pt_HasAllCraftConditions(oActivator,  oItem)) return;
    if(!pt_HasRaw(oActivator,  oItem)) return;

    //debug
//    FloatingTextStringOnCreature(pt_SKILL_LEVEL_ROW, oActivator, FALSE);
    //debug
//    FloatingTextStringOnCreature(pt_SKILL_LIMITS_ROW, oActivator, FALSE);


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


        //Значение навыка для процесса
        string sItSkillVal=pArray(sSkillsVal, iValI);
        float fItSkillVal=StringToFloat(sItSkillVal);

        //Бонусы и значения этого навыка у активатора
        float fBonPen=GetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_DMbonpen");
        float fActivatorSkill=GetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_value")+fBonPen;

        //Переменный для итема коэффициент успешности. Определяется отношениями навыков крафтера
        //к соответствующим навыкам процесса
        fK*=(fActivatorSkill/(fItSkillVal+0.01));
        if(fActivatorSkill<fItSkillVal && fK>0.10) fK=0.10; //Если навык меньше чем требуемый, но более 10%, то всего 10% шанса на успех


        /////////////////////////////Skill
        //Увеличение скила, общая идея такая - от одного процесса (применительно к максимальной границе 100.0)
        //который требует 15.0 значений навыка можно развивать навык гдето до ~17.0 (+ 1/8 от 15.0)
        //Еще учитывается "общая сложность" системы крафта на шарде, однако значение повышения не может быть больше 0.15
        float fSkillInc=(fabs(100.0-(fActivatorSkill-fBonPen))/(IntToFloat(iMaxItem)+0.01)+0.01) * (IntToFloat(d6())/IntToFloat(d4()));
        //debug
//        FloatingTextStringOnCreature("Навык повышение1.." + FloatToString(fSkillInc), oActivator, FALSE);


        fSkillInc = fSkillInc>0.15?0.15:fSkillInc;
        //debug
//        FloatingTextStringOnCreature("Навык повышение2.." + FloatToString(fSkillInc), oActivator, FALSE);


        //////////////////////////////
        //Вычисляем лимит скила (прокачиваемого) исходя из уровня
        int iLimitsLen = pArrayLength(pt_SKILL_LIMITS_ROW, " ");   //Массив-константа
        float fSkillSkillLimit=0.0;
        //Перебор по значениям констант
        for(j=0; j<iLimitsLen; j++)
            {
            int iCurLimSkill = StringToInt(pArray(pt_SKILL_LEVEL_ROW, j, "*", " "));
            float fCurLimSkillLim = StringToFloat(pArray(pt_SKILL_LIMITS_ROW, j, "*", " "));

            if (iActivatorLevel>=iCurLimSkill) fSkillSkillLimit=fCurLimSkillLim; //Сравнение чарфайловского уровня с константным
            };
        if((fActivatorSkill-fBonPen)+fSkillInc > fSkillSkillLimit) FloatingTextStringOnCreature( "Необходимо повысить уровень чтобы продолжить развитие из крафтовых процессов..",   oActivator,   FALSE  );

        fSkillInc = ((fActivatorSkill-fBonPen)+fSkillInc > fSkillSkillLimit) ? fSkillSkillLimit-(fActivatorSkill-fBonPen) : fSkillInc;
        //debug
//        FloatingTextStringOnCreature("Навык повышение3.." + FloatToString(fSkillInc), oActivator, FALSE);

        fSkillInc = (fSkillInc<0.0) ? 0.0 : fSkillInc;
        //debug
//        FloatingTextStringOnCreature("Навык повышение4.." + FloatToString(fSkillInc), oActivator, FALSE);

        float fBackupInc=fSkillInc;
        //////////////////////////////



        //Навык не может увеличиваться от одного процесса вечно
        if((fActivatorSkill-fBonPen)+fSkillInc > fItSkillVal+((fItSkillVal<16.0)?16.0:fItSkillVal)/8.0)
            {
            fSkillInc=fSkillInc-(((fActivatorSkill-fBonPen)+fSkillInc)-(fItSkillVal+((fItSkillVal<16.0)?16.0:fItSkillVal)/8.0));
            };
        fSkillInc = (fSkillInc<0.005 && fSkillInc>0.0) ? 0.005 : fSkillInc ;



        //debug
//        FloatingTextStringOnCreature("Навык повышение5.." + FloatToString(fSkillInc), oActivator, FALSE);

        //Сообщим об этом
        if(fSkillInc<=0.0)
            {
            fSkillInc=0.0; fXPforCraft=0.0;
            FloatingTextStringOnCreature("Ваш навык стал слишком высок для полноценного обучения из этого процесса. ("+FloatToString((fActivatorSkill-fBonPen), 2, 3)+")", oActivator, FALSE);
            FloatingTextStringOnCreature("Вы не узнали ничего нового..", oActivator, FALSE);
            }
            else if(fSkillInc<=fBackupInc/4.0)
            {
            FloatingTextStringOnCreature("Ваш навык сложно улучшить с помощью этого процесса. Ваш навык '"+sSkillID+"' увеличился с "+FloatToString((fActivatorSkill-fBonPen), 2, 3)+" до "+FloatToString((fActivatorSkill-fBonPen)+fSkillInc, 2, 3), oActivator, FALSE);
            FloatingTextStringOnCreature(StringToRGBString("Вам сложно узнать что-то новое из этого процесса..", "700"), oActivator, FALSE);
            fXPforCraft*=0.5;
            }
            else if(fSkillInc<=fBackupInc/2.0)
            {
            FloatingTextStringOnCreature("Ваш навык нелегко улучшить с помощью этого процесса. Ваш навык '"+sSkillID+"' увеличился с "+FloatToString((fActivatorSkill-fBonPen), 2, 3)+" до "+FloatToString((fActivatorSkill-fBonPen)+fSkillInc, 2, 3), oActivator, FALSE);
            FloatingTextStringOnCreature(StringToRGBString("Вам нелегко узнать что-то новое из этого процесса..", "700"), oActivator, FALSE);
            fXPforCraft*=0.75;
            }
            else
            {
            FloatingTextStringOnCreature(StringToRGBString("Ваш навык '"+sSkillID+"' увеличился до "+FloatToString((fActivatorSkill-fBonPen)+fSkillInc, 2, 3), "070"), oActivator, FALSE);
            };


        //debug
//        FloatingTextStringOnCreature("Навык повышение6.." + FloatToString(fSkillInc), oActivator, FALSE);

        //
        FloatingTextStringOnCreature(StringToRGBString("Ваш запас сил "+FloatToString(fActivatorWeary, 2, 2), (fActivatorWeary<=25.00?"700":"070")), oActivator, FALSE);
        //
        SetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_value", (fActivatorSkill-fBonPen)+fSkillInc);
        //
        GiveXPToCreature(oActivator, FloatToInt(fXPforCraft));
        };



    //Исходы процесса
    pt_TakeRawFromPC(oActivator, oItem);
    if(pResponse(FloatToInt(IntToFloat(iChanceToCreate)*fK)))
        {
        int iMinQuant=GetLocalInt(oItem, "pt_CRAFT_MINQUANT");
        int iMaxQuant=GetLocalInt(oItem, "pt_CRAFT_MAXQUANT");
        int iQuant=iMinQuant+Random(1+iMaxQuant-iMinQuant);
        iQuant=(iQuant<1)?1:iQuant;

        int iQ; for(iQ=1; iQ<=iQuant; iQ++) {CopyItem(oItem, oActivator, TRUE);};
        }
        else
        {
        FloatingTextStringOnCreature(StringToRGBString("Ваших навыков оказалось недостаточно для успешного проведения этого процесса.", "700"), oActivator, FALSE);
        };


    //Очистка служебных переменных и локации
    pt_ClearVarsWhithNumuses(oActivator);
}






void pmainNAMC(int iIteraNum=1)
{
    object oModule=GetModule();
    object oActivator=OBJECT_SELF;
    object oSkin=SKIN_SupportGetSkin(oActivator);

    int iMode=GetLocalInt(oActivator, "pt_curCraftProcess_Mode");
    object oItem=GetLocalObject(oActivator, "pt_curCraftProcess_Object");


    int iChance=GetLocalInt(oItem, "pt_CRAFT_PROCESS_CHANCE");
    float fTime=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_TIME");
    fTime=(fTime<5.0?5.0:fTime);
    float fWeary=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_WEARY");
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
                DelayCommand(fTime, pt_CreateItemNAMC(oActivator, oItem));
                }
                else
                {
                SetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake", 1);
                DelayCommand(fTime, SetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake", 2));
                };
            //Обновление функции
            DelayCommand(pt_REFRATE, pmainNAMC(iIteraNum+1));
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



            //Расчет усталости на единицу времени обновления
            float fWearyPerRef=fWeary/(fTime/pt_REFRATE);

            float fActivatorWeary=GetLocalFloat(oSkin, "pt_craft_weary_value");

            fActivatorWeary-=fWearyPerRef;
            SetLocalFloat(oSkin, "pt_craft_weary_value", fActivatorWeary);




            //Проверка усталости и остальных условий и прерывание или продолжение процесса исходя из этого
            if(!pt_HasAllCraftConditions(oActivator,  oItem) || fActivatorWeary<0.0)
                {
                if(fActivatorWeary > 0.0) {FloatingTextStringOnCreature(StringToRGBString("Вы нарушили условия процесса.", "700"), oActivator, FALSE);} else{FloatingTextStringOnCreature(StringToRGBString("Вы совсем устали и не можете продолжать процесс пока не отдохнете.", "700"), oActivator, FALSE);};

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
                DelayCommand(pt_REFRATE, pmainNAMC(iIteraNum+1));
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
    pmainNAMC();
}
