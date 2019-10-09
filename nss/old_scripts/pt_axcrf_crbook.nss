//Скрипт генерирования книги с рецептами

#include "pt_axcrf_include"



const int pt_CRFPERFOMANCE_MAXITEMS_IN_SCRIPT=30;
const float pt_CRFPERFOMANCE_MAXTIME_OF_SCRIPT=1.0;


void main()
{
    int i, k, l, m, z;

    object oModule=GetModule();
    object oCaller=OBJECT_SELF;

    object oPC = GetLocalObject(oCaller, "pt_CRAFT_BOOKGEN_USER");
    if(oPC == OBJECT_INVALID)
    {oPC=GetLastOpenedBy();SetLocalObject(oCaller, "pt_CRAFT_BOOKGEN_USER", oPC);};

    //Скилы на которые генерируем книжки
    string sSkillsForGen=GetLocalString(oCaller, "pt_CRAFT_SKILLS_FOR_BOOKGEN");

    //Квантование и границы
    //Сколько итемов в модуле не вызовут краша скрипта. по столько и анализируем
    int iBeginItem=GetLocalInt(oPC, "pt_craft_BeginAnalisisNum");
    int iMaxIItem=GetLocalInt(oModule, "pt_CraftItemBoxArray_Length");

    //Индикация
    int iTen =  (iBeginItem*10)/iMaxIItem;
    SendMessageToPC(oPC, "*Автомат пыхтит и трясется, на табло появляется "+IntToString(iTen)+" / 10 делений*");

    // Неподвижность
    effect eCuImm=EffectCutsceneImmobilize();
    eCuImm=ExtraordinaryEffect(eCuImm);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCuImm, oPC, pt_CRFPERFOMANCE_MAXTIME_OF_SCRIPT+0.05);


    //Квантование //////////////////////////////////////////
    for(i=iBeginItem; i<iMaxIItem; i++)
        {
        string sI=IntToString(i);

        //Если превысили лимит итемов за один ход скрипта
        if(i>=iBeginItem+pt_CRFPERFOMANCE_MAXITEMS_IN_SCRIPT)
            {
            //debug
            //SendMessageToPC(GetFirstPC(), "Анализировались позиции " + IntToString(iBeginItem) + " - " + IntToString(iMaxIItem));

            iBeginItem=iBeginItem+pt_CRFPERFOMANCE_MAXITEMS_IN_SCRIPT;
            SetLocalInt(oPC, "pt_craft_BeginAnalisisNum", iBeginItem);


            DelayCommand(pt_CRFPERFOMANCE_MAXTIME_OF_SCRIPT+0.01, ExecuteScript("pt_axcrf_crbook", oCaller));

            return;
            };

        //Итем
        object oCrfTit=GetLocalObject(oModule, "pt_CraftItemBoxArray"+sI);
        if(!GetIsObjectValid(oCrfTit)) continue;

        //Для каждого запрошенного навыка создадим книжку
        for(z=0; z<pArrayLength(sSkillsForGen); z++)
            {
            string sCreateSkill=pArray(sSkillsForGen, z);

            string sSkills=GetLocalString(oCrfTit, "pt_CRAFT_SKILL_ID");
            if(pArray(sSkills, 0)!=sCreateSkill) continue;   //Если основной(первый) Скилл не тот по котрому генерируется книжка то пропустим
            string sSkillsVal=GetLocalString(oCrfTit, "pt_CRAFT_SKILL_VALUE");


            string sRaws=GetLocalString(oCrfTit, "pt_CRAFT_RAW");
            if(sRaws=="") continue; //Если предмет не трубует сырья для производства - то пропустим
            string sRawsCost=GetLocalString(oCrfTit, "pt_CRAFT_RAW_COST");

            string sTools=GetLocalString(oCrfTit, "pt_CRAFT_TOOL");

            string sSkills1=sSkills;
            string sRaws1=sRaws;
            string sTools1=sTools;


            //Величины навыков человеческим языком
            for(k=0; k<pArrayLength(sSkills); k++)
                {
                string sTag=pArray(sSkills, k);
                string sCost=pArray(sSkillsVal, k);

                sSkills1=pGetStringReplace(sSkills1, sTag, sTag+" "+sCost);
                };


            //Инструменты человеческим языком
            for(k=0; k<pArrayLength(sTools); k++)
                {
                string sTag=pArray(sTools, k);
                object oTool = GetObjectByTag(sTag);

                if(!GetIsObjectValid(oTool)) continue;

                string sWord=GetName(oTool);

                sTools1=pGetStringReplace(sTools1, sTag, sWord);
                };
            sTools1=pGetStringReplace(sTools1, ",", ", ");
            sTools1=pGetStringReplace(sTools1, " [Крафт]", "");


            //Сырье человеческим языком
            for(k=0; k<pArrayLength(sRaws); k++)
                {
                string sTag=pArray(sRaws, k);
                string sCost=pArray(sRawsCost, k);
                string sWord=pTagDictGetWord(sTag);

                if(sCost=="-1")
                    {
                    sRaws1=pGetStringReplace(sRaws1, sTag, sWord);
                    }
                    else
                    {
                    sRaws1=pGetStringReplace(sRaws1, sTag, sWord + " " + sCost);
                    };
                };
            sRaws1=pGetStringReplace(sRaws1, ",", ", ");
            sRaws1=pGetStringReplace(sRaws1, " [Крафт]", "");


            //Строка
            int CurSkillNum=GetLocalInt(oModule, "pt_craft_gendescrN_" + sCreateSkill);
            CurSkillNum++;
            string somstr=
            "\n\n "
            +
            IntToString(CurSkillNum) + ". " + StringToRGBString(pGetStringReplace(GetName(oCrfTit), " [Крафт]", ""), "070")
            +
            StringToRGBString("\n Верстаки и инструменты: ", "720")
            +
            sTools1
            +
            StringToRGBString("\n Сырье: ", "720")
            +
            sRaws1
            +
            StringToRGBString("\n Значение навыка: ", "720")
            +
            sSkills1
            +
            StringToRGBString(" Легкость получения: ", "722")
            +
            IntToString(GetLocalInt(oCrfTit, "pt_CRAFT_PROCESS_CHANCE")) + "%"
            ;
            ///
            SetLocalInt(oModule, "pt_craft_gendescrN_" + sCreateSkill, CurSkillNum);
            SetLocalString(oModule, "pt_craft_gendescr_" + sCreateSkill,  GetLocalString(oModule, "pt_craft_gendescr_" + sCreateSkill) + somstr) ;
            };
        };//-конец цикла




    ////Последний кусок
    if(iBeginItem+pt_CRFPERFOMANCE_MAXITEMS_IN_SCRIPT>=iMaxIItem)
        {
        DeleteLocalInt(oPC, "pt_craft_BeginAnalisisNum"); //Сброс текущего шага итемов

        //По какому навыку генерируем книжку для генератора
        for(z=0; z<pArrayLength(sSkillsForGen); z++)
            {
            string sCreateSkill=pArray(sSkillsForGen, z);

            string sBuffer=GetLocalString(oModule, "pt_craft_gendescr_"+sCreateSkill);
            int iBuf=0, iSumBuf=0, iAllLen=GetStringLength(sBuffer), iBookNum=0;

            //Буффер на книгу 7000 символов, обрыв только по \n\n
            while( sBuffer!="" )
                {
                object oBook=CreateItemOnObject("pt_axcrf_it040", oCaller, 1, "pt_axcrf_BookOfSkills"+IntToString(z));

                iBookNum++;
                iBuf=FindSubString(sBuffer, "\n\n " , 7000);

                iSumBuf+=iBuf;
                sBuffer=GetStringLeft(sBuffer, (iBuf<=-1)?GetStringLength(sBuffer):iBuf);
                if(iBuf<=-1) iSumBuf=iAllLen;

                SetName(oBook, pGetStringReplace(GetName(oBook), "%DYNAMIC_NAME%", sCreateSkill + " т." + IntToString(iBookNum)));
                SetDescription(oBook, pGetStringReplace(GetDescription(oBook), "%DYNAMIC_DESC%",  sBuffer));
                SetLocalString(oBook, "pt_CRAFT_SKILL_OF_BOOK", sCreateSkill);

                if(sBuffer!="") sBuffer=GetStringRight(GetLocalString(oModule, "pt_craft_gendescr_"+sCreateSkill), iAllLen-iSumBuf);
                };


            DeleteLocalInt(oModule, "pt_craft_gendescrN_" + sCreateSkill);
            DeleteLocalString(oModule, "pt_craft_gendescr_"+sCreateSkill);
            };

        DeleteLocalObject(oCaller, "pt_CRAFT_BOOKGEN_USER");
        return ;
        };




}
