//������ ��� ��������. ����������� ������ ������� ������� �������, ��������� ���������� ���� "��������� ��� �������"
//�������-�����, ������� ����� � ����� - �� ������������, ������ ����� ������� �������������� ��� ��������� ��
//�������� ������ ����-����� ������� ������� � ��������� ����������� (������ ��������������� ������� ���������� ���������)

#include "pt_axcrf_md_cons"
#include "pt_frame000"

#include "x3_inc_string"


void main()
{
object oModule=GetModule();
object oActivator=GetPCSpeaker();
object oTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");

string sCustScript=GetLocalString(oTarget, "pt_CRAFT_PROCESS_PC_CUSTOM_SCRIPT");


//��������
sCustScript="pt_axcrf_pr_repa";
SetLocalString(oTarget, "pt_CRAFT_PROCESS_PC_CUSTOM_SCRIPT", sCustScript);
}
