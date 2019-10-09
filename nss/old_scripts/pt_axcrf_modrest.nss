#include "pt_frame000"
#include "pt_axcrf_oveskin"


void main()
{
if(GetLastRestEventType()==REST_EVENTTYPE_REST_FINISHED)
    {
    object oRester=GetLastPCRested();

    //Даем усталости пк..
    float fWeary=150.0+IntToFloat(((GetAbilityModifier(ABILITY_CONSTITUTION, oRester)+GetAbilityModifier(ABILITY_STRENGTH, oRester)/2)/2)*75);
    fWeary=(fWeary<150.0)?150.0:fWeary;

    object oSkin=SKIN_SupportGetSkin(oRester);
    SetLocalFloat(oSkin, "pt_craft_weary_value", fWeary);


    FloatingTextStringOnCreature("Вы востановили "+FloatToString(fWeary, 2, 2)+" ед. усталости.", oRester, FALSE);
    };
}

