//������ ������ ������

#include "pt_axcrf_include"


void main()
{
    //������� �� ����� � ����
    if(pt_CRAFT_USE_NWNX)
        {
        object oPC=GetExitingObject();
        if(GetIsDM(oPC)) return;
        //
        SetLocalInt(oPC, "pt_PCLOGIN", FALSE);
        // ������ �������� ��� ������ ������ �� �����, ���������� � ���� ������ ��� � ������
        return;
        //
        //................����� ��� ��� ���������� ���������� � ���� ;).....................
        //
        };
}
