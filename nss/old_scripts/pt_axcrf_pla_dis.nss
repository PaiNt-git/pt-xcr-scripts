void main()
{
int iType = GetInventoryDisturbType();
if(iType == INVENTORY_DISTURB_TYPE_ADDED) return;

object oItem = GetInventoryDisturbItem();
object oActivator = GetLastDisturbed();


if(GetLocalInt(oActivator, "pt_curCraftProcess_Mode"))
    {
    SendMessageToPC(oActivator, "Нельзя убирать предметы во время процесса");
    AssignCommand(oActivator, ActionGiveItem(oItem, OBJECT_SELF));
    };
}





