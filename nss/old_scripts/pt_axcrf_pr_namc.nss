//������� ������������. �������� ������ ������� �� ������. ���� ����� �� ������ ����� �������� � ����� - ������� �������� � 90% ������� �������.

#include "pt_axcrf_include"

//��������� ����������� ������� �� �������
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


        //�������� ������ ��� ��������
        string sItSkillVal=pArray(sSkillsVal, iValI);
        float fItSkillVal=StringToFloat(sItSkillVal);

        //������ � �������� ����� ������ � ����������
        float fBonPen=GetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_DMbonpen");
        float fActivatorSkill=GetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_value")+fBonPen;

        //���������� ��� ����� ����������� ����������. ������������ ����������� ������� ��������
        //� ��������������� ������� ��������
        fK*=(fActivatorSkill/(fItSkillVal+0.01));
        if(fActivatorSkill<fItSkillVal && fK>0.10) fK=0.10; //���� ����� ������ ��� ���������, �� ����� 10%, �� ����� 10% ����� �� �����


        /////////////////////////////Skill
        //���������� �����, ����� ���� ����� - �� ������ �������� (������������� � ������������ ������� 100.0)
        //������� ������� 15.0 �������� ������ ����� ��������� ����� ����� �� ~17.0 (+ 1/8 �� 15.0)
        //��� ����������� "����� ���������" ������� ������ �� �����, ������ �������� ��������� �� ����� ���� ������ 0.15
        float fSkillInc=(fabs(100.0-(fActivatorSkill-fBonPen))/(IntToFloat(iMaxItem)+0.01)+0.01) * (IntToFloat(d6())/IntToFloat(d4()));
        //debug
//        FloatingTextStringOnCreature("����� ���������1.." + FloatToString(fSkillInc), oActivator, FALSE);


        fSkillInc = fSkillInc>0.15?0.15:fSkillInc;
        //debug
//        FloatingTextStringOnCreature("����� ���������2.." + FloatToString(fSkillInc), oActivator, FALSE);


        //////////////////////////////
        //��������� ����� ����� (��������������) ������ �� ������
        int iLimitsLen = pArrayLength(pt_SKILL_LIMITS_ROW, " ");   //������-���������
        float fSkillSkillLimit=0.0;
        //������� �� ��������� ��������
        for(j=0; j<iLimitsLen; j++)
            {
            int iCurLimSkill = StringToInt(pArray(pt_SKILL_LEVEL_ROW, j, "*", " "));
            float fCurLimSkillLim = StringToFloat(pArray(pt_SKILL_LIMITS_ROW, j, "*", " "));

            if (iActivatorLevel>=iCurLimSkill) fSkillSkillLimit=fCurLimSkillLim; //��������� �������������� ������ � �����������
            };
        if((fActivatorSkill-fBonPen)+fSkillInc > fSkillSkillLimit) FloatingTextStringOnCreature( "���������� �������� ������� ����� ���������� �������� �� ��������� ���������..",   oActivator,   FALSE  );

        fSkillInc = ((fActivatorSkill-fBonPen)+fSkillInc > fSkillSkillLimit) ? fSkillSkillLimit-(fActivatorSkill-fBonPen) : fSkillInc;
        //debug
//        FloatingTextStringOnCreature("����� ���������3.." + FloatToString(fSkillInc), oActivator, FALSE);

        fSkillInc = (fSkillInc<0.0) ? 0.0 : fSkillInc;
        //debug
//        FloatingTextStringOnCreature("����� ���������4.." + FloatToString(fSkillInc), oActivator, FALSE);

        float fBackupInc=fSkillInc;
        //////////////////////////////



        //����� �� ����� ������������� �� ������ �������� �����
        if((fActivatorSkill-fBonPen)+fSkillInc > fItSkillVal+((fItSkillVal<16.0)?16.0:fItSkillVal)/8.0)
            {
            fSkillInc=fSkillInc-(((fActivatorSkill-fBonPen)+fSkillInc)-(fItSkillVal+((fItSkillVal<16.0)?16.0:fItSkillVal)/8.0));
            };
        fSkillInc = (fSkillInc<0.005 && fSkillInc>0.0) ? 0.005 : fSkillInc ;



        //debug
