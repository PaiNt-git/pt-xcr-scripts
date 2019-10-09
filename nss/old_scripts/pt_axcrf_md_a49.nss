//Скрипт для процесса. Специальный скрипт который создает процесс, используя положенные туда "материалы для починки"
//Предмет-якорь, который лежит в бочке - не производится, вместо этого чинится соотвествующий для материала из
//которого сделан итем-якорь предмет лежащий в инвентаре инструмента (первый удовлетворяющий условию совпадения материала)

#include "pt_axcrf_md_cons"
#include "pt_frame000"

#include "x3_inc_string"


void main()
{
object oModule=GetModule();
object oActivator=GetPCSpeaker();
object oTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");

string sCustScript=GetLocalString(oTarget, "pt_CRAFT_PROCESS_PC_CUSTOM_SCRIPT");


//Действие
sCustScript="pt_axcrf_pr_repa";
SetLocalString(oTarget, "pt_CRAFT_PROCESS_PC_CUSTOM_SCRIPT", sCustScript);
}
