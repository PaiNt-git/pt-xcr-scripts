//::///////////////////////////////////////////////
//:: Base functions that define elementary types
//:: pt_xcr_inc_bfunc.nss
//:: Copyright (c) 2018 PaiNt.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: PaiNt
//:: Created On: 2018
//:://////////////////////////////////////////////

//#include "aps_include"
//#include "aps_include_co"
#include "x3_inc_string"
#include "pt_xcr_inc_const"

struct stItemSettings {

    string sTools;
    int _iToolsLen;

    string sSkills;
    string sSkillsVal;
    int _iSkillsLen;
    int _iSkillsValLen;

    string sRaws;
    string sRawsCost;
    int _iRawsLen;
    int _iRawCostLen;

    float fWeary;
    float fTime;

    int iChanceToCreate;
    int iMinQuant;
    int iMaxQuant;

    string sScript;
};

//Getter for stItemSettings of Item
struct stItemSettings ptItemSettings(object oItem);

struct stItemSettings ptItemSettings(object oItem) {

    struct stItemSettings stRet;

    stRet.sTools = "";
    stRet._iToolsLen = 0;

    stRet.sSkills = "";
    stRet.sSkillsVal = "";
    stRet._iSkillsLen = 0;
    stRet._iSkillsValLen = 0;

    stRet.sRaws = "";
    stRet.sRawsCost = "";
    stRet._iRawsLen = 0;
    stRet._iRawCostLen = 0;

    stRet.fWeary = 0.0;
    stRet.fTime = 0.0;

    stRet.iChanceToCreate = 0;
    stRet.iMinQuant = 0;
    stRet.iMaxQuant = 0;

    stRet.sScript = "";

    if (GetObjectType(oItem) != OBJECT_TYPE_ITEM) return stRet;

    stRet.sTools = GetLocalString(oItem, PT_XCR_ITEM_SETTINGS_TOOLS);
    stRet._iToolsLen = ptArrayLength(stRet.sTools);

    stRet.sSkills = GetLocalString(oItem, PT_XCR_ITEM_SETTINGS_SKILLS);
    stRet.sSkillsVal = GetLocalString(oItem, PT_XCR_ITEM_SETTINGS_SKILLSVAL);
    stRet._iSkillsLen = ptArrayLength(stRet.sSkills);
    stRet._iSkillsValLen = ptArrayLength(stRet.sSkillsVal);

    stRet.sRaws = GetLocalString(oItem, PT_XCR_ITEM_SETTINGS_RAWS);
    stRet.sRawsCost = GetLocalString(oItem, PT_XCR_ITEM_SETTINGS_RAWSCOST);
    stRet._iRawsLen = ptArrayLength(stRet.sRaws);
    stRet._iRawCostLen = ptArrayLength(stRet.sRawsCost);

    stRet.fWeary = GetLocalFloat(oItem, PT_XCR_ITEM_SETTINGS_WEARY);
    stRet.fTime = GetLocalFloat(oItem, PT_XCR_ITEM_SETTINGS_TIME);

    stRet.iChanceToCreate = GetLocalInt(oItem, PT_XCR_ITEM_SETTINGS_CHANCETOCREATE);
    stRet.iMinQuant = GetLocalInt(oItem, PT_XCR_ITEM_SETTINGS_MINQUANT);
    stRet.iMaxQuant = GetLocalInt(oItem, PT_XCR_ITEM_SETTINGS_MAXQUANT);

    stRet.sScript = GetLocalString(oItem, PT_XCR_ITEM_SETTINGS_SCRIPT);

    return stRet;
}

//Refresh internal length-vars of struct stItemSettings
struct stItemSettings ptItemSettingsRecalcLens(struct stItemSettings stRet);

struct stItemSettings ptItemSettingsRecalcLens(struct stItemSettings stRet) {

    stRet._iToolsLen = ptArrayLength(stRet.sTools);

    stRet._iSkillsLen = ptArrayLength(stRet.sSkills);
    stRet._iSkillsValLen = ptArrayLength(stRet.sSkillsVal);

