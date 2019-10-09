//��� ������ �������

#include "aps_include"
#include "aps_include_co"

#include "pt_frame000"

#include "x3_inc_string"
#include "pt_axcrf_oveskin"

#include "pt_axcrf_md_cons"



/////////////////////////////////////////////////
/////////////////////////////////////////////////

//����
const int pt_CRAFT_USE_NWNX = TRUE ;

//��������� ��� ����������� ���������� � ��������� � ������� ������, �� ����� ������
const string pt_DBDUMP_MOD_ARRAY_NAME = "pt_DBDUMP_";
const int pt_DBDUMP_TYPE_UNDEFINED = -1;
const int pt_DBDUMP_TYPE_STRING = 0;
const int pt_DBDUMP_TYPE_INT = 1;
const int pt_DBDUMP_TYPE_FLOAT = 2;


/////////////////////////////////////////////////
/////////////////////////////////////////////////


//��������� ������� ���������� ��������
const float pt_REFRATE=1.0;

//��������� ������������������ ������
const int pt_CRFPERFOMANCE_MODULE_MAXBOX_IN_SCRIPT=1;
const float pt_CRFPERFOMANCE_MODULE_MAXTIME_OF_SCRIPT=1.5;

const int pt_CRFPERFOMANCE_ACTIVATE_MAXITEMS_IN_SCRIPT=125;
const float pt_CRFPERFOMANCE_ACTIVATE_MAXTIME_OF_SCRIPT=0.6;


/////////////////////////////////////////////////
/////////////////////////////////////////////////











//////////////////////////////////////////////////
// ����������� �������
//
//




////
////��������

//�������� ��� ���������� ������� ���� ����������� � ���� ��������� (� �� ����� ��������� �������),
//����� ���� ����������� ��������� ����� (� pt_TakeRawFromPC() � pt_CreateItem() ��� ������������)
void pt_ClearVarsWhithNumuses(object oActivator);

//�������� ���������� ������������ �������� (���������� ������ pt_REFRATE �.):
// 1. ������� ������������ (�������: �����, � ����-������, � ���������)
// 2. ��������� �� ��������� �������, � ������� ������ 5.0
// ����������: ����� ����������� ���� (������� ������������ ��� ���������� ������� ��������� ���������) - ��� ���� �� ��������������
int pt_HasAllCraftConditions(object oActivator,  object oItem);

//����������� �� pt_HasAllCraftConditions() �������� �����
int pt_HasRaw(object oActivator,  object oItem);

//������� ����� ��� ������������ oItem � ��������, ��� �� ��������� ����������� �����������, ���� ��� ����������(��������� ���������� �� PC).
void pt_TakeRawFromPC(object oActivator, object oItem, float fK=1.0);

//������� ��������� oItem � ��������� ��������, � �������� ������ �� "�����������" �����. "����������� �����" ����� ������������.
void pt_CreateItem(object oActivator, object oItem);

//�������� ������� ���������-������ �� "�����������" �����, ���� ��������� ��� ���������(pt_HasAllCraftConditions(), pt_TakeRawFromPC(), pt_CreateItem()) ����� ���������
void pmainDEFAULTPROC(int iIteraNum=1);





////
////SQL

//������� ���� ���� ���������� ��� ������� ����
void pCreateModuleVarNameDump(int iBeginItem=0);

//�������� ������ ����� ���� ���������� ��� ������� ����
int pGetModuleVarNameDumpLength();

//�������� ��� ��������� ���������� �� ������� � ����� ������
int pGetModuleVarNameDumpType(int iIndex=-1);

//�������� ��� ��������� ���������� �� ������� � ����� ������
string pGetModuleVarNameDumpString(int iIndex=-1);




////
////����������� ��� ��������

//����������� ������������
void pInitProgressBar(object oPlaceable, int iMax=100);

//����������� ������� ��������
void pSetProgressBar(object oPlaceable, int iCur=0);

//������ �����������
void pClearProgressBar(object oPlaceable);






////
////������

//�������� ���������� �� ����, �� ���� �����, ������������ ������ ���� � �����(� ���������
// �������) ����� ������ ���������� � ����� ��� ���������
void pRefreshCraftVars(object oItem);






////
////��������

//�������� ����� � ������� (���������� ������)
void pTagDictAddWord(string sTagKey, string sWord);

//�������� ����� �� �����
string pTagDictGetWord(string sTagKey);








//////////////////////////////////////////////////
//////////////////////////////////////////////////
// �������� �������
//////////////////////////////////////////////////



