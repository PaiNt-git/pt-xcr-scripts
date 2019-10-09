//Верхний скрипт активации итема

void main()
{
     object oItem = GetItemActivated();

    //Предметы-инструменты активируются
    if(GetStringLeft(GetTag(oItem), 14)=="pt_craft_tool_")
        {
        object oActivator=GetItemActivator();

        //Служебные переменные для акт-скрипта
        SetLocalObject(oActivator, "pt_ActTool", oItem);
        SetLocalObject(oActivator, "pt_ActTarget", GetItemActivatedTarget());

        //Основной скрипт активвации инструмента, должен всегда запускаться от лица активатора
        ExecuteScript("pt_axcrf_activ", oActivator);


        //Дополнительный скрипт активации который запускается после основного
        string sCustomScript=GetLocalString(oItem, "pt_CRAFT_ZCUST_ACTSCRIPT");
        if(sCustomScript!="")
            {
            object oModule=GetModule();
            ExecuteScript(sCustomScript, oModule);
            };
        };
}
