//Захватчик сырья :). начальный условный скрипт

#include "pt_axcrf_md_cons"
#include "pt_frame000"

#include "x3_inc_string"


int StartingConditional()
{
int iResult;

object oModule=GetModule();
object oActivator=GetPCSpeaker();
object oTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");

//Дополнительная установка токена
//Ибо в мультиплеере глюки
SetCustomToken(pt_CUSTTOK_TOOL, GetLocalString(oActivator, "pt_craft_dialTool")+" ("+StringToRGBString(GetName(oTarget), "700")+")");

ExecuteScript("pt_axcrf_md_a34", OBJECT_SELF);

if(GetLocalInt(oActivator, "pt_craft_dialToolIsRawCreateSp")) { iResult=TRUE;};

return iResult;
}