//������ ������� ������ ���������� �� ����
void pRefreshCraftVars(object oItem)
{
    if(GetObjectType(oItem)!=OBJECT_TYPE_ITEM) return;

    string sTools=GetLocalString(oItem, "pt_CRAFT_TOOL");

    if(sTools!="") return;

    string sSkills=GetLocalString(oItem, "pt_CRAFT_SKILL_ID");
    string sSkillsVal=GetLocalString(oItem, "pt_CRAFT_SKILL_VALUE");
    string sRaws=GetLocalString(oItem, "pt_CRAFT_RAW");
    string sRawsCost=GetLocalString(oItem, "pt_CRAFT_RAW_COST");

    float fWeary=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_WEARY");
    float fTime=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_TIME");


    int iChanceToCreate=GetLocalInt(oItem, "pt_CRAFT_PROCESS_CHANCE");
    int iMinQuant=GetLocalInt(oItem, "pt_CRAFT_MINQUANT");
    int iMaxQuant=GetLocalInt(oItem, "pt_CRAFT_MAXQUANT");

    string sScript=GetLocalString(oItem, "pt_CRAFT_PROCESS_PC_CUSTOM_SCRIPT");


    SQLExecDirect("SELECT * FROM `pt_axcrf_varimport` WHERE ID = '"+SQLEncodeSpecialChars(GetTag(oItem))+"' ; ");
    if(SQLFetch() == SQL_SUCCESS)
        {
        sTools=SQLGetData(2);

        sSkills=SQLGetData(3);
        sSkillsVal=SQLGetData(4);
        sRaws=SQLGetData(5);
        sRawsCost=SQLGetData(6);

        fWeary=StringToFloat(SQLGetData(7));
        fTime=StringToFloat(SQLGetData(8));


        iChanceToCreate=StringToInt(SQLGetData(9));
        iMinQuant=StringToInt(SQLGetData(10));
        iMaxQuant=StringToInt(SQLGetData(11));

        sScript=SQLGetData(12);



        SetLocalString(oItem, "pt_CRAFT_TOOL", sTools);

        SetLocalString(oItem, "pt_CRAFT_SKILL_ID", sSkills);
        SetLocalString(oItem, "pt_CRAFT_SKILL_VALUE", sSkillsVal);
        SetLocalString(oItem, "pt_CRAFT_RAW", sRaws);
        SetLocalString(oItem, "pt_CRAFT_RAW_COST", sRawsCost);

        SetLocalFloat(oItem, "pt_CRAFT_PROCESS_WEARY", fWeary);
        SetLocalFloat(oItem, "pt_CRAFT_PROCESS_TIME", fTime);

        SetLocalInt(oItem, "pt_CRAFT_PROCESS_CHANCE", iChanceToCreate);
        SetLocalInt(oItem, "pt_CRAFT_MINQUANT", iMinQuant);
        SetLocalInt(oItem, "pt_CRAFT_MAXQUANT", iMaxQuant);

        SetLocalString(oItem, "pt_CRAFT_PROCESS_PC_CUSTOM_SCRIPT", sScript);
        };
}
//����� ������� ������ ���������� �� ����






//������ ������� ������������
void pInitProgressBar(object oPlaceable, int iMax=100)
{
    int iOType=GetObjectType(oPlaceable);
    if(iOType!=OBJECT_TYPE_PLACEABLE && iOType!=OBJECT_TYPE_ITEM)  return;

    string kav=GetLocalString(GetModule(), "pt_kav");

    string sCraftMess = "\n" + "���������������� �������.." + "\n" + StringToRGBString("[==========]", "000");

    if(iOType==OBJECT_TYPE_PLACEABLE)
        {
        AssignCommand(oPlaceable, SpeakString(sCraftMess, TALKVOLUME_TALK));
        }
        else
        {
        FloatingTextStringOnCreature(sCraftMess, GetItemPossessor(oPlaceable));
        };

    SetLocalInt(oPlaceable, "pt_progressbarMax", iMax);
    SetLocalInt(oPlaceable, "pt_progressbarCur", 0);
}



