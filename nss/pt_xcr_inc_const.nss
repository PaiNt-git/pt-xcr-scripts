//::///////////////////////////////////////////////
//:: System constants
//:: pt_xcr_inc_const.nss
//:: Copyright (c) 2018 PaiNt.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: PaiNt
//:: Created On: 2018
//:://////////////////////////////////////////////

//---START BASE CONSTANTS

// If this True - then system will use NWNX-save object of craft-barrels
// and keep craft-skill-variables of PC to sql (client-enter-leave refresh)
const int PT_XCR_USE_NWNX = TRUE;

// If this True - then system will save object of craft-barrels
// (campaign-variable if PT_XCR_USE_NWNX is false)
const int PT_XCR_SAVE_BARRELS = TRUE;

// Campaign-name for persistent store (if SQL not used)
// Warning - if (if NWNX-SQL not used - system has limited functionality, persistent only PC skills/weary)
const string PT_XCR_CAMPAIGN_NAME = "pt_xcr";

// SQL tables (if used NWNX)
const string PT_XCR_SQL_TABLES_VARIMPORT = "pt_axcrf_varimport";
const string PT_XCR_SQL_TABLES_BARRELS = "pt_axcrf_boxes";
const string PT_XCR_SQL_TABLES_PC_VARS = "pt_axcrf_table";

// Prefixes for dump craft-skill-variables of PC to base,
// this names/types set to module for further move from PC to SQL/Persistent campaign store.
// Change it if collisions..
const string PT_XCR_DBDUMP_MOD_ARRAY_NAME = "pt_xcr.mod.dump.";
const int PT_XCR_DBDUMP_TYPE_UNDEFINED = -1;
const int PT_XCR_DBDUMP_TYPE_STRING = 0;
const int PT_XCR_DBDUMP_TYPE_INT = 1;
const int PT_XCR_DBDUMP_TYPE_FLOAT = 2;

// Namespace for system vars. Change it if collisions
const string PT_XCR_NAMESPACE_ITEMS = "pt_xcr.items.";
const string PT_XCR_NAMESPACE_SKILLS = "pt_xcr.skills.";
const string PT_XCR_NAMESPACE_RAWS = "pt_xcr.raws.";
const string PT_XCR_NAMESPACE_TOOLS = "pt_xcr.tools.";
const string PT_XCR_NAMESPACE_DIALOGUE = "pt_xcr.dialogue.";
const string PT_XCR_NAMESPACE_DICT = "pt_xcr.dict.";
const string PT_XCR_NAMESPACE_PROC = "pt_xcr.proc.";

const string PT_XCR_NAMESPACE_PRIVVARS_MLOAD = "_pt_xcr.priv.mload.";
const string PT_XCR_NAMESPACE_PRIVVARS_MHB = "_pt_xcr.priv.mhb.";
const string PT_XCR_NAMESPACE_PRIVVARS_MCHAT = "_pt_xcr.priv.mchat.";
const string PT_XCR_NAMESPACE_PRIVVARS_MACT = "_pt_xcr.priv.mact.";
const string PT_XCR_NAMESPACE_PRIVVARS_MREST = "_pt_xcr.priv.mrest.";

const string PT_XCR_NAMESPACE_OTHERS = "pt_xcr.others.";

//---END BASE CONSTANTS

//---START DEFAULT PROCESS CONSTANTS

// This is base refrate of craft-process, this constant affected on
// spending weary points, and use for quantification of heavy scripts
const float PT_XCR_REFRATE = 1.0;

// Constants for quantification of on-module analysis (init) script (that
// cached barrel-items to module-local vars)/ Before that script done -
// no craft-process was enabled
const int PT_XCR_PERFOMANCE_MODULE_MAXBOX_IN_SCRIPT = 1;
const float PT_XCR_PERFOMANCE_MODULE_MAXTIME_OF_SCRIPT = 1.5;

// Constants for quantification of on-activate script (that
// prepares dialog of available processes)
const int PT_XCR_PERFOMANCE_ACTIVATE_MAXITEMS_IN_SCRIPT = 125;
const float PT_XCR_PERFOMANCE_ACTIVATE_MAXTIME_OF_SCRIPT = 0.6;

//---END DEFAULT PROCESS CONSTANTS

