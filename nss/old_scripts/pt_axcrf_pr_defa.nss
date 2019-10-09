//Дефолтный процесс

#include "pt_axcrf_include"

void main()
{
    object oModule=GetModule();
    object oActivator=OBJECT_SELF;

    //int iMode=GetLocalInt(oActivator, "pt_curCraftProcess_Mode");   // //0-Begin mode, 1-Refresh mode
    object oItem=GetLocalObject(oActivator, "pt_curCraftProcess_Object");

    float fTime=GetLocalFloat(oItem, "pt_CRAFT_PROCESS_TIME");

    //Анимация для процесса
    PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, fTime);

    //Функция для просчетов
    pmainDEFAULTPROC();
}
