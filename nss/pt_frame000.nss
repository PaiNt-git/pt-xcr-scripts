////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

//Random location
location pt_GetRandomLocation(object oTarget, float fRadius = 1.0, int bInLine =
		FALSE);

// Probability roll (d100). Use as (e.g. "if(pResponse(20)) p();)"
int pResponse(int iFreq, int iBase = 100);

// String Array function. Can set and read an element from a string (e.g. "ff,4,sds,t").
// sRowBox - that string,
// iElemLink - index of the element to return or replace,
// sValue - if set to something other than "*", then the iElemLink-th element
// will be replaced by sValue and this function will return sRowBox
// with this change
string pArray(string sRowBox, int iElemLink = 0, string sValue = "*",
		string sDevider = ",");

// Get array length from string uses in pArray()
int pArrayLength(string sRowBox, string sDevider = ",");

//Get sHays with replace sNeedl->sRepl
string pGetStringReplace(string sHays, string sNeedl, string sRepl);

//GetStringLowerCase with RUS
string pRUSGetStringLowerCase(string sHays);
//GetStringUpperCase with RUS
string pRUSGetStringUpperCase(string sHays);

//Get RUS gender of the string. 0-male, 1-middle, 2-female.
int pGetStringGender(string sHays);

//Get a location from spesial-formated string
location pGetLocationFromString(string sLocCode);

//Get a spesial-formated string from location
string pGetStringFromLocation(location lLoc);

// Shell of CreateObjectAction as action function(void)
void pCreateObjectAction(int nObjectType, string sTemplate, location lLocation,
		int bUseAppearAnimation = FALSE, string sNewTag = "");

////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////

vector pGetChangedPosition(vector vOriginal, float fDistance, float fAngle) {
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

location pt_GetRandomLocation(object oTarget, float fRadius = 1.0, int bInLine =
		FALSE) {
	if (!bInLine)
		fRadius = IntToFloat(Random(FloatToInt(fRadius * 100.0))) / 100.0;

	object oArea = GetArea(oTarget);
	float fAngle = IntToFloat(Random(FloatToInt(360.0 * 100.0))) / 100.0;

	return Location(oArea,
			pGetChangedPosition(GetPosition(oTarget), fRadius, fAngle), fAngle);
}

void pCreateObjectAction(int nObjectType, string sTemplate, location lLocation,
		int bUseAppearAnimation = FALSE, string sNewTag = "") {
	CreateObject(nObjectType, sTemplate, lLocation, bUseAppearAnimation,
			sNewTag);
}

int pGetStringGender(string sHays) {
	string sEnding = GetStringRight(sHays, 1);

	if (sEnding == "î" || sEnding == "å")
		return 1;
	if (sEnding == "à" || sEnding == "ÿ")
		return 2;

	return 0;
}

string pGetStringReplace(string sHays, string sNeedl, string sRepl) {
	int iRepLen = GetStringLength(sRepl);
	int iNeedLen = GetStringLength(sNeedl);

	int iLen = GetStringLength(sHays);
	int iPos = FindSubString(sHays, sNeedl, 0);
	while (iPos >= 0) {
		sHays = GetStringLeft(sHays, iPos) + sRepl
				+ GetStringRight(sHays, iLen - iPos - iNeedLen);

		iLen = GetStringLength(sHays);
		iPos = FindSubString(sHays, sNeedl, iPos + iRepLen);
	};

	return sHays;
}

string pRUSGetStringLowerCase(string sHays) {
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

string pRUSGetStringUpperCase(string sHays) {
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

int pResponse(int iFreq, int iBase = 100) {
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

string pArray(string sRowBox, int iElemLink = 0, string sValue = "*",
		string sDivider = ",") {
	// Safety check on the divider.
	if (sDivider == "")
		sDivider = ",";

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
	if (iCurrentEnd == -1)
		iCurrentEnd = iBoxLength;

	// Check for not enough elements.
	if (iCurrentElem < iElemLink) {
		if (sValue == "*") {
			// The user asked for a non-existent element.
			return "";
		} else {
			// Pad sRowBox out to the desired element.
			while (iCurrentElem++ < iElemLink)
				sRowBox += sDivider;

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
		return GetStringLeft(sRowBox, iCurrentStart) + // The elements before the current one.
				sValue + // Value
				GetStringRight(sRowBox, iBoxLength - iCurrentEnd); // The elements after the current one.
	};
}

int pArrayLength(string sRowBox, string sDivider = ",") {
	// Safety check on the divider.
	if (sDivider == "")
		sDivider = ",";

	int iDivLength = GetStringLength(sDivider);

	// Check for no elements.
	if (sRowBox == "")
		return 0;

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

string pGetStringFromLocation(location lLoc) {
	string sAreaTag = GetTag(GetAreaFromLocation(lLoc));
	vector vPos = GetPositionFromLocation(lLoc);

	string x = FloatToString(vPos.x, 5, 2);
	string y = FloatToString(vPos.y, 5, 2);
	string z = FloatToString(vPos.z, 5, 2);
	string o = FloatToString(GetFacingFromLocation(lLoc), 3, 3);

	return sAreaTag + "|" + x + "," + y + "," + z + "|" + o;
}

location pGetLocationFromString(string sLocCode) {
	object oModule = GetModule();
	location lRet;

	string sAreaTag = pArray(sLocCode, 0, "*", "|");
	string sVector = pArray(sLocCode, 1, "*", "|");
	string sOrient = pArray(sLocCode, 2, "*", "|");

	float x = StringToFloat(pArray(sVector, 0));
	float y = StringToFloat(pArray(sVector, 1));
	float z = StringToFloat(pArray(sVector, 2));
	float o = StringToFloat(pArray(sOrient, 0));

	vector vPos = Vector(x, y, z);

	int i = 0;
	object oArea;
	do {
		oArea = GetObjectByTag(sAreaTag, i);
		if (GetArea(oArea) == oArea)   //find area
				{
			return Location(oArea, vPos, o);
		};
		i++;
	} while (GetIsObjectValid(oArea));

	return lRet;
}