void pSetProgressBar(object oPlaceable, int iCur=0)
{
    int iOType=GetObjectType(oPlaceable);
    if(iOType!=OBJECT_TYPE_PLACEABLE && iOType!=OBJECT_TYPE_ITEM)  return;

    string kav=GetLocalString(GetModule(), "pt_kav");

    int iMax=GetLocalInt(oPlaceable, "pt_progressbarMax");
    int iDiffPoints=iMax/10;

    int iPoints = (iDiffPoints==0)? 10 : (iCur/iDiffPoints);
    int iBlankPoints=10-iPoints;
    string sPoints="", sBlankPoints="";

    int i;
    if(iPoints>0) {for(i=1; i<=iPoints; i++) {sPoints+="=";}; };
    if(iBlankPoints>0) {for(i=1; i<=iBlankPoints; i++) {sBlankPoints+="=";}; };

    sPoints=StringToRGBString(sPoints, "070");
    sBlankPoints=StringToRGBString(sBlankPoints, "000");

    string sCraftMess = "\n" + "���������������� �������.." + "\n" + StringToRGBString("[", "070")+sPoints+sBlankPoints+StringToRGBString("]", "070");

    if(iOType==OBJECT_TYPE_PLACEABLE)
        {
        AssignCommand(oPlaceable, SpeakString(sCraftMess, TALKVOLUME_TALK));
        }
        else
        {
        FloatingTextStringOnCreature(sCraftMess, GetItemPossessor(oPlaceable));
        };


    SetLocalInt(oPlaceable, "pt_progressbarCur", iCur);
}



void pClearProgressBar(object oPlaceable)
{
    int iOType=GetObjectType(oPlaceable);
    if(iOType!=OBJECT_TYPE_PLACEABLE && iOType!=OBJECT_TYPE_ITEM)  return;

    string sName=GetName(oPlaceable);
    string sOrigName=GetName(oPlaceable, TRUE);

    DeleteLocalInt(oPlaceable, "pt_progressbarMax");
    DeleteLocalInt(oPlaceable, "pt_progressbarCur");
}
//����� ������� ������������










//������ ������� �������������� �������
void pCreateObjectInLocal(object oTarget, string sName, int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE, string sNewTag="")
{
    SetLocalObject(oTarget, sName, CreateObject(nObjectType, sTemplate, lLocation, bUseAppearAnimation, sNewTag));
}

void pClearDialogTokensVars(object oActivator)
{
    SetLocalInt(oActivator, "pt_craft_dialNodeArray_Length", 0);
    SetLocalInt(oActivator, "pt_craft_dialTok"+IntToString(pt_CUSTTOK_NODE_ONE)+"_Index", -1);
    SetLocalInt(oActivator, "pt_craft_dialTok"+IntToString(pt_CUSTTOK_NODE_TWO)+"_Index", -1);
    SetLocalInt(oActivator, "pt_craft_dialTok"+IntToString(pt_CUSTTOK_NODE_THREE)+"_Index", -1);
    SetLocalInt(oActivator, "pt_craft_dialTok"+IntToString(pt_CUSTTOK_NODE_FOUR)+"_Index", -1);
    SetLocalInt(oActivator, "pt_craft_dialTok"+IntToString(pt_CUSTTOK_NODE_FIVE)+"_Index", -1);
    SetCustomToken(pt_CUSTTOK_NODE_ONE, "");
    SetCustomToken(pt_CUSTTOK_NODE_TWO, "");
    SetCustomToken(pt_CUSTTOK_NODE_THREE, "");
    SetCustomToken(pt_CUSTTOK_NODE_FOUR, "");
    SetCustomToken(pt_CUSTTOK_NODE_FIVE, "");
    SetLocalInt(oActivator, "pt_craft_dialMinI", 0);
    SetLocalInt(oActivator, "pt_craft_dialMaxI", 0);
}

void pClearServiceVars(object oActivator)
{
    SetLocalInt(oActivator, "pt_craft_dialToolIsBook", FALSE);
    SetLocalInt(oActivator, "pt_craft_dialToolIsSkillStick", FALSE);
    SetLocalInt(oActivator, "pt_craft_dialToolIsToolTool", FALSE);

    SetLocalInt(oActivator, "pt_craft_dialToolIsRawCreateSp", FALSE);
    SetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeRawSp", FALSE);
    SetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeToolSp", FALSE);
    SetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeSkillSp", FALSE);
    SetLocalInt(oActivator, "pt_craft_dialToolIsRawCreateSkillSt", FALSE);
}
//����� ������� �������������� �������






