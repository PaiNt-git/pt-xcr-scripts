//Начальный условный скрипт обычного производства предмета

#include "pt_axcrf_md_cons"
#include "pt_frame000"

#include "x3_inc_string"


int StartingConditional()
{
int iResult;

object oModule=GetModule();
object oActivator=GetPCSpeaker();

//Дополнительная установка токена
//Ибо в мультиплеере глюки
SetCustomToken(pt_CUSTTOK_TOOL, GetLocalString(oActivator, "pt_craft_dialTool"));

ExecuteScript("pt_axcrf_md_a01", OBJECT_SELF);

return TRUE;
}
