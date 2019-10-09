//Кастомный процесс рубки дров

#include "pt_axcrf_include"

//const float pt_REFRATE=3.0;

void main()
{
object oModule=GetModule();
object oActivator=OBJECT_SELF;

int iMode=GetLocalInt(oActivator, "pt_curCraftProcess_Mode");
object oItem=GetLocalObject(oActivator, "pt_curCraftProcess_Object");

float fTime=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_TIME");

if(iMode)
    {
    int iScriptMode=GetLocalInt(oActivator, "pt_curCraftProcess_ScriptMode");
    object oTool=GetLocalObject(oActivator, "pt_craft_lastUsedTool");
    if(GetLocalInt(oTool, "pt_CRAFT_PROCESS_NUMUSE")>5) SetLocalInt(oTool, "pt_CRAFT_PROCESS_NUMUSE", d6());

    if(!iScriptMode)  //Begin mode
        {
        DelayCommand(0.8, ActionAttack(oTool, TRUE));
        DelayCommand(0.8, AssignCommand(oActivator, DelayCommand(fTime+0.8, ClearAllActions(TRUE))));
        }
        else if(iScriptMode==1)  //Refresh mode
        {
        //ActionAttack(oTool, TRUE);
        };
    };

//Функция для просчетов
//Запустим скрипт неймлеса поверх анимации рубки
ExecuteScript("pt_axcrf_pr_namc", OBJECT_SELF);
//pmainDEFAULTPROC(); //т.к. запустили стандартный скрипт то подобная функция уже запущена
}
