// ������ ����������� (pt_CRAFT_ZCUST_ACTSCRIPT) -  ���������� ����������� �� ����� � ����� , ����������� ����� ���������� ��������� ������� �����������
void main()
{
    object oItem = GetItemActivated();
    location lTarget=GetItemActivatedTargetLocation();

    string sResPlace=GetLocalString(oItem, "pt_PLA_UNPACK_RR");
    if(sResPlace!="")
        {
        CreateObject(OBJECT_TYPE_PLACEABLE, sResPlace, lTarget);
        };
}
