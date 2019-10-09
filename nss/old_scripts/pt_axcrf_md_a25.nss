#include "pt_axcrf_md_cons"
#include "pt_frame000"

#include "x3_inc_string"


void main()
{
object oModule=GetModule();
object oActivator=GetPCSpeaker();
object oTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");

int iSelectedIndex=GetLocalInt(oActivator, "pt_craft_dialSelectedItem");
string sItemInd=IntToString(iSelectedIndex);

string sItemRawTag=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemRawTag");
string sItemToolTag=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemToolTag");
string sItemSkillId=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemSkillId");


string sTools=GetLocalString(oTarget, "pt_CRAFT_TOOL");

int i, iCurI;
int iLen=pArrayLength(sTools);
for(i=0; i<iLen; i++)
    {
    string sTempStr=pArray(sTools, i);
    if(sTempStr==sItemToolTag)  {sTools=pArray(sTools, i, ""); iCurI=i; break;};
    };
SetCustomToken(pt_CUSTTOK_NODE_CURRENT_ITEM_VALUE, "");

/////////////////////////////////////
sTools=StringReplace(sTools, ",,", "");

if(GetStringLeft(sTools, 1)==",") sTools=GetStringRight(sTools, GetStringLength(sTools)-1);
if(GetStringRight(sTools, 1)==",") sTools=GetStringLeft(sTools, GetStringLength(sTools)-1);

SetLocalString(oTarget, "pt_CRAFT_TOOL", sTools);

DeleteLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemName");
//DeleteLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemRawTag");
DeleteLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemToolTag");
//DeleteLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemSkillId");
}

