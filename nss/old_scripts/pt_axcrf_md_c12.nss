//�������� ������������ ����������� ��������. ��������� �������� ������

#include "pt_axcrf_md_cons"
#include "pt_frame000"

#include "x3_inc_string"


int StartingConditional()
{
int iResult;

object oModule=GetModule();
object oActivator=GetPCSpeaker();
object oTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");

//�������������� ��������� ������
//��� � ������������ �����
SetCustomToken(pt_CUSTTOK_TOOL, GetLocalString(oActivator, "pt_craft_dialTool")+" ("+StringToRGBString(GetName(oTarget)+"->"+"������ ������������", "700")+")");

ExecuteScript("pt_axcrf_md_a01", OBJECT_SELF);

if(GetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeRawSp")) { iResult=TRUE;};

return iResult;
}

