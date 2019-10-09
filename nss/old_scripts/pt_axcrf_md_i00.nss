//Библиотека для вызова скрипта при тычке на элемент диалога

#include "x3_inc_string"

#include "pt_frame000"

#include "pt_axcrf_md_cons"
#include "pt_axcrf_oveskin"
#include "pt_axcrf_include"


void pmain(int index)
{
object oModule=GetModule();
object oActivator=GetPCSpeaker();
object oTarget;
int i, k, z;
int bIsBook;

string sSkills;
string sSkillsVal;
string sRaws;
string sRawsCost;
string sTools;


int iSelectedIndex=GetLocalInt(oActivator, "pt_craft_dialTok"+IntToString(index)+"_Index");
SetLocalInt(oActivator, "pt_craft_dialSelectedItem", iSelectedIndex);
string sItemInd=IntToString(iSelectedIndex);

object oItem=GetLocalObject(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_Object");


string sItem=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemName");
string sItemRawTag=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemRawTag");
string sItemToolTag=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemToolTag");
string sItemSkillId=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ItemSkillId");




/////
int iRawCreRawMode=GetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeRawSp");
int iRawCreToolMode=GetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeToolSp");
int iRawCreSkillMode=GetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeSkillSp");
/////
if(iRawCreRawMode || iRawCreToolMode || iRawCreSkillMode)
    {
    object oTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");
    }
    else
    {
    object oTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsSkillStickTarget");
    };
/////


//Шкура
object oSkin=SKIN_SupportGetSkin(oTarget);

//Токен выбраного
SetCustomToken(pt_CUSTTOK_NODE_CURRENT_ITEM, sItem);

string sRawsWithCost="";


/////////
/////////


if(!iRawCreRawMode && !iRawCreToolMode && !iRawCreSkillMode)
    {
    object oTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsSkillStickTarget");


    string sSkills=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_Skills");
    string sSkillsVal=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_SkillsVal");
    string sRaws=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_RawNames");
    string sRawsCost=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_RawCost");

    string sTools=GetLocalString(oActivator, "pt_craft_dialNodeArray"+sItemInd+"_ToolNames");

    //Если диалог вызван книгой
    int bIsBook=GetLocalInt(oActivator, "pt_craft_dialToolIsBook");


    if(!GetLocalInt(oActivator, "pt_craft_dialToolIsSkillStick"))
        {
        sRawsWithCost+="\nНеобходимо: ";
        int iToolLen=pArrayLength(sTools);
        for(i=0; i<iToolLen; i++)
            {
            if(!bIsBook)
                {
                sRawsWithCost+=pArray(sTools, i)+", ";
                }
                else
                {
                string sTag=pArray(sTools, i);
                string sName=pTagDictGetWord(sTag);
                sRawsWithCost+=sName+", ";
                };
            };
        sRawsWithCost=GetSubString(sRawsWithCost, 0, GetStringLength(sRawsWithCost)-2);
        sRawsWithCost+=".";




        sRawsWithCost+="\nНеобходимые навыки: ";
        string sProcSkill=sSkills;
        string sProcSkillVal=sSkillsVal;
        int iSkillLen=pArrayLength(sProcSkill);
        int iSkillValLen=pArrayLength(sProcSkillVal);
        for(k=0; k<iSkillLen; k++)
            {
            int iValK=(k<=(iSkillValLen-1)?k:iSkillValLen-1);

            if(!bIsBook)
                {
                string sTempString=pArray(sProcSkill, k);
                float fActivatorSkill=GetLocalFloat(oSkin, "pt_craft_skill_"+pArray(sProcSkill, k)+"_value");
                float fCurItemSkill=StringToFloat(pArray(sProcSkillVal, k));

                if( fActivatorSkill<(fCurItemSkill-fCurItemSkill*0.05) ) {sTempString=StringToRGBString(sTempString, STRING_COLOR_RED);} //Red
                else if(fActivatorSkill<fCurItemSkill) {sTempString=StringToRGBString(sTempString, "055");}                          //Yelow
                else if(fActivatorSkill>=fCurItemSkill) {sTempString=StringToRGBString(sTempString, "070");};                        //Green

                sRawsWithCost+=sTempString+", ";
                }
                else
                {
                sRawsWithCost+=pArray(sProcSkill, k)+" "+pArray(sSkillsVal, iValK)+", ";
                };
            };
        sRawsWithCost=GetSubString(sRawsWithCost, 0, GetStringLength(sRawsWithCost)-2);
        sRawsWithCost+=".";


        if(sRaws!="")
            {
            sRawsWithCost+="\nНеобходимые материалы: ";
            int iRawLen=pArrayLength(sRaws);
            int iRawCostLen=pArrayLength(sRawsCost);
            for(i=0; i<iRawLen; i++)
                {
                int iValI=(i<=(iRawCostLen-1)?i:iRawCostLen-1);
                if(!bIsBook)
                    {
                    string sTempCost=pArray(sRawsCost, iValI);
                    sRawsWithCost+=pArray(sRaws, i)+": "+((sTempCost=="")?pArray(sRawsCost, pArrayLength(sTempCost)-1):sTempCost)+" ед."+", ";
                    }
                    else
                    {
                    string sTag=pArray(sRaws, i);
                    string sName=pTagDictGetWord(sTag);
                    string sTempCost=pArray(sRawsCost, iValI);
                    sRawsWithCost+=sName+" - "+((sTempCost=="")?pArray(sRawsCost, pArrayLength(sTempCost)-1):sTempCost)+" ед."+", ";
                    };
                };
            sRawsWithCost=GetSubString(sRawsWithCost, 0, GetStringLength(sRawsWithCost)-2);
            sRawsWithCost+=".";
            };
        }
        else
        {
        oSkin=SKIN_SupportGetSkin(oTarget);
        sRawsWithCost+="\nНавык у персонажа: "+FloatToString(GetLocalFloat(oSkin, "pt_craft_skill_"+sItem+"_value"), 2, 2);
        sRawsWithCost+="\nБонусы/штрафы: "+FloatToString(GetLocalFloat(oSkin, "pt_craft_skill_"+sItem+"_DMbonpen"), 2, 2);
        sRawsWithCost+="\nЗаблокирован?: "+(((GetLocalInt(oSkin, "pt_craft_skill_"+sItem+"_DMblock")<=0)?"Нет":"Да"));
        };


    if(bIsBook)
        {
        //Изучение объекта
        object oTempItem=CopyObject(oItem, GetLocation(oActivator));
        DelayCommand(0.2, AssignCommand(oActivator, ActionExamine(oTempItem)));
        DelayCommand(0.25, DestroyObject(oTempItem));
        };
    };





//string sRaws=GetLocalString(oTarget, "pt_CRAFT_RAW");
//string sRawsCost=GetLocalString(oTarget, "pt_CRAFT_RAW_COST");

//string sTools=GetLocalString(oTarget, "pt_CRAFT_TOOL");

//string sSkills=GetLocalString(oTarget, "pt_CRAFT_SKILL_ID");
//string sSkillsVal=GetLocalString(oTarget, "pt_CRAFT_SKILL_VALUE");




SetCustomToken(pt_CUSTTOK_NODE_CURRENT_ITEM_RAW, sRawsWithCost);
}
