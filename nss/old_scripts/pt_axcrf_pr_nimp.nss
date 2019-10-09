//������� ��������� ��������. �������� ������ ������� �� ������. ���� ����� �� ������ ����� �������� � ����� - ������� �������� � 90% ������� �������.

#include "pt_axcrf_include"
#include "x2_inc_itemprop"

//��������� ����������� ������� �� �������
const string pt_SKILL_LEVEL_ROW =  "000 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040" ;
const string pt_SKILL_LIMITS_ROW = "002 003 004 005 008 010 012 015 016 018 020 022 025 030 032 035 040 045 050 055 060 065 070 075 080 085 090 092 092 096 100 110 120 130 140 150 160 170 180 190 200" ;






itemproperty pt_IPGetItemProperty(object oItem, itemproperty ipCompareTo, int nDurationCompare, int bIgnoreSubType = FALSE)
{
    itemproperty ip = GetFirstItemProperty(oItem);

    //PrintString ("Filter - T:" + IntToString(GetItemPropertyType(ipCompareTo))+ " S: " + IntToString(GetItemPropertySubType(ipCompareTo)) + " (Ignore: " + IntToString (bIgnoreSubType) + ") D:" + IntToString(nDurationCompare));
    while (GetIsItemPropertyValid(ip))
    {
        // PrintString ("Testing - T: " + IntToString(GetItemPropertyType(ip)));
        if ((GetItemPropertyType(ip) == GetItemPropertyType(ipCompareTo)))
        {
             //PrintString ("**Testing - S: " + IntToString(GetItemPropertySubType(ip)));
             if (GetItemPropertySubType(ip) == GetItemPropertySubType(ipCompareTo) || bIgnoreSubType)
             {
               // PrintString ("***Testing - d: " + IntToString(GetItemPropertyDurationType(ip)));
                if (GetItemPropertyDurationType(ip) == nDurationCompare || nDurationCompare == -1)
                {
                    //PrintString ("***FOUND");
                      return ip; // if duration is not ignored and durationtypes are equal, true
                 }
            }
        }
        ip = GetNextItemProperty(oItem);
    }
    //PrintString ("Not Found");
    return ItemPropertyHealersKit(-1);
}



