#include "pt_axcrf_include"
void main()
{
object oModule=GetModule();
object oPC=GetLastUsedBy();

int iBoxNum = GetLocalInt(oModule, "pt_craft_stats_iter");
int iMaxIItem=GetLocalInt(oModule, "pt_CraftItemBoxArray_Length");

object oTargetBox=GetObjectByTag("pt_craft_box", iBoxNum);
if(!GetIsObjectValid(oTargetBox))
    {
    SetLocalInt(oModule, "pt_craft_stats_iter", 0);

    SendMessageToPC(oPC, "=======END========");
    return ;
    };

while(GetIsObjectValid(oTargetBox))
    {
    iBoxNum++;

    object oCrfTit=GetFirstItemInInventory(oTargetBox);
    while(GetIsObjectValid(oCrfTit))
        {
            string sSkills=GetLocalString(oCrfTit, "pt_CRAFT_SKILL_ID");
            string sSkillsVal=GetLocalString(oCrfTit, "pt_CRAFT_SKILL_VALUE");
            string sRaws=GetLocalString(oCrfTit, "pt_CRAFT_RAW");
            string sRawsCost=GetLocalString(oCrfTit, "pt_CRAFT_RAW_COST");
            string sTools=GetLocalString(oCrfTit, "pt_CRAFT_TOOL");


            string sSkills1=sSkills;
            string sRaws1=sRaws;
            string sTools1=sTools;


            int i;
            for(i=0; i<pArrayLength(sTools); i++)
                {
                string sTag=pArray(sTools, i);
                object oTag=GetObjectByTag(sTag);

                sTools1=pGetStringReplace(sTools1, sTag, GetName(oTag));
                };


            for(i=0; i<pArrayLength(sSkills); i++)
                {
                string sTag=pArray(sSkills, i);

                sSkills1=pGetStringReplace(sSkills1, sTag, sTag + " " + pArray(sSkillsVal, i));
                };


            for(i=0; i<pArrayLength(sRaws); i++)
                {
                string sTag=pArray(sRaws, i);
                sRaws1=pGetStringReplace(sRaws1, sTag, sTag + " " + pArray(sRawsCost, i));
                };




//Строка
string somstr=
" "
+
GetName(oCrfTit)
+
"====="
+
sSkills1
+
"====="
+
sTools1
+
"====="
+
sRaws1
;




            //Строка
            SendMessageToPC(oPC, somstr);


            oCrfTit=GetNextItemInInventory(oTargetBox);
        };

    oTargetBox=GetObjectByTag("pt_craft_box", iBoxNum);
    SetLocalInt(oModule, "pt_craft_stats_iter", iBoxNum);
    return;
    };
}
