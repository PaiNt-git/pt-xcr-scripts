//Активационный скрипт инструмента-плейсабла
void main()
{
    object oModule=GetModule();
    object oActivator=GetLastUsedBy();
    object oTool=OBJECT_SELF;
    object oTarget=oActivator;


    SetLocalObject(oActivator, "pt_ActTool", oTool);
    SetLocalObject(oActivator, "pt_ActTarget", oTool);


    ExecuteScript("pt_axcrf_activ", oActivator);

}
