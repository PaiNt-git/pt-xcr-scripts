#include "pt_axcrf_md_cons"
#include "pt_frame000"

#include "x3_inc_string"


void main()
{
object oModule=GetModule();
object oActivator=GetPCSpeaker();
object oTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsToolToolTarget");

int iNumUse=GetLocalInt(oTarget, "pt_curCraftProcess_uses");
int iMaxNumUse=GetLocalInt(oTarget, "pt_CRAFT_PROCESS_NUMUSE");
float fRespTime=GetLocalFloat(oTarget, "pt_CRAFT_PROCESS_RESPTIME");



//��������
iMaxNumUse+=1;
SetLocalInt(oTarget, "pt_CRAFT_PROCESS_NUMUSE", iMaxNumUse);


//���������� ������
string sRawsWithCost="";
sRawsWithCost+="\n���������� �������������: "+IntToString(iNumUse)+"";
sRawsWithCost+="\n�������� �������������: "+(iMaxNumUse<=0?"~":IntToString(iMaxNumUse))+"";
sRawsWithCost+="\n����� �������������: "+(fRespTime<=0.0?"~":FloatToString(fRespTime, 2, 2)+"�");

SetCustomToken(pt_CUSTTOK_NODE_CURRENT_ITEM_RAW, sRawsWithCost);
}
