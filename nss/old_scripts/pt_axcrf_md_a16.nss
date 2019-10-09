//Навык минус

#include "pt_axcrf_md_cons"
#include "pt_frame000"

#include "x3_inc_string"
#include "pt_axcrf_oveskin"

void main()
{
object oModule=GetModule();
object oActivator=GetPCSpeaker();

int iSelectedIndex=GetLocalInt(oActivator, "pt_craft_dialSelectedItem");
string sItemInd=IntToString(iSelectedIndex);

object oTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsSkillStickTarget");
//Шкура
object oSkin=SKIN_SupportGetSkin(oTarget);

string sItem=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemName");
float fCurSkill=GetLocalFloat(oSkin, "pt_craft_skill_"+sItem+"_value");
fCurSkill-=1.0;
SetLocalFloat(oSkin, "pt_craft_skill_"+sItem+"_value", fCurSkill);

//Обновление токена
string sRawsWithCost="";
sRawsWithCost+="\nНавык у персонажа: "+FloatToString(GetLocalFloat(oSkin, "pt_craft_skill_"+sItem+"_value"), 2, 2);
sRawsWithCost+="\nБонусы/штрафы: "+FloatToString(GetLocalFloat(oSkin, "pt_craft_skill_"+sItem+"_DMbonpen"), 2, 2);
sRawsWithCost+="\nЗаблокирован?: "+(((GetLocalInt(oSkin, "pt_craft_skill_"+sItem+"_DMblock")<=0)?"Нет":"Да"));
SetCustomToken(pt_CUSTTOK_NODE_CURRENT_ITEM_RAW, sRawsWithCost);


}
