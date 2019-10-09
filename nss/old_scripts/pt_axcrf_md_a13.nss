//����� ����� ������

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
//�����
object oSkin=SKIN_SupportGetSkin(oTarget);

string sItem=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemName");
float fCurBonPen=GetLocalFloat(oSkin, "pt_craft_skill_"+sItem+"_DMbonpen");
fCurBonPen-=1.0;
SetLocalFloat(oSkin, "pt_craft_skill_"+sItem+"_DMbonpen", fCurBonPen);

//���������� ������
string sRawsWithCost="";
sRawsWithCost+="\n����� � ���������: "+FloatToString(GetLocalFloat(oSkin, "pt_craft_skill_"+sItem+"_value"), 2, 2);
sRawsWithCost+="\n������/������: "+FloatToString(GetLocalFloat(oSkin, "pt_craft_skill_"+sItem+"_DMbonpen"), 2, 2);
sRawsWithCost+="\n������������?: "+(((GetLocalInt(oSkin, "pt_craft_skill_"+sItem+"_DMblock")<=0)?"���":"��"));
SetCustomToken(pt_CUSTTOK_NODE_CURRENT_ITEM_RAW, sRawsWithCost);
}
