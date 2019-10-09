//����������� ��� ������ ������ ������ - �������� �������� �� �����,
//����� ��������� �� ��������� ������� ��� ���������������

#include "pt_axcrf_include"


void pDestroyCreate(object oDestroy, string sResRef, int iStoreNum, int iStoreIBC, location lLoc, int iType)
{
    object oDuplBox;
    oDuplBox=SQLRCOExec("SELECT OBJ FROM `pt_axcrf_boxes` WHERE ResRef = '"+SQLEncodeSpecialChars( sResRef )+"' AND Number = "+(IntToString(iStoreNum))+"; ", lLoc, iType);
    DestroyObject(oDestroy);
}



void main()
{
    int i, k, m;
    object oModule=GetModule();
    //���� ���� ��� ������� ������ ��� ��� ������ ������
    int bIsModFirstRuned = !GetLocalInt(oModule, "pt_craft_box_mfirstruned");

    //////////////////////////////////////////////////////////////////////////////////////////
    //��� ��������� �� ����� � ��������� ����������, � ����� ��������� ����� ���������� � ����
    //����������� �������
    i=GetLocalInt(oModule, "pt_CraftItemBoxArray_curi");  //�� ����� ����� ���������� ������ ��� ����������� �������
    int iBeginItemForDump = i;
    i=(i==0)?-1:i;
    int iBoxNum=GetLocalInt(oModule, "pt_CraftItemBoxArray_curiBoxNum"); //�� ����� ������ ���������� ������ ���������� ��� ����������� �������
    int iBoxFirstStart=GetLocalInt(oModule, "pt_craft_box_mfirstboxes"); //�� ����� ������ ����������� �����������

    ///��������� ��������� �����������
    if(i == (-1) && !GetLocalInt(oModule, "pt_CraftItemBoxArray_display")) SendMessageToAllDMs("!!!\n�������� ��������������� �����-��������. \n��������� ���������..");
    if(GetLocalInt(oModule, "pt_CraftItemBoxArray_display")) SendMessageToAllDMs("!!!\n�������� ��������������� �����-��������. \n���������� �����: " +IntToString(iBoxNum)+ " ����������� � " +IntToString(i+1)+ " ���������� ������. \n��������� ���������..");
    ///

    ////////////////////////////////////////////////
    //�������������� ����, ��� ������ ������ �������
    if(pt_CRAFT_USE_NWNX && iBoxNum==0)
        {
        SetLocalString(oModule, "NWNX!INIT", "1");
        GetLocalObject(oModule, "NWNX!INIT");

        SQLInit();

        SQLExecDirect("CREATE TABLE IF NOT EXISTS `pt_axcrf_table` (ID CHAR(30), sVar CHAR(60), fValue FLOAT, iType INT(1) default "+IntToString(pt_DBDUMP_TYPE_FLOAT)+") COLLATE='latin1_general_ci' ;");

        SQLExecDirect("CREATE TABLE IF NOT EXISTS `pt_axcrf_boxes` (OBJ MEDIUMBLOB NOT NULL, ResRef VARCHAR(18) NOT NULL DEFAULT '', Number SMALLINT NULL DEFAULT '0', ItemsCount INT NOT NULL DEFAULT '0');");

        SQLExecDirect("CREATE TABLE IF NOT EXISTS `pt_axcrf_varimport` (ID VARCHAR(100), sTools VARCHAR(100), sSkills VARCHAR(150),  sSkillsVal VARCHAR(100), sRaws VARCHAR(150),  sRawsCost VARCHAR(100), fWeary FLOAT, fTime FLOAT, iChanceToCreate INT NOT NULL DEFAULT '0', iMinQuant INT NOT NULL DEFAULT '0',  iMaxQuant INT NOT NULL DEFAULT '0',   sScript VARCHAR(100) );");
        };


    ///////////////////////////
    //������ ��������� � ������
    int bHasNew=FALSE;
    object oTargetBox=GetObjectByTag("pt_craft_box", iBoxNum);
    if(!GetIsObjectValid(oTargetBox))  return;


    ///////////////////////////////////////////////////
    // �������� �� ������
    int bStopped=FALSE, bAllBoxes=FALSE;
    while(GetIsObjectValid(oTargetBox))
        {
        //���������� �����-�����������, ������� �� ���� ������� ����� ������� ������
        if(bIsModFirstRuned)
            {
            SetLocalInt(oTargetBox, "pt_craft_box_prime", TRUE);
            SetLocalInt(oTargetBox, "pt_craft_box_number", iBoxNum+1);
            iBoxFirstStart++;
            SetLocalInt(oModule, "pt_craft_box_mfirstboxes", iBoxFirstStart);
            };

        //��������� ����������
        object oTempItem=GetFirstItemInInventory(oTargetBox);
        int iBC=1, ico=0; //����� ���� ����, ����� ��������� ���� ��������� �������� ������������ ����� � ����������
        while(GetIsObjectValid(oTempItem))
            {
            //������ ��� ����� � �������� ������
            pTagDictAddWord(GetTag(oTempItem), GetName(oTempItem));

            i++; ico++; //�������� ����� ����� �������������� �� ������� ������ ������ � ������ � ����� �������������
            SetLocalInt(oModule, "pt_CraftItemBoxArray_curi", i);
            SetLocalInt(oModule, "pt_CraftItemBoxArray_Length", i+1); //������ ������ ������ (���� ������)

            //������� ������ �� ����� �� ���� ���� ��� ���� �� ������� ����������
            if(pt_CRAFT_USE_NWNX && bIsModFirstRuned) pRefreshCraftVars(oTempItem);

            //���������� ������ ������� ����� ���������� _�������_
            string sSkills=GetLocalString(oTempItem, "pt_CRAFT_SKILL_ID");
            string sSkillsVal=GetLocalString(oTempItem, "pt_CRAFT_SKILL_VALUE");
            string sRaws=GetLocalString(oTempItem, "pt_CRAFT_RAW");
            string sRawsCost=GetLocalString(oTempItem, "pt_CRAFT_RAW_COST");
            string sTools=GetLocalString(oTempItem, "pt_CRAFT_TOOL");

            //�������������� �� ���� ����� ������ ����� �� "�������������" "��������� ������������"
            if (
                sSkills=="" &&
                sSkillsVal=="" &&
                sRaws=="" &&
                sRawsCost=="" &&
                sTools=="")
                {  sTools="%NO_SETTINGS%";     SetLocalString(oTempItem, "pt_CRAFT_TOOL", "%NO_SETTINGS%");   };

            // _�������_
            iBC=iBC+ico+  (
                        GetStringLength( GetName(oTempItem) ) +
                        StringToInt( pArray(sSkillsVal, 0) ) +
                        StringToInt( pArray(sRawsCost, 0) ) +
                        GetStringLength( sRaws+sTools  ) -
                        GetStringLength( sSkills )
                        )/3;
            SetLocalObject(oModule, "pt_CraftItemBoxArray"+IntToString(i), oTempItem);  //��� ����� ��� �������

            //� ���������� ����� �����
            oTempItem=GetNextItemInInventory(oTargetBox);
            };
        //�������� �������� �� ����� ������������ � ����������
        SetLocalInt(oTargetBox, "pt_craft_box_ibc", iBC);

        //////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //��� �����������, ���� ����� �� ���������� ������������������ � ���� ������� �� ����������� - �� ������� ����
        iBoxNum++;
        SetLocalInt(oModule, "pt_CraftItemBoxArray_curiBoxNum", iBoxNum);
        oTargetBox=GetObjectByTag("pt_craft_box", iBoxNum);
        if(!GetIsObjectValid(oTargetBox)) bAllBoxes=TRUE;
        //������������ �� ��������� ����������� �� ��� ������� ������ 1 ����� ������ �� �����
        if(!bAllBoxes && iBoxNum-GetLocalInt(oModule, "pt_CraftItemBoxArray_stopiBoxNum")>=pt_CRFPERFOMANCE_MODULE_MAXBOX_IN_SCRIPT)
            {
            bStopped=TRUE; SetLocalInt(oModule, "pt_CraftItemBoxArray_stopiBoxNum", iBoxNum);
            oTargetBox=OBJECT_INVALID;
            continue;
            };
        };
        //���� _����_ ���������� (������ �� ���� ��� � ������) PC ����������� � �������� � ����
        // �.�. ����-������� ������� ������� ������ ���� ������ �� � ��������� �������� ��������� ����� (������� �� ���������� ��� ����������� �������)
        // ������ � ������ ����� � ���� �������� ��������������. � ����� ���������� ��� ���� ������ ���� "����������" � ����������� ����� ������ �� ���
        pCreateModuleVarNameDump(iBeginItemForDump);



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//��� �����������, ���� ��� �� ����������������� ��� �����, � ������ �� ��� ���������� (����� ���������� ����� �� �����
//� pt_CRFPERFOMANCE_MODULE_MAXBOX_IN_SCRIPT, �� ���������� �������� ������  � ��������� (����������� �� ��������� ������)
if(!bAllBoxes && ( bStopped ) )
            {
            DelayCommand(pt_CRFPERFOMANCE_MODULE_MAXTIME_OF_SCRIPT, ExecuteScript("pt_axcrf_modlod", oModule));
            return;
            };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//������������� ���� ����������� ������ ����� ��� ����� (������) ������� ���������, � ����������������� ��� �����
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        //����� ���������� ����������� ��� ������ ������ ������ ������
        SetLocalInt(oModule, "pt_craft_box_mfirstruned", TRUE);
        SetLocalInt(oModule, "pt_CraftItemBoxArray_curiBoxNum", 0);
        SetLocalInt(oModule, "pt_CraftItemBoxArray_stopiBoxNum", 0);
        SetLocalInt(oModule, "pt_CraftItemBoxArray_curi", 0);


        /////////////////////////////////////////////////////////////////////
        //�������� ����������� ������� ���� � ������ ������(��� ������ ������)
        int bHasNewBox=FALSE;
        if(pt_CRAFT_USE_NWNX && bIsModFirstRuned)
            {
            //�������� ����������� ������� ���� � ������ ������ (�� ��� ���� ������ ������� ����� ���������� ������� - �� �� ����� �������)
            //������� �������� ������� ����� ��������
            int iFuckenModuleArrayIndex=-1;
            SQLExecDirect("SELECT Number FROM `pt_axcrf_boxes` WHERE Number < 0; ");
            while(SQLFetch() == SQL_SUCCESS)
                {
                iFuckenModuleArrayIndex++;
                int iNotPrimeNumb = StringToInt(SQLGetData(1));

                SetLocalInt(oModule, "pt_craft_box_fuckenArray"+IntToString(iFuckenModuleArrayIndex), iNotPrimeNumb);
                };
            //��������� �������� ���������� ��������
            if(iFuckenModuleArrayIndex>-1)
                {
                int k;
                for(k=0; k<=iFuckenModuleArrayIndex; k++)
                    {
                    object oNewBox = SQLRCOExec("SELECT OBJ FROM `pt_axcrf_boxes` WHERE Number = "+(IntToString(GetLocalInt(oModule, "pt_craft_box_fuckenArray"+IntToString(k))))+"; ", pt_GetRandomLocation(GetObjectByTag("pt_craft_box"), 2.0, TRUE), OBJECT_TYPE_PLACEABLE);

                    //������� �������� �� �����, � ���� �� �������� ������������ ������� -
                    // ��� �������� ��� ������� � ���� � �������� ��� �������� ��� :(
                    string sLoc=GetLocalString(oNewBox, "pt_craft_box_location");
                    location lLoc=pGetLocationFromString(sLoc);

                    //�������� ����� ���������� ����� - ��� ���� ����� ����� ������ ������������� ��������� � �� ������������
                    iBoxFirstStart++;
                    SetLocalInt(oModule, "pt_craft_box_mfirstboxes", iBoxFirstStart);
                    bHasNewBox=TRUE; //���� ��� ���� ����� ��������� ����� ����� � ������� �� ������������
                    };
                };
            };

        ///////////////////////////////////////////////////////////////////////
        //���������� ��� ���������(���������� � ������) ����� ���������� � ����
        int bHasRefreshBox=FALSE;
        if(pt_CRAFT_USE_NWNX)
            {
            ///////////////////////////////////////////////////
            // �������� �� ������ ����� ����������� �������
            int iBoxNum=0; //��� ������ ����������� ��� ����� ��������� �� ������� ������ � ������
            object oTargetBox=GetObjectByTag("pt_craft_box", iBoxNum);
            if(!GetIsObjectValid(oTargetBox))  return;
            while(GetIsObjectValid(oTargetBox))
                {
                //�������� _�������_ ����� �������� ��� � ���, ������� � ����
                //� ������ ��������� �� ������� � ������� ���������� ������� ����� �������
                int iBC=GetLocalInt(oTargetBox, "pt_craft_box_ibc");
                //��� �����-������������� ��� ������� �������� ������� � ����.
                // ������������� ��� � ���� �������� ���������� � "0" - �� � ���������� pt_craft_box_number
                // ������� �� ����� ���� �������� �� ��������� � aeyrwbb GetLocalInt = 0 - ���������� ������� �������� �� 1 ������
                int iStoreNum=GetLocalInt(oTargetBox, "pt_craft_box_number")-1;

//���������� � ������� ����� ��� ������� ������������ �� ���������
// 1. �����-��������� - ������ � ������� - ���� ��� ������ ������
// 2. �� �����-��������� - ������ ����� ������ ������.

                //////////////////
                //�����-����������
                if(GetLocalInt(oTargetBox, "pt_craft_box_prime"))
                    {
                    if(iStoreNum==-1) //���� ���������� �� �����������(�������� 0 - 1 = -1) - ����� iBoxNum
                        {
                        iStoreNum=iBoxNum;
                        SetLocalInt(oTargetBox, "pt_craft_box_number", iBoxNum+1);
                        };
                    SQLExecDirect("SELECT ItemsCount FROM `pt_axcrf_boxes` WHERE ResRef = '"+SQLEncodeSpecialChars(GetResRef(oTargetBox))+"' AND Number = "+(IntToString(iStoreNum))+"; ");

                    /////////////////////////////////////////////////////////////
                    //���� � ���� ���� ��������� ��� ���� ������� �����-���������
                    if(SQLFetch() == SQL_SUCCESS)
                        {
                        int iSQLBC=StringToInt(SQLGetData(1));
                        //debug
                        //SendMessageToAllDMs("��������� " + IntToString(iStoreNum) + " iBC=" + IntToString(iBC) + " iSQLBC=" +IntToString(iSQLBC));

                        //���� ������ ������� ������ ��� � SQL-������� �� ����� ���� (�� ������� � ���� � ���� ������� �������� ���)
                        //��� ������� ��� ������ ����� ���������� � ���� ��� �������������
                        if(bIsModFirstRuned && iSQLBC!=0)
                            {
                            bHasRefreshBox=TRUE; //���� ��� ���� ���������� ��� ����������(������ ������������)
                            DelayCommand(2.5, pDestroyCreate(oTargetBox, GetResRef(oTargetBox), iStoreNum, iSQLBC, GetLocation(oTargetBox), GetObjectType(oTargetBox)));
                            }
                            //���� ������� ������ �� ����� �������
                            //��������� �������� � ���� �� ������
                            else if(iBC!=iSQLBC)
                            {
                            SetLocalInt(oTargetBox, "pt_craft_box_number", iStoreNum+1);
                            SetLocalInt(oTargetBox, "pt_craft_box_ibc", iBC);

                            SQLSCOExec("UPDATE `pt_axcrf_boxes` SET `ItemsCount` = "+(IntToString(iBC))+", `OBJ` = %s  WHERE  ResRef = '"+SQLEncodeSpecialChars(GetResRef(oTargetBox))+"' AND Number = "+(IntToString(iStoreNum))+" LIMIT 1;", oTargetBox);
                            };
                        }

                        ///////////////////////////////////////////////////////////////////////////////////
                        //���� � ���� ���� �����-���������� � ������ ������� - ��������(�������) ��� � ���
                        else
                        {
                        SetLocalInt(oTargetBox, "pt_craft_box_number", iStoreNum+1);
                        SetLocalInt(oTargetBox, "pt_craft_box_ibc", iBC);

                        SQLSCOExec("INSERT into `pt_axcrf_boxes` (OBJ, ResRef, Number, ItemsCount) values (%s, '"+SQLEncodeSpecialChars(GetResRef(oTargetBox))+"', "+(IntToString(iStoreNum))+", "+(IntToString(iBC))+") ; ", oTargetBox);
                        };
                    }
                    /////////////////////
                    //�� ����� ����������
                    else
                    {
                    //������ �������� ���������� �� ����
                    int iSQLBC=0;
                    SQLExecDirect("SELECT ItemsCount FROM `pt_axcrf_boxes` WHERE ResRef = '"+SQLEncodeSpecialChars(GetResRef(oTargetBox))+"' AND Number = "+(IntToString(GetLocalInt(oTargetBox, "pt_craft_box_number")+1))+"; ");
                    if(SQLFetch() == SQL_SUCCESS) iSQLBC=StringToInt(SQLGetData(1));

                    //���� �� ���������� ������ ���� ������� ������� � ��� ������ - ������
                    //��� ������� ����� ����������� � ����� �������� ��� � ����.
                    //�� ����� ���������� ����� ���� �����-������������� - �������������, ��� ��������
                    //�� �� ��������� ���������� ������� ������� �����������, �������� ���� ����������
                    // 0, 1, .. 20, 21, *� ���������� ��� ����������� ������* -22, -23 � �.�. ��� ��� ��������� ����������� (�� �����)
                    // ���� ������� ����� ������ ������ � ��������� � ����.
                    if(!GetLocalInt(oTargetBox, "pt_craft_box_number"))
                        {
                        bHasNew=TRUE; //���� ��� ���� ����� ��������� �� ����� ����������
                        SetLocalInt(oTargetBox, "pt_craft_box_number", 0-(iBoxFirstStart+1) );
                        SetLocalInt(oTargetBox, "pt_craft_box_ibc", iBC);
                        SetLocalString(oTargetBox, "pt_craft_box_location", pGetStringFromLocation(GetLocation(oTargetBox)));

                        SQLSCOExec("INSERT into `pt_axcrf_boxes` (OBJ, ResRef, Number, ItemsCount) values (%s, '"+SQLEncodeSpecialChars(GetResRef(oTargetBox))+"', "+(IntToString( 0-(iBoxFirstStart) ))+", "+(IntToString(iBC))+") ; ", oTargetBox);
                        iBoxFirstStart++;
                        SetLocalInt(oModule, "pt_craft_box_mfirstboxes", iBoxFirstStart);
                        }
                        //���� ������� �� ���� �� ������ �� ����� �������� �� ����������
                        //��������� �������� � ����
                        else if(iBC!=iSQLBC)
                        {
                        SetLocalInt(oTargetBox, "pt_craft_box_ibc", iBC);

                        SQLSCOExec("UPDATE `pt_axcrf_boxes` SET `ItemsCount` = "+(IntToString(iBC))+", `OBJ` = %s  WHERE  ResRef = '"+SQLEncodeSpecialChars(GetResRef(oTargetBox))+"' AND Number = "+(IntToString(GetLocalInt(oTargetBox, "pt_craft_box_number")+1))+" LIMIT 1;", oTargetBox);
                        };
                    };

                iBoxNum++;
                oTargetBox=GetObjectByTag("pt_craft_box", iBoxNum);
                };
            };

//���� ���� ������������� ����������, �� ������ ������� ��������� � ��������������� � �.�. -
//- �������� ����������� ������ (�� ������ ��� �� ����� ����� ���� bIsModFirstRuned)
if(bHasRefreshBox || bHasNewBox) {SetLocalInt(oModule, "pt_CraftItemBoxArray_display", TRUE);   DelayCommand(4.5, ExecuteScript("pt_axcrf_modlod", oModule));   return;};
SetLocalInt(oModule, "pt_CraftItemBoxArray_display", FALSE);
DelayCommand(10.0, SendMessageToAllDMs("!!!\n��������������� �����-�������� ���������. �������� ����.."));
}