//������ ������� ���������� ��������
void pt_ClearVarsWhithNumuses(object oActivator)
{
    //������� ��������� ���������� � �������
    DeleteLocalInt(oActivator, "pt_curCraftProcess_Mode");
    DeleteLocalInt(oActivator, "pt_curCraftProcess_ScriptMode");
    DeleteLocalLocation(oActivator, "pt_craft_PClocation");
    DeleteLocalInt(oActivator, "pt_scanRawInTool");

    DeleteLocalLocation(oActivator, "pt_craft_pcInventory_Length");
    DeleteLocalInt(oActivator, "pt_craft_toolInventory_Length");


    object  oCurTool=GetLocalObject(oActivator, "pt_ActTool");
    DeleteLocalObject(oActivator, "pt_ActTool");
    if(GetLocalInt(oCurTool, "pt_CRAFT_PROCESS_NUMUSE")!=0 && GetLocalInt(oCurTool, "pt_curCraftProcess_uses")>=GetLocalInt(oCurTool, "pt_CRAFT_PROCESS_NUMUSE"))
        {
        SetLocalObject(oActivator, "pt_ActTool", oCurTool);
        DelayCommand(0.3, ExecuteScript("pt_axcrf_activ", oActivator));
        };
}




//
int pt_HasAllCraftConditions(object oActivator,  object oItem)
{
    if(!GetLocalInt(oActivator, "pt_curCraftProcess_Mode")) return FALSE;


    float fWeary=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_WEARY");

    string sSkills=GetLocalString(oItem, "pt_CRAFT_SKILL_ID");
    string sSkillsVal=GetLocalString(oItem, "pt_CRAFT_SKILL_VALUE");
    string sRaws=GetLocalString(oItem, "pt_CRAFT_RAW");
    string sRawsCost=GetLocalString(oItem, "pt_CRAFT_RAW_COST");
    string sTools=GetLocalString(oItem, "pt_CRAFT_TOOL");


    int k;

        //�������� ������������
        if(sTools!="")
            {
            int iToolLen=pArrayLength(sTools);
            int bNotHasAllTool=FALSE;
            for(k=0; k<iToolLen; k++)
                {
                int bHasTool=FALSE;

                string sToolTag=pArray(sTools, k);

                object oPlaTool=GetNearestObjectByTag(sToolTag, oActivator); //����� � �����������
                if(GetIsObjectValid(oPlaTool) && GetObjectType(oPlaTool)!=OBJECT_TYPE_ITEM && GetDistanceBetween(oPlaTool, oActivator)<=10.0) { bHasTool=TRUE;};
                if(!bHasTool)
                    {
                    int iCurItemSlot=0;
                    object oActItem=GetItemInSlot(iCurItemSlot, oActivator);
                    while(!bHasTool && iCurItemSlot<=17) //� ������������� ������
                        {
                        if(GetTag(oActItem)==sToolTag) { bHasTool=TRUE; break;};

                        iCurItemSlot++; oActItem=GetItemInSlot(iCurItemSlot, oActivator);
                        };
                    if(!bHasTool)
                        {
                        oActItem=GetFirstItemInInventory(oActivator);
                        while(!bHasTool && GetIsObjectValid(oActItem)) //� ���������
                            {
                            if(GetTag(oActItem)==sToolTag) { bHasTool=TRUE; break;};

                            oActItem=GetNextItemInInventory(oActivator);
                            };
                        };
                    };

                if(!bHasTool) {bNotHasAllTool=TRUE; return FALSE;};
                };
            };




        //�������� ���������
        if(GetDistanceBetweenLocations(GetLocation(oActivator), GetLocalLocation(oActivator, "pt_craft_PClocation"))<=5.0)
            {
            return TRUE;
            };




    return FALSE;
}








