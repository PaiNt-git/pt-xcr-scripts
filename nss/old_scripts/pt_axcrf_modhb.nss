//Верхний Скрипт сердца модуля

#include "pt_axcrf_include"

void pNWNXcraftRefPlayerVars(object oPC)    //обновить значения переменных в базе
{
if(!GetIsObjectValid(oPC)) return;

string sPCcharID=GetLocalString(oPC, "pt_craft_CharID");
if(sPCcharID=="") return;

object oSkin=SKIN_SupportGetSkin(oPC);
if(!GetIsObjectValid(oSkin)) return;

int i=0;
int iEndLen=pGetModuleVarNameDumpLength();
for(i=0; i<iEndLen; i++)
    {
    int iVarType=pGetModuleVarNameDumpType(i);
    int bExist=FALSE;

    if(iVarType==pt_DBDUMP_TYPE_FLOAT || iVarType==pt_DBDUMP_TYPE_INT)
        {
        string sVarName=pGetModuleVarNameDumpString(i);
        float fCurSkillVal=GetLocalFloat(oSkin, sVarName);
        if(iVarType==pt_DBDUMP_TYPE_INT)
            {
            fCurSkillVal=IntToFloat(GetLocalInt(oSkin, sVarName));
            };


        SQLExecDirect("SELECT * FROM `pt_axcrf_table` WHERE ID = '"+SQLEncodeSpecialChars(sPCcharID)+"' AND sVar = '"+SQLEncodeSpecialChars(sVarName)+"' ; ");
        if(SQLFetch() == SQL_SUCCESS) bExist=TRUE;

        if(bExist)
            {
            SQLExecDirect("UPDATE `pt_axcrf_table` SET `fValue` = "+FloatToString(fCurSkillVal, 5, 2)+", `iType` = "+IntToString(iVarType)+" WHERE ID = '"+SQLEncodeSpecialChars(sPCcharID)+"' AND sVar = '"+SQLEncodeSpecialChars(sVarName)+"'  LIMIT 30 ;");
            }
            else
            {
            SQLExecDirect("INSERT into `pt_axcrf_table` (ID, sVar, fValue, iType) values ('"+SQLEncodeSpecialChars(sPCcharID)+"', '"+SQLEncodeSpecialChars(sVarName)+"', "+FloatToString(fCurSkillVal, 5, 2)+", "+IntToString(iVarType)+") ; ");
            };
        };
    };
}


void main()
{
    object oModule=GetModule();

    //Дампинг значений навыков из шкуры в базу
    if(pt_CRAFT_USE_NWNX && GetLocalInt(oModule, "pt_craft_box_mfirstruned") )
        {
        //Скрипт срабатывает раз в полминуты
        if(GetLocalInt(oModule, "pt_CRAFT_DUMP_TIMEOUT"))  return;
        SetLocalInt(oModule, "pt_CRAFT_DUMP_TIMEOUT", TRUE);
        DelayCommand(30.0+IntToFloat(d10()), DeleteLocalInt(oModule, "pt_CRAFT_DUMP_TIMEOUT"));

        //Поддержание соединения
        if(!GetLocalInt(oModule, "pt_CRAFT_SQLIDLE_TIMEOUT"))
            {
            SetLocalInt(oModule, "pt_CRAFT_SQLIDLE_TIMEOUT", TRUE);
            SQLExecDirect("SELECT Number FROM `pt_axcrf_boxes`; ");
            DelayCommand(200.0, DeleteLocalInt(oModule, "pt_CRAFT_SQLIDLE_TIMEOUT"));
            };

        //Навыки и крафт-параметры персонажа обновляем в базе
        object oPC=GetFirstPC();
        if(!GetIsObjectValid(oPC)) return;
        if(GetIsDM(oPC)) return;
        //Для каждого PC через задержку 5-15с запустим обновеление
        while(GetIsObjectValid(oPC))
            {
            //Чтоб событие хертбрет не срабатывало на полузашедшего игрока
            if(!GetLocalInt(oPC, "pt_PCLOGIN")) {oPC=GetNextPC(); continue;};

            DelayCommand(5.0+IntToFloat(d100())/10, pNWNXcraftRefPlayerVars(oPC));

            oPC=GetNextPC();
            };
        };
}
