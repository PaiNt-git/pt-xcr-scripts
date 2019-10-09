//������������� ������ ��������� �����������, � ��� ��������� ��������� ���������
//���������� �� ���� ������ ���������� ���������-��������� (��������� ��������, �������� � ���, ������ �� ��������, �������� �� ��������)
//

#include "pt_axcrf_include"


//////////////////////////////////////////////////////
//////////////////////////////////////////////////////




void main()
{
    //��������� ����������///////////////////////////////
    object oModule=GetModule();
    object oActivator=OBJECT_SELF;
    if(GetLocalInt(oActivator, "pt_curCraftProcess_Mode")) return;
    object oTool=GetLocalObject(oActivator, "pt_ActTool");
    object oTarget=GetLocalObject(oActivator, "pt_ActTarget");

    int bScanRawInToolInventory=GetLocalInt(oActivator, "pt_scanRawInTool");
    int bIsVendor=FALSE; //��� ��������� �� "�������" ����-��, �������� � ��� ������ ��� �����-�� �����-������ � ��������� ����
    object oParentRawTarget;
    object oCrftItem;


    //����������� ��������� ��������
    object oActItem=GetFirstItemInInventory(oActivator);
    int iArrayNum=-1; string sArrayNum="";
    //����������� ��������� ����������� �����������
    object oToolItem=bScanRawInToolInventory? GetFirstItemInInventory(oTool) : OBJECT_INVALID;
    int iToolItemArrayNum=-1; string sToolItemArrayNum="";



    //����������� � �������
    //������� ������ � ������ �� ������� ����� �������. �� ������� � �����������
    int iBeginItem=GetLocalInt(oActivator, "pt_craft_BeginAnalisisNum");
    int iMaxIItem=GetLocalInt(oModule, "pt_CraftItemBoxArray_Length");
    if(iBeginItem+pt_CRFPERFOMANCE_ACTIVATE_MAXITEMS_IN_SCRIPT>=iMaxIItem) DeleteLocalObject(oActivator, "pt_ActTarget");

    //����� ���������� (�������� �� ���� �������������� �����������, �� ��� �������� ���������� ������ � ������ ����)
    object oSkin=SKIN_SupportGetSkin(oActivator);

    //��� �����������, ������� ������ ������
    string sToolTag=GetTag(oTool);

    //���������� ��� ����������� �����������, ������ ��� ���� ����� ������� ������ ������� �� ���� ��� ��������� � ������� ������ �������� ��� �� �����-�� ��������,
    //� ����������� ������� ������ � ��������� �� �������������� ���������� ��� -
    //��� ��� � ������ ���������� ������ ���� ��� ����� ����� �������������� - ����� ���������� �������� ������ �������� ������������ ��� ������� ������
    string sTOverlayTag=GetLocalString(oTool, "pt_CRAFT_OVERLAY_TAG");
    if(sTOverlayTag!="") sToolTag=sTOverlayTag;
    if(GetStringRight(sToolTag, 5)=="_port") //����� ����������� ����������� ����������� ���������
        {
        sToolTag=GetStringLeft(sToolTag, GetStringLength(sToolTag)-5);
        };
    //debug
    //SendMessageToPC(GetFirstPC(), "�������� sToolTag = "+sToolTag);


    // �������������
    effect eCuImm=EffectCutsceneImmobilize();
    eCuImm=ExtraordinaryEffect(eCuImm);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCuImm, oActivator, pt_CRFPERFOMANCE_ACTIVATE_MAXTIME_OF_SCRIPT+0.05);


    /////////////////////////////////////////////////////
    /////////////////////////////////////////////////////
    /////////////////////////////////////////////////////

    //����������� //////////////////////////////////////////
    //������� ������� � ���������� ������������ ����� �������
    int iNumDialogNodes=-1;
    if(iBeginItem<=0)  //���� ������ �������� �� ������������
        {
            //�����������
            pInitProgressBar(oTool, iMaxIItem);
            pClearDialogTokensVars(oActivator); iNumDialogNodes=-1;
            pClearServiceVars(oActivator);
        }
        else
        {
            //�����������
            pSetProgressBar(oTool, iBeginItem);
            iNumDialogNodes=(GetLocalInt(oActivator, "pt_craft_currentNumDialogNodes")<=0)?-1:GetLocalInt(oActivator, "pt_craft_currentNumDialogNodes")-1;
        };
    //debug
    //SendMessageToPC(GetFirstPC(), "�������� iNumDialogNodes = "+IntToString(iNumDialogNodes));


    //����������� //////////////////////////////////////////
    if(iBeginItem<=0)  //���� ������ �������� �� ������������
        {
        //������� ��� �����������,������� ������ ������ ��� �������
        SetLocalString(oActivator, "pt_craft_dialTool", GetName(oTool));
        //������� ��������� ������������ ����������, ����� �������������� � �������� ��������.
        SetLocalObject(oActivator, "pt_craft_lastUsedTool", oTool);



        //1./////////////////////////////////////////////////
        //��������� �������� ��� ���������� ��������
        /////////////////////////////////////////////////////
        //
        //������� ����� ������������(��������� �����������)
            if(sToolTag=="pt_craft_tool_DMs10")
            {
            if(GetObjectType(oTarget)!=OBJECT_TYPE_ITEM && GetObjectType(oTarget)!=OBJECT_TYPE_PLACEABLE && GetObjectType(oTarget)!=OBJECT_TYPE_CREATURE) {FloatingTextStringOnCreature("�� ���������� �������.", oActivator, FALSE); return;};

            SetLocalInt(oActivator, "pt_craft_dialToolIsToolTool", TRUE);
            SetLocalObject(oActivator, "pt_craft_dialToolIsToolToolTarget", oTarget);

            AssignCommand(oActivator, ActionStartConversation(oActivator, "pt_axcrf_main", TRUE, FALSE));
            return;
            }


        //2./////////////////////////////////////////////////
        /////////////////////////////////////////////////////
        //��������� �������� ��� ����� � ������� ������������
        /////////////////////////////////////////////////////
        /////////////////////////////////////////////////////
        //
        //������� c���� �������������(�������������� ����� � �����)
            else if(sToolTag=="pt_craft_tool_DMs01")
            {
            if(GetObjectType(oTarget)!=OBJECT_TYPE_ITEM) {DeleteLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget"); FloatingTextStringOnCreature("�� ���������� �������.", oActivator, FALSE); return;};

            SetLocalInt(oActivator, "pt_craft_dialToolIsRawCreateSp", TRUE);
            SetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget", oTarget);


            //������� ���������� ��� �������
            string sRawsString=GetLocalString(oTarget, "pt_CRAFT_RAW"), sToolsString=GetLocalString(oTarget, "pt_CRAFT_TOOL"), sSkillsString=GetLocalString(oTarget, "pt_CRAFT_SKILL_ID"), sRTtempstring, sNumDialogNodes;
            int x, iRawLen=pArrayLength(sRawsString), iToolLen=pArrayLength(sToolsString), iSkillLen=pArrayLength(sSkillsString);

            int iNumDialogNodes=-1;
            for(x=0; x<iRawLen; x++)
                {
                sRTtempstring=pArray(sRawsString, x);
                if(sRTtempstring=="") continue;

                iNumDialogNodes++;
                sNumDialogNodes=IntToString(iNumDialogNodes);

                SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_ItemRawTag", sRTtempstring);
                };
            iNumDialogNodes=-1;
            for(x=0; x<iToolLen; x++)
                {
                sRTtempstring=pArray(sToolsString, x);
                if(sRTtempstring=="") continue;

                iNumDialogNodes++;
                sNumDialogNodes=IntToString(iNumDialogNodes);

                SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_ItemToolTag", sRTtempstring);
                };
            iNumDialogNodes=-1;
            for(x=0; x<iSkillLen; x++)
                {
                sRTtempstring=pArray(sSkillsString, x);
                if(sRTtempstring=="") continue;

                iNumDialogNodes++;
                sNumDialogNodes=IntToString(iNumDialogNodes);

                SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_ItemSkillId", sRTtempstring);
                };

            //������� ������ �������
            SetLocalInt(oActivator, "pt_craft_dialNodeArray_Length", iRawLen+((iRawLen<iToolLen)?abs(iRawLen-iToolLen):0));
            //debug
            //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' ������ ������ � ����������");


            AssignCommand(oActivator, ActionStartConversation(oActivator, "pt_axcrf_main", TRUE, FALSE));
            return;
            }
        //
        //
        //����� ����� �����(���������� ����� � �����)
            else if(sToolTag=="pt_craft_tool_DMs02")
            {
            oParentRawTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");
            if(!GetIsObjectValid(oParentRawTarget)) {FloatingTextStringOnCreature("�� �� ������� ������� ��� �������������� � ������� ����� �������������.", oActivator, FALSE); return;};

            if(GetIsObjectValid(oTarget) && GetObjectType(oTarget)==OBJECT_TYPE_ITEM)
                {
                FloatingTextStringOnCreature("������� �������� � �������� ����� � '"+GetName(oParentRawTarget)+"'" , oActivator, FALSE);
                }
                else
                {
                FloatingTextStringOnCreature("�� ���������� �������.", oActivator, FALSE);
                SetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeRawSp", TRUE);
                AssignCommand(oActivator, ActionStartConversation(oActivator, "pt_axcrf_main", TRUE, FALSE));
                return;
                };

            //������� ���������� ��� �������
            string sRawsString=GetLocalString(oParentRawTarget, "pt_CRAFT_RAW");
            int iRawLen=pArrayLength(sRawsString);

            int iNumDialogNodes=iRawLen;
            iNumDialogNodes++;
            string sNumDialogNodes=IntToString(iNumDialogNodes);

            SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_ItemRawTag", GetTag(oTarget));
            if(sRawsString!="") {sRawsString+=","+GetTag(oTarget);} else{sRawsString=GetTag(oTarget);};
            SetLocalString(oParentRawTarget, "pt_CRAFT_RAW", sRawsString);

            //������� ������ �������
            SetLocalInt(oActivator, "pt_craft_dialNodeArray_Length", iNumDialogNodes);
            //debug
            //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' ������ ������ � ����������");

            SetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeRawSp", TRUE);
            AssignCommand(oActivator, ActionStartConversation(oActivator, "pt_axcrf_main", TRUE, FALSE));

            return;
            }
        //
        //
        //����� ����� ������������(���������� ����������� � �����)
            else if(sToolTag=="pt_craft_tool_DMs04")
            {
            oParentRawTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");
            if(!GetIsObjectValid(oParentRawTarget)){FloatingTextStringOnCreature("�� �� ������� ������� ��� �������������� � ������� ����� �������������.", oActivator, FALSE);return;};

            if(GetIsObjectValid(oTarget))
                {
                FloatingTextStringOnCreature("������� �������� � �������� ����������� � '"+GetName(oParentRawTarget)+"'" , oActivator, FALSE);
                }
                else
                {
                FloatingTextStringOnCreature("�� ���������� �������.", oActivator, FALSE);
                SetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeToolSp", TRUE);
                AssignCommand(oActivator, ActionStartConversation(oActivator, "pt_axcrf_main", TRUE, FALSE));
                return;
                };
            //������� ���������� ��� �������
            string sToolsString=GetLocalString(oParentRawTarget, "pt_CRAFT_TOOL");
            int iToolLen=pArrayLength(sToolsString);

            int iNumDialogNodes=iToolLen;
            iNumDialogNodes++;
            string sNumDialogNodes=IntToString(iNumDialogNodes);

            SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_ItemToolTag", GetTag(oTarget));
            if(sToolsString!="") {sToolsString+=","+GetTag(oTarget);} else{sToolsString=GetTag(oTarget);};
            SetLocalString(oParentRawTarget, "pt_CRAFT_TOOL", sToolsString);

            //������� ������ �������
            SetLocalInt(oActivator, "pt_craft_dialNodeArray_Length", iNumDialogNodes);
            //debug
            //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' ������ ������ � ����������");

            SetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeToolSp", TRUE);
            AssignCommand(oActivator, ActionStartConversation(oActivator, "pt_axcrf_main", TRUE, FALSE));

            return;
            }
        //
        //
        //����� ����� �������(���������� ������ � �����)
            else if(sToolTag=="pt_craft_tool_DMs06")
            {
            oParentRawTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");
            if(!GetIsObjectValid(oParentRawTarget)){FloatingTextStringOnCreature("�� �� ������� ������� ��� �������������� � ������� ����� �������������.", oActivator, FALSE);return;};

            FloatingTextStringOnCreature("����������� ������������� ������", oActivator, FALSE);

            SetLocalInt(oActivator, "pt_craft_dialToolIsRawCreateSkillSt", TRUE);

            return;
            }
        //
        //
        //����� ����� ��������� �����
            else if(sToolTag=="pt_craft_tool_DMs03")
            {
            oParentRawTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");
            if(!GetIsObjectValid(oParentRawTarget)) {FloatingTextStringOnCreature("�� �� ������� ������� ��� �������������� � ������� ����� �������������.", oActivator, FALSE); return;};

            SetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeRawSp", TRUE);

            AssignCommand(oActivator, ActionStartConversation(oActivator, "pt_axcrf_main", TRUE, FALSE));
            return;
            }
        //
        //
        //����� ����� ��������� ������������
            else if(sToolTag=="pt_craft_tool_DMs05")
            {
            oParentRawTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");
            if(!GetIsObjectValid(oParentRawTarget)) {FloatingTextStringOnCreature("�� �� ������� ������� ��� �������������� � ������� ����� �������������.", oActivator, FALSE); return;};

            SetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeToolSp", TRUE);

            AssignCommand(oActivator, ActionStartConversation(oActivator, "pt_axcrf_main", TRUE, FALSE));
            return;
            }
        //
        //
        //����� ����� ��������� �������
            else if(sToolTag=="pt_craft_tool_DMs07")
            {
            oParentRawTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");
            if(!GetIsObjectValid(oParentRawTarget)) {FloatingTextStringOnCreature("�� �� ������� ������� ��� �������������� � ������� ����� �������������.", oActivator, FALSE); return;};

            SetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeSkillSp", TRUE);

            AssignCommand(oActivator, ActionStartConversation(oActivator, "pt_axcrf_main", TRUE, FALSE));
            return;
            };

        ////////////////////////////////////////////////////
        ////////////////////////////////////////////////////
        ////////////////////////////////////////////////////
        ////////////////////////////////////////////////////
        ////////////////////////////////////////////////////


        //���������� ������������
        int iMaxUses=GetLocalInt(oTool, "pt_CRAFT_PROCESS_NUMUSE");
        int iCurUses=GetLocalInt(oTool, "pt_curCraftProcess_uses");
        iCurUses++;
        SetLocalInt(oTool, "pt_curCraftProcess_uses", iCurUses);
        if(iCurUses>iMaxUses && iMaxUses>0)
            {
            //debug
            //FloatingTextStringOnCreature("������ ����������� ��� ��������� ��������.", oActivator, FALSE);

            int iToolObjectType=GetObjectType(oTool);
            float fRespTime=GetLocalFloat(oTool, "pt_CRAFT_PROCESS_RESPTIME");
            if(fRespTime>0.0 && iToolObjectType!=OBJECT_TYPE_ITEM && iToolObjectType!=OBJECT_TYPE_TRIGGER)
                {
                string sToolResRef=GetResRef(oTool);
                object oBuoy=CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", GetLocation(oTool));
                float fCurRespTime=fRespTime+IntToFloat(Random(FloatToInt(fRespTime)/2));

                AssignCommand(oBuoy, DelayCommand(fCurRespTime, pCreateObjectInLocal(oBuoy, "pt_curCraftProcess_buoytool", iToolObjectType, sToolResRef, GetLocation(oBuoy))));

                AssignCommand(oBuoy, DelayCommand(fCurRespTime+0.1, SetLocalInt(GetLocalObject(oBuoy, "pt_curCraftProcess_buoytool"), "pt_CRAFT_PROCESS_NUMUSE", iMaxUses)));
                AssignCommand(oBuoy, DelayCommand(fCurRespTime+0.1, SetLocalFloat(GetLocalObject(oBuoy, "pt_curCraftProcess_buoytool"), "pt_CRAFT_PROCESS_RESPTIME", fRespTime)));

                AssignCommand(oBuoy, DelayCommand(fCurRespTime+0.1, DestroyObject(oBuoy)));
                };

            DeleteLocalInt(oActivator, "pt_curCraftProcess_Mode");
            DeleteLocalInt(oActivator, "pt_curCraftProcess_ScriptMode");
            DeleteLocalLocation(oActivator, "pt_craft_PClocation");
            DeleteLocalInt(oActivator, "pt_scanRawInTool");
            DestroyObject(oTool);

            return;
            };


        //��� ��������� ��������� � ��� ��������� ����������
        oActItem=GetFirstItemInInventory(oActivator);
        iArrayNum=-1; sArrayNum="";
        while(GetIsObjectValid(oActItem))
            {
            iArrayNum++;
            //debug
            //SendMessageToPC(GetFirstPC(), "������� #"+IntToString(iArrayNum));
            sArrayNum=IntToString(iArrayNum);
            SetLocalObject(oActivator, "pt_craft_pcInventory"+sArrayNum+"_Object", oActItem);
            SetLocalInt(oActivator, "pt_craft_pcInventory_Length", iArrayNum+1);
            //debug
            //SendMessageToPC(GetFirstPC(), "�����������");

            oActItem=GetNextItemInInventory(oActivator);
            };
        //debug
        //SendMessageToPC(GetFirstPC(), "������������ ���������: "+IntToString(GetLocalInt(oActivator, "pt_craft_pcInventory_Length")));


        //��� ��������� ��������� ����������� ����������� � ��������� ���������� ��������
        if(bScanRawInToolInventory)
            {
            object oToolItem=GetFirstItemInInventory(oTool);
            int iToolItemArrayNum=-1;string sToolItemArrayNum="";
            while(GetIsObjectValid(oToolItem))
                {
                iToolItemArrayNum++;
                //debug
                //SendMessageToPC(GetFirstPC(), "������� #"+IntToString(iArrayNum));
                sToolItemArrayNum=IntToString(iToolItemArrayNum);
                SetLocalObject(oActivator, "pt_craft_toolInventory"+sToolItemArrayNum+"_Object", oToolItem);
                SetLocalInt(oActivator, "pt_craft_toolInventory_Length", iToolItemArrayNum+1);
                //debug
                //SendMessageToPC(GetFirstPC(), "�����������");

                oToolItem=GetNextItemInInventory(oTool);
                };
            //debug
            //SendMessageToPC(GetFirstPC(), "������������ ���������: "+IntToString(GetLocalInt(oActivator, "pt_craft_pcInventory_Length")));
            };


        //���� ��������� ��� ��� ����� � ������������ ������������� ����� �������� � ������������ :))
        //�������� ����������� ����������� � �������� ������� �� �� ��������� � ��������� ���������
        //(���������� ������ ���������������� pt_craft_tool_ � �������)
        if(GetTag(oTool)=="pt_craft_tool_")
            {
            float fDel=1.5; int port=0;
            iArrayNum=0;    sArrayNum="0";    int iArrayLenn=GetLocalInt(oActivator, "pt_craft_pcInventory_Length");
            for(iArrayNum=0; iArrayNum<iArrayLenn; iArrayNum++)
                {
                sArrayNum=IntToString(iArrayNum);
                oActItem=GetLocalObject(oActivator, "pt_craft_pcInventory"+sArrayNum+"_Object");

                if(GetStringRight(GetTag(oActItem), 5)=="_port")  //����������� �����������
                    {
                    port++;
                    fDel+=0.2;
                    DelayCommand(1.0+fDel, SetLocalObject(oActivator, "pt_ActTool", oActItem));
                    DelayCommand(1.0+fDel+0.01, ExecuteScript("pt_axcrf_activ", OBJECT_SELF));
                    };
                };
            //debug
            //SendMessageToPC(oActivator, "����������� ���������: "+IntToString(port));
            };
        };




        //1|--.//////////////////////////////////////////////
        //��������� �������� ��� ���������� ��������
        /////////////////////////////////////////////////////
        //������  ������������ � �����������
        //
        //������� ����� ������(�������� ��������)
        if(sToolTag=="pt_craft_tool_DMbook")
            {
            SetLocalInt(oActivator, "pt_craft_dialToolIsBook", TRUE);
            }
        //
        //
        //������� ����� �������(��������� ������� ���������)
            else if(sToolTag=="pt_craft_tool_DMs00")
            {
            if(GetObjectType(oTarget)!=OBJECT_TYPE_CREATURE) {FloatingTextStringOnCreature("�� ���������� �������.", oActivator, FALSE); return;};

            SetLocalInt(oActivator, "pt_craft_dialToolIsSkillStick", TRUE);
            SetLocalObject(oActivator, "pt_craft_dialToolIsSkillStickTarget", oTarget);
            };
        //


    //debug
    //SendMessageToPC(GetFirstPC(), "��������� � ���������� "+IntToString(iMaxIItem) + " ���������");



    //3./////////////////////////////////////////////////
    //                                                 //
    //                   �����                         //
    //                                                 //
    /////////////////////////////////////////////////////


    //4.//////////////////////////////////////////
    ///������ ����� ���������� ��������� ���������
    //////////////////////////////////////////////
    int i, k, l, m;
    for(i=iBeginItem; i<iMaxIItem; i++)
        {
        string sI=IntToString(i);
        DeleteLocalObject(oActivator, "pt_craft_dialNodeArray"+sI+"_Object");
        DeleteLocalString(oActivator, "pt_craft_dialNodeArray"+sI+"_ItemName");
        ///////////////////////////////////////////////////////////////////////
        //debug
        //SendMessageToPC(GetFirstPC(), "������� " + sI);


            //4.0.1////////////////////////////////////////////////////////////////
            ////����������� �������������� ��������, ����� ������� ����� ����������
            if(i>=iBeginItem+pt_CRFPERFOMANCE_ACTIVATE_MAXITEMS_IN_SCRIPT)
                {
                //debug
                //SendMessageToPC(GetFirstPC(), "������������� ������� " + IntToString(iBeginItem) + " - " + IntToString(iMaxIItem));

                iBeginItem=iBeginItem+pt_CRFPERFOMANCE_ACTIVATE_MAXITEMS_IN_SCRIPT;
                SetLocalInt(oActivator, "pt_craft_BeginAnalisisNum", iBeginItem);
                SetLocalInt(oActivator, "pt_craft_currentNumDialogNodes", iNumDialogNodes+1);

                SetCommandable(TRUE, oActivator);
                AssignCommand(oActivator, DelayCommand(pt_CRFPERFOMANCE_ACTIVATE_MAXTIME_OF_SCRIPT, SetCommandable(TRUE, oActivator)));
                AssignCommand(oActivator, DelayCommand(pt_CRFPERFOMANCE_ACTIVATE_MAXTIME_OF_SCRIPT+0.01, ExecuteScript("pt_axcrf_activ", OBJECT_SELF)));
                SetCommandable(FALSE, oActivator);
                return;
                };


            //����, ������� �������
            oCrftItem=GetLocalObject(oModule, "pt_CraftItemBoxArray"+sI);
            if(!GetIsObjectValid(oCrftItem)) continue;




            //4.1///////////////////////////////////////////////////////
            //������� ����� ������, ���������� �������� �� �������������
            if(GetTag(oTool)=="pt_craft_tool_DMbook")
                {
                iNumDialogNodes++;
                string sNumDialogNodes=IntToString(iNumDialogNodes);

                SetLocalObject(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_Object", oCrftItem);
                SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_ItemName", GetName(oCrftItem) + (FindSubString(GetName(oCrftItem), "*")==-1?" (" + IntToString(GetLocalInt(oCrftItem, "pt_CRAFT_MINQUANT")) + "-" + IntToString(GetLocalInt(oCrftItem, "pt_CRAFT_MAXQUANT")) + " ��.)":""));

                SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_Skills", GetLocalString(oCrftItem, "pt_CRAFT_SKILL_ID"));
                SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_SkillsVal", GetLocalString(oCrftItem, "pt_CRAFT_SKILL_VALUE"));
                SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_RawNames", GetLocalString(oCrftItem, "pt_CRAFT_RAW"));
                SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_RawCost", GetLocalString(oCrftItem, "pt_CRAFT_RAW_COST"));

                SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_ToolNames", GetLocalString(oCrftItem, "pt_CRAFT_TOOL"));

                //debug
                //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' ������ ������ � ����������");

                continue;
                };




            //4.2/////////////////
            ////�������� ������
            string sProcSkill=GetLocalString(oCrftItem, "pt_CRAFT_SKILL_ID");
            string sProcSkillVal=GetLocalString(oCrftItem, "pt_CRAFT_SKILL_VALUE");
            if(sProcSkill!="") //���� �� ��������� ������ - ��������� ��� ��������, �� ����������� ������������������
            {
            int iSkillLen=pArrayLength(sProcSkill);
            int iSkillValLen=pArrayLength(sProcSkillVal);
            int bClosedSkill=FALSE;
            for(k=0; k<iSkillLen; k++)
                {
                int iValK=(k<=(iSkillValLen-1)?k:iSkillValLen-1);

                string sSkillID=pArray(sProcSkill, k);
                sSkillID=GetStringLeft(sSkillID, 35);

                //������� ����� �������
                if(GetTag(oTool)=="pt_craft_tool_DMs00")
                    {
                    int z, bHasThatSkill;
                    bHasThatSkill=FALSE;
                    for(z=0; z<=iNumDialogNodes+1; z++)
                        {
                        if(GetLocalString(oActivator, "pt_craft_dialNodeArray"+IntToString(z)+"_ItemName")==sSkillID) {bHasThatSkill=TRUE; break;};
                        };
                    if(!bHasThatSkill)
                        {
                        iNumDialogNodes++;
                        string sNumDialogNodes=IntToString(iNumDialogNodes);

                        SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_ItemName", sSkillID);
                        };

                    //debug
                    //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' ������ ������ � ����������");

                    continue;
                    }
                    else
                    {
                    float fActivatorSkill=GetLocalFloat(oSkin, "pt_craft_skill_"+sSkillID+"_value");

                    if(fActivatorSkill<0.0 || GetLocalInt(oSkin, "pt_craft_skill_"+sSkillID+"_DMblock")) {bClosedSkill=TRUE; break;};
                    };
                };
            if(bClosedSkill) continue;
            };
            //debug
            //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' �������� ����� �������.");

            //4.3/////////////////////////////////////////////////////////
            //������� ����� �������, ���������� �������� �� �������������
            if(GetTag(oTool)=="pt_craft_tool_DMs00")
                {
                continue;
                };






            //4.4///////////////////////////////
            ////�������� ����������� �����������
            string sProcTool=GetLocalString(oCrftItem, "pt_CRAFT_TOOL");
            string sProcToolNames=sProcTool;
            int iToolLen=pArrayLength(sProcTool);

            string sCurToolTag=sToolTag;

            //debug
            //SendMessageToPC(GetFirstPC(), "���������� ������ '"+sCurToolTag+"'");
            //debug
            //SendMessageToPC(GetFirstPC(), "���������� �������� '"+sProcTool+"'");

            int iCurToolIndex=-1;
            if(sCurToolTag=="pt_craft_tool_" && sProcTool=="") {sProcToolNames=GetName(oTool) ; iCurToolIndex=0;};
            for(k=0; k<iToolLen; k++)
                    {
                    string sToolTemp=pArray(sProcTool, k);
                    if(sCurToolTag==sToolTemp) {sProcToolNames=pArray(sProcToolNames, k, GetName(oTool)); iCurToolIndex=k; break;};
                    };
            if(iCurToolIndex<0) continue; //���� � �������� �� ��� ������ ���� ���������� ���������� - �� ��������� � ����������
            //debug
            //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' �������� ���������� ������. ("+pArray(sProcTool, iCurToolIndex)+")");

            //4.5////////////////////////////////////////////////////////
            ////�������� ������������ ������� ��������� ����� �����������
            if (sProcTool!="") //���� � �������� ��������� ������ �� ������������ - ����������, ����� - �������� �� ����� - ������� ��� ������������������
                {
                int bNotHasAllTool=FALSE;
                for(k=0; k<iToolLen; k++)
                    {
                    int bHasTool=FALSE;

                    if(iCurToolIndex==k) continue; //�������� ��� ����������� ����������� �� ��������������

                    string sToolTag=pArray(sProcTool, k);

                    object oPlaTool=GetNearestObjectByTag(sToolTag, oActivator); //������������ �����
                    if(GetIsObjectValid(oPlaTool) && GetObjectType(oPlaTool)!=OBJECT_TYPE_ITEM && GetDistanceBetween(oPlaTool, oActivator)<=4.0) {sProcToolNames=pArray(sProcToolNames, k, GetName(oPlaTool)); bHasTool=TRUE;};
                    if(!bHasTool)//
                        {
                        int iCurItemSlot=0;
                        object oActItem=GetItemInSlot(iCurItemSlot, oActivator);
                        while(!bHasTool && iCurItemSlot<=17) //������������ � ������ ������� �����
                            {
                            if(GetTag(oActItem)==sToolTag) {sProcToolNames=pArray(sProcToolNames, k, GetName(oActItem)); bHasTool=TRUE; break;};

                            iCurItemSlot++; oActItem=GetItemInSlot(iCurItemSlot, oActivator);
                            };
                        if(!bHasTool)///
                            {
                            int iArrayNum=0;string sArrayNum="0";int iArrayLenn=GetLocalInt(oActivator, "pt_craft_pcInventory_Length");
                            for(iArrayNum=0; iArrayNum<iArrayLenn; iArrayNum++)
                                {
                                sArrayNum=IntToString(iArrayNum);
                                oActItem=GetLocalObject(oActivator, "pt_craft_pcInventory"+sArrayNum+"_Object");

                                if(!bHasTool && GetIsObjectValid(oActItem)) //������������ � ���������
                                    {
                                    if(GetTag(oActItem)==sToolTag)
                                        {
                                        sProcToolNames=pArray(sProcToolNames, k, GetName(oActItem)); bHasTool=TRUE; break;
                                        };
                                    };
                                };
                            };
                        };
                    if(!bHasTool) {bNotHasAllTool=TRUE; break;};
                    };
                if(bNotHasAllTool) continue;
                };
            //debug
            //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' �������� ��������� ������������ �������");



            //4.6/////////////////////////////////
            ////�������� ������������ �����
            string sProcRaw=GetLocalString(oCrftItem, "pt_CRAFT_RAW");
            if (sProcRaw=="NW_IT_GOLD001") bIsVendor=TRUE;
            string sProcRawNames=GetLocalString(oCrftItem, "pt_CRAFT_RAW");
            string sProcRawCost=GetLocalString(oCrftItem, "pt_CRAFT_RAW_COST");
            if (sProcRaw!="") //���� ������������ ����� � �������� ����� - �� ��� �������� �� ����� �������
            {
            string sProcActivatorRawValue="0";

            int iRawLen=pArrayLength(sProcRaw);
            int iRawCostLen=pArrayLength(sProcRawCost);

            int bNotHasAllRaw=FALSE;
            for(k=0; k<iRawLen; k++)
                {
                string sRawTag=pArray(sProcRaw, k);

                int bHasRaw=FALSE;
                if(bScanRawInToolInventory) //����������� ������� � ��������� �����������
                    {
                    int iToolItemArrayNum; string sToolItemArrayNum; int iToolItemArrayLenn=GetLocalInt(oActivator, "pt_craft_toolInventory_Length");
                    for(iToolItemArrayNum=0; iToolItemArrayNum<iToolItemArrayLenn; iToolItemArrayNum++)
                        {
                        sToolItemArrayNum=IntToString(iToolItemArrayNum);

                        object oToolItem=GetLocalObject(oActivator, "pt_craft_toolInventory"+sToolItemArrayNum+"_Object");
                        if(GetIsObjectValid(oToolItem))
                            {
                            if(GetTag(oToolItem)==sRawTag)
                                {
                                sProcRawNames=pArray(sProcRawNames, k, GetName(oToolItem));

                                int iToolItemRawVal=StringToInt(pArray(sProcActivatorRawValue, k));
                                iToolItemRawVal+=GetItemStackSize(oToolItem);
                                sProcActivatorRawValue=pArray(sProcActivatorRawValue, k, IntToString(iToolItemRawVal));
                                bHasRaw=TRUE;
                                };
                            };
                        };
                    }
                    else //����������� ������� � ��������� ����������
                    {
                    int iArrayNum; string sArrayNum; int iArrayLenn=GetLocalInt(oActivator, "pt_craft_pcInventory_Length");
                    for(iArrayNum=0; iArrayNum<iArrayLenn; iArrayNum++)
                        {
                        sArrayNum=IntToString(iArrayNum);

                        object oActItem=GetLocalObject(oActivator, "pt_craft_pcInventory"+sArrayNum+"_Object");
                        if(GetIsObjectValid(oActItem))
                            {
                            if(GetTag(oActItem)==sRawTag)
                                {
                                sProcRawNames=pArray(sProcRawNames, k, GetName(oActItem));

                                int iActRawVal=StringToInt(pArray(sProcActivatorRawValue, k));
                                iActRawVal+=GetItemStackSize(oActItem);
                                sProcActivatorRawValue=pArray(sProcActivatorRawValue, k, IntToString(iActRawVal));
                                bHasRaw=TRUE;
                                };
                            };
                        };
                    };
                if(!bHasRaw) {bNotHasAllRaw=TRUE; break;};
                };
            if(bNotHasAllRaw) continue;
            //debug
            //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' ������������ ������� ������� ����� �������.");


            //4.7///////////////////////////////////
            ////�������� ���������� ����� � ������
            //debug
            //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' ���������� �����: "+sProcRawCost);
            //debug
            //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' ������� �����: "+sProcActivatorRawValue);
            int bNotHasAllRawQuant=FALSE;
            for(k=0; k<iRawLen; k++)
                {
                int iCostK=(k<=(iRawCostLen-1)?k:iRawCostLen-1);

                int iCurRawCost=StringToInt(pArray(sProcRawCost, iCostK));
                int iCurRawHave=StringToInt(pArray(sProcActivatorRawValue, iCostK));

                if(iCurRawCost<0) iCurRawCost=1;

                if(iCurRawHave<iCurRawCost) {bNotHasAllRawQuant=TRUE; break;};
                };
            if(bNotHasAllRawQuant) continue;
            };
            //debug
            //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' �������� ���������� ����� � ������ �������.");




            //4.8////////////////////////////////////////////////////////////////
            ////������� ���������� ���� ��� �������� ������� ��� ������� ��������
            iNumDialogNodes++;
            string sNumDialogNodes=IntToString(iNumDialogNodes);

            SetLocalObject(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_Object", oCrftItem);
            SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_ItemName", GetName(oCrftItem) + (FindSubString(GetName(oCrftItem), "*")==-1?" (" + IntToString(GetLocalInt(oCrftItem, "pt_CRAFT_MINQUANT")) + "-" + IntToString(GetLocalInt(oCrftItem, "pt_CRAFT_MAXQUANT")) + " ��.)":""));

            SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_Skills", sProcSkill);
            SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_SkillsVal", sProcSkillVal);   //������ ��� ������ �� �����, ����� ����� �� ��������� ����������, �� ��� ����-�� � �������
            SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_RawNames", sProcRawNames);
            SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_RawCost", sProcRawCost);      //������ ��� ������ �� �����, ����� ����� �� ��������� ����������

            SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_ToolNames", sProcToolNames);
            //debug
            //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' ������ ������ � ����������");

        };//-����� �����




    //5.////////////////////////////////////////////////////////////////
    ////����������� �������������� ��������
    if(iBeginItem+pt_CRFPERFOMANCE_ACTIVATE_MAXITEMS_IN_SCRIPT>=iMaxIItem)
        {
        SetLocalInt(oActivator, "pt_craft_BeginAnalisisNum", 0);
        SetLocalInt(oActivator, "pt_craft_currentNumDialogNodes", 0);
        };

    //�����������
    pSetProgressBar(oTool, iMaxIItem);
    pClearProgressBar(oTool);
    //������� ��� �����������,������� ������ ������ ��� �������
    SetLocalString(oActivator, "pt_craft_dialTool", GetName(oTool));


    //debug
    //SendMessageToPC(GetFirstPC(), "���� "+IntToString(iNumDialogNodes));
    //debug
    //SendMessageToPC(GetFirstPC(), "� ��������� "+IntToString(bScanRawInToolInventory));
    //debug
    //SendMessageToPC(GetFirstPC(), "������ "+IntToString(bIsVendor));


    //6./////////////////////////////////////////////////////////
    //���� ������ ���� ������� �������� - �� ����� �������� ������
    if(iNumDialogNodes==0 && GetTag(oTool)!="pt_craft_tool_" && GetStringRight(GetTag(oTool), 5)!="_port" && GetStringLeft(GetTag(oTool), 16)!="pt_craft_tool_DM" && (!bScanRawInToolInventory || bIsVendor))
        {
        oCrftItem=GetLocalObject(oActivator, "pt_craft_dialNodeArray"+IntToString(iNumDialogNodes)+"_Object");
        string sCustomScript=GetLocalString(oCrftItem, "pt_CRAFT_PROCESS_PC_CUSTOM_SCRIPT");
        sCustomScript=(sCustomScript==""?"pt_axcrf_pr_defa":sCustomScript);

        SetLocalInt(oActivator, "pt_curCraftProcess_Mode", 1);
        SetLocalObject(oActivator, "pt_curCraftProcess_Object", oCrftItem);

        ExecuteScript(sCustomScript, oActivator);
        return;
        }

    //7.///////////////////////////////////////
    //������� ������ ������� ���������� ���������
    SetLocalInt(oActivator, "pt_craft_dialNodeArray_Length", iNumDialogNodes+1);

    //8.////////////////////
    //������ ����������� ����
    if(iNumDialogNodes>=0) AssignCommand(oActivator, ActionStartConversation(oActivator, "pt_axcrf_main", TRUE, FALSE));
}
