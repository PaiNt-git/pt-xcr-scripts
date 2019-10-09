//Начать процесс


#include "pt_axcrf_md_cons"
#include "pt_frame000"



void main()
{
object oModule=GetModule();
object oActivator=GetPCSpeaker();

int iSelectedIndex=GetLocalInt(oActivator, "pt_craft_dialSelectedItem");



string sItemInd=IntToString(iSelectedIndex);
object oItem=GetLocalObject(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_Object");



string sCustomScript=GetLocalString(oItem, "pt_CRAFT_PROCESS_PC_CUSTOM_SCRIPT");
sCustomScript=(sCustomScript==""?"pt_axcrf_pr_defa":sCustomScript);



SetLocalInt(oActivator, "pt_curCraftProcess_Mode", 1);
SetLocalObject(oActivator, "pt_curCraftProcess_Object", oItem);



ExecuteScript(sCustomScript, oActivator);
}
