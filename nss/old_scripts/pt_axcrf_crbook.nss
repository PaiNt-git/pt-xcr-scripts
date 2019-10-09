//������ ������������� ����� � ���������

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

    //����� �� ������� ���������� ������
    string sSkillsForGen=GetLocalString(oCaller, "pt_CRAFT_SKILLS_FOR_BOOKGEN");

    //����������� � �������
    //������� ������ � ������ �� ������� ����� �������. �� ������� � �����������
    int iBeginItem=GetLocalInt(oPC, "pt_craft_BeginAnalisisNum");
    int iMaxIItem=GetLocalInt(oModule, "pt_CraftItemBoxArray_Length");

    //���������
    int iTen =  (iBeginItem*10)/iMaxIItem;
    SendMessageToPC(oPC, "*������� ������ � ��������, �� ����� ���������� "+IntToString(iTen)+" / 10 �������*");

    // �������������
    effect eCuImm=EffectCutsceneImmobilize();
    eCuImm=ExtraordinaryEffect(eCuImm);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCuImm, oPC, pt_CRFPERFOMANCE_MAXTIME_OF_SCRIPT+0.05);


    //����������� //////////////////////////////////////////
    for(i=iBeginItem; i<iMaxIItem; i++)
        {
        string sI=IntToString(i);

        //���� ��������� ����� ������ �� ���� ��� �������
        if(i>=iBeginItem+pt_CRFPERFOMANCE_MAXITEMS_IN_SCRIPT)
            {
            //debug
            //SendMessageToPC(GetFirstPC(), "��������������� ������� " + IntToString(iBeginItem) + " - " + IntToString(iMaxIItem));

            iBeginItem=iBeginItem+pt_CRFPERFOMANCE_MAXITEMS_IN_SCRIPT;
            SetLocalInt(oPC, "pt_craft_BeginAnalisisNum", iBeginItem);


            DelayCommand(pt_CRFPERFOMANCE_MAXTIME_OF_SCRIPT+0.01, ExecuteScript("pt_axcrf_crbook", oCaller));

            return;
            };

        //����
        object oCrfTit=GetLocalObject(oModule, "pt_CraftItemBoxArray"+sI);
        if(!GetIsObjectValid(oCrfTit)) continue;

        //��� ������� ������������ ������ �������� ������
        for(z=0; z<pArrayLength(sSkillsForGen); z++)
            {
            string sCreateSkill=pArray(sSkillsForGen, z);

            string sSkills=GetLocalString(oCrfTit, "pt_CRAFT_SKILL_ID");
            if(pArray(sSkills, 0)!=sCreateSkill) continue;   //���� ��������(������) ����� �� ��� �� ������� ������������ ������ �� ���������
            string sSkillsVal=GetLocalString(oCrfTit, "pt_CRAFT_SKILL_VALUE");


            string sRaws=GetLocalString(oCrfTit, "pt_CRAFT_RAW");
            if(sRaws=="") continue; //���� ������� �� ������� ����� ��� ������������ - �� ���������
            string sRawsCost=GetLocalString(oCrfTit, "pt_CRAFT_RAW_COST");

            string sTools=GetLocalString(oCrfTit, "pt_CRAFT_TOOL");

            string sSkills1=sSkills;
            string sRaws1=sRaws;
            string sTools1=sTools;


            //�������� ������� ������������ ������
            for(k=0; k<pArrayLength(sSkills); k++)
                {
                string sTag=pArray(sSkills, k);
                string sCost=pArray(sSkillsVal, k);

                sSkills1=pGetStringReplace(sSkills1, sTag, sTag+" "+sCost);
                };


            //����������� ������������ ������
            for(k=0; k<pArrayLength(sTools); k++)
                {
                string sTag=pArray(sTools, k);
                object oTool = GetObjectByTag(sTag);

                if(!GetIsObjectValid(oTool)) continue;

                string sWord=GetName(oTool);

                sTools1=pGetStringReplace(sTools1, sTag, sWord);
                };
            sTools1=pGetStringReplace(sTools1, ",", ", ");
            sTools1=pGetStringReplace(sTools1, " [�����]", "");


            //����� ������������ ������
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
            sRaws1=pGetStringReplace(sRaws1, " [�����]", "");


            //������
            int CurSkillNum=GetLocalInt(oModule, "pt_craft_gendescrN_" + sCreateSkill);
            CurSkillNum++;
            string somstr=
            "\n\n "
            +
            IntToString(CurSkillNum) + ". " + StringToRGBString(pGetStringReplace(GetName(oCrfTit), " [�����]", ""), "070")
            +
            StringToRGBString("\n �������� � �����������: ", "720")
            +
            sTools1
            +
            StringToRGBString("\n �����: ", "720")
            +
            sRaws1
            +
            StringToRGBString("\n �������� ������: ", "720")
            +
            sSkills1
            +
            StringToRGBString(" �������� ���������: ", "722")
            +
            IntToString(GetLocalInt(oCrfTit, "pt_CRAFT_PROCESS_CHANCE")) + "%"
            ;
            ///
            SetLocalInt(oModule, "pt_craft_gendescrN_" + sCreateSkill, CurSkillNum);
            SetLocalString(oModule, "pt_craft_gendescr_" + sCreateSkill,  GetLocalString(oModule, "pt_craft_gendescr_" + sCreateSkill) + somstr) ;
            };
        };//-����� �����




    ////��������� �����
    if(iBeginItem+pt_CRFPERFOMANCE_MAXITEMS_IN_SCRIPT>=iMaxIItem)
        {
        DeleteLocalInt(oPC, "pt_craft_BeginAnalisisNum"); //����� �������� ���� ������

        //�� ������ ������ ���������� ������ ��� ����������
        for(z=0; z<pArrayLength(sSkillsForGen); z++)
            {
            string sCreateSkill=pArray(sSkillsForGen, z);

            string sBuffer=GetLocalString(oModule, "pt_craft_gendescr_"+sCreateSkill);
            int iBuf=0, iSumBuf=0, iAllLen=GetStringLength(sBuffer), iBookNum=0;

            //������ �� ����� 7000 ��������, ����� ������ �� \n\n
            while( sBuffer!="" )
                {
                object oBook=CreateItemOnObject("pt_axcrf_it040", oCaller, 1, "pt_axcrf_BookOfSkills"+IntToString(z));

                iBookNum++;
                iBuf=FindSubString(sBuffer, "\n\n " , 7000);

                iSumBuf+=iBuf;
                sBuffer=GetStringLeft(sBuffer, (iBuf<=-1)?GetStringLength(sBuffer):iBuf);
                if(iBuf<=-1) iSumBuf=iAllLen;

                SetName(oBook, pGetStringReplace(GetName(oBook), "%DYNAMIC_NAME%", sCreateSkill + " �." + IntToString(iBookNum)));
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
