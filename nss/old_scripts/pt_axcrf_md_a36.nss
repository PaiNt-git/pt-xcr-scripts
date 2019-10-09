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



//Действие
iMaxNumUse+=1;
SetLocalInt(oTarget, "pt_CRAFT_PROCESS_NUMUSE", iMaxNumUse);


//Обновление токена
string sRawsWithCost="";
sRawsWithCost+="\nКоличество использований: "+IntToString(iNumUse)+"";
sRawsWithCost+="\nМаксимум использований: "+(iMaxNumUse<=0?"~":IntToString(iMaxNumUse))+"";
sRawsWithCost+="\nВремя востановления: "+(fRespTime<=0.0?"~":FloatToString(fRespTime, 2, 2)+"с");

SetCustomToken(pt_CUSTTOK_NODE_CURRENT_ITEM_RAW, sRawsWithCost);
}
