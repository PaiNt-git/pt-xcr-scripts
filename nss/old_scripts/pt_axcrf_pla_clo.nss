//Активационный скрипт инструмента-плейсабла  (с инвентарем)
void main()
{
    object oModule=GetModule();
    object oActivator=GetLastClosedBy();
    object oTool=OBJECT_SELF;
    object oTarget=oActivator;


    SetLocalInt(oActivator, "pt_scanRawInTool", 1);
    SetLocalObject(oActivator, "pt_ActTool", oTool);
    SetLocalObject(oActivator, "pt_ActTarget", oTool);



    ExecuteScript("pt_axcrf_activ", oActivator);

}
