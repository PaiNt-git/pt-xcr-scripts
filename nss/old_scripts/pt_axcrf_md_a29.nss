#include "pt_axcrf_md_cons"
#include "pt_frame000"

#include "x3_inc_string"


void main()
{
object oModule=GetModule();
object oActivator=GetPCSpeaker();
object oTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");

int iChanse=GetLocalInt(oTarget, "pt_CRAFT_PROCESS_CHANCE");
float fTime=GetLocalFloat(oTarget, "pt_CRAFT_PROCESS_TIME");
float fWeary=GetLocalFloat(oTarget, "pt_CRAFT_PROCESS_WEARY");
int iMin=GetLocalInt(oTarget, "pt_CRAFT_MINQUANT");
int iMax=GetLocalInt(oTarget, "pt_CRAFT_MAXQUANT");


//��������
iMin+=1;
iMax=(iMax<iMin?iMin:iMax);
SetLocalInt(oTarget, "pt_CRAFT_MINQUANT", iMin);
SetLocalInt(oTarget, "pt_CRAFT_MAXQUANT", iMax);



//���������� ������
string sRawsWithCost="";
sRawsWithCost+="\n���� ����������: "+IntToString(iChanse)+"%";
sRawsWithCost+="\n����� ��������: "+FloatToString(fTime, 2, 2)+"�";
sRawsWithCost+="\n���������: "+FloatToString(fWeary, 2, 2)+"��.";
sRawsWithCost+="\n���������� ��� ������������: "+IntToString(iMin)+"-"+IntToString(iMax)+" ��.";


SetCustomToken(pt_CUSTTOK_NODE_CURRENT_ITEM_RAW, sRawsWithCost);
}
