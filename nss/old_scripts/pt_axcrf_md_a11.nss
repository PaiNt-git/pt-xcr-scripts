//Создать предмет в инвентаре

#include "pt_axcrf_md_cons"
#include "pt_frame000"

#include "x3_inc_string"


void main()
{
object oModule=GetModule();
object oActivator=GetPCSpeaker();

int iSelectedIndex=GetLocalInt(oActivator, "pt_craft_dialSelectedItem");
string sItemInd=IntToString(iSelectedIndex);

object oItem=GetLocalObject(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_Object");


//Создание объекта в инвентаре
object oTempItem=CopyObject(oItem, GetLocation(oActivator), oActivator);
}