    stRet._iRawsLen = ptArrayLength(stRet.sRaws);
    stRet._iRawCostLen = ptArrayLength(stRet.sRawsCost);

    return stRet;
}

//Setter for stItemSettings of Item
void ptItemSettings_set(object oItem, struct stItemSettings stVal);

void ptItemSettings_set(object oItem, struct stItemSettings stVal) {

    SetLocalString(oItem, PT_XCR_ITEM_SETTINGS_TOOLS, stVal.sTools);

    SetLocalString(oItem, PT_XCR_ITEM_SETTINGS_SKILLS, stVal.sSkills);
    SetLocalString(oItem, PT_XCR_ITEM_SETTINGS_SKILLSVAL, stVal.sSkillsVal);

    SetLocalString(oItem, PT_XCR_ITEM_SETTINGS_RAWS, stVal.sRaws);
    SetLocalString(oItem, PT_XCR_ITEM_SETTINGS_RAWSCOST, stVal.sRawsCost);

    SetLocalFloat(oItem, PT_XCR_ITEM_SETTINGS_WEARY, stVal.fWeary);
    SetLocalFloat(oItem, PT_XCR_ITEM_SETTINGS_TIME, stVal.fTime);

    SetLocalInt(oItem, PT_XCR_ITEM_SETTINGS_CHANCETOCREATE, stVal.iChanceToCreate);
    SetLocalInt(oItem, PT_XCR_ITEM_SETTINGS_MINQUANT, stVal.iMinQuant);
    SetLocalInt(oItem, PT_XCR_ITEM_SETTINGS_MAXQUANT, stVal.iMaxQuant);

    SetLocalString(oItem, PT_XCR_ITEM_SETTINGS_SCRIPT, stVal.sScript);

}

void ptObjArrayAddPossibleProps(object oObject, string sProp) {
    int iPropLen = GetLocalInt(oObject, "_pt_prop.length");
    bool bHasProp = false;
    int i;
    for (i = 0; i < iPropLen; i++) {
    	if(GetLocalString(oObject, "_pt_prop." + IntToString(iPropLen))!="") {
    		bHasProp = true
    	};
    };
    if(!bHasProp) {
    	SetLocalString(oObject, "_pt_prop." + IntToString(iPropLen) + ".prop", sProp);
    	iPropLen++
    	SetLocalInt(oObject, "_pt_prop.length", iPropLen)
    };
}

//Getter length of arrays of oObject
int ptObjArrayLen(string sNamespace, object oObject, string sKey);

int ptObjArrayLen(string sNamespace, object oObject, string sKey) {
    return GetLocalInt(oObject, sNamespace + sKey + "." + "length");
}

//Setter length of arrays of oObject, if iLen = 0 then delete all affected vars
void ptObjArrayLen_set(string sNamespace, object oObject, string sKey, int iLen);

void ptObjArrayLen_set(string sNamespace, object oObject, string sKey, int iLen) {
    int iCurLen = GetLocalInt(oObject, sNamespace + sKey + "." + "length");
    SetLocalInt(oObject, sNamespace + sKey + "." + "length", iLen);
    if (iLen == 0) {
        DeleteLocalInt(oObject, sNamespace + sKey + "." + "length");
        int iPropLen = GetLocalInt(oObject, "_pt_prop.length");

        int i;
        for (i = 0; i < iCurLen; i++) {
            DeleteLocalString(oObject, sNamespace + sKey + "." + IntToString(i));
            DeleteLocalInt(oObject, sNamespace + sKey + "." + IntToString(i));
            DeleteLocalFloat(oObject, sNamespace + sKey + "." + IntToString(i));
            DeleteLocalObject(oObject, sNamespace + sKey + "." + IntToString(i));
            DeleteLocalLocation(oObject, sNamespace + sKey + "." + IntToString(i));

            int j;
            for (j = 0; j < iPropLen; j++) {

				string sProp = GetLocalString(oObject, "_pt_prop." + IntToString(j) + ".prop");

				DeleteLocalString(oObject, sNamespace + sKey + "." + IntToString(i) + "." + sProp);
				DeleteLocalInt(oObject, sNamespace + sKey + "." + IntToString(i) + "." + sProp);
				DeleteLocalFloat(oObject, sNamespace + sKey + "." + IntToString(i) + "." + sProp);
				DeleteLocalObject(oObject, sNamespace + sKey + "." + IntToString(i) + "." + sProp);
				DeleteLocalLocation(oObject, sNamespace + sKey + "." + IntToString(i) + "." + sProp);

            };
        };

        for (j = 0; j < iPropLen; j++) {
			DeleteLocalString(oObject, "_pt_prop." + IntToString(j) + ".prop");
        };
        DeleteLocalInt(oObject, "_pt_prop.length");

    };
}

