//Скрипт выхода игрока

#include "pt_axcrf_include"


void main()
{
    //Дампинг из шкуры в базу
    if(pt_CRAFT_USE_NWNX)
        {
        object oPC=GetExitingObject();
        if(GetIsDM(oPC)) return;
        //
        SetLocalInt(oPC, "pt_PCLOGIN", FALSE);
        // плохие значения при выходе игрока на шкуре, обновление в базу только раз в минуту
        return;
        //
        //................Здесь был код обновления переменных в базу ;).....................
        //
        };
}