void pt_ImproveItemProperty(object oItem, itemproperty iCurPropInCurItem)
{
    itemproperty ipNew;
    int iCurImproveLevel = GetLocalInt(oItem, "pt_CRAFT_IMPROVE_CURLEVEL");

    int nPropID=GetItemPropertyType(iCurPropInCurItem), nParam1 = 0, nParam2 = 0, nParam3 = 0, nParam4 = 0;
    int iCurParam1, iCurParam2;

    switch(nPropID)
        {

        case ITEM_PROPERTY_ABILITY_BONUS: {
            nParam1 = GetItemPropertySubType(iCurPropInCurItem);

            if(iCurImproveLevel<=1)
            {
            nParam2 = 2;
            }
            else if(iCurImproveLevel==2)
            {
            nParam2 = 3;
            }
            else if(iCurImproveLevel==3)
            {
            nParam2 = 4;
            }
            else if(iCurImproveLevel==4)
            {
            nParam2 = 5;
            }
            else if(iCurImproveLevel==5)
            {
            nParam2 = 6;
            }
            else
            {
            nParam2 = 6;
            };

            iCurParam2 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam2>nParam2) nParam2 = iCurParam2;

            };break;



        case ITEM_PROPERTY_ATTACK_BONUS: {
            if(iCurImproveLevel<=1)
            {
            nParam1 = 2;
            }
            else if(iCurImproveLevel==2)
            {
            nParam1 = 3;
            }
            else if(iCurImproveLevel==3)
            {
            nParam1 = 4;
            }
            else if(iCurImproveLevel==4)
            {
            nParam1 = 5;
            }
            else if(iCurImproveLevel==5)
            {
            nParam1 = 5;
            }
            else
            {
            nParam1 = 5;
            };

            iCurParam1 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam1>nParam1) nParam1 = iCurParam1;

            };break;



        case ITEM_PROPERTY_DAMAGE_BONUS: {
            nParam1 = GetItemPropertySubType(iCurPropInCurItem);

            if(iCurImproveLevel<=1)
            {
            nParam2 = DAMAGE_BONUS_1d6;
            }
            else if(iCurImproveLevel==2)
            {
            nParam2 = DAMAGE_BONUS_1d8;
            }
            else if(iCurImproveLevel==3)
            {
            nParam2 = DAMAGE_BONUS_1d10;
            }
            else if(iCurImproveLevel==4)
            {
            nParam2 = DAMAGE_BONUS_2d6;
            }
            else if(iCurImproveLevel==5)
            {
            nParam2 = DAMAGE_BONUS_2d8;
            }
            else
            {
            nParam2 = DAMAGE_BONUS_10;
            };

            iCurParam2 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam2>nParam2) nParam2 = iCurParam2;

            };break;



        case ITEM_PROPERTY_DAMAGE_REDUCTION: {
            nParam1 = GetItemPropertySubType(iCurPropInCurItem);

            if(iCurImproveLevel<=1)
            {
            nParam2 = IP_CONST_DAMAGESOAK_10_HP;
            }
            else if(iCurImproveLevel==2)
            {
            nParam2 = IP_CONST_DAMAGESOAK_15_HP;
            }
            else if(iCurImproveLevel==3)
            {
            nParam2 = IP_CONST_DAMAGESOAK_20_HP;
            }
            else if(iCurImproveLevel==4)
            {
            nParam2 = IP_CONST_DAMAGESOAK_20_HP;
            }
            else if(iCurImproveLevel==5)
            {
            nParam2 = IP_CONST_DAMAGESOAK_20_HP;
            }
            else
            {
            nParam2 = IP_CONST_DAMAGESOAK_20_HP;
            };

            iCurParam2 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam2>nParam2) nParam2 = iCurParam2;

            };break;




        case ITEM_PROPERTY_DAMAGE_RESISTANCE: {
            nParam1 = GetItemPropertySubType(iCurPropInCurItem);

            if(iCurImproveLevel<=1)
            {
            nParam2 = IP_CONST_DAMAGERESIST_10;
            }
            else if(iCurImproveLevel==2)
            {
            nParam2 = IP_CONST_DAMAGERESIST_15;
            }
            else if(iCurImproveLevel==3)
            {
            nParam2 = IP_CONST_DAMAGERESIST_20;
            }
            else if(iCurImproveLevel==4)
            {
            nParam2 = IP_CONST_DAMAGERESIST_20;
            }
            else if(iCurImproveLevel==5)
            {
            nParam2 = IP_CONST_DAMAGERESIST_20;
            }
            else
            {
            nParam2 = IP_CONST_DAMAGERESIST_20;
            };

            iCurParam2 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam2>nParam2) nParam2 = iCurParam2;

            };break;




        case ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL: {
            if(iCurImproveLevel<=1)
            {
            nParam1 = 2;
            }
            else if(iCurImproveLevel==2)
            {
            nParam1 = 2;
            }
            else if(iCurImproveLevel==3)
            {
            nParam1 = 3;
            }
            else if(iCurImproveLevel==4)
            {
            nParam1 = 3;
            }
            else if(iCurImproveLevel==5)
            {
            nParam1 = 4;
            }
            else
            {
            nParam1 = 4;
            };

            iCurParam1 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam1>nParam1) nParam1 = iCurParam1;

            };break;




        case ITEM_PROPERTY_MASSIVE_CRITICALS: {
            if(iCurImproveLevel<=1)
            {
            nParam1 = IP_CONST_DAMAGEBONUS_1d6;
            }
            else if(iCurImproveLevel==2)
            {
            nParam1 = IP_CONST_DAMAGEBONUS_1d8;
            }
            else if(iCurImproveLevel==3)
            {
            nParam1 = IP_CONST_DAMAGEBONUS_1d10;
            }
            else if(iCurImproveLevel==4)
            {
            nParam1 = IP_CONST_DAMAGEBONUS_2d6;
            }
            else if(iCurImproveLevel==5)
            {
            nParam1 = IP_CONST_DAMAGEBONUS_2d8;
            }
            else
            {
            nParam1 = IP_CONST_DAMAGEBONUS_10;
            };

            iCurParam1 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam1>nParam1) nParam1 = iCurParam1;

            };break;





        case ITEM_PROPERTY_REGENERATION_VAMPIRIC: {
            if(iCurImproveLevel<=1)
            {
            nParam1 = 3;
            }
            else if(iCurImproveLevel==2)
            {
            nParam1 = 4;
            }
            else if(iCurImproveLevel==3)
            {
            nParam1 = 6;
            }
            else if(iCurImproveLevel==4)
            {
            nParam1 = 7;
            }
            else if(iCurImproveLevel==5)
            {
            nParam1 = 8;
            }
            else
            {
            nParam1 = 9;
            };

            iCurParam1 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam1>nParam1) nParam1 = iCurParam1;

            };break;




        case ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE: {
            nParam1 = GetItemPropertySubType(iCurPropInCurItem);

            if(iCurImproveLevel<=1)
            {
            nParam2 = IP_CONST_DAMAGEIMMUNITY_10_PERCENT;
            }
            else if(iCurImproveLevel==2)
            {
            nParam2 = IP_CONST_DAMAGEIMMUNITY_10_PERCENT;
            }
            else if(iCurImproveLevel==3)
            {
            nParam2 = IP_CONST_DAMAGEIMMUNITY_25_PERCENT;
            }
            else if(iCurImproveLevel==4)
            {
            nParam2 = IP_CONST_DAMAGEIMMUNITY_25_PERCENT;
            }
            else if(iCurImproveLevel==5)
            {
            nParam2 = IP_CONST_DAMAGEIMMUNITY_50_PERCENT;
            }
            else
            {
            nParam2 = IP_CONST_DAMAGEIMMUNITY_50_PERCENT;
            };

            iCurParam2 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam2>nParam2) nParam2 = iCurParam2;

            };break;





        case ITEM_PROPERTY_REGENERATION: {
            if(iCurImproveLevel<=1)
            {
            nParam1 = 2;
            }
            else if(iCurImproveLevel==2)
            {
            nParam1 = 3;
            }
            else if(iCurImproveLevel==3)
            {
            nParam1 = 4;
            }
            else if(iCurImproveLevel==4)
            {
            nParam1 = 5;
            }
            else if(iCurImproveLevel==5)
            {
            nParam1 = 5;
            }
            else
            {
            nParam1 = 5;
            };

            iCurParam1 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam1>nParam1) nParam1 = iCurParam1;

            };break;



        case ITEM_PROPERTY_SAVING_THROW_BONUS: {
            nParam1 = GetItemPropertySubType(iCurPropInCurItem);

            if(iCurImproveLevel<=1)
            {
            nParam2 = 2;
            }
            else if(iCurImproveLevel==2)
            {
            nParam2 = 4;
            }
            else if(iCurImproveLevel==3)
            {
            nParam2 = 6;
            }
            else if(iCurImproveLevel==4)
            {
            nParam2 = 8;
            }
            else if(iCurImproveLevel==5)
            {
            nParam2 = 10;
            }
            else
            {
            nParam2 = 12;
            };

            iCurParam2 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam2>nParam2) nParam2 = iCurParam2;

            };break;



        case ITEM_PROPERTY_SKILL_BONUS: {
            nParam1 = GetItemPropertySubType(iCurPropInCurItem);

            if(iCurImproveLevel<=1)
            {
            nParam2 = 5;
            }
            else if(iCurImproveLevel==2)
            {
            nParam2 = 8;
            }
            else if(iCurImproveLevel==3)
            {
            nParam2 = 10;
            }
            else if(iCurImproveLevel==4)
            {
            nParam2 = 12;
            }
            else if(iCurImproveLevel==5)
            {
            nParam2 = 15;
            }
            else
            {
            nParam2 = 20;
            };

            iCurParam2 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam2>nParam2) nParam2 = iCurParam2;

            };break;




        case ITEM_PROPERTY_ARCANE_SPELL_FAILURE: {
            if(iCurImproveLevel<=1)
            {
            nParam1 = 8;
            }
            else if(iCurImproveLevel==2)
            {
            nParam1 = 7;
            }
            else if(iCurImproveLevel==3)
            {
            nParam1 = 6;
            }
            else if(iCurImproveLevel==4)
            {
            nParam1 = 5;
            }
            else if(iCurImproveLevel==5)
            {
            nParam1 = 4;
            }
            else
            {
            nParam1 = 3;
            };

            iCurParam1 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam1<nParam1) nParam1 = iCurParam1;

            };break;



        case ITEM_PROPERTY_MIGHTY: {
            if(iCurImproveLevel<=1)
            {
            nParam1 = 2;
            }
            else if(iCurImproveLevel==2)
            {
            nParam1 = 3;
            }
            else if(iCurImproveLevel==3)
            {
            nParam1 = 4;
            }
            else if(iCurImproveLevel==4)
            {
            nParam1 = 5;
            }
            else if(iCurImproveLevel==5)
            {
            nParam1 = 6;
            }
            else
            {
            nParam1 = 7;
            };

            iCurParam1 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam1>nParam1) nParam1 = iCurParam1;

            };break;



        case ITEM_PROPERTY_SPELL_RESISTANCE: {
            if(iCurImproveLevel<=1)
            {
            nParam1 = IP_CONST_SPELLRESISTANCEBONUS_16;
            }
            else if(iCurImproveLevel==2)
            {
            nParam1 = IP_CONST_SPELLRESISTANCEBONUS_20;
            }
            else if(iCurImproveLevel==3)
            {
            nParam1 = IP_CONST_SPELLRESISTANCEBONUS_22;
            }
            else if(iCurImproveLevel==4)
            {
            nParam1 = IP_CONST_SPELLRESISTANCEBONUS_26;
            }
            else if(iCurImproveLevel==5)
            {
            nParam1 = IP_CONST_SPELLRESISTANCEBONUS_30;
            }
            else
            {
            nParam1 = IP_CONST_SPELLRESISTANCEBONUS_32;
            };

            iCurParam1 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam1>nParam1) nParam1 = iCurParam1;

            };break;


        case ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION: {
            if(iCurImproveLevel<=1)
            {
            nParam1 = IP_CONST_REDUCEDWEIGHT_20_PERCENT;
            }
            else if(iCurImproveLevel==2)
            {
            nParam1 = IP_CONST_REDUCEDWEIGHT_40_PERCENT;
            }
            else if(iCurImproveLevel==3)
            {
            nParam1 = IP_CONST_REDUCEDWEIGHT_60_PERCENT;
            }
            else if(iCurImproveLevel==4)
            {
            nParam1 = IP_CONST_REDUCEDWEIGHT_80_PERCENT;
            }
            else if(iCurImproveLevel==5)
            {
            nParam1 = IP_CONST_REDUCEDWEIGHT_80_PERCENT;
            }
            else
            {
            nParam1 = IP_CONST_REDUCEDWEIGHT_80_PERCENT;
            };

            iCurParam1 = GetItemPropertyCostTableValue(iCurPropInCurItem);
            if(iCurParam1<nParam1) nParam1 = iCurParam1;

            };break;



        };



    if(nParam1==0) return;

    ipNew = IPGetItemPropertyByID(nPropID, nParam1 , nParam2 , nParam3 , nParam4 );
    IPSafeAddItemProperty(oItem, ipNew);
}




