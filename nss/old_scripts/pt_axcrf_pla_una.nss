// Для вандалов, скрипт при разрушении - инструмент пересоздается но тыкать его больше нельзя, хотя если запустить чтото рядом - он засканируется
// Надо повесить на разружение плейса
void main()
{
    object oNew=CreateObject(OBJECT_TYPE_PLACEABLE, GetResRef(OBJECT_SELF), GetLocation(OBJECT_SELF));
    SetLocalInt(oNew, "pt_CRAFT_PROCESS_NUMUSE", 0);
    SetUseableFlag(oNew, FALSE);

}
