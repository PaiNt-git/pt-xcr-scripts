#include "pt_axcrf_md_cons"
#include "pt_frame000"

#include "x3_inc_string"


void main()
{
object oModule=GetModule();
object oActivator=GetPCSpeaker();
object oTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");

int iChanse=GetLocalInt(oTarget, "pt_CRAFT_PROCESS_CHANCE");
float fTime=GetLocalFloat(oTarget, "pt_CRAFT_PROCESS_TIME");
float fWeary=GetLocalFloat(oTarget, "pt_CRAFT_PROCESS_WEARY");
int iMin=GetLocalInt(oTarget, "pt_CRAFT_MINQUANT");
int iMax=GetLocalInt(oTarget, "pt_CRAFT_MAXQUANT");


//Действие
iMin+=1;
iMax=(iMax<iMin?iMin:iMax);
SetLocalInt(oTarget, "pt_CRAFT_MINQUANT", iMin);
SetLocalInt(oTarget, "pt_CRAFT_MAXQUANT", iMax);



//Обновление токена
string sRawsWithCost="";
sRawsWithCost+="\nШанс успешности: "+IntToString(iChanse)+"%";
sRawsWithCost+="\nВремя процесса: "+FloatToString(fTime, 2, 2)+"с";
sRawsWithCost+="\nУсталость: "+FloatToString(fWeary, 2, 2)+"ед.";
sRawsWithCost+="\nКоличество при изготовлении: "+IntToString(iMin)+"-"+IntToString(iMax)+" ед.";


SetCustomToken(pt_CUSTTOK_NODE_CURRENT_ITEM_RAW, sRawsWithCost);
}