//
int pt_HasRaw(object oActivator,  object oItem)
{
    if(!GetLocalInt(oActivator, "pt_curCraftProcess_Mode")) return FALSE;


    string sProcRaw=GetLocalString(oItem, "pt_CRAFT_RAW");
    string sProcRawCost=GetLocalString(oItem, "pt_CRAFT_RAW_COST");


    int k;

    ////�������� ������������ �����
    int bIsVendor = FALSE;
    object oTool=GetLocalObject(oActivator, "pt_ActTool");
    int bScanRawInToolInventory=GetLocalInt(oActivator, "pt_scanRawInTool");
    if (sProcRaw=="NW_IT_GOLD001") bIsVendor=TRUE;
    if (sProcRaw!="") //���� ������������ ����� � �������� ����� - �� ��� �������� �� ����� �������
        {
        string sProcActivatorRawValue="0";

        int iRawLen=pArrayLength(sProcRaw);
        int iRawCostLen=pArrayLength(sProcRawCost);

        int bNotHasAllRaw=FALSE;
        for(k=0; k<iRawLen; k++)
            {
            string sRawTag=pArray(sProcRaw, k);

            int bHasRaw=FALSE;
            if(bScanRawInToolInventory) //����������� ������� � ��������� �����������
                {
                int iToolItemArrayNum; string sToolItemArrayNum; int iToolItemArrayLenn=GetLocalInt(oActivator, "pt_craft_toolInventory_Length");
                for(iToolItemArrayNum=0; iToolItemArrayNum<iToolItemArrayLenn; iToolItemArrayNum++)
                    {
                    sToolItemArrayNum=IntToString(iToolItemArrayNum);

                    object oToolItem=GetLocalObject(oActivator, "pt_craft_toolInventory"+sToolItemArrayNum+"_Object");
                    if(GetIsObjectValid(oToolItem))
                        {
                        if(GetTag(oToolItem)==sRawTag && GetItemPossessor(oToolItem)==oTool)
                            {
                            int iToolItemRawVal=StringToInt(pArray(sProcActivatorRawValue, k));
                            iToolItemRawVal+=GetItemStackSize(oToolItem);
                            sProcActivatorRawValue=pArray(sProcActivatorRawValue, k, IntToString(iToolItemRawVal));
                            bHasRaw=TRUE;
                            };
                        };
                    };
                }
                else //����������� ������� � ��������� ����������
                {
                int iArrayNum; string sArrayNum; int iArrayLenn=GetLocalInt(oActivator, "pt_craft_pcInventory_Length");
                for(iArrayNum=0; iArrayNum<iArrayLenn; iArrayNum++)
                    {
                    sArrayNum=IntToString(iArrayNum);

                    object oActItem=GetLocalObject(oActivator, "pt_craft_pcInventory"+sArrayNum+"_Object");
                    if(GetIsObjectValid(oActItem))
                        {
                        if(GetTag(oActItem)==sRawTag && GetItemPossessor(oActItem)==oActivator)
                            {
                            int iActRawVal=StringToInt(pArray(sProcActivatorRawValue, k));
                            iActRawVal+=GetItemStackSize(oActItem);
                            sProcActivatorRawValue=pArray(sProcActivatorRawValue, k, IntToString(iActRawVal));
                            bHasRaw=TRUE;
                            };
                        };
                    };
                };
            if(!bHasRaw) {bNotHasAllRaw=TRUE; break;};
            };
        if(bNotHasAllRaw) return FALSE;


        ////�������� ���������� ����� � ������
        int bNotHasAllRawQuant=FALSE;
        for(k=0; k<iRawLen; k++)
            {
            int iCostK=(k<=(iRawCostLen-1)?k:iRawCostLen-1);

            int iCurRawCost=StringToInt(pArray(sProcRawCost, iCostK));
            int iCurRawHave=StringToInt(pArray(sProcActivatorRawValue, iCostK));

            if(iCurRawCost<0) iCurRawCost=1;

            if(iCurRawHave<iCurRawCost) {bNotHasAllRawQuant=TRUE; break;};
            };
        if(bNotHasAllRawQuant) return FALSE;
    };


    return TRUE;
}






































void pt_TakeRawFromPC(object oActivator, object oItem, float fK=1.0)
{
    if(!GetLocalInt(oActivator, "pt_curCraftProcess_Mode")) return;

    object oTool=GetLocalObject(oActivator, "pt_ActTool");
    int bScanRawInToolInventory=GetLocalInt(oActivator, "pt_scanRawInTool");

    string sRaws=GetLocalString(oItem, "pt_CRAFT_RAW");
    string sRawsCost=GetLocalString(oItem, "pt_CRAFT_RAW_COST");


    ////////////
    if(sRaws=="") //��� ���, �������� � �.�.
        {
        //������� ��������� ���������� � �������
        DelayCommand(1.0, pt_ClearVarsWhithNumuses(oActivator));
        return;
        };
    /////////////

    int i;
    int iRawsLen=pArrayLength(sRaws);
    int iRawsCostLen=pArrayLength(sRawsCost);


    //�������� ����� �� ��������� ��������
    for(i=0; i<iRawsLen; i++)
        {
        int iCostI=(i<=(iRawsCostLen-1)?i:iRawsCostLen-1);
        int iCurQuant=StringToInt(pArray(sRawsCost, iCostI));
        iCurQuant = FloatToInt(IntToFloat(iCurQuant)*fK);

        string sCurRawTag=pArray(sRaws, i);

        object iBox=oActivator;

        //���� ���������� �������� ���������
        if(bScanRawInToolInventory) iBox=oTool;

            object oActItem=GetFirstItemInInventory(iBox);
            while(GetIsObjectValid(oActItem))
                {
                if(GetTag(oActItem)==sCurRawTag)
                    {
                    if(iCurQuant>0)
                        {
                        int iItemStack=GetItemStackSize(oActItem);

                        if(iItemStack>iCurQuant) {SetItemStackSize(oActItem, iItemStack-iCurQuant);} else{DestroyObject(oActItem);};

                        int iDecr=(iItemStack>iCurQuant?iCurQuant:iItemStack);
                        iCurQuant-=iDecr;
                        };
                    };
                oActItem=GetNextItemInInventory(iBox);
                };
        };

    //������� ��������� ���������� � �������
    DelayCommand(1.0, pt_ClearVarsWhithNumuses(oActivator));
}





