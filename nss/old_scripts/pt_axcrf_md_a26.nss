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


string sSkills=GetLocalString(oTarget, "pt_CRAFT_SKILL_ID");
string sSkillsVal=GetLocalString(oTarget, "pt_CRAFT_SKILL_VALUE");

int i, iCurI;
int iLen=pArrayLength(sSkills);
for(i=0; i<iLen; i++)
    {
    string sTempStr=pArray(sSkills, i);
    if(sTempStr==sItemRawTag)  {iCurI=i; break;};
    };
int iCurCost=StringToInt(pArray(sSkillsVal, iCurI));
SetCustomToken(pt_CUSTTOK_NODE_CURRENT_ITEM_VALUE, IntToString(iCurCost+5)+"");
sSkillsVal=pArray(sSkillsVal, iCurI, IntToString((iCurCost+5)));

SetLocalString(oTarget, "pt_CRAFT_SKILL_VALUE", sSkillsVal);

//DeleteLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemName");
//DeleteLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemRawTag");
//DeleteLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemToolTag");
//DeleteLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemSkillId");
}