//---START PC SKILLS/WEARY VARS

// Because possible old-style conflicts - that variable structure handed  to constants..
// If we new user of craft - change this constants.
//
// skill value on PC-SKIN structure:
//   PT_XCR_PCSKILL_BASE_PREFIX + sSkillID + PT_XCR_PCSKILL_SUFFIX_VALUE (value of skill)
//   PT_XCR_PCSKILL_BASE_PREFIX + sSkillID + PT_XCR_PCSKILL_SUFFIX_DMBONPEN (bonus or penalty of skill, modificator)
//   PT_XCR_PCSKILL_BASE_PREFIX + sSkillID + PT_XCR_PCSKILL_SUFFIX_DMBLOCK (block of use that skill processes)

const string PT_XCR_PCSKILL_BASE_PREFIX = "pt_craft_skill_";
const string PT_XCR_PCSKILL_SUFFIX_VALUE = "_value";
const string PT_XCR_PCSKILL_SUFFIX_DMBONPEN = "_DMbonpen";
const string PT_XCR_PCSKILL_SUFFIX_DMBLOCK = "_DMblock";

const string PT_XCR_PCWEARY = "pt_craft_weary_value";

//---END START PC SKILLS/WEARY VARS

//---START ITEM SETTINGS VARS

// From this variables on craft-items in barrels system build
// available craft-process list

const string PT_XCR_ITEM_SETTINGS_TOOLS = "pt_CRAFT_TOOL";
const string PT_XCR_ITEM_SETTINGS_SKILLS = "pt_CRAFT_SKILL_ID";
const string PT_XCR_ITEM_SETTINGS_SKILLSVAL = "pt_CRAFT_SKILL_VALUE";
const string PT_XCR_ITEM_SETTINGS_RAWS = "pt_CRAFT_RAW";
const string PT_XCR_ITEM_SETTINGS_RAWSCOST = "pt_CRAFT_RAW_COST";
const string PT_XCR_ITEM_SETTINGS_WEARY = "pt_CRAFT_PROCESS_WEARY";
const string PT_XCR_ITEM_SETTINGS_TIME = "pt_CRAFT_PROCESS_TIME";
const string PT_XCR_ITEM_SETTINGS_CHANCETOCREATE = "pt_CRAFT_PROCESS_CHANCE";
const string PT_XCR_ITEM_SETTINGS_MINQUANT = "pt_CRAFT_MINQUANT";
const string PT_XCR_ITEM_SETTINGS_MAXQUANT = "pt_CRAFT_MAXQUANT";
const string PT_XCR_ITEM_SETTINGS_SCRIPT = "pt_CRAFT_PROCESS_PC_CUSTOM_SCRIPT";

//---END ITEM SETTINGS VARS

//---START TOOL SETTINGS VARS

// This is not required variable of tools

//Number of uses tool before tool destroy. After destroy tool can respawn
const string PT_XCR_TOOL_SETTINGS_NUMUSE = "pt_CRAFT_PROCESS_NUMUSE";

//---END TOOL SETTINGS VARS

//---START BARREL SETTINGS VARS

const string PT_XCR_BARREL_TAG = "pt_craft_box";

//---END BARREL SETTINGS VARS

//---START PROGRESSBAR SETTINGS VARS

// Progressbar floating on creature or pleaceable-tool and indicates
// remaining prepare time
const string PT_XCR_PROGRESSBAR_SETTINGS_MAX = "pt_xcr.ProgressbarMax";
const string PT_XCR_PROGRESSBAR_SETTINGS_CUR = "pt_xcr.ProgressbarCur";

//---END PROGRESSBAR SETTINGS VARS

//---START EXECUTESCRIPT SCRIPTS

const string PT_XCR_SCRIPT_EXECUTE_ACTIVATE = "pt_xcr_activ";
const string PT_XCR_SCRIPT_MODULE_LOAD = "pt_xcr_modlod";

//---END PROGRESSBAR SETTINGS VARS

//---START DIALOG CONSTANTS

// Custom tokens, change if collision
const int PT_XCR_CUSTTOK_TOOL = 77880;