//Getter for string vars of oObject,
// if sProp is set - then this getter get that property value (but array-length is parent)
string ptObjArrayString(string sNamespace, object oObject, string sKey, int i = 0, string sProp = "");

string ptObjArrayString(string sNamespace, object oObject, int i = 0, string sProp = "") {
    return GetLocalString(oObject, sNamespace + sKey + "." + IntToString(i) + (sProp == "" ? "" : ("." + sProp)));
}

//Setter for string vars of oObject,
// if sProp is set - then this Setter set that property value (but array-length is parent)
void ptObjArrayString_set(string sNamespace, object oObject, string sKey, string sVal, int i = -1, string sProp = "");

void ptObjArrayString_set(string sNamespace, object oObject, string sKey, string sVal, int i = -1, string sProp = "") {
    if (i == -1) {
        i = ptObjArrayLen(sNamespace, oObject, sKey);
    };

    SetLocalString(oObject, sNamespace + sKey + "." + IntToString(i) + (sProp == "" ? "" : ("." + sProp)), sVal);
    ptObjArrayLen_set(sNamespace, oObject, sKey, i + 1);

    if (sProp != "") {
        ptObjArrayAddPossibleProps(oObject, sProp);
    };
}

//Getter for int vars of oObject,
// if sProp is set - then this getter get that property value (but array-length is parent)
int ptObjArrayInt(string sNamespace, object oObject, string sKey, int i = 0, string sProp = "");

int ptObjArrayInt(string sNamespace, object oObject, int i = 0, string sProp = "") {
    return GetLocalInt(oObject, sNamespace + sKey + "." + IntToString(i) + (sProp == "" ? "" : ("." + sProp)));
}

//Setter for int vars of oObject,
// if sProp is set - then this Setter set that property value (but array-length is parent)
void ptObjArrayInt_set(string sNamespace, object oObject, string sKey, int iVal, int i = -1, string sProp = "");

void ptObjArrayInt_set(string sNamespace, object oObject, string sKey, int iVal, int i = -1, string sProp = "") {
    if (i == -1) {
        i = ptObjArrayLen(sNamespace, oObject, sKey);
    };

    SetLocalInt(oObject, sNamespace + sKey + "." + IntToString(i) + (sProp == "" ? "" : ("." + sProp)), iVal);
    ptObjArrayLen_set(sNamespace, oObject, sKey, i + 1);

    if (sProp != "") {
        ptObjArrayAddPossibleProps(oObject, sProp);
    };
}

//Getter for float vars of oObject,
// if sProp is set - then this getter get that property value (but array-length is parent)
float ptObjArrayFloat(string sNamespace, object oObject, string sKey, int i = 0, string sProp = "");

float ptObjArrayFloat(string sNamespace, object oObject, int i = 0, string sProp = "") {
    return GetLocalFloat(oObject, sNamespace + sKey + "." + IntToString(i) + (sProp == "" ? "" : ("." + sProp)));
}

//Setter for float vars of oObject,
// if sProp is set - then this Setter set that property value (but array-length is parent)
void ptObjArrayFloat_set(string sNamespace, object oObject, string sKey, float fVal, int i = -1, string sProp = "");

