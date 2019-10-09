//Кастомный процесс Упаковки инструмента из плейса в итем
//Скрипт добычи - упаковка (инструмент с плейса разрушается
//- а в инвентаре появляется заданный итем из бочки, который является упакованной версией инструмента)

#include "pt_axcrf_include"

void main()
{
    object oModule=GetModule();
    object oActivator=OBJECT_SELF;

    //int iMode=GetLocalInt(oActivator, "pt_curCraftProcess_Mode");     // //0-Begin mode, 1-Refresh mode
    object oItem=GetLocalObject(oActivator, "pt_curCraftProcess_Object");

    float fTime=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_TIME");

    object oTool=GetLocalObject(oActivator, "pt_craft_lastUsedTool");

    PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, fTime);
    DestroyObject(oTool, fTime);

    //Функция для просчетов
    pmainDEFAULTPROC();
}
