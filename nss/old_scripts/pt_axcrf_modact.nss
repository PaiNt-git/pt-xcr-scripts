//������� ������ ��������� �����

void main()
{
     object oItem = GetItemActivated();

    //��������-����������� ������������
    if(GetStringLeft(GetTag(oItem), 14)=="pt_craft_tool_")
        {
        object oActivator=GetItemActivator();

        //��������� ���������� ��� ���-�������
        SetLocalObject(oActivator, "pt_ActTool", oItem);
        SetLocalObject(oActivator, "pt_ActTarget", GetItemActivatedTarget());

        //�������� ������ ���������� �����������, ������ ������ ����������� �� ���� ����������
        ExecuteScript("pt_axcrf_activ", oActivator);


        //�������������� ������ ��������� ������� ����������� ����� ���������
        string sCustomScript=GetLocalString(oItem, "pt_CRAFT_ZCUST_ACTSCRIPT");
        if(sCustomScript!="")
            {
            object oModule=GetModule();
            ExecuteScript(sCustomScript, oModule);
            };
        };
}