void ptObjArrayFloat_set(string sNamespace, object oObject, string sKey, float fVal, int i = -1, string sProp = "") {
    if (i == -1) {
        i = ptObjArrayLen(sNamespace, oObject, sKey);
    };

    SetLocalFloat(oObject, sNamespace + sKey + "." + IntToString(i) + (sProp == "" ? "" : ("." + sProp)), fVal);
    ptObjArrayLen_set(sNamespace, oObject, sKey, i + 1);

    if (sProp != "") {
        ptObjArrayAddPossibleProps(oObject, sProp);
    };
}

//Getter for object vars of oObject,
// if sProp is set - then this getter get that property value (but array-length is parent)
object ptObjArrayObject(string sNamespace, object oObject, string sKey, int i = 0, string sProp = "");

object ptObjArrayObject(string sNamespace, object oObject, int i = 0, string sProp = "") {
    return GetLocalObject(oObject, sNamespace + sKey + "." + IntToString(i) + (sProp == "" ? "" : ("." + sProp)));
}

//Setter for object vars of oObject,
// if sProp is set - then this Setter set that property value (but array-length is parent)
void ptObjArrayObject_set(string sNamespace, object oObject, string sKey, object oVal, int i = -1, string sProp = "");

void ptObjArrayObject_set(string sNamespace, object oObject, string sKey, object oVal, int i = -1, string sProp = "") {
    if (i == -1) {
        i = ptObjArrayLen(sNamespace, oObject, sKey);
    };

    SetLocalObject(oObject, sNamespace + sKey + "." + IntToString(i) + (sProp == "" ? "" : ("." + sProp)), oVal);
    ptObjArrayLen_set(sNamespace, oObject, sKey, i + 1);

    if (sProp != "") {
        ptObjArrayAddPossibleProps(oObject, sProp);
    };
}

//Getter for location vars of oObject,
// if sProp is set - then this getter get that property value (but array-length is parent)
location ptObjArrayLocation(string sNamespace, object oObject, string sKey, int i = 0, string sProp = "");

location ptObjArrayLocation(string sNamespace, object oObject, int i = 0, string sProp = "") {
    return GetLocalLocation(oObject, sNamespace + sKey + "." + IntToString(i) + (sProp == "" ? "" : ("." + sProp)));
}

//Setter for location vars of oObject,
// if sProp is set - then this Setter set that property value (but array-length is parent)
void ptObjArrayLocation_set(string sNamespace, object oObject, string sKey, location lVal, int i = -1, string sProp = "");

void ptObjArrayLocation_set(string sNamespace, object oObject, string sKey, location lVal, int i = -1, string sProp = "") {
    if (i == -1) {
        i = ptObjArrayLen(sNamespace, oObject, sKey);
    };

    SetLocalLocation(oObject, sNamespace + sKey + "." + IntToString(i) + (sProp == "" ? "" : ("." + sProp)), lVal);
    ptObjArrayLen_set(sNamespace, oObject, sKey, i + 1);

    if (sProp != "") {
        ptObjArrayAddPossibleProps(oObject, sProp);
    };
}

vector ptGetChangedPosition(vector vOriginal, float fDistance, float fAngle) {
    vector vChanged;
    vChanged.z = vOriginal.z;
    vChanged.x = vOriginal.x + fDistance * cos(fAngle);
    if (vChanged.x < 0.0)
        vChanged.x = -vChanged.x;
    vChanged.y = vOriginal.y + fDistance * sin(fAngle);
    if (vChanged.y < 0.0)
        vChanged.y = -vChanged.y;

    return vChanged;
}

//Random location
location ptGetRandomLocation(object oTarget, float fRadius = 1.0, int bInLine = FALSE);

location ptGetRandomLocation(object oTarget, float fRadius = 1.0, int bInLine = FALSE) {
    if (!bInLine) fRadius = IntToFloat(Random(FloatToInt(fRadius * 100.0))) / 100.0;

    object oArea = GetArea(oTarget);
    float fAngle = IntToFloat(Random(FloatToInt(360.0 * 100.0))) / 100.0;

    return Location(oArea, ptGetChangedPosition(GetPosition(oTarget), fRadius, fAngle), fAngle);
}

