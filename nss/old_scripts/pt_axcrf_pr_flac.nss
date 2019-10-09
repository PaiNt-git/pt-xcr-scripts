//������� ������������ ��������� ��������� ����� ������

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



    //������ ��������� ������� � �� ��������� (��������� ����� �������������� ������ �� ������������ ������ ������� ���������� ��������� ����)
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
        if (sSkillID==""){}//������������ ������������ ������ � ������� � �� �������� � ��������
        else if(sSkillID=="[SKILL] �������") {iActivatorSkill=GetSkillRank(41, oActivator);}
        else if(sSkillID=="[SKILL] �������") {iActivatorSkill=GetSkillRank(42, oActivator);}
        else if(sSkillID=="[SKILL] ������") {iActivatorSkill=GetSkillRank(43, oActivator);}
        else if(sSkillID=="[SKILL] �����") {iActivatorSkill=GetSkillRank(44, oActivator);}
        else if(sSkillID=="[SKILL] ������") {iActivatorSkill=GetSkillRank(45, oActivator);}
        else if(sSkillID=="[SKILL] ������") {iActivatorSkill=GetSkillRank(46, oActivator);}
        else if(sSkillID=="[SKILL] �����") {iActivatorSkill=GetSkillRank(47, oActivator);}
        else if(sSkillID=="[SKILL] ������") {iActivatorSkill=GetSkillRank(48, oActivator);}
        else if(sSkillID=="[SKILL] �������/������") {iActivatorSkill=GetSkillRank(49, oActivator);}
        else if(sSkillID=="[SKILL] �����") {iActivatorSkill=GetSkillRank(50, oActivator);}
        else if(sSkillID=="[SKILL] ��������/�������") {iActivatorSkill=GetSkillRank(51, oActivator);}
        else if(sSkillID=="[SKILL] �������/���������") {iActivatorSkill=GetSkillRank(52, oActivator);}
        else if(sSkillID=="[SKILL] �������") {iActivatorSkill=GetSkillRank(22, oActivator);}
        else if(sSkillID=="[SKILL] �����") {iActivatorSkill=GetSkillRank(25, oActivator);}
        else if(sSkillID=="[SKILL] ������") {iActivatorSkill=GetSkillRank(26, oActivator);}


        //����������, ������� ����������� ��� ���������� ����� � ��������� �������
        int iActivatorLevel=GetLevelByPosition(1, oActivator)+GetLevelByPosition(2, oActivator)+GetLevelByPosition(3, oActivator);
        float fActivatorLevel=IntToFloat(iActivatorLevel);
        int iCraftItemCost=GetGoldPieceValue(oItem);
        float fCraftItemCost=IntToFloat(iCraftItemCost);



        ///////////////////////////XP
        //������� ������� �� ��������� ���� � �������� ������ ��������
        //����� ���� ����� - �� ������ ������ �������  ����� �������� 25-500 ����� ����� (500 ��� ��� ��������� �������� ����� 10�)
        //����� � ������ ������ ��������������� �������� ����� �����������, ������� �������� 500(10� �������) �� 20� ������ ���������������� ���-�� � ~120
        //���� ����� �� ����� ��������� � �������� - �� � ���� �� ������ - ������..
        float fXPforCraft=(((1000.0*(fActivatorLevel+0.5)-500.0)*0.05)/(pow(fActivatorLevel, 1.5))+1.0)*((fCraftItemCost/10000.0<1.0?1.0:fCraftItemCost/10000)-(fCraftItemCost/10000.0>10.0?fCraftItemCost/10000.0-10.0:1.0)+1.0)/2.0;
        ////////////////////////////



        string sItSkillVal=pArray(sSkillsVal, iValI);
        float fItSkillVal=StringToFloat(sItSkillVal);

        float fBonPen=GetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_DMbonpen");
        float fActivatorSkill=GetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_value")+fBonPen;

        //���������� ��� ����� ����������� ����������. ������������ ����������� ������� ��������
        //� ��������������� ������� ��������
        fK*=(fActivatorSkill/(fItSkillVal+0.01));



        /////////////////////////////Skill
        //���������� �����, ����� ���� ����� - �� ������ �������� (������������� � ������������ ������� 100.0)
        //������� ������� 15.0 �������� ������ ����� ��������� ����� ����� �� ~19.0
        //��� ����������� "����� ���������" ������� ������ �� �����, ������ �������� ��������� �� ����� ���� ������ 0.25
        float fSkillInc=fabs(100.0-(fActivatorSkill-fBonPen))/(IntToFloat(iMaxItem)+0.01)+0.01;
        fSkillInc = fSkillInc>0.25?0.25:fSkillInc;


        //////////////////////////////
        //��������� ����� ����� (��������������) ������ �� �������� ����� (� ��������)
        int iLimitsLen = pArrayLength(pt_SKILL_LIMITS_ROW, " ");   //������-���������
        float fSkillSkillLimit=0.0;
        for(j=0; j<iLimitsLen; j++)
            {
            int iCurLimSkill = StringToInt(pArray(pt_SKILL_VALUES_ROW, j, "*", " "));
            float fCurLimSkillLim = StringToFloat(pArray(pt_SKILL_LIMITS_ROW, j, "*", " "));

            if (iActivatorSkill>=iCurLimSkill) fSkillSkillLimit=fCurLimSkillLim; //��������� �������������� ������ � �����������
            };
        if((fActivatorSkill-fBonPen)+fSkillInc > fSkillSkillLimit) FloatingTextStringOnCreature( "���������� �������� �������� ������ ��� ��������� ������ ������ ����� ���������� �������� �� ��������� ���������..",   oActivator,   FALSE  );
        fSkillInc = ((fActivatorSkill-fBonPen)+fSkillInc > fSkillSkillLimit) ? fSkillSkillLimit-(fActivatorSkill-fBonPen) : fSkillInc;
        fSkillInc = (fSkillInc<0.0) ? 0.0 : fSkillInc;
        float fBackupInc=fSkillInc;
        //////////////////////////////



        //����� �� ����� ������������� �� ������ �������� �����
        if(fActivatorSkill+fSkillInc > ((fItSkillVal<12.0)?12.0:fItSkillVal)+((fItSkillVal<12.0)?12.0:fItSkillVal)/4.0)
            {
            fSkillInc=fSkillInc-((fActivatorSkill+fSkillInc)-(((fItSkillVal<12.0)?12.0:fItSkillVal)+((fItSkillVal<12.0)?12.0:fItSkillVal)/4.0));
            };
        //������� �� ����
        if(fSkillInc<=0.0)
            {
            fSkillInc=0.0; fXPforCraft=0.0;
            //FloatingTextStringOnCreature("��� ����� ���� ������� ����� ��� ������������ �������� �� ����� ��������. ("+FloatToString((fActivatorSkill-fBonPen), 2, 2)+")", oActivator, FALSE);
            FloatingTextStringOnCreature("�� �� ������ ������ ������..", oActivator, FALSE);
            }
            else if(fSkillInc<=fBackupInc/4.0)
            {
            //FloatingTextStringOnCreature("��� ����� ������ �������� � ������� ����� ��������. ��� ����� '"+sSkillID+"' ���������� � "+FloatToString((fActivatorSkill-fBonPen), 2, 2)+" �� "+FloatToString((fActivatorSkill-fBonPen)+fSkillInc, 2, 2), oActivator, FALSE);
            FloatingTextStringOnCreature(StringToRGBString("��� ������ ������ ���-�� ����� �� ����� ��������..", "700"), oActivator, FALSE);
            fXPforCraft*=0.5;
            }
            else if(fSkillInc<=fBackupInc/2.0)
            {
            //FloatingTextStringOnCreature("��� ����� ������� �������� � ������� ����� ��������. ��� ����� '"+sSkillID+"' ���������� � "+FloatToString((fActivatorSkill-fBonPen), 2, 2)+" �� "+FloatToString((fActivatorSkill-fBonPen)+fSkillInc, 2, 2), oActivator, FALSE);
            FloatingTextStringOnCreature(StringToRGBString("��� ������� ������ ���-�� ����� �� ����� ��������..", "700"), oActivator, FALSE);
            fXPforCraft*=0.75;
            }
            else
            {
            FloatingTextStringOnCreature(StringToRGBString("��� ����� '"+sSkillID+"' ���������� �� "+FloatToString((fActivatorSkill-fBonPen)+fSkillInc, 2, 2), "070"), oActivator, FALSE);
            };
        //
        SetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_value", (fActivatorSkill-fBonPen)+fSkillInc);
        //
        GiveXPToCreature(oActivator, FloatToInt(fXPforCraft));
        };


    //������ ��������
    if(pResponse(FloatToInt(IntToFloat(iChanceToCreate)*fK)))
        {
        //FloatingTextStringOnCreature(StringToRGBString("�� ������ ������� ������� � �������� ��������� ���������.", "070"), oActivator, FALSE);

        int iMinQuant=GetLocalInt(oItem, "pt_CRAFT_MINQUANT");
        int iMaxQuant=GetLocalInt(oItem, "pt_CRAFT_MAXQUANT");
        int iQuant=iMinQuant+Random(1+iMaxQuant-iMinQuant);
        iQuant=(iQuant<1)?1:iQuant;

        //� flac ������ ����� ��������� ������ ��� ������� ������
        pt_TakeRawFromPC(oActivator, oItem);
        int iQ; for(iQ=1; iQ<=iQuant; iQ++) {CopyItem(oItem, oActivator, TRUE);};
        }
        else
        {
        FloatingTextStringOnCreature(StringToRGBString("����� ������� ��������� ������������ ��� ��������� ���������� ����� ��������.", "700"), oActivator, FALSE);
        };


    //������� ��������� ���������� � �������
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
        if(!iScriptMode)  //��������� �����
            {
            DeleteLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake");

            SetLocalInt(oActivator, "pt_curCraftProcess_ScriptMode", 1);

            SetLocalLocation(oActivator, "pt_craft_PClocation", GetLocation(oActivator));

            DeleteLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft");
            DelayCommand(fTime/2, SetLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft", 1));


            //������� ������ �� �������������� ������������ ������ ����� ���������� ��� ����������� �� �������
            if(pResponse(iChance))
                {
                DelayCommand(fTime, pt_CreateItemFLAC(oActivator, oItem));
                }
                else
                {
                SetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake", 1);
                DelayCommand(fTime, SetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake", 2));
                };
            //���������� �������
            DelayCommand(pt_REFRATE, pmainFLAC(iIteraNum+1));
            return;
            }

            //
            else if(iScriptMode==1)  //����� ����������
            {
            //���� ������ ����� ��������� �������� �� ��������� ��� � �������� � �������
            if(GetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake")==2)
                {
                FloatingTextStringOnCreature(StringToRGBString("��������, �� �� ���������� �������� ������� �� ������.", "700"), oActivator, FALSE);
                pt_TakeRawFromPC(oActivator, oItem);
                DeleteLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake");

                DeleteLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft");
                //������� ��������� ���������� � �������
                pt_ClearVarsWhithNumuses(oActivator);
                return;
                };

            //�������� ���������(�� � ������(flac) ������) � ��������� ������� � ���������� ��� ����������� �������� ������ �� �����
            if(!pt_HasAllCraftConditions(oActivator,  oItem))
                {
                FloatingTextStringOnCreature(StringToRGBString("�� �������� ������� ��������.", "700"), oActivator, FALSE);


                if(GetLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft"))
                    {
                    //���� �������� ������� - ��������
                    if(GetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake"))
                        {
                        FloatingTextStringOnCreature(StringToRGBString("��������, �� �� ���������� �������� ������� �� ������.", "700"), oActivator, FALSE);
                        DeleteLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake");
                        };
                    //
                    pt_TakeRawFromPC(oActivator, oItem);
                    //
                    DeleteLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft");
                    };
                //������� ��������� ���������� � �������
                pt_ClearVarsWhithNumuses(oActivator);
                return;
                }
                else
                {
                //����������
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

    //�������� ��� ��������
    PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, fTime);

    //        }
    //        else if(iScriptMode==1)  //Refresh mode
    //        {
    //        };
    //    };


    //������� ��� ��������
    pmainFLAC();
}
