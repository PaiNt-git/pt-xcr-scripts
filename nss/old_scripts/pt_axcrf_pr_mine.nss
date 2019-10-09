//Кастомный процесс рудокопства  -обертка

#include "pt_axcrf_include"

void main()
{
object oModule=GetModule();
object oActivator=OBJECT_SELF;

int iMode=GetLocalInt(oActivator, "pt_curCraftProcess_Mode");    // //0-Begin mode, 1-Refresh mode
object oItem=GetLocalObject(oActivator, "pt_curCraftProcess_Object");

float fTime=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_TIME");

if(iMode)
    {
    int iScriptMode=GetLocalInt(oActivator, "pt_curCraftProcess_ScriptMode");
    object oTool=GetLocalObject(oActivator, "pt_craft_lastUsedTool");
    if(!iScriptMode)  //Begin mode
        {
        DelayCommand(0.6, ActionAttack(oTool, TRUE));
        DelayCommand(0.6, AssignCommand(oActivator, DelayCommand(fTime+0.4, ClearAllActions(TRUE))));
        }
        else if(iScriptMode==1)  //Refresh mode
        {
        //ActionAttack(oTool, TRUE);
        };
    };

//Функция для просчетов
//Запустим скрипт неймлеса поверх анимации рубки
ExecuteScript("pt_axcrf_pr_namc", OBJECT_SELF);
//pmainDEFAULTPROC(); //т.к. запустили pt_axcrf_pr_namc скрипт то подобная функция уже запущена
}