// Custom tokens, change if collision
const int PT_XCR_CUSTTOK_NODE_ONE = 77881;
const int PT_XCR_CUSTTOK_NODE_TWO = 77882;
const int PT_XCR_CUSTTOK_NODE_THREE = 77883;
const int PT_XCR_CUSTTOK_NODE_FOUR = 77884;
const int PT_XCR_CUSTTOK_NODE_FIVE = 77885;

// Custom tokens, change if collision
const int PT_XCR_CUSTTOK_NODE_CURRENT_ITEM = 77886;
const int PT_XCR_CUSTTOK_NODE_CURRENT_ITEM_RAW = 77887;

// Custom tokens, change if collision
const int PT_XCR_CUSTTOK_PAGE = 77888;
const int PT_XCR_CUSTTOK_NODE_CURRENT_ITEM_VALUE = 77889;

// Custom tokens, change if collision
const int PT_XCR_LANGTOK_NEXT_PAGE = 77701;
const int PT_XCR_LANGTOK_PREV_PAGE = 77702;

// Custom tokens, change if collision
const int PT_XCR_LANGTOK_DIAL_1 = 77901;
const int PT_XCR_LANGTOK_DIAL_2 = 77902;
const int PT_XCR_LANGTOK_DIAL_3 = 77903;
const int PT_XCR_LANGTOK_DIAL_4 = 77904;
const int PT_XCR_LANGTOK_DIAL_5 = 77905;
const int PT_XCR_LANGTOK_DIAL_6 = 77906;
const int PT_XCR_LANGTOK_DIAL_7 = 77907;
const int PT_XCR_LANGTOK_DIAL_8 = 77908;
const int PT_XCR_LANGTOK_DIAL_9 = 77909;
const int PT_XCR_LANGTOK_DIAL_10 = 77910;

// Custom tokens, change if collision
const int PT_XCR_LANGTOK_DIAL_11 = 77911;
const int PT_XCR_LANGTOK_DIAL_12 = 77912;
const int PT_XCR_LANGTOK_DIAL_13 = 77913;
const int PT_XCR_LANGTOK_DIAL_14 = 77914;
const int PT_XCR_LANGTOK_DIAL_15 = 77915;
const int PT_XCR_LANGTOK_DIAL_16 = 77916;
const int PT_XCR_LANGTOK_DIAL_17 = 77917;
const int PT_XCR_LANGTOK_DIAL_18 = 77918;
const int PT_XCR_LANGTOK_DIAL_19 = 77919;
const int PT_XCR_LANGTOK_DIAL_20 = 77920;

// Custom tokens, change if collision
const int PT_XCR_LANGTOK_DIAL_21 = 77921;
const int PT_XCR_LANGTOK_DIAL_22 = 77922;
const int PT_XCR_LANGTOK_DIAL_23 = 77923;
const int PT_XCR_LANGTOK_DIAL_24 = 77924;
const int PT_XCR_LANGTOK_DIAL_25 = 77925;
const int PT_XCR_LANGTOK_DIAL_26 = 77926;
const int PT_XCR_LANGTOK_DIAL_27 = 77927;
const int PT_XCR_LANGTOK_DIAL_28 = 77928;
const int PT_XCR_LANGTOK_DIAL_29 = 77929;
const int PT_XCR_LANGTOK_DIAL_30 = 77930;

// Custom tokens, change if collision
const int PT_XCR_LANGTOK_DIAL_31 = 77931;
const int PT_XCR_LANGTOK_DIAL_32 = 77932;
const int PT_XCR_LANGTOK_DIAL_33 = 77933;
const int PT_XCR_LANGTOK_DIAL_34 = 77934;
const int PT_XCR_LANGTOK_DIAL_35 = 77935;
const int PT_XCR_LANGTOK_DIAL_36 = 77936;
const int PT_XCR_LANGTOK_DIAL_37 = 77937;
const int PT_XCR_LANGTOK_DIAL_38 = 77938;
const int PT_XCR_LANGTOK_DIAL_39 = 77939;
const int PT_XCR_LANGTOK_DIAL_40 = 77940;