void pt_ImproveItemProperties(object oItem, object oItemFirstLevel, string sExceptions="", string sResolved="")
{
    if(!GetIsObjectValid(oItem) || GetObjectType(oItem)!=OBJECT_TYPE_ITEM) return;

    int iCurImproveLevel = GetLocalInt(oItem, "pt_CRAFT_IMPROVE_CURLEVEL");
    iCurImproveLevel++;
    SetLocalInt(oItem, "pt_CRAFT_IMPROVE_CURLEVEL", iCurImproveLevel);

    string sName = GetName(oItem);
    if(FindSubString(sName, StringToRGBString(" (" + IntToString(iCurImproveLevel-1) + " ��.)", "070")) == -1)
        {
        SetDescription(oItem, GetDescription(oItem) + "\n");
        SetName(oItem, GetName(oItem) + StringToRGBString(" (" + IntToString(iCurImproveLevel) + " ��.)", "070"));
        }
        else
        {
        SetName(oItem, StringReplace(GetName(oItem), StringToRGBString(" (" + IntToString(iCurImproveLevel-1) + " ��.)", "070"), StringToRGBString(" (" + IntToString(iCurImproveLevel) + " ��.)", "070")));
        };
    SetDescription(oItem, GetDescription(oItem) + "\n " + StringToRGBString("*�������� ������� �� " + IntToString(iCurImproveLevel) + " ������.\n", "070"));


    if(pArrayLength(sExceptions)>20)  sExceptions="";
    if(pArrayLength(sResolved)>20)  sResolved="";
    int k;

    itemproperty ipCurProp = GetFirstItemProperty(oItemFirstLevel);
    while(GetIsItemPropertyValid(ipCurProp))
        {
        // Exceptions
        if(sExceptions!="")
            {
            int bException=FALSE, iExceptionsArrayLength = pArrayLength(sExceptions);
            for(k=0; k<iExceptionsArrayLength; k++)
                {
                if(StringToInt(pArray(sExceptions, k))==GetItemPropertyType(ipCurProp)) {bException=TRUE;break;};
                };
                if(bException) continue;
            };
        // Resolved
        if(sResolved!="")
            {
            int bResolved=FALSE, iResolvedArrayLength = pArrayLength(sResolved);
            for(k=0; k<iResolvedArrayLength; k++)
                {
                if(StringToInt(pArray(sResolved, k))==GetItemPropertyType(ipCurProp)) {bResolved=TRUE;break;};
                };
                if(!bResolved) continue;
            };


        itemproperty ipCurPropInCurItem = pt_IPGetItemProperty(oItem, ipCurProp, DURATION_TYPE_PERMANENT);
        if(GetIsItemPropertyValid(ipCurPropInCurItem)) pt_ImproveItemProperty(oItem, ipCurPropInCurItem);

        ipCurProp = GetNextItemProperty(oItemFirstLevel);
        };

}