// Probability roll (d100). Use as (e.g. "if(ptResponse(20)) p();)"
int ptResponse(int iFreq, int iBase = 100);

int ptResponse(int iFreq, int iBase = 100) {
    if (iFreq <= 0) {
        return FALSE;
    };
    if (iFreq >= iBase) {
        return TRUE;
    };

    int iRN = Random(iBase) + 1;

    if (iRN <= iFreq) {
        return TRUE;
    } else {
        return FALSE;
    };
}

// String Array function. Can set and read an element from a string (e.g. "ff,4,sds,t").
// sRowBox - that string,
// iElemLink - index of the element to return or replace,
// sValue - if set to something other than "*", then the iElemLink-th element
// will be replaced by sValue and this function will return sRowBox
// with this change
string ptArray(string sRowBox, int iElemLink = 0, string sValue = "*", string sDevider = ",");

string ptArray(string sRowBox, int iElemLink = 0, string sValue = "*", string sDivider = ",") {
    // Safety check on the divider.
    if (sDivider == "") sDivider = ",";

    int iDivLength = GetStringLength(sDivider);
    int iBoxLength = GetStringLength(sRowBox);

    // Start with the first element.
    int iCurrentElem = 0;
    int iCurrentStart = 0;
    int iCurrentEnd = FindSubString(sRowBox, sDivider);

    // Advance to the specified element.
    while (iCurrentElem < iElemLink && iCurrentEnd > -1) {
        iCurrentElem++;
        iCurrentStart = iCurrentEnd + iDivLength;
        iCurrentEnd = FindSubString(sRowBox, sDivider, iCurrentStart);
    }
    // Adjust the end point if this is the last element.
    if (iCurrentEnd == -1) iCurrentEnd = iBoxLength;

    // Check for not enough elements.
    if (iCurrentElem < iElemLink) {
        if (sValue == "*") {
            // The user asked for a non-existent element.
            return "";
        } else {
            // Pad sRowBox out to the desired element.
            while (iCurrentElem++ < iElemLink) sRowBox += sDivider;

            // Append the specified value and return.
            return sRowBox + sValue;
        };
    };

    // What shall we do with this element?
    if (sValue == "*") {
        // Just return it.
        return GetSubString(sRowBox, iCurrentStart, iCurrentEnd - iCurrentStart);
    } else {
        // Replace this element with the provided value.
        return
        GetStringLeft(sRowBox, iCurrentStart) + // The elements before the current one.
            sValue + // Value
            GetStringRight(sRowBox, iBoxLength - iCurrentEnd); // The elements after the current one.
    };
}

// Get array length from string uses in ptArray()
int ptArrayLength(string sRowBox, string sDevider = ",");

int ptArrayLength(string sRowBox, string sDivider = ",") {
    // Safety check on the divider.
    if (sDivider == "") sDivider = ",";

    int iDivLength = GetStringLength(sDivider);

    // Check for no elements.
    if (sRowBox == "") return 0;

    // The number of elements will be one more than the number of dividers.
    int iElemCount = 1;
    int iElemEnd = FindSubString(sRowBox, sDivider);

    // Advance to the specified element.
    while (iElemEnd > -1) {
        iElemCount++;
        iElemEnd = FindSubString(sRowBox, sDivider, iElemEnd + iDivLength);
    }

    return iElemCount;
}

//Get sHays with replace sNeedl->sRepl
string ptGetStringReplace(string sHays, string sNeedl, string sRepl);

string ptGetStringReplace(string sHays, string sNeedl, string sRepl) {
    int iRepLen = GetStringLength(sRepl);
    int iNeedLen = GetStringLength(sNeedl);

    int iLen = GetStringLength(sHays);
    int iPos = FindSubString(sHays, sNeedl, 0);
    while (iPos >= 0) {
        sHays = GetStringLeft(sHays, iPos) + sRepl + GetStringRight(sHays, iLen - iPos - iNeedLen);

        iLen = GetStringLength(sHays);
        iPos = FindSubString(sHays, sNeedl, iPos + iRepLen);
    };

    return sHays;
}

