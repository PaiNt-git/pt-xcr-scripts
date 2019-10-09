//Условный первой ветви

#include "pt_axcrf_md_cons"
#include "pt_frame000"


int StartingConditional()
{
int iResult;

object oModule=GetModule();
object oActivator=GetPCSpeaker();

int iSelectedIndex=GetLocalInt(oActivator, "pt_craft_dialTok"+IntToString(pt_CUSTTOK_NODE_ONE)+"_Index");

if(iSelectedIndex>=0) iResult=TRUE;

return iResult;
}