//        FloatingTextStringOnCreature("����� ���������5.." + FloatToString(fSkillInc), oActivator, FALSE);

        //������� �� ����
        if(fSkillInc<=0.0)
            {
            fSkillInc=0.0; fXPforCraft=0.0;
            FloatingTextStringOnCreature("��� ����� ���� ������� ����� ��� ������������ �������� �� ����� ��������. ("+FloatToString((fActivatorSkill-fBonPen), 2, 3)+")", oActivator, FALSE);
            FloatingTextStringOnCreature("�� �� ������ ������ ������..", oActivator, FALSE);
            }
            else if(fSkillInc<=fBackupInc/4.0)
            {
            FloatingTextStringOnCreature("��� ����� ������ �������� � ������� ����� ��������. ��� ����� '"+sSkillID+"' ���������� � "+FloatToString((fActivatorSkill-fBonPen), 2, 3)+" �� "+FloatToString((fActivatorSkill-fBonPen)+fSkillInc, 2, 3), oActivator, FALSE);
            FloatingTextStringOnCreature(StringToRGBString("��� ������ ������ ���-�� ����� �� ����� ��������..", "700"), oActivator, FALSE);
            fXPforCraft*=0.5;
            }
            else if(fSkillInc<=fBackupInc/2.0)
            {
            FloatingTextStringOnCreature("��� ����� ������� �������� � ������� ����� ��������. ��� ����� '"+sSkillID+"' ���������� � "+FloatToString((fActivatorSkill-fBonPen), 2, 3)+" �� "+FloatToString((fActivatorSkill-fBonPen)+fSkillInc, 2, 3), oActivator, FALSE);
            FloatingTextStringOnCreature(StringToRGBString("��� ������� ������ ���-�� ����� �� ����� ��������..", "700"), oActivator, FALSE);
            fXPforCraft*=0.75;
            }
            else
            {
            FloatingTextStringOnCreature(StringToRGBString("��� ����� '"+sSkillID+"' ���������� �� "+FloatToString((fActivatorSkill-fBonPen)+fSkillInc, 2, 3), "070"), oActivator, FALSE);
            };


        //debug
//        FloatingTextStringOnCreature("����� ���������6.." + FloatToString(fSkillInc), oActivator, FALSE);

        //
        FloatingTextStringOnCreature(StringToRGBString("��� ����� ��� "+FloatToString(fActivatorWeary, 2, 2), (fActivatorWeary<=25.00?"700":"070")), oActivator, FALSE);
        //
        SetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_value", (fActivatorSkill-fBonPen)+fSkillInc);
        //
        GiveXPToCreature(oActivator, FloatToInt(fXPforCraft));
        };



    //������ ��������
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
        FloatingTextStringOnCreature(StringToRGBString("����� ������� ��������� ������������ ��� ��������� ���������� ����� ��������.", "700"), oActivator, FALSE);
        };


    //������� ��������� ���������� � �������
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
                DelayCommand(fTime, pt_CreateItemNAMC(oActivator, oItem));
                }
                else
                {
                SetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake", 1);
                DelayCommand(fTime, SetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake", 2));
                };
            //���������� �������
            DelayCommand(pt_REFRATE, pmainNAMC(iIteraNum+1));
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



            //������ ��������� �� ������� ������� ����������
            float fWearyPerRef=fWeary/(fTime/pt_REFRATE);

            float fActivatorWeary=GetLocalFloat(oSkin, "pt_craft_weary_value");

            fActivatorWeary-=fWearyPerRef;
            SetLocalFloat(oSkin, "pt_craft_weary_value", fActivatorWeary);




            //�������� ��������� � ��������� ������� � ���������� ��� ����������� �������� ������ �� �����
            if(!pt_HasAllCraftConditions(oActivator,  oItem) || fActivatorWeary<0.0)
                {
                if(fActivatorWeary > 0.0) {FloatingTextStringOnCreature(StringToRGBString("�� �������� ������� ��������.", "700"), oActivator, FALSE);} else{FloatingTextStringOnCreature(StringToRGBString("�� ������ ������ � �� ������ ���������� ������� ���� �� ���������.", "700"), oActivator, FALSE);};

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

    //�������� ��� ��������
    PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, fTime);

    //        }
    //        else if(iScriptMode==1)  //Refresh mode
    //        {
    //        };
    //    };


    //������� ��� ��������
    pmainNAMC();
}