//
void pt_CreateItem(object oActivator, object oItem)
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



    //������ ��������� ������� � �� ���������
    int i;
    int iMaxItem=GetLocalInt(GetModule(), "pt_CraftItemBoxArray_Length");
    object oSkin=SKIN_SupportGetSkin(oActivator);
    float fActivatorWeary=GetLocalFloat(oSkin, "pt_craft_weary_value");
    for(i=0; i<iSkillsLen; i++)
        {
        int iValI=(i<=(iSkillsValLen-1)?i:iSkillsValLen-1);
        string sSkillID=pArray(sSkills, i);
        sSkillID=GetStringLeft(sSkillID, 35);
        if(sSkillID=="") continue;

        int iActivatorLevel=GetLevelByPosition(1, oActivator)+GetLevelByPosition(2, oActivator)+GetLevelByPosition(3, oActivator);
        float fActivatorLevel=IntToFloat(iActivatorLevel);
        int iCraftItemCost=GetGoldPieceValue(oItem);
        float fCraftItemCost=IntToFloat(iCraftItemCost);


        ///////////////////////////XP
        float fXPforCraft=(((1000.0*(fActivatorLevel+0.5)-500.0)*0.05)/(pow(fActivatorLevel, 1.5))+1.0)*((fCraftItemCost/10000.0<1.0?1.0:fCraftItemCost/10000)-(fCraftItemCost/10000.0>10.0?fCraftItemCost/10000.0-10.0:1.0)+1.0)/2.0;
        ////////////////////////////


        string sItSkillVal=pArray(sSkillsVal, iValI);
        float fItSkillVal=StringToFloat(sItSkillVal);

        float fBonPen=GetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_DMbonpen");
        float fActivatorSkill=GetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_value")+fBonPen;

        fK*=(fActivatorSkill/(fItSkillVal+0.01));


        /////////////////////////////Skill
        //���������� �����, ����� ���� ����� - �� ������ �������� (������������� � ������������ ������� 100.0)
        //������� ������� 15.0 �������� ������ ����� ��������� ����� ����� �� ~19.0
        //��� ����������� "����� ���������" ������� ������ �� �����, ������ �������� ��������� �� ����� ���� ������ 0.25
        float fSkillInc=fabs(100.0-(fActivatorSkill-fBonPen))/(IntToFloat(iMaxItem)+0.01)+0.01;
        fSkillInc=fSkillInc>0.25?0.25:fSkillInc;
        float fBackupInc=fSkillInc;
        //////////////////////////////


        //����� �� ����� ������������� �� ������ �������� �����
        if((fActivatorSkill-fBonPen)+fSkillInc > ((fItSkillVal<12.0)?12.0:fItSkillVal)+((fItSkillVal<12.0)?12.0:fItSkillVal)/4.0)
            {
            fSkillInc=fSkillInc-(((fActivatorSkill-fBonPen)+fSkillInc)-(((fItSkillVal<12.0)?12.0:fItSkillVal)+((fItSkillVal<12.0)?12.0:fItSkillVal)/4.0));
            fSkillInc = fSkillInc<0.005?0.005:fSkillInc; //����������� �������� - 5 ��������
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
        FloatingTextStringOnCreature(StringToRGBString("��� ����� ��� "+FloatToString(fActivatorWeary, 2, 2), (fActivatorWeary<=25.00?"700":"070")), oActivator, FALSE);
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

        int iQ; for(iQ=1; iQ<=iQuant; iQ++) {CopyItem(oItem, oActivator, TRUE);};
        }
        else
        {
        FloatingTextStringOnCreature(StringToRGBString("����� ������� ��������� ������������ ��� ��������� ���������� ����� ��������.", "700"), oActivator, FALSE);
        };

    //������� �����
    pt_TakeRawFromPC(oActivator, oItem);
}






