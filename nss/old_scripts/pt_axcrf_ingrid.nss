//Скрипт он-спавн генерирования ингридиентов в рюкзаке моба

#include "pt_frame000"

void main()
{
object oModule=GetModule();
object oCaller=OBJECT_SELF;

int z;
int iBoxNum = 0;
int iMaxIItem=GetLocalInt(oModule, "pt_CraftItemBoxArray_Length");
object oTargetBox=GetObjectByTag("pt_craft_box", iBoxNum);

while(GetIsObjectValid(oTargetBox))
    {
    iBoxNum++;
    int iItemInBox=0;

    if(GetLocalInt(oTargetBox, "pt_CRAFT_IS_LOOTBOX"))  //Допущение - в модуле только один-два небольшых боченка специально для ингридиентов в луте мобов
        {
        object oCrfTit=GetFirstItemInInventory(oTargetBox);
        while(GetIsObjectValid(oCrfTit))
            {
            iItemInBox++;

            string sTool=GetLocalString(oCrfTit, "pt_CRAFT_TOOL"); //Допущение - в инструментах задано только одно значение
            if(sTool==GetTag(oCaller))
                {
                int iChanceToCreate=GetLocalInt(oCrfTit, "pt_CRAFT_PROCESS_CHANCE");

                if(pResponse(iChanceToCreate))
                    {
                    int iMinQuant=GetLocalInt(oCrfTit, "pt_CRAFT_MINQUANT");
                    int iMaxQuant=GetLocalInt(oCrfTit, "pt_CRAFT_MAXQUANT");
                    int iQuant=iMinQuant+Random(1+iMaxQuant-iMinQuant);
                    iQuant=(iQuant<1)?1:iQuant;

                    int iQ; for(iQ=1; iQ<=iQuant; iQ++) {object oCopyItem=CopyItem(oCrfTit, oCaller, TRUE); SetDroppableFlag(oCopyItem, TRUE);};
                    };
                };
            oCrfTit=GetNextItemInInventory(oTargetBox);
            };
        };
    oTargetBox=GetObjectByTag("pt_craft_box", iBoxNum);
    };
}
