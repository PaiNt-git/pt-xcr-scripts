
#include "pt_axcrf_md_cons"
#include "pt_frame000"

#include "x3_inc_string"


int StartingConditional()
{
int iResult;

object oModule=GetModule();
object oActivator=GetPCSpeaker();







int iMinI=0;
int iMaxI=GetLocalInt(oActivator, "pt_craft_dialNodeArray_Length")-1;

int iDialogCurMinI=GetLocalInt(oActivator, "pt_craft_dialMinI");
int iDialogCurMaxI=GetLocalInt(oActivator, "pt_craft_dialMaxI");
if(iDialogCurMaxI<=4)
    {
    iDialogCurMinI=0; iDialogCurMaxI=4;
    };


int iPageQuantity=(iMaxI)/5+1;
int iCurPage=StringToInt(StringParse(FloatToString((IntToFloat(iDialogCurMaxI))/5.0, 2, 2), "."))+1;






if(GetLocalInt(oActivator, "pt_craft_dialNodeArray_Length")>5 && iCurPage<iPageQuantity) iResult=TRUE;

return iResult;
}