void pmainDEFAULTPROC(int iIteraNum=1)
{
    object oModule=GetModule();
    object oActivator=OBJECT_SELF;
    object oSkin=SKIN_SupportGetSkin(oActivator);

    int iMode=GetLocalInt(oActivator, "pt_curCraftProcess_Mode");
    object oItem=GetLocalObject(oActivator, "pt_curCraftProcess_Object");

    //���������� �����
    int iChance=GetLocalInt(oItem, "pt_CRAFT_PROCESS_CHANCE");
    float fTime=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_TIME");
    fTime=(fTime<5.0?5.0:fTime);
    float fWeary=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_WEARY");
    string sSkills=GetLocalString(oItem, "pt_CRAFT_SKILL_ID");
    string sSkillsVal=GetLocalString(oItem, "pt_CRAFT_SKILL_VALUE");
    string sRaws=GetLocalString(oItem, "pt_CRAFT_RAW");
    string sRawsCost=GetLocalString(oItem, "pt_CRAFT_RAW_COST");
    string sTools=GetLocalString(oItem, "pt_CRAFT_TOOL");

    //���� �������� ������ ��� ��������� ��������
    if( iIteraNum > FloatToInt(fTime/pt_REFRATE) +5) {pt_ClearVarsWhithNumuses(oActivator); return;};



    ///////////
    if(iMode)// ����� ��������
        {
        int iScriptMode=GetLocalInt(oActivator, "pt_curCraftProcess_ScriptMode");

        ////////////////////
        if(!iScriptMode)  //��������� �����
            {
            DeleteLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake");

            SetLocalInt(oActivator, "pt_curCraftProcess_ScriptMode", 1);

            SetLocalLocation(oActivator, "pt_craft_PClocation", GetLocation(oActivator));

            DeleteLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft");
            DelayCommand(fTime/2, SetLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft", 1));
            DelayCommand(fTime+0.05, pt_ClearVarsWhithNumuses(oActivator));

            //������� ������ �� �������������� ������������ ������ ����� ���������� ��� ����������� �� �������
            if(pResponse(iChance))
                {
                DelayCommand(fTime, pt_CreateItem(oActivator, oItem));
                }
                else
                {
                SetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake", 1);
                DelayCommand(fTime, SetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake", 2));
                };
            //���������� �������
            DelayCommand(pt_REFRATE, pmainDEFAULTPROC(iIteraNum+1));
            return;
            }
            ///////////////////////////
            else if(iScriptMode==1)  //����� ����������
            {
            //���� ������ ����� ��������� �������� �� ��������� ��� � �������� � �������
            if(GetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake")==2)
                {
                FloatingTextStringOnCreature(StringToRGBString("��������, �� �� ���������� �������� ������� �� ������.", "700"), oActivator, FALSE);
                //������� �����
                pt_TakeRawFromPC(oActivator, oItem);
                //
                DeleteLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake");
                DeleteLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft");
                //
                //������� ��������� ���������� � �������
                // � ������ ����� pt_ClearVarsWhithNumuses(oActivator);
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
                    //����� �����
                    pt_TakeRawFromPC(oActivator, oItem);
                    //���������� �������� �������
                    DeleteLocalInt(oActivator, "pt_curCraftProcess_HalfTimeLeft");
                    };

                //������� ��������� ���������� � �������
                pt_ClearVarsWhithNumuses(oActivator);
                return;
                }
                else
                {
                //����������
                DelayCommand(pt_REFRATE, pmainDEFAULTPROC(iIteraNum+1));
                return;
                };
            };
        };
}
//����� ������� ���������� ��������







//������ ������ �����
void pCreateModuleVarNameDump(int iBeginItem=0)
{
    object oModule=GetModule();
    int iArrayLen=pGetModuleVarNameDumpLength();
    string sArrayLen=IntToString(iArrayLen);


    //������������� ��������� ������ �����������
    if(GetLocalString(oModule, pt_DBDUMP_MOD_ARRAY_NAME+"0")!="pt_craft_weary_value")
        {
        iArrayLen++;
        SetLocalString(oModule, pt_DBDUMP_MOD_ARRAY_NAME+"0", "pt_craft_weary_value");
        SetLocalInt(oModule, pt_DBDUMP_MOD_ARRAY_NAME+"0"+"_type", pt_DBDUMP_TYPE_FLOAT);
        };


    int i;
    int iMaxItem=GetLocalInt(oModule, "pt_CraftItemBoxArray_Length");
    for(i=iBeginItem+1; i<iMaxItem+1; i++)
        {
        string sI=IntToString(i);
        object oCrftItem=GetLocalObject(oModule, "pt_CraftItemBoxArray"+sI);
        if(!GetIsObjectValid(oCrftItem)) continue;


        string sProcSkill=GetLocalString(oCrftItem, "pt_CRAFT_SKILL_ID");
        int iSkillLen=pArrayLength(sProcSkill);


        int k;
        for(k=0; k<iSkillLen; k++)
            {
            string sSkillID=pArray(sProcSkill, k);

            int z, bHasThatSkill;
            bHasThatSkill=FALSE;
            for(z=0; z<=iArrayLen; z++)
                {
                if(GetLocalString(oModule, pt_DBDUMP_MOD_ARRAY_NAME+IntToString(z))=="pt_craft_skill_"+sSkillID+"_value") {bHasThatSkill=TRUE; break;};
                };
            if(!bHasThatSkill)
                {
                sArrayLen=IntToString(iArrayLen);


                //������������� ������
                sArrayLen=IntToString(iArrayLen);
                SetLocalString(oModule, pt_DBDUMP_MOD_ARRAY_NAME+sArrayLen, "pt_craft_skill_"+sSkillID+"_value");
                SetLocalInt(oModule, pt_DBDUMP_MOD_ARRAY_NAME+sArrayLen+"_type", pt_DBDUMP_TYPE_FLOAT);
                iArrayLen++;

                //�� ��������
                sArrayLen=IntToString(iArrayLen);
                SetLocalString(oModule, pt_DBDUMP_MOD_ARRAY_NAME+sArrayLen, "pt_craft_skill_"+sSkillID+"_DMbonpen");
                SetLocalInt(oModule, pt_DBDUMP_MOD_ARRAY_NAME+sArrayLen+"_type", pt_DBDUMP_TYPE_FLOAT);
                iArrayLen++;

                //�� ������ ������
                sArrayLen=IntToString(iArrayLen);
                SetLocalString(oModule, pt_DBDUMP_MOD_ARRAY_NAME+sArrayLen, "pt_craft_skill_"+sSkillID+"_DMblock");
                SetLocalInt(oModule, pt_DBDUMP_MOD_ARRAY_NAME+sArrayLen+"_type", pt_DBDUMP_TYPE_INT);
                iArrayLen++;
                };
            };
        };
    //������ �������
    SetLocalInt(oModule, pt_DBDUMP_MOD_ARRAY_NAME+"_length", iArrayLen);
}





int pGetModuleVarNameDumpLength()
{
    object oModule=GetModule();

    return GetLocalInt(oModule, pt_DBDUMP_MOD_ARRAY_NAME+"_length");
}



int pGetModuleVarNameDumpType(int iIndex=-1)
{
    if(iIndex<0) return pt_DBDUMP_TYPE_UNDEFINED;

    object oModule=GetModule();

    return GetLocalInt(oModule, pt_DBDUMP_MOD_ARRAY_NAME+IntToString(iIndex)+"_type");
}



string pGetModuleVarNameDumpString(int iIndex=-1)
{
    if(iIndex<0) return "";

    object oModule=GetModule();

    return GetLocalString(oModule, pt_DBDUMP_MOD_ARRAY_NAME+IntToString(iIndex));
}
//����� ������� �����










//������ ������� �������
//�������� ����� � ������� (���������� ������). ����������� ������������
void pTagDictAddWord(string sTagKey, string sWord)
{
    object oModule=GetModule();

    SetLocalString(oModule, "pt_CRAFT_TAGDICT_VAL_"+sTagKey, sWord);
}



//�������� ����� �� �����
string pTagDictGetWord(string sTagKey)
{
    object oModule=GetModule();

    string sWord=GetLocalString(oModule, "pt_CRAFT_TAGDICT_VAL_"+sTagKey);

    if(sWord=="") return sTagKey;

    return sWord;
}
//����� ������� �������







//20.05.13 ��������� ��������� ������� ������� �������� ������
//21.05.13 �������� �����������
//28.05.13 ���������� ������ �����
//15.08.13 ��������� ������� ������������� ������������� ��������� �����-������������ ��������
//13.08.14 �������� float fK=1.0 �������� � ������� pt_TakeRawFromPC
