//Скрипт дачи усталости на крафт исходя из телосложения активатора и силы

#include "pt_frame000"
#include "pt_axcrf_oveskin"


void main()
{
    object oRester=OBJECT_SELF;

    //Даем усталости пк..
    float fWeary=50.0+IntToFloat(((GetAbilityModifier(ABILITY_CONSTITUTION, oRester)+GetAbilityModifier(ABILITY_STRENGTH, oRester)/2)/2)*50);
    fWeary=(fWeary<50.0)?50.0:fWeary;

    object oSkin=SKIN_SupportGetSkin(oRester);
    SetLocalFloat(oSkin, "pt_craft_weary_value", fWeary);


    FloatingTextStringOnCreature("Вы востановили "+FloatToString(fWeary, 2, 2)+" ед. усталости.", oRester, FALSE);

}

