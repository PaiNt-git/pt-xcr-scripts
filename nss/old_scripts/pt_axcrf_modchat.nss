//������� ������ ����

#include "pt_frame000"

void main()
{
    object oModule=GetModule();
    object oActivator=GetPCChatSpeaker();
    string sMess=GetPCChatMessage();


    if(GetLocalInt(oActivator, "pt_craft_dialToolIsRawCreateSkillSt"))
        {
        sMess=GetStringLeft(sMess, 35);

        object oParentRawTarget=GetLocalObject(oActivator, "pt_craft_dialToolIsRawCreateTarget");;

        SetLocalInt(oActivator, "pt_craft_dialToolIsRawCreateSkillSt", FALSE);

        //������� ���������� ��� �������
        string sSkillsString=GetLocalString(oParentRawTarget, "pt_CRAFT_SKILL_ID");
        int iSkillLen=pArrayLength(sSkillsString);

        int iNumDialogNodes=iSkillLen;
        iNumDialogNodes++;
        string sNumDialogNodes=IntToString(iNumDialogNodes);

        SetLocalString(oActivator, "pt_craft_dialNodeArray"+sNumDialogNodes+"_ItemSkillId", sMess);
        if(sSkillsString!="") {sSkillsString+=","+sMess;} else{sSkillsString=sMess;};
        SetLocalString(oParentRawTarget, "pt_CRAFT_SKILL_ID", sSkillsString);

        //������� ������ �������
        SetLocalInt(oActivator, "pt_craft_dialNodeArray_Length", iNumDialogNodes);
        //debug
        //SendMessageToPC(GetFirstPC(), "'"+GetName(oCrftItem)+"' ������ ������ � ����������");

        FloatingTextStringOnCreature("����� '"+sMess+"' ����������� '"+GetName(oParentRawTarget)+"' �����.", oActivator, FALSE);

        SetLocalInt(oActivator, "pt_craft_dialToolIsRawSeeSkillSp", TRUE);
        AssignCommand(oActivator, ActionStartConversation(oActivator, "pt_axcrf_main", TRUE, FALSE));

        sMess="";
        SetPCChatMessage("");
        return;
        };
}