// Custom tokens, change if collision
const int PT_XCR_LANGTOK_DIAL_41 = 77941;
const int PT_XCR_LANGTOK_DIAL_42 = 77942;
const int PT_XCR_LANGTOK_DIAL_43 = 77943;
const int PT_XCR_LANGTOK_DIAL_44 = 77944;
const int PT_XCR_LANGTOK_DIAL_45 = 77945;
const int PT_XCR_LANGTOK_DIAL_46 = 77946;
const int PT_XCR_LANGTOK_DIAL_47 = 77947;
const int PT_XCR_LANGTOK_DIAL_48 = 77948;
const int PT_XCR_LANGTOK_DIAL_49 = 77949;
const int PT_XCR_LANGTOK_DIAL_50 = 77950;

// ------- language ---------

const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_NEXT_PAGE = "[---|>]";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_PREV_PAGE = "[<|---]";

const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_1 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_2 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_3 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_4 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_5 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_6 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_7 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_8 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_9 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_10 = "...";

const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_11 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_12 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_13 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_14 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_15 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_16 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_17 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_18 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_19 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_20 = "...";

const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_21 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_22 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_23 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_24 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_25 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_26 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_27 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_28 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_29 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_30 = "...";

const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_31 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_32 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_33 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_34 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_35 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_36 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_37 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_38 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_39 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_40 = "...";

const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_41 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_42 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_43 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_44 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_45 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_46 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_47 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_48 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_49 = "...";
const string PT_XCR_LANGTOK_DIAL_DESCRIPTION_50 = "...";

const string PT_XCR_LANGWORD_DESCRIPTION_1 = "���������������� �������..";
const string PT_XCR_LANGWORD_DESCRIPTION_2 = "�� �� ������ ������ ������..";
const string PT_XCR_LANGWORD_DESCRIPTION_3 = "��� ������ ������ ���-�� ����� �� ����� ��������..";
const string PT_XCR_LANGWORD_DESCRIPTION_4 = "��� ������� ������ ���-�� ����� �� ����� ��������..";
const string PT_XCR_LANGWORD_DESCRIPTION_5 = "��� �����";
const string PT_XCR_LANGWORD_DESCRIPTION_6 = "���������� ��";
const string PT_XCR_LANGWORD_DESCRIPTION_7 = "��� ����� ���";
const string PT_XCR_LANGWORD_DESCRIPTION_8 = "����� ������� ��������� ������������ ��� ��������� ���������� ����� ��������..";
const string PT_XCR_LANGWORD_DESCRIPTION_9 = "��������, �� �� ���������� �������� ������� �� ������..";
const string PT_XCR_LANGWORD_DESCRIPTION_10 = "�� �������� ������� ��������..";

const string PT_XCR_LANGWORD_DESCRIPTION_11 = "�� ������ ������ � �� ������ ���������� ������� ���� �� ���������..";
const string PT_XCR_LANGWORD_DESCRIPTION_12 = "!!!\n�������� ��������������� �����-��������. \n��������� ���������..";
const string PT_XCR_LANGWORD_DESCRIPTION_13 = "!!!\n�������� ��������������� �����-��������. \n���������� �����: ";
const string PT_XCR_LANGWORD_DESCRIPTION_14 = " ����������� � ";
const string PT_XCR_LANGWORD_DESCRIPTION_15 = " ���������� ������. \n��������� ���������..";
const string PT_XCR_LANGWORD_DESCRIPTION_16 = "...";
const string PT_XCR_LANGWORD_DESCRIPTION_17 = "...";
const string PT_XCR_LANGWORD_DESCRIPTION_18 = "...";
const string PT_XCR_LANGWORD_DESCRIPTION_19 = "...";
const string PT_XCR_LANGWORD_DESCRIPTION_20 = "...";

const string PT_XCR_LANGWORD_DESCRIPTION_21 = "...";
const string PT_XCR_LANGWORD_DESCRIPTION_22 = "...";
const string PT_XCR_LANGWORD_DESCRIPTION_23 = "...";
const string PT_XCR_LANGWORD_DESCRIPTION_24 = "...";
const string PT_XCR_LANGWORD_DESCRIPTION_25 = "...";
const string PT_XCR_LANGWORD_DESCRIPTION_26 = "...";
const string PT_XCR_LANGWORD_DESCRIPTION_27 = "...";
const string PT_XCR_LANGWORD_DESCRIPTION_28 = "...";
const string PT_XCR_LANGWORD_DESCRIPTION_29 = "...";
const string PT_XCR_LANGWORD_DESCRIPTION_30 = "...";

// ------- language ---------

//---END END DIALOG CONSTANTS
