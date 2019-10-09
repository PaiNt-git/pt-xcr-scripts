//Кастомный процесс собирательства  -обертка

#include "pt_axcrf_include"

void main()
{
object oModule=GetModule();
object oActivator=OBJECT_SELF;

//int iMode=GetLocalInt(oActivator, "pt_curCraftProcess_Mode");   // //0-Begin mode, 1-Refresh mode
object oItem=GetLocalObject(oActivator, "pt_curCraftProcess_Object");

float fTime=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_TIME");


DelayCommand(0.8, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, fTime));



//Функция для просчетов
//Запустим скрипт неймлеса поверх анимации собирательства
ExecuteScript("pt_axcrf_pr_namc", OBJECT_SELF);
//pmainDEFAULTPROC(); //т.к. запустили pt_axcrf_pr_namc скрипт то подобная функция уже запущена
}
