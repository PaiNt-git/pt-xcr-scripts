//������ ������� ������ � ���� � ��������� �����������

#include "pt_axcrf_include"

void main()
{

    if(pt_CRAFT_USE_NWNX)
        {
        SQLExecDirect("DELETE FROM `pt_axcrf_boxes` WHERE Number < 0; ");
        };
}