///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////





object pt_GetInstanceItemInCraft(object oItem)
{
    object oModule=GetModule();
    string sRR = GetResRef(oItem);

    int i, iMaxIItem=GetLocalInt(oModule, "pt_CraftItemBoxArray_Length");;
    for(i=0; i<iMaxIItem; i++)
        {
        string sI=IntToString(i);

        object oCrftItem=GetLocalObject(oModule, "pt_CraftItemBoxArray"+sI);

        if(GetResRef(oCrftItem) == sRR)  return oCrftItem;
        };
    return OBJECT_INVALID;
}



struct stReturnRawCondition
{
    string sProcRawNames;

    int bReturn;
};


struct stReturnRawCondition pt_GetRawCondition(object oActivator,  object oItem, float fK=1.0)
{
    struct stReturnRawCondition stRet;

    object  oTool=GetLocalObject(oActivator, "pt_ActTool");
    int bScanRawInToolInventory=TRUE;

    ////�������� ������������ �����
    string sProcRaw=GetLocalString(oItem, "pt_CRAFT_RAW");
    stRet.sProcRawNames = GetLocalString(oItem, "pt_CRAFT_RAW");
    string sProcRawCost=GetLocalString(oItem, "pt_CRAFT_RAW_COST");
    if (sProcRaw!="") //���� ������������ ����� � �������� ����� - �� ��� �������� �� ����� �������
    {
    string sProcActivatorRawValue="0";

    int iRawLen=pArrayLength(sProcRaw);
    int iRawCostLen=pArrayLength(sProcRawCost);

    int k, bNotHasAllRaw=FALSE;
    for(k=0; k<iRawLen; k++)
        {
        string sRawTag=pArray(sProcRaw, k);

        int bHasRaw=FALSE;
        if(bScanRawInToolInventory) //����������� ������� � ��������� �����������
            {
            object oActItem=GetFirstItemInInventory(oTool);

            while(GetIsObjectValid(oActItem))
                {
                stRet.sProcRawNames=pArray(stRet.sProcRawNames, k, " " + pTagDictGetWord(sRawTag) + " " + FloatToString(StringToFloat(pArray(sProcRawCost, k))*fK, 3, 0) );
                if(GetTag(oActItem)==sRawTag)
                    {
                    int iActRawVal=StringToInt(pArray(sProcActivatorRawValue, k));
                    iActRawVal+=GetItemStackSize(oActItem);
                    sProcActivatorRawValue=pArray(sProcActivatorRawValue, k, IntToString(iActRawVal));
                    bHasRaw=TRUE;
                    };

                oActItem=GetNextItemInInventory(oTool);
                };
            };
        if(!bHasRaw) {bNotHasAllRaw=TRUE; break;};
        };
    if(bNotHasAllRaw) {stRet.bReturn = FALSE; return stRet;};


    int bNotHasAllRawQuant=FALSE;
    for(k=0; k<iRawLen; k++)
        {
        int iCostK=(k<=(iRawCostLen-1)?k:iRawCostLen-1);

        int iCurRawCost=StringToInt(pArray(sProcRawCost, iCostK));
        int iCurRawHave=StringToInt(pArray(sProcActivatorRawValue, iCostK));

        iCurRawCost = iCurRawCost>0? FloatToInt(IntToFloat(iCurRawCost)*fK) : iCurRawCost;

        if(iCurRawCost<0) iCurRawCost=1;

        if(iCurRawHave<iCurRawCost) {bNotHasAllRawQuant=TRUE; break;};
        };
    if(bNotHasAllRawQuant) {stRet.bReturn = FALSE; return stRet;};
    };