//GetStringLowerCase with RUS
string ptRUSGetStringLowerCase(string sHays);

string ptRUSGetStringLowerCase(string sHays) {
    string sPatt = "ß×ÑÌÈÒÜÁÞÔÛÂÀÏÐÎËÄÆÝÉÖÓÊÅÍÃØÙÇÕÚ¨";
    string sRepl = "ÿ÷ñìèòüáþôûâàïðîëäæýéöóêåíãøùçõú¸";

    int i;
    int iLen = GetStringLength(sPatt);
    for (i = 0; i < iLen; i++) {
        string sPCh = GetSubString(sPatt, i, 1);
        string sRCh = GetSubString(sRepl, i, 1);

        sHays = pGetStringReplace(sHays, sPCh, sRCh);
    };

    return GetStringLowerCase(sHays);
}

//GetStringUpperCase with RUS
string ptRUSGetStringUpperCase(string sHays);

string ptRUSGetStringUpperCase(string sHays) {
    string sPatt = "ÿ÷ñìèòüáþôûâàïðîëäæýéöóêåíãøùçõú¸";
    string sRepl = "ß×ÑÌÈÒÜÁÞÔÛÂÀÏÐÎËÄÆÝÉÖÓÊÅÍÃØÙÇÕÚ¨";

    int i;
    int iLen = GetStringLength(sPatt);
    for (i = 0; i < iLen; i++) {
        string sPCh = GetSubString(sPatt, i, 1);
        string sRCh = GetSubString(sRepl, i, 1);

        sHays = pGetStringReplace(sHays, sPCh, sRCh);
    };

    return GetStringUpperCase(sHays);
}

//Get a location from special-formatted string
location ptGetLocationFromString(string sLocCode);

location ptGetLocationFromString(string sLocCode) {
    object oModule = GetModule();
    location lRet;

    string sAreaTag = ptArray(sLocCode, 0, "*", "|");
    string sVector = ptArray(sLocCode, 1, "*", "|");
    string sOrient = ptArray(sLocCode, 2, "*", "|");

    float x = StringToFloat(ptArray(sVector, 0));
    float y = StringToFloat(ptArray(sVector, 1));
    float z = StringToFloat(ptArray(sVector, 2));
    float o = StringToFloat(ptArray(sOrient, 0));

    vector vPos = Vector(x, y, z);

    int i = 0;
    object oArea;
    do {
        oArea = GetObjectByTag(sAreaTag, i);
        if (GetArea(oArea) == oArea) {
            return Location(oArea, vPos, o);
        };
        i++;
    } while (GetIsObjectValid(oArea));

    return lRet;
}

//Get a special-formatted string from location
string ptGetStringFromLocation(location lLoc);

string ptGetStringFromLocation(location lLoc) {
    string sAreaTag = GetTag(GetAreaFromLocation(lLoc));
    vector vPos = GetPositionFromLocation(lLoc);

    string x = FloatToString(vPos.x, 5, 2);
    string y = FloatToString(vPos.y, 5, 2);
    string z = FloatToString(vPos.z, 5, 2);
    string o = FloatToString(GetFacingFromLocation(lLoc), 3, 3);

    return sAreaTag + "|" + x + "," + y + "," + z + "|" + o;
}

// Wrapper of CreateObjectAction as action function(void)
void ptCreateObjectAction(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation = FALSE, string sNewTag = "");

void ptCreateObjectAction(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation = FALSE, string sNewTag = "") {
    CreateObject(nObjectType, sTemplate, lLocation, bUseAppearAnimation, sNewTag);
}

// Create object in oTarget local vars with name of var - sName
void ptCreateObjectInLocal(object oTarget, string sName, int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation = FALSE, string sNewTag = "");

void ptCreateObjectInLocal(object oTarget, string sName, int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation = FALSE, string sNewTag = "") {
    SetLocalObject(oTarget, sName, CreateObject(nObjectType, sTemplate, lLocation, bUseAppearAnimation, sNewTag));
}
