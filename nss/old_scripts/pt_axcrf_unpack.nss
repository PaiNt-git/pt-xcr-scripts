// Скрипт инструмента (pt_CRAFT_ZCUST_ACTSCRIPT) -  распаковки инструмента из итема в плейс , выполняется после выполнения основного скрипта инструмента
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