    stRet.bReturn = TRUE; return stRet;
}








void pt_ImproveNAMC(object oActivator, object oItem)
{
    if(!GetLocalInt(oActivator, "pt_curCraftProcess_Mode")) return;
    if(!pt_HasAllCraftConditions(oActivator,  oItem)) return;
    if(!pt_HasRaw(oActivator,  oItem)) return;



    int iMaxQuant=GetLocalInt(oItem, "pt_CRAFT_MAXQUANT");
    int iMinQuant=GetLocalInt(oItem, "pt_CRAFT_MINQUANT");
    int iCurImproveLevel, iMaxImproveLevel = GetLocalInt(oItem, "pt_CRAFT_IMPROVE_MAXLEVEL");
    if(iMaxImproveLevel == 0) iMaxImproveLevel = iMaxQuant;
    float fRawSkillKoefficient = GetLocalFloat(oItem, "pt_CRAFT_IMPROVE_K");
    if(fRawSkillKoefficient == 0.0f) fRawSkillKoefficient = 1.0f + IntToFloat(iMinQuant)/(IntToFloat(iMaxQuant)+0.0001) ;

    object  oTool=GetLocalObject(oActivator, "pt_ActTool");

    float fWeary=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_WEARY");

    string sSkills=GetLocalString(oItem, "pt_CRAFT_SKILL_ID");
    int iSkillsLen=pArrayLength(sSkills);
    string sSkillsVal=GetLocalString(oItem, "pt_CRAFT_SKILL_VALUE");
    int iSkillsValLen=pArrayLength(sSkillsVal);

    string sRaws=GetLocalString(oItem, "pt_CRAFT_RAW");
    int iRawsLen=pArrayLength(sRaws);
    string sRawsCost=GetLocalString(oItem, "pt_CRAFT_RAW_COST");
    string sTools=GetLocalString(oItem, "pt_CRAFT_TOOL");

    int iChanceToCreate=GetLocalInt(oItem, "pt_CRAFT_PROCESS_CHANCE");
    float fK=1.0;


    int iMaxItem=GetLocalInt(GetModule(), "pt_CraftItemBoxArray_Length");
    object oSkin=SKIN_SupportGetSkin(oActivator);
    float fActivatorWeary=GetLocalFloat(oSkin, "pt_craft_weary_value");


    //������ ��������
    if(pResponse(FloatToInt(IntToFloat(iChanceToCreate)*fK)))
        {
        int iAncorBaseType=GetBaseItemType(oItem); //�������� ������ ��� ���� ��� �������� �� ���� (��� ���� ������ �� ����->����, ������->������)
        int bAncorMelee = IPGetIsMeleeWeapon(oItem);
        int bAncorRanged = IPGetIsRangedWeapon(oItem);

        object oChargItem=OBJECT_INVALID;
        object oActItem=GetFirstItemInInventory(oTool);
        while(GetIsObjectValid(oActItem))
                {
                int i, iRawCicle=(iRawsLen==0)?1:iRawsLen;
                for(i=0; i<iRawCicle; i++)
                    {
                    string sCurRawTag=pArray(sRaws, i);
                    if(GetTag(oActItem)!=sCurRawTag)
                        {
                        int iChaBaseType = GetBaseItemType(oActItem);
                        int bChaMelee = IPGetIsMeleeWeapon(oActItem);
                        int bChaRanged = IPGetIsRangedWeapon(oActItem);

                        if (iChaBaseType==iAncorBaseType)
                            {
                            oChargItem=oActItem; //���������� �������� ���� ��������
                            }
                            else
                            {
                            if((bAncorMelee && bChaMelee == bAncorMelee) || (bAncorRanged && bChaRanged == bAncorRanged)) oChargItem=oActItem;   //���������� ���� ������ � ������
                            };


                        //////////////////////////////////////////////
                        //���� ����� ������� ��� ��������� �� ��������
                        //����� ����� ���������� ��������� � ������ � ������� ������������ � ����
                        if(GetIsObjectValid(oChargItem))
                            {
                            //����� ������ � ����� � "���������" �������� �� �������� ������� ��������, ���� ���� iChanceToCreateImpItem - ������� ��� ��� �� ��������� ������� � �������
                            string sRawsImpItem=GetLocalString(oChargItem, "pt_CRAFT_RAW");
                            string sRawsCostImpItem=GetLocalString(oChargItem, "pt_CRAFT_RAW_COST"); //�������� ���� ����� �� �����������
                            int iRawsLenImpItem=pArrayLength(sRawsImpItem);

                            string sSkillsImpItem=GetLocalString(oChargItem, "pt_CRAFT_SKILL_ID");
                            string sSkillsValImpItem=GetLocalString(oChargItem, "pt_CRAFT_SKILL_VALUE");
                            int iSkillsLenImpItem=pArrayLength(sSkillsImpItem);

                            int iChanceToCreateImpItem=GetLocalInt(oChargItem, "pt_CRAFT_PROCESS_CHANCE");
                            if(!iChanceToCreateImpItem) break;
                            float fKImpItem=1.0;


                            //����������, ������� ����������� ��� ���������� ����� � ��������� �������
                            int iActivatorLevel=GetLevelByPosition(1, oActivator)+GetLevelByPosition(2, oActivator)+GetLevelByPosition(3, oActivator);
                            float fActivatorLevel=IntToFloat(iActivatorLevel);
                            int iCraftItemCost=GetGoldPieceValue(oItem);
                            float fCraftItemCost=IntToFloat(iCraftItemCost);


                            object oFirstLevItem=pt_GetInstanceItemInCraft(oChargItem);  //�.�. ������� ����� �������� ���������������� ����, ���� �������� � �������
                            if(!GetIsObjectValid(oFirstLevItem)) break;

                            //������� ������� ��������� �� ��������
                            iCurImproveLevel = GetLocalInt(oChargItem, "pt_CRAFT_IMPROVE_CURLEVEL");
                            fRawSkillKoefficient *= IntToFloat(iCurImproveLevel+1);

                            struct stReturnRawCondition stRetCondition;
                            stRetCondition = pt_GetRawCondition(oActivator,  oFirstLevItem, fRawSkillKoefficient);

                            //�� �������� ������� �����
                            if(!stRetCondition.bReturn)
                                {
                                FloatingTextStringOnCreature(StringToRGBString("������������ �����. ��� ��������� �������� �� " + IntToString(iCurImproveLevel+1) + " �����-������ ���������: " + stRetCondition.sProcRawNames, "700"), oActivator, FALSE);

                                //������� ��������� ���������� � �������
                                DelayCommand(1.0, pt_ClearVarsWhithNumuses(oActivator));
                                return;
                                };

                            if(iCurImproveLevel+1 > iMaxImproveLevel)
                                {
                                FloatingTextStringOnCreature(StringToRGBString("������� ������ ��������� ��������� � ������� ������.", "700"), oActivator, FALSE);

                                //������� ��������� ���������� � �������
                                DelayCommand(1.0, pt_ClearVarsWhithNumuses(oActivator));
                                return;
                                };


                            //������ ������������ ���������� ��� "�����������" �������� � ��������� ������
                            string sSkillRequest = sSkillsImpItem;
                            int z, u, y;
                            for(z=0; z<iSkillsLenImpItem; z++)
                                {
                                int iValI=(z<=(iSkillsValLen-1)?z:iSkillsValLen-1);
                                string sSkillID=pArray(sSkillsImpItem, z);
                                sSkillID=GetStringLeft(sSkillID, 35);
                                if(sSkillID=="") continue;

                                //�������� ������ ��� ��������
                                string sItSkillVal=pArray(sSkillsValImpItem, iValI);
                                float fItSkillVal=StringToFloat(sItSkillVal)*fRawSkillKoefficient;

                                //������� ���������� � ��������� ��� ������������ ����
                                sSkillRequest = pArray(sSkillRequest, z, sSkillID + " " + FloatToString(fItSkillVal, 3, 0));

                                //������ � �������� ����� ������ � ����������
                                float fBonPen=GetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_DMbonpen");
                                float fActivatorSkill=GetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_value")+fBonPen;

                                //���������� ��� ����� ����������� ����������. ������������ ����������� ������� ��������
                                //� ��������������� ������� ��������
                                fKImpItem*=(fActivatorSkill/(fItSkillVal+0.01));
                                if(fActivatorSkill<fItSkillVal && fKImpItem>0.10) fKImpItem=0.10;


                                ///////////////////////////XP
                                //������� ������� �� ��������� ���� � �������� ������ ��������
                                //����� ���� ����� - �� ������ ������ �������  ����� �������� 25-500 ����� ����� (500 ��� ��� ��������� �������� ����� 10�)
                                //����� � ������ ������ ��������������� �������� ����� �����������, ������� �������� 500(10� �������) �� 20� ������ ���������������� ���-�� � ~120
                                //���� ����� �� ����� ��������� � �������� - �� � ���� �� ������ - ������..
                                float fXPforCraft=(((1000.0*(fActivatorLevel+0.5)-500.0)*0.05)/(pow(fActivatorLevel, 1.5))+1.0)*((fCraftItemCost/10000.0<1.0?1.0:fCraftItemCost/10000)-(fCraftItemCost/10000.0>10.0?fCraftItemCost/10000.0-10.0:1.0)+1.0)/2.0;
                                ////////////////////////////

                                /////////////////////////////Skill
                                //���������� �����, ����� ���� ����� - �� ������ �������� (������������� � ������������ ������� 100.0)
                                //������� ������� 15.0 �������� ������ ����� ��������� ����� ����� �� ~17.0 (+ 1/8 �� 15.0)
                                //��� ����������� "����� ���������" ������� ������ �� �����, ������ �������� ��������� �� ����� ���� ������ 0.15
                                float fSkillInc=(fabs(100.0-(fActivatorSkill-fBonPen))/(IntToFloat(iMaxItem)+0.01)+0.01) * (IntToFloat(d6())/IntToFloat(d4()));

                                fSkillInc = fSkillInc>0.15?0.15:fSkillInc;

                                //////////////////////////////
                                //��������� ����� ����� (��������������) ������ �� ������
                                int iLimitsLen = pArrayLength(pt_SKILL_LIMITS_ROW, " ");   //������-���������
                                float fSkillSkillLimit=0.0;
                                //������� �� ��������� ��������
                                for(y=0; y<iLimitsLen; y++)
                                    {
                                    int iCurLimSkill = StringToInt(pArray(pt_SKILL_LEVEL_ROW, y, "*", " "));
                                    float fCurLimSkillLim = StringToFloat(pArray(pt_SKILL_LIMITS_ROW, y, "*", " "));

                                    if (iActivatorLevel>=iCurLimSkill) fSkillSkillLimit=fCurLimSkillLim; //��������� �������������� ������ � �����������
                                    };
                                if((fActivatorSkill-fBonPen)+fSkillInc > fSkillSkillLimit) FloatingTextStringOnCreature( "���������� �������� ������� ����� ���������� �������� �� ��������� ���������..",   oActivator,   FALSE  );

                                fSkillInc = ((fActivatorSkill-fBonPen)+fSkillInc > fSkillSkillLimit) ? fSkillSkillLimit-(fActivatorSkill-fBonPen) : fSkillInc;

                                fSkillInc = (fSkillInc<0.0) ? 0.0 : fSkillInc;

                                float fBackupInc=fSkillInc;
                                //////////////////////////////


                                //����� �� ����� ������������� �� ������ �������� �����
                                if((fActivatorSkill-fBonPen)+fSkillInc > fItSkillVal+((fItSkillVal<16.0)?16.0:fItSkillVal)/8.0)
                                    {
                                    fSkillInc=fSkillInc-(((fActivatorSkill-fBonPen)+fSkillInc)-(fItSkillVal+((fItSkillVal<16.0)?16.0:fItSkillVal)/8.0));
                                    };
                                fSkillInc = (fSkillInc<0.005 && fSkillInc>0.0) ? 0.005 : fSkillInc ;


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
                                //
                                FloatingTextStringOnCreature(StringToRGBString("��� ����� ��� "+FloatToString(fActivatorWeary, 2, 2), (fActivatorWeary<=25.00?"700":"070")), oActivator, FALSE);
                                //
                                SetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_value", (fActivatorSkill-fBonPen)+fSkillInc);
                                //
                                GiveXPToCreature(oActivator, FloatToInt(fXPforCraft));
                                };




                            //������ ��������
                            if(pResponse(FloatToInt( IntToFloat(iChanceToCreateImpItem)*fKImpItem )))
                                {
                                //����� ������� ��������� ��������� ������� (�� �������� ���������� ������� ��������) ����� �������, ����������� ������� ���������
                                FloatingTextStringOnCreature(StringToRGBString("�������� ��������� ��������", "070"), oActivator, FALSE);
                                effect eMagCom = EffectVisualEffect(VFX_COM_HIT_DIVINE);
                                ApplyEffectToObject(DURATION_TYPE_INSTANT, eMagCom, oTool);

                                pt_ImproveItemProperties(oChargItem, oFirstLevItem);

                                pt_TakeRawFromPC(oActivator, oItem);
                                pt_TakeRawFromPC(oActivator, oFirstLevItem, fRawSkillKoefficient);
                                }
                                else
                                {
                                pt_TakeRawFromPC(oActivator, oItem);
                                pt_TakeRawFromPC(oActivator, oFirstLevItem, 0.5f);
                                FloatingTextStringOnCreature(StringToRGBString("����� ������� ��������� ������������ ��������� ��������. ���������� �������: "+sSkillRequest, "700"), oActivator, FALSE);
                                };

                                //������� ��������� ���������� � �������
                                DelayCommand(1.0, pt_ClearVarsWhithNumuses(oActivator));
                                return;
                            };
                        };
                    };

                oActItem=GetNextItemInInventory(oTool);
                };

        }
        else
        {
        FloatingTextStringOnCreature(StringToRGBString("����� ������� ��������� ������������ ��� ��������� ���������� ����� ��������.", "700"), oActivator, FALSE);
        };


    //������� ��������� ���������� � �������
    DelayCommand(1.0, pt_ClearVarsWhithNumuses(oActivator));
}







void pmainIMPROVE(int iIteraNum=1)
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
                DelayCommand(fTime, pt_ImproveNAMC(oActivator, oItem));
                }
                else
                {
                SetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake", 1);
                DelayCommand(fTime, SetLocalInt(oActivator, "pt_curCraftProcess_ScriptIsFake", 2));
                };
            //���������� �������
            DelayCommand(pt_REFRATE, pmainIMPROVE(iIteraNum+1));
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
                DelayCommand(pt_REFRATE, pmainIMPROVE(iIteraNum+1));
                return;
                };
            };
        };

}




void main()
{
    object oModule=GetModule();
    object oActivator=OBJECT_SELF;

    object  oTool=GetLocalObject(oActivator, "pt_ActTool");
    object oItem=GetLocalObject(oActivator, "pt_curCraftProcess_Object");
    float fTime=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_TIME");


    //�������� ��� ��������
    PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, fTime);


    //������� ��� ��������
    pmainIMPROVE();
}
