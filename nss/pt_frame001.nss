//PaiNt framework
#include "pt_frame000"



struct stSpellData
{
string sName;

int iSchool;

string sTargetType;

int iCategory;

int iLevel;
};


//Возвращает структуру данных stSpellData о заклинании iSpell (SPELL_* - константы)
struct stSpellData pGetSpellInfo(int iSpell=-1);

//Возвращает массив заклинаний (SPELL_* - константы) через запятую меньше или равные определеного уровня
//iLevel - уровень
//iLessThan - на сколько допускается уровень ниже чем iLevel
//iTrustPercent - так как функция анализирует список из 800+ заклинаний (хотя фактически меньше),
//                то необходимо задать "доверие" функции, ибо ресурсоемкая, это насколько ее результаты анализа будут исчерпывающими,
//                т.е. грубо говоря скоко процентов от 800+ заклинаний она проанализирует.
string pGetSpellLeveledLessThen(int iLevel=0, int iLessThan=0, int iTrustPercent=20);

//Возвращает массив заклинаний (SPELL_* - константы) через запятую больше или равные определеного уровня
//iLevel - уровень
//iLessThan - на сколько допускается уровень больше чем iLevel
//iTrustPercent - так как функция анализирует список из 800+ заклинаний (хотя фактически меньше),
//                то необходимо задать "доверие" функции, ибо ресурсоемкая, это насколько ее результаты анализа будут исчерпывающими,
//                т.е. грубо говоря скоко процентов от 800+ заклинаний она проанализирует.
string pGetSpellLeveledMoreThen(int iLevel=0, int iMoreThan=0, int iTrustPercent=20);

//Возвращает массив заклинаний (SPELL_* - константы) через запятую определенной школы
//iSchool - школа (SPELL_SCHOOL_* - константы)
//iTrustPercent - так как функция анализирует список из 800+ заклинаний (хотя фактически меньше),
//                то необходимо задать "доверие" функции, ибо ресурсоемкая, это насколько ее результаты анализа будут исчерпывающими,
//                т.е. грубо говоря скоко процентов от 800+ заклинаний она проанализирует.
string pGetSpellSchooled(int iSchool=0, int iTrustPercent=20);

//Возвращает массив заклинаний (SPELL_* - константы) через запятую определенной категории
//iCategory - категория:
//               0 -
//               1 -
//               2 -
//               3 -
//               4 -
//               5 -
//               6 -
//               7 -
//               8 -
//               9 -
//              10 -
//              11 -
//iTrustPercent - так как функция анализирует список из 800+ заклинаний (хотя фактически меньше),
//                то необходимо задать "доверие" функции, ибо ресурсоемкая, это насколько ее результаты анализа будут исчерпывающими,
//                т.е. грубо говоря скоко процентов от 800+ заклинаний она проанализирует.
string pGetSpellCategored(int iCategory=0, int iTrustPercent=20);





















struct stSpellData pGetSpellInfo(int iSpell=-1)
{
struct stSpellData stRet;

stRet.sName="";   stRet.iSchool=-1;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;

if(iSpell<0) return stRet;

switch(iSpell)
    {
    case 0: {stRet.sName="Acid_Fog";   stRet.iSchool=2;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=6;};break;

    case 1: {stRet.sName="Aid";   stRet.iSchool=4;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    case 2: {stRet.sName="Animate_Dead";   stRet.iSchool=7;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=3;};break;

    case 3: {stRet.sName="Barkskin";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=2;};break;

    case 4: {stRet.sName="Bestow_Curse";   stRet.iSchool=8;    stRet.sTargetType="0x2A";     stRet.iCategory=3;     stRet.iLevel=3;};break;

    case 5: {stRet.sName="Blade_Barrier";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=6;};break;

    case 6: {stRet.sName="Bless";   stRet.iSchool=4;    stRet.sTargetType="0x2F";     stRet.iCategory=9;     stRet.iLevel=1;};break;

    case 7: {stRet.sName="Bless_Weapon";   stRet.iSchool=8;    stRet.sTargetType="0x28";     stRet.iCategory=9;     stRet.iLevel=1;};break;

    case 8: {stRet.sName="Blindness_and_Deafness";   stRet.iSchool=4;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=2;};break;

    case 9: {stRet.sName="Bulls_Strength";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    case 10: {stRet.sName="Burning_Hands";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=1;};break;

    case 11: {stRet.sName="Call_Lightning";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=1;     stRet.iLevel=3;};break;

    case 12: {stRet.sName="Calm_Emotions";   stRet.iSchool=4;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=1;};break;

    case 13: {stRet.sName="Cats_Grace";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    case 14: {stRet.sName="Chain_Lightning";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=1;     stRet.iLevel=6;};break;

    case 15: {stRet.sName="Charm_Monster";   stRet.iSchool=4;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    case 16: {stRet.sName="Charm_Person";   stRet.iSchool=4;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=1;};break;

    case 17: {stRet.sName="Charm_Person_or_Animal";   stRet.iSchool=4;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=2;};break;

    case 18: {stRet.sName="Circle_of_Death";   stRet.iSchool=7;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=6;};break;

    case 19: {stRet.sName="Circle_of_Doom";   stRet.iSchool=7;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=5;};break;

    case 20: {stRet.sName="Clairaudience_and_Clairvoyance";   stRet.iSchool=3;    stRet.sTargetType="0x2B";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    case 21: {stRet.sName="Clarity";   stRet.iSchool=7;    stRet.sTargetType="0x2B";     stRet.iCategory=7;     stRet.iLevel=2;};break;

    case 22: {stRet.sName="Cloak_of_Chaos";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=10;     stRet.iLevel=8;};break;

    case 23: {stRet.sName="Cloudkill";   stRet.iSchool=2;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    case 24: {stRet.sName="Color_Spray";   stRet.iSchool=6;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=1;};break;

    case 25: {stRet.sName="Cone_of_Cold";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    case 26: {stRet.sName="Confusion";   stRet.iSchool=4;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=3;};break;

    case 27: {stRet.sName="Contagion";   stRet.iSchool=7;    stRet.sTargetType="0x2A";     stRet.iCategory=3;     stRet.iLevel=3;};break;

    case 28: {stRet.sName="Control_Undead";   stRet.iSchool=7;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=7;};break;

    case 29: {stRet.sName="Create_Greater_Undead";   stRet.iSchool=7;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=8;};break;

    case 30: {stRet.sName="Create_Undead";   stRet.iSchool=7;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=6;};break;

    case 31: {stRet.sName="Cure_Critical_Wounds";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=5;     stRet.iLevel=4;};break;

    case 32: {stRet.sName="Cure_Light_Wounds";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=5;     stRet.iLevel=1;};break;

    case 33: {stRet.sName="Cure_Minor_Wounds";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=5;     stRet.iLevel=0;};break;

    case 34: {stRet.sName="Cure_Moderate_Wounds";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=5;     stRet.iLevel=2;};break;

    case 35: {stRet.sName="Cure_Serious_Wounds";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=5;     stRet.iLevel=3;};break;

    case 36: {stRet.sName="Darkness";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=-1;     stRet.iLevel=2;};break;

    case 37: {stRet.sName="Daze";   stRet.iSchool=4;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=0;};break;

    case 38: {stRet.sName="Death_Ward";   stRet.iSchool=7;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=4;};break;

    case 39: {stRet.sName="Delayed_Blast_Fireball";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=7;};break;

    case 40: {stRet.sName="Dismissal";   stRet.iSchool=1;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=4;};break;

    case 41: {stRet.sName="Dispel_Magic";   stRet.iSchool=1;    stRet.sTargetType="0x2F";     stRet.iCategory=3;     stRet.iLevel=3;};break;

    case 42: {stRet.sName="Divine_Power";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=10;     stRet.iLevel=4;};break;

    case 43: {stRet.sName="Dominate_Animal";   stRet.iSchool=4;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    case 44: {stRet.sName="Dominate_Monster";   stRet.iSchool=4;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=9;};break;

    case 45: {stRet.sName="Dominate_Person";   stRet.iSchool=4;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    case 46: {stRet.sName="Doom";   stRet.iSchool=4;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=1;};break;

    case 47: {stRet.sName="Elemental_Shield";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=4;};break;

    case 48: {stRet.sName="Elemental_Swarm";   stRet.iSchool=2;    stRet.sTargetType="0x09";     stRet.iCategory=15;     stRet.iLevel=9;};break;

    case 49: {stRet.sName="Endurance";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    case 50: {stRet.sName="Endure_Elements";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=1;};break;

    case 51: {stRet.sName="Energy_Drain";   stRet.iSchool=7;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=9;};break;

    case 52: {stRet.sName="Enervation";   stRet.iSchool=7;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    case 53: {stRet.sName="Entangle";   stRet.iSchool=8;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=1;};break;

    case 54: {stRet.sName="Fear";   stRet.iSchool=7;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=3;};break;

    case 55: {stRet.sName="Feeblemind";   stRet.iSchool=3;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    case 56: {stRet.sName="Finger_of_Death";   stRet.iSchool=7;    stRet.sTargetType="0x0A";     stRet.iCategory=2;     stRet.iLevel=7;};break;

    case 57: {stRet.sName="Fire_Storm";   stRet.iSchool=5;    stRet.sTargetType="0x05";     stRet.iCategory=1;     stRet.iLevel=7;};break;

    case 58: {stRet.sName="Fireball";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=3;};break;

    case 59: {stRet.sName="Flame_Arrow";   stRet.iSchool=2;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    case 60: {stRet.sName="Flame_Lash";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=2;};break;

    case 61: {stRet.sName="Flame_Strike";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=4;};break;

    case 62: {stRet.sName="Freedom_of_Movement";   stRet.iSchool=1;    stRet.sTargetType="0x3B";     stRet.iCategory=9;     stRet.iLevel=4;};break;

    case 63: {stRet.sName="Gate";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=9;};break;

    case 64: {stRet.sName="Ghoul_Touch";   stRet.iSchool=7;    stRet.sTargetType="0x2A";     stRet.iCategory=3;     stRet.iLevel=2;};break;

    case 65: {stRet.sName="Globe_of_Invulnerability";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=6;};break;

    case 66: {stRet.sName="Grease";   stRet.iSchool=2;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=1;};break;

    case 67: {stRet.sName="Greater_Dispelling";   stRet.iSchool=1;    stRet.sTargetType="0x2F";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    case 68: {stRet.sName="Greater_Magic_Weapon";   stRet.iSchool=8;    stRet.sTargetType="0x28";     stRet.iCategory=9;     stRet.iLevel=3;};break;

    case 69: {stRet.sName="Greater_Planar_Binding";   stRet.iSchool=2;    stRet.sTargetType="0x2E";     stRet.iCategory=15;     stRet.iLevel=8;};break;

    case 70: {stRet.sName="Greater_Restoration";   stRet.iSchool=7;    stRet.sTargetType="0x2B";     stRet.iCategory=7;     stRet.iLevel=7;};break;

    case 71: {stRet.sName="Greater_Shadow_Conjuration";   stRet.iSchool=6;    stRet.sTargetType="0x2F";     stRet.iCategory=-1;     stRet.iLevel=5;};break;

    case 72: {stRet.sName="Greater_Spell_Breach";   stRet.iSchool=1;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=6;};break;

    case 73: {stRet.sName="Greater_Spell_Mantle";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=9;};break;

    case 74: {stRet.sName="Greater_Stoneskin";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=6;};break;

    case 75: {stRet.sName="Gust_of_Wind";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=3;};break;

    case 76: {stRet.sName="Hammer_of_the_Gods";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=1;     stRet.iLevel=4;};break;

    case 77: {stRet.sName="Harm";   stRet.iSchool=7;    stRet.sTargetType="0x3A";     stRet.iCategory=3;     stRet.iLevel=6;};break;

    case 78: {stRet.sName="Haste";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=3;};break;

    case 79: {stRet.sName="Heal";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=5;     stRet.iLevel=6;};break;

    case 80: {stRet.sName="Healing_Circle";   stRet.iSchool=2;    stRet.sTargetType="0x05";     stRet.iCategory=4;     stRet.iLevel=5;};break;

    case 81: {stRet.sName="Hold_Animal";   stRet.iSchool=4;    stRet.sTargetType="0x0A";     stRet.iCategory=2;     stRet.iLevel=2;};break;

    case 82: {stRet.sName="Hold_Monster";   stRet.iSchool=4;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    case 83: {stRet.sName="Hold_Person";   stRet.iSchool=4;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=2;};break;

    case 84: {stRet.sName="Holy_Aura";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=10;     stRet.iLevel=8;};break;

    case 85: {stRet.sName="Holy_Sword";   stRet.iSchool=5;    stRet.sTargetType="0x28";     stRet.iCategory=10;     stRet.iLevel=4;};break;

    case 86: {stRet.sName="Identify";   stRet.iSchool=3;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=2;};break;

    case 87: {stRet.sName="Implosion";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=9;};break;

    case 88: {stRet.sName="Improved_Invisibility";   stRet.iSchool=6;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=4;};break;

    case 89: {stRet.sName="Incendiary_Cloud";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    case 90: {stRet.sName="Invisibility";   stRet.iSchool=6;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    case 91: {stRet.sName="Invisibility_Purge";   stRet.iSchool=5;    stRet.sTargetType="0x05";     stRet.iCategory=6;     stRet.iLevel=3;};break;

    case 92: {stRet.sName="Invisibility_Sphere";   stRet.iSchool=6;    stRet.sTargetType="0x09";     stRet.iCategory=8;     stRet.iLevel=3;};break;

    case 93: {stRet.sName="Knock";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=2;};break;

    case 94: {stRet.sName="Lesser_Dispel";   stRet.iSchool=1;    stRet.sTargetType="0x2F";     stRet.iCategory=11;     stRet.iLevel=2;};break;

    case 95: {stRet.sName="Lesser_Mind_Blank";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=5;};break;

    case 96: {stRet.sName="Lesser_Planar_Binding";   stRet.iSchool=2;    stRet.sTargetType="0x2E";     stRet.iCategory=15;     stRet.iLevel=5;};break;

    case 97: {stRet.sName="Lesser_Restoration";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=7;     stRet.iLevel=2;};break;

    case 98: {stRet.sName="Lesser_Spell_Breach";   stRet.iSchool=1;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    case 99: {stRet.sName="Lesser_Spell_Mantle";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=5;};break;

    case 100: {stRet.sName="Light";   stRet.iSchool=5;    stRet.sTargetType="0x2B";     stRet.iCategory=-1;     stRet.iLevel=0;};break;

    case 101: {stRet.sName="Lightning_Bolt";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=11;     stRet.iLevel=3;};break;

    case 102: {stRet.sName="Mage_Armor";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=1;};break;

    case 103: {stRet.sName="Magic_Circle_against_Chaos";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=8;     stRet.iLevel=3;};break;

    case 104: {stRet.sName="Magic_Circle_against_Evil";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=8;     stRet.iLevel=3;};break;

    case 105: {stRet.sName="Magic_Circle_against_Good";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=8;     stRet.iLevel=3;};break;

    case 106: {stRet.sName="Magic_Circle_against_Law";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=8;     stRet.iLevel=3;};break;

    case 107: {stRet.sName="Magic_Missile";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=1;};break;

    case 108: {stRet.sName="Magic_Vestment";   stRet.iSchool=8;    stRet.sTargetType="0x28";     stRet.iCategory=9;     stRet.iLevel=3;};break;

    case 109: {stRet.sName="Magic_Weapon";   stRet.iSchool=8;    stRet.sTargetType="0x28";     stRet.iCategory=9;     stRet.iLevel=1;};break;

    case 110: {stRet.sName="Mass_Blindness_and_Deafness";   stRet.iSchool=6;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=8;};break;

    case 111: {stRet.sName="Mass_Charm";   stRet.iSchool=4;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=8;};break;

    case 112: {stRet.sName="Mass_Domination";   stRet.iSchool=4;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=9;};break;

    case 113: {stRet.sName="Mass_Haste";   stRet.iSchool=4;    stRet.sTargetType="0x2F";     stRet.iCategory=8;     stRet.iLevel=6;};break;

    case 114: {stRet.sName="Mass_Heal";   stRet.iSchool=2;    stRet.sTargetType="0x2F";     stRet.iCategory=4;     stRet.iLevel=8;};break;

    case 115: {stRet.sName="Melfs_Acid_Arrow";   stRet.iSchool=2;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=2;};break;

    case 116: {stRet.sName="Meteor_Swarm";   stRet.iSchool=5;    stRet.sTargetType="0x0D";     stRet.iCategory=1;     stRet.iLevel=9;};break;

    case 117: {stRet.sName="Mind_Blank";   stRet.iSchool=1;    stRet.sTargetType="0x2F";     stRet.iCategory=9;     stRet.iLevel=8;};break;

    case 118: {stRet.sName="Mind_Fog";   stRet.iSchool=4;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    case 119: {stRet.sName="Minor_Globe_of_Invulnerability";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=4;};break;

    case 120: {stRet.sName="Ghostly_Visage";   stRet.iSchool=6;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=2;};break;

    case 121: {stRet.sName="Ethereal_Visage";   stRet.iSchool=6;    stRet.sTargetType="0x09";     stRet.iCategory=10;     stRet.iLevel=5;};break;

    case 122: {stRet.sName="Mordenkainens_Disjunction";   stRet.iSchool=1;    stRet.sTargetType="0x2F";     stRet.iCategory=11;     stRet.iLevel=9;};break;

    case 123: {stRet.sName="Mordenkainens_Sword";   stRet.iSchool=8;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=7;};break;

    case 124: {stRet.sName="Natures_Balance";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=1;     stRet.iLevel=8;};break;

    case 125: {stRet.sName="Negative_Energy_Protection";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=12;     stRet.iLevel=3;};break;

    case 126: {stRet.sName="Neutralize_Poison";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=7;     stRet.iLevel=3;};break;

    case 127: {stRet.sName="Phantasmal_Killer";   stRet.iSchool=6;    stRet.sTargetType="0x0A";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    case 128: {stRet.sName="Planar_Binding";   stRet.iSchool=2;    stRet.sTargetType="0x2E";     stRet.iCategory=15;     stRet.iLevel=6;};break;

    case 129: {stRet.sName="Poison";   stRet.iSchool=7;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    case 130: {stRet.sName="Polymorph_Self";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=4;};break;

    case 131: {stRet.sName="Power_Word_Kill";   stRet.iSchool=3;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=9;};break;

    case 132: {stRet.sName="Power_Word_Stun";   stRet.iSchool=3;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=7;};break;

    case 133: {stRet.sName="Prayer";   stRet.iSchool=2;    stRet.sTargetType="0x2F";     stRet.iCategory=8;     stRet.iLevel=3;};break;

    case 134: {stRet.sName="Premonition";   stRet.iSchool=3;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=8;};break;

    case 135: {stRet.sName="Prismatic_Spray";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=7;};break;

    case 136: {stRet.sName="Protection__from_Chaos";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    case 137: {stRet.sName="Protection_from_Elements";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=3;};break;

    case 138: {stRet.sName="Protection_from_Evil";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=1;};break;

    case 139: {stRet.sName="Protection_from_Good";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=1;};break;

    case 140: {stRet.sName="Protection_from_Law";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    case 141: {stRet.sName="Protection_from_Spells";   stRet.iSchool=4;    stRet.sTargetType="0x2F";     stRet.iCategory=14;     stRet.iLevel=7;};break;

    case 142: {stRet.sName="Raise_Dead";   stRet.iSchool=2;    stRet.sTargetType="0x2A";     stRet.iCategory=7;     stRet.iLevel=5;};break;

    case 143: {stRet.sName="Ray_of_Enfeeblement";   stRet.iSchool=7;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=1;};break;

    case 144: {stRet.sName="Ray_of_Frost";   stRet.iSchool=2;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=0;};break;

    case 145: {stRet.sName="Remove_Blindness_and_Deafness";   stRet.iSchool=3;    stRet.sTargetType="0x2F";     stRet.iCategory=6;     stRet.iLevel=3;};break;

    case 146: {stRet.sName="Remove_Curse";   stRet.iSchool=1;    stRet.sTargetType="0x3B";     stRet.iCategory=7;     stRet.iLevel=3;};break;

    case 147: {stRet.sName="Remove_Disease";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=7;     stRet.iLevel=3;};break;

    case 148: {stRet.sName="Remove_Fear";   stRet.iSchool=1;    stRet.sTargetType="0x2F";     stRet.iCategory=6;     stRet.iLevel=1;};break;

    case 149: {stRet.sName="Remove_Paralysis";   stRet.iSchool=2;    stRet.sTargetType="0x2F";     stRet.iCategory=7;     stRet.iLevel=2;};break;

    case 150: {stRet.sName="Resist_Elements";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=2;};break;

    case 151: {stRet.sName="Resistance";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=1;};break;

    case 152: {stRet.sName="Restoration";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=7;     stRet.iLevel=4;};break;

    case 153: {stRet.sName="Resurrection";   stRet.iSchool=2;    stRet.sTargetType="0x2A";     stRet.iCategory=7;     stRet.iLevel=7;};break;

    case 154: {stRet.sName="Sanctuary";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=1;};break;

    case 155: {stRet.sName="Scare";   stRet.iSchool=7;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=1;};break;

    case 156: {stRet.sName="Searing_Light";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    case 157: {stRet.sName="See_Invisibility";   stRet.iSchool=3;    stRet.sTargetType="0x2B";     stRet.iCategory=7;     stRet.iLevel=2;};break;

    case 158: {stRet.sName="Shades";   stRet.iSchool=6;    stRet.sTargetType="0x2F";     stRet.iCategory=-1;     stRet.iLevel=6;};break;

    case 159: {stRet.sName="Shadow_Conjuration";   stRet.iSchool=6;    stRet.sTargetType="0x2F";     stRet.iCategory=-1;     stRet.iLevel=4;};break;

    case 160: {stRet.sName="Shadow_Shield";   stRet.iSchool=6;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=7;};break;

    case 161: {stRet.sName="Shapechange";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=9;};break;

    case 162: {stRet.sName="Shield_of_Law";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=8;};break;

    case 163: {stRet.sName="Silence";   stRet.iSchool=6;    stRet.sTargetType="0x2B";     stRet.iCategory=-1;     stRet.iLevel=2;};break;

    case 164: {stRet.sName="Slay_Living";   stRet.iSchool=7;    stRet.sTargetType="0x0A";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    case 165: {stRet.sName="Sleep";   stRet.iSchool=4;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=1;};break;

    case 166: {stRet.sName="Slow";   stRet.iSchool=8;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=3;};break;

    case 167: {stRet.sName="Sound_Burst";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=2;};break;

    case 168: {stRet.sName="Spell_Resistance";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=5;};break;

    case 169: {stRet.sName="Spell_Mantle";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=7;};break;

    case 170: {stRet.sName="Sphere_of_Chaos";   stRet.iSchool=8;    stRet.sTargetType="0x2E";     stRet.iCategory=10;     stRet.iLevel=5;};break;

    case 171: {stRet.sName="Stinking_Cloud";   stRet.iSchool=2;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=3;};break;

    case 172: {stRet.sName="Stoneskin";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=4;};break;

    case 173: {stRet.sName="Storm_of_Vengeance";   stRet.iSchool=2;    stRet.sTargetType="0x05";     stRet.iCategory=1;     stRet.iLevel=9;};break;

    case 174: {stRet.sName="Summon_Creature_I";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=1;};break;

    case 175: {stRet.sName="Summon_Creature_II";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=2;};break;

    case 176: {stRet.sName="Summon_Creature_III";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=3;};break;

    case 177: {stRet.sName="Summon_Creature_IV";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=4;};break;

    case 178: {stRet.sName="Summon_Creature_IX";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=9;};break;

    case 179: {stRet.sName="Summon_Creature_V";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=5;};break;

    case 180: {stRet.sName="Summon_Creature_VI";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=6;};break;

    case 181: {stRet.sName="Summon_Creature_VII";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=7;};break;

    case 182: {stRet.sName="Summon_Creature_VIII";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=8;};break;

    case 183: {stRet.sName="Sunbeam";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=7;};break;

    case 184: {stRet.sName="Tensers_Transformation";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=10;     stRet.iLevel=6;};break;

    case 185: {stRet.sName="Time_Stop";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=1;     stRet.iLevel=9;};break;

    case 186: {stRet.sName="True_Seeing";   stRet.iSchool=3;    stRet.sTargetType="0x2B";     stRet.iCategory=6;     stRet.iLevel=5;};break;

    case 187: {stRet.sName="Unholy_Aura";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=10;     stRet.iLevel=8;};break;

    case 188: {stRet.sName="Vampiric_Touch";   stRet.iSchool=7;    stRet.sTargetType="0x0A";     stRet.iCategory=3;     stRet.iLevel=3;};break;

    case 189: {stRet.sName="Virtue";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=0;};break;

    case 190: {stRet.sName="Wail_of_the_Banshee";   stRet.iSchool=7;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=9;};break;

    case 191: {stRet.sName="Wall_of_Fire";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=4;};break;

    case 192: {stRet.sName="Web";   stRet.iSchool=2;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=2;};break;

    case 193: {stRet.sName="Weird";   stRet.iSchool=6;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=9;};break;

    case 194: {stRet.sName="Word_of_Faith";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=7;};break;

    //case 195: {stRet.sName="AURA_BLINDING";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=16;     stRet.iLevel=5;};break;

    //case 196: {stRet.sName="Aura_Cold";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=16;     stRet.iLevel=4;};break;

    //case 197: {stRet.sName="Aura_Electricity";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=16;     stRet.iLevel=4;};break;

    //case 198: {stRet.sName="Aura_Fear";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=16;     stRet.iLevel=4;};break;

    //case 199: {stRet.sName="Aura_Fire";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=16;     stRet.iLevel=4;};break;

    //case 200: {stRet.sName="Aura_Menace";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=16;     stRet.iLevel=3;};break;

    //case 201: {stRet.sName="Aura_Protection";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=16;     stRet.iLevel=4;};break;

    //case 202: {stRet.sName="Aura_Stun";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=16;     stRet.iLevel=5;};break;

    //case 203: {stRet.sName="Aura_Unearthly_Visage";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=16;     stRet.iLevel=7;};break;

    //case 204: {stRet.sName="Aura_Unnatural";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=16;     stRet.iLevel=3;};break;

    //case 205: {stRet.sName="Bolt_Ability_Drain_Charisma";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 206: {stRet.sName="Bolt_Ability_Drain_Constitution";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 207: {stRet.sName="Bolt_Ability_Drain_Dexterity";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 208: {stRet.sName="Bolt_Ability_Drain_Intelligence";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 209: {stRet.sName="Bolt_Ability_Drain_Strength";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 210: {stRet.sName="Bolt_Ability_Drain_Wisdom";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 211: {stRet.sName="Bolt_Acid";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 212: {stRet.sName="Bolt_Charm";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 213: {stRet.sName="Bolt_Cold";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 214: {stRet.sName="Bolt_Confuse";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 215: {stRet.sName="Bolt_Daze";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    //case 216: {stRet.sName="Bolt_Death";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    //case 217: {stRet.sName="Bolt_Disease";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 218: {stRet.sName="Bolt_Dominate";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=6;};break;

    //case 219: {stRet.sName="Bolt_Fire";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 220: {stRet.sName="Bolt_Knockdown";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 221: {stRet.sName="Bolt_Level_Drain";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=6;};break;

    //case 222: {stRet.sName="Bolt_Lightning";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 223: {stRet.sName="Bolt_Paralyze";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    //case 224: {stRet.sName="Bolt_Poison";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    //case 225: {stRet.sName="Bolt_Shards";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 226: {stRet.sName="Bolt_Slow";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 227: {stRet.sName="Bolt_Stun";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    //case 228: {stRet.sName="Bolt_Web";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 229: {stRet.sName="Cone_Acid";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 230: {stRet.sName="Cone_Cold";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 231: {stRet.sName="Cone_Disease";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 232: {stRet.sName="Cone_Fire";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 233: {stRet.sName="Cone_Lightning";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 234: {stRet.sName="Cone_Poison";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=6;};break;

    //case 235: {stRet.sName="Cone_Sonic";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 236: {stRet.sName="Dragon_Breath_Acid";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 237: {stRet.sName="Dragon_Breath_Cold";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 238: {stRet.sName="Dragon_Breath_Fear";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 239: {stRet.sName="Dragon_Breath_Fire";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 240: {stRet.sName="Dragon_Breath_Gas";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 241: {stRet.sName="Dragon_Breath_Lightning";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 242: {stRet.sName="Dragon_Breath_Paralyze";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 243: {stRet.sName="Dragon_Breath_Sleep";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 244: {stRet.sName="Dragon_Breath_Slow";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 245: {stRet.sName="Dragon_Breath_Weaken";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 246: {stRet.sName="Dragon_Wing_Buffet";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=19;     stRet.iLevel=7;};break;

    //case 247: {stRet.sName="Ferocity_1";   stRet.iSchool=5;    stRet.sTargetType="0x29";     stRet.iCategory=16;     stRet.iLevel=3;};break;

    //case 248: {stRet.sName="Ferocity_2";   stRet.iSchool=5;    stRet.sTargetType="0x29";     stRet.iCategory=16;     stRet.iLevel=4;};break;

    //case 249: {stRet.sName="Ferocity_3";   stRet.iSchool=5;    stRet.sTargetType="0x29";     stRet.iCategory=16;     stRet.iLevel=5;};break;

    //case 250: {stRet.sName="Gaze_Charm";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 251: {stRet.sName="Gaze_Confusion";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 252: {stRet.sName="Gaze_Daze";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=4;};break;

    //case 253: {stRet.sName="Gaze_Death";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=6;};break;

    //case 254: {stRet.sName="Gaze_Destroy_Chaos";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 255: {stRet.sName="Gaze_Destroy_Evil";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 256: {stRet.sName="Gaze_Destroy_Good";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 257: {stRet.sName="Gaze_Destroy_Law";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 258: {stRet.sName="Gaze_Dominate";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=6;};break;

    //case 259: {stRet.sName="Gaze_Doom";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=4;};break;

    //case 260: {stRet.sName="Gaze_Fear";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 261: {stRet.sName="Gaze_Paralysis";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 262: {stRet.sName="Gaze_Stunned";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 263: {stRet.sName="Golem_Breath_Gas";   stRet.iSchool=5;    stRet.sTargetType="0x0A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 264: {stRet.sName="Hell_Hound_Firebreath";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=1;};break;

    //case 265: {stRet.sName="Howl_Confuse";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=6;};break;

    //case 266: {stRet.sName="Howl_Daze";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=4;};break;

    //case 267: {stRet.sName="Howl_Death";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=7;};break;

    //case 268: {stRet.sName="Howl_Doom";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=4;};break;

    //case 269: {stRet.sName="Howl_Fear";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 270: {stRet.sName="Howl_Paralysis";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 271: {stRet.sName="Howl_Sonic";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 272: {stRet.sName="Howl_Stun";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=6;};break;

    //case 273: {stRet.sName="Intensity_1";   stRet.iSchool=5;    stRet.sTargetType="0x29";     stRet.iCategory=16;     stRet.iLevel=3;};break;

    //case 274: {stRet.sName="Intensity_2";   stRet.iSchool=5;    stRet.sTargetType="0x29";     stRet.iCategory=16;     stRet.iLevel=4;};break;

    //case 275: {stRet.sName="Intensity_3";   stRet.iSchool=5;    stRet.sTargetType="0x29";     stRet.iCategory=16;     stRet.iLevel=5;};break;

    //case 276: {stRet.sName="Krenshar_Scare";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=1;     stRet.iLevel=2;};break;

    //case 277: {stRet.sName="Lesser_Body_Adjustment";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=5;     stRet.iLevel=2;};break;

    //case 278: {stRet.sName="Mephit_Salt_Breath";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=3;};break;

    //case 279: {stRet.sName="Mephit_Steam_Breath";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=11;     stRet.iLevel=3;};break;

    //case 280: {stRet.sName="Mummy_Bolster_Undead";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=8;     stRet.iLevel=5;};break;

    //case 281: {stRet.sName="Pulse_Drown";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=1;     stRet.iLevel=4;};break;

    //case 282: {stRet.sName="Pulse_Spores";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=1;     stRet.iLevel=4;};break;

    //case 283: {stRet.sName="Pulse_Whirlwind";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=1;     stRet.iLevel=4;};break;

    //case 284: {stRet.sName="Pulse_Fire";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 285: {stRet.sName="Pulse_Lightning";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 286: {stRet.sName="Pulse_Cold";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 287: {stRet.sName="Pulse_Negative";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 288: {stRet.sName="Pulse_Holy";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 289: {stRet.sName="Pulse_Death";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=11;     stRet.iLevel=7;};break;

    //case 290: {stRet.sName="Pulse_Level_Drain";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=11;     stRet.iLevel=7;};break;

    //case 291: {stRet.sName="Pulse_Ability_Drain_Intelligence";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=1;     stRet.iLevel=6;};break;

    //case 292: {stRet.sName="Pulse_Ability_Drain_Charisma";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=1;     stRet.iLevel=6;};break;

    //case 293: {stRet.sName="Pulse_Ability_Drain_Constitution";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=1;     stRet.iLevel=6;};break;

    //case 294: {stRet.sName="Pulse_Ability_Drain_Dexterity";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=1;     stRet.iLevel=6;};break;

    //case 295: {stRet.sName="Pulse_Ability_Drain_Strength";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=1;     stRet.iLevel=6;};break;

    //case 296: {stRet.sName="Pulse_Ability_Drain_Wisdom";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=1;     stRet.iLevel=6;};break;

    //case 297: {stRet.sName="Pulse_Poison";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=1;     stRet.iLevel=5;};break;

    //case 298: {stRet.sName="Pulse_Disease";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=1;     stRet.iLevel=5;};break;

    //case 299: {stRet.sName="Rage_3";   stRet.iSchool=5;    stRet.sTargetType="0x29";     stRet.iCategory=16;     stRet.iLevel=3;};break;

    //case 300: {stRet.sName="Rage_4";   stRet.iSchool=5;    stRet.sTargetType="0x29";     stRet.iCategory=16;     stRet.iLevel=4;};break;

    //case 301: {stRet.sName="Rage_5";   stRet.iSchool=5;    stRet.sTargetType="0x29";     stRet.iCategory=16;     stRet.iLevel=5;};break;

    //case 302: {stRet.sName="Smoke_Claw";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=3;     stRet.iLevel=3;};break;

    case 303: {stRet.sName="Summon_Slaad";   stRet.iSchool=5;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=5;};break;

    case 304: {stRet.sName="Summon_Tanarri";   stRet.iSchool=5;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=5;};break;

    //case 305: {stRet.sName="Trumpet_Blast";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=1;     stRet.iLevel=5;};break;

    //case 306: {stRet.sName="Tyrant_Fog_Mist";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=16;     stRet.iLevel=3;};break;

    //case 307: {stRet.sName="BARBARIAN_RAGE";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=16;     stRet.iLevel=1;};break;

    //case 308: {stRet.sName="Turn_Undead";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=1;     stRet.iLevel=1;};break;

    //case 309: {stRet.sName="Wholeness_of_Body";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=17;     stRet.iLevel=1;};break;

    //case 310: {stRet.sName="Quivering_Palm";   stRet.iSchool=5;    stRet.sTargetType="0x0a";     stRet.iCategory=3;     stRet.iLevel=1;};break;

    //case 311: {stRet.sName="Empty_Body";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=9;     stRet.iLevel=1;};break;

    //case 312: {stRet.sName="Detect_Evil";   stRet.iSchool=5;    stRet.sTargetType="0x0f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 313: {stRet.sName="Lay_On_Hands";   stRet.iSchool=5;    stRet.sTargetType="0x03";     stRet.iCategory=5;     stRet.iLevel=1;};break;

    //case 314: {stRet.sName="Aura_Of_Courage";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 315: {stRet.sName="Smite_Evil";   stRet.iSchool=5;    stRet.sTargetType="0x0a";     stRet.iCategory=3;     stRet.iLevel=1;};break;

    //case 316: {stRet.sName="Remove_Disease";   stRet.iSchool=5;    stRet.sTargetType="0x0b";     stRet.iCategory=7;     stRet.iLevel=1;};break;

    //case 317: {stRet.sName="Summon_Animal_Companion";   stRet.iSchool=5;    stRet.sTargetType="0x0c";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 318: {stRet.sName="Summon_Familiar";   stRet.iSchool=5;    stRet.sTargetType="0x0c";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 319: {stRet.sName="Elemental_Shape";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 320: {stRet.sName="Wild_Shape";   stRet.iSchool=5;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    case 321: {stRet.sName="PROTECTION_FROM_ALIGNMENT";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    case 322: {stRet.sName="Magic_Circle_against_Alignment";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    case 323: {stRet.sName="Aura_versus_Alignment";   stRet.iSchool=1;    stRet.sTargetType="0x29";     stRet.iCategory=-1;     stRet.iLevel=8;};break;

    case 324: {stRet.sName="SHADES_Summon_Shadow";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=1;     stRet.iLevel=4;};break;

    //case 325: {stRet.sName="DELETED_PRO_Cold";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 326: {stRet.sName="DELETED_PRO_Fire";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 327: {stRet.sName="DELETED_PRO_Acid";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 328: {stRet.sName="DELETED_PRO_Sonic";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 329: {stRet.sName="DELETED_PRO_Elec";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 330: {stRet.sName="DELETED_END_Cold";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 331: {stRet.sName="DELETED_END_Fire";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 332: {stRet.sName="DELETED_END_Acid";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 333: {stRet.sName="DELETED_END_Sonic";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 334: {stRet.sName="DELETED_END_Elec";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 335: {stRet.sName="DELETED_RES_Cold";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 336: {stRet.sName="DELETED_RES_Fire";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 337: {stRet.sName="DELETED_RES_Acid";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 338: {stRet.sName="DELETED_RES_Sonic";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 339: {stRet.sName="DELETED_RES_Elec";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    case 340: {stRet.sName="SHADES_Cone_of_Cold";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    case 341: {stRet.sName="SHADES_Fireball";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=3;};break;

    case 342: {stRet.sName="SHADES_Stoneskin";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=4;};break;

    case 343: {stRet.sName="SHADES_Wall_of_Fire";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=4;};break;

    case 344: {stRet.sName="SHADOW_CON_Summon_Shadow";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=1;     stRet.iLevel=4;};break;

    case 345: {stRet.sName="SHADOW_CON_Darkness";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=11;     stRet.iLevel=2;};break;

    case 346: {stRet.sName="SHADOW_CON_Inivsibility";   stRet.iSchool=6;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    case 347: {stRet.sName="SHADOW_CON_Mage_Armor";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=1;};break;

    case 348: {stRet.sName="SHADOW_CON_Magic_Missile";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=1;};break;

    case 349: {stRet.sName="GR_SHADOW_CON_Summon_Shadow";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=1;     stRet.iLevel=4;};break;

    case 350: {stRet.sName="GR_SHADOW_CON_Acid_Arrow";   stRet.iSchool=2;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=2;};break;

    case 351: {stRet.sName="GR_SHADOW_CON_Ghostly_Visage";   stRet.iSchool=6;    stRet.sTargetType="0x29";     stRet.iCategory=13;     stRet.iLevel=2;};break;

    case 352: {stRet.sName="GR_SHADOW_CON_Web";   stRet.iSchool=2;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=2;};break;

    case 353: {stRet.sName="GR_SHADOW_CON_Minor_Globe";   stRet.iSchool=1;    stRet.sTargetType="0x29";     stRet.iCategory=12;     stRet.iLevel=4;};break;

    case 354: {stRet.sName="Eagle_Splendor";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    case 355: {stRet.sName="Owls_Wisdom";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    case 356: {stRet.sName="Foxs_Cunning";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    case 357: {stRet.sName="Greater_Eagle_Splendor";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=6;};break;

    case 358: {stRet.sName="Greater_Owls_Wisdom";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=6;};break;

    case 359: {stRet.sName="Greater_Foxs_Cunning";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=6;};break;

    case 360: {stRet.sName="Greater_Bulls_Strength";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=6;};break;

    case 361: {stRet.sName="Greater_Cats_Grace";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=6;};break;

    case 362: {stRet.sName="Greater_Endurance";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=6;};break;

    case 363: {stRet.sName="Awaken";   stRet.iSchool=8;    stRet.sTargetType="0x2A";     stRet.iCategory=10;     stRet.iLevel=5;};break;

    case 364: {stRet.sName="Creeping_Doom";   stRet.iSchool=2;    stRet.sTargetType="0x3f";     stRet.iCategory=1;     stRet.iLevel=7;};break;

    case 365: {stRet.sName="Ultravision";   stRet.iSchool=8;    stRet.sTargetType="0x0b";     stRet.iCategory=10;     stRet.iLevel=2;};break;

    case 366: {stRet.sName="Destruction";   stRet.iSchool=7;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=7;};break;

    case 367: {stRet.sName="Horrid_Wilting";   stRet.iSchool=7;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=8;};break;

    case 368: {stRet.sName="Ice_Storm";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=4;};break;

    case 369: {stRet.sName="Energy_Buffer";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=5;};break;

    case 370: {stRet.sName="Negative_Energy_Burst";   stRet.iSchool=7;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=3;};break;

    case 371: {stRet.sName="Negative_Energy_Ray";   stRet.iSchool=7;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=1;};break;

    case 372: {stRet.sName="Aura_of_Vitality";   stRet.iSchool=8;    stRet.sTargetType="0x2F";     stRet.iCategory=8;     stRet.iLevel=7;};break;

    case 373: {stRet.sName="War_Cry";   stRet.iSchool=4;    stRet.sTargetType="0x09";     stRet.iCategory=1;     stRet.iLevel=4;};break;

    case 374: {stRet.sName="Regenerate";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=10;     stRet.iLevel=7;};break;

    case 375: {stRet.sName="Evards_Black_Tentacles";   stRet.iSchool=2;    stRet.sTargetType="0x3E";     stRet.iCategory=1;     stRet.iLevel=4;};break;

    case 376: {stRet.sName="Legend_Lore";   stRet.iSchool=3;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=5;};break;

    case 377: {stRet.sName="Find_Traps";   stRet.iSchool=3;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    case 378: {stRet.sName="Summon_Mephit";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=5;};break;

    case 379: {stRet.sName="Summon_Celestial";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=5;};break;

    case 380: {stRet.sName="Battle_Mastery_Spell";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=10;     stRet.iLevel=1;};break;

    case 381: {stRet.sName="Divine_Strength";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=10;     stRet.iLevel=1;};break;

    case 382: {stRet.sName="Divine_Protection";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=10;     stRet.iLevel=1;};break;

    case 383: {stRet.sName="Negative_Plane_Avatar";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=10;     stRet.iLevel=1;};break;

    case 384: {stRet.sName="Divine_Trickery";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=10;     stRet.iLevel=1;};break;

    case 385: {stRet.sName="Rogues_Cunning";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=10;     stRet.iLevel=3;};break;

    //case 386: {stRet.sName="ACTIVATE_ITEM";   stRet.iSchool=2;    stRet.sTargetType="0x7f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    case 387: {stRet.sName="Polymorph_GIANT_SPIDER";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    case 388: {stRet.sName="Polymorph_TROLL";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    case 389: {stRet.sName="Polymorph_UMBER_HULK";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    case 390: {stRet.sName="Polymorph_PIXIE";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    case 391: {stRet.sName="Polymorph_ZOMBIE";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    case 392: {stRet.sName="Shapechange_RED_DRAGON";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=9;};break;

    case 393: {stRet.sName="Shapechange_FIRE_GIANT";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=9;};break;

    case 394: {stRet.sName="Shapechange_BALOR";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=9;};break;

    case 395: {stRet.sName="Shapechange_DEATH_SLAAD";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=9;};break;

    case 396: {stRet.sName="Shapechange_IRON_GOLEM";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=9;};break;

    //case 397: {stRet.sName="Elemental_Shape_FIRE";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 398: {stRet.sName="Elemental_Shape_WATER";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 399: {stRet.sName="Elemental_Shape_EARTH";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 400: {stRet.sName="Elemental_Shape_AIR";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 401: {stRet.sName="Wild_Shape_BROWN_BEAR";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 402: {stRet.sName="Wild_Shape_PANTHER";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 403: {stRet.sName="Wild_Shape_WOLF";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 404: {stRet.sName="Wild_Shape_BOAR";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 405: {stRet.sName="Wild_Shape_BADGER";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 406: {stRet.sName="Special_Alcohol_Beer";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 407: {stRet.sName="Special_Alcohol_Wine";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 408: {stRet.sName="Special_Alcohol_Spirits";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 409: {stRet.sName="Special_Herb_Belladonna";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 410: {stRet.sName="Special_Herb_Garlic";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 411: {stRet.sName="Bards_Song";   stRet.iSchool=5;    stRet.sTargetType="0x01";     stRet.iCategory=8;     stRet.iLevel=1;};break;

    //case 412: {stRet.sName="Aura_Fear_Dragon";   stRet.iSchool=5;    stRet.sTargetType="0x01";     stRet.iCategory=16;     stRet.iLevel=7;};break;

    //case 413: {stRet.sName="ACTIVATE_ITEM_SELF";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 414: {stRet.sName="Divine_Favor";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=9;     stRet.iLevel=1;};break;

    case 415: {stRet.sName="True_Strike";   stRet.iSchool=3;    stRet.sTargetType="0x09";     stRet.iCategory=9;     stRet.iLevel=1;};break;

    case 416: {stRet.sName="Flare";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=0;};break;

    case 417: {stRet.sName="Shield";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=13;     stRet.iLevel=1;};break;

    case 418: {stRet.sName="Entropic_Shield";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=13;     stRet.iLevel=1;};break;

    case 419: {stRet.sName="Continual_Flame";   stRet.iSchool=6;    stRet.sTargetType="0x2B";     stRet.iCategory=-1;     stRet.iLevel=2;};break;

    case 420: {stRet.sName="One_With_The_Land";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=2;};break;

    case 421: {stRet.sName="Camoflage";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    case 422: {stRet.sName="Blood_Frenzy";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=2;};break;

    case 423: {stRet.sName="Bombardment";   stRet.iSchool=2;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    case 424: {stRet.sName="Acid_Splash";   stRet.iSchool=2;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=0;};break;

    case 425: {stRet.sName="Quillfire";   stRet.iSchool=8;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    case 426: {stRet.sName="Earthquake";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    case 427: {stRet.sName="Sunburst";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=1;     stRet.iLevel=8;};break;

    //case 428: {stRet.sName="ACTIVATE_ITEM_SELF2";   stRet.iSchool=2;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    case 429: {stRet.sName="AuraOfGlory";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    case 430: {stRet.sName="Banishment";   stRet.iSchool=1;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=6;};break;

    case 431: {stRet.sName="Inflict_Minor_Wounds";   stRet.iSchool=7;    stRet.sTargetType="0x3A";     stRet.iCategory=-1;     stRet.iLevel=0;};break;

    case 432: {stRet.sName="Inflict_Light_Wounds";   stRet.iSchool=7;    stRet.sTargetType="0x3A";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    case 433: {stRet.sName="Inflict_Moderate_Wounds";   stRet.iSchool=7;    stRet.sTargetType="0x3A";     stRet.iCategory=-1;     stRet.iLevel=2;};break;

    case 434: {stRet.sName="Inflict_Serious_Wounds";   stRet.iSchool=7;    stRet.sTargetType="0x3A";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    case 435: {stRet.sName="Inflict_Critical_Wounds";   stRet.iSchool=7;    stRet.sTargetType="0x3A";     stRet.iCategory=3;     stRet.iLevel=4;};break;

    case 436: {stRet.sName="BalagarnsIronHorn";   stRet.iSchool=4;    stRet.sTargetType="0x09";     stRet.iCategory=1;     stRet.iLevel=2;};break;

    case 437: {stRet.sName="Drown";   stRet.iSchool=8;    stRet.sTargetType="0x0a";     stRet.iCategory=2;     stRet.iLevel=6;};break;

    case 438: {stRet.sName="Owls_Insight";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=5;};break;

    case 439: {stRet.sName="Electric_Jolt";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=0;};break;

    case 440: {stRet.sName="Firebrand";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    case 441: {stRet.sName="Wounding_Whispers";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=3;};break;

    case 442: {stRet.sName="Amplify";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    case 443: {stRet.sName="Etherealness";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=7;};break;

    case 444: {stRet.sName="Undeaths_Eternal_Foe";   stRet.iSchool=1;    stRet.sTargetType="0x2F";     stRet.iCategory=9;     stRet.iLevel=9;};break;

    case 445: {stRet.sName="Dirge";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=11;     stRet.iLevel=6;};break;

    case 446: {stRet.sName="Inferno";   stRet.iSchool=8;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    case 447: {stRet.sName="Isaacs_Lesser_Missile_Storm";   stRet.iSchool=5;    stRet.sTargetType="0x1E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    case 448: {stRet.sName="Isaacs_Greater_Missile_Storm";   stRet.iSchool=5;    stRet.sTargetType="0x1E";     stRet.iCategory=2;     stRet.iLevel=6;};break;

    case 449: {stRet.sName="Bane";   stRet.iSchool=4;    stRet.sTargetType="0x2F";     stRet.iCategory=9;     stRet.iLevel=1;};break;

    case 450: {stRet.sName="Shield_of_Faith";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=1;};break;

    case 451: {stRet.sName="Planar_Ally";   stRet.iSchool=2;    stRet.sTargetType="0x2E";     stRet.iCategory=15;     stRet.iLevel=6;};break;

    case 452: {stRet.sName="Magic_Fang";   stRet.iSchool=2;    stRet.sTargetType="0x09";     stRet.iCategory=13;     stRet.iLevel=1;};break;

    case 453: {stRet.sName="Greater_Magic_Fang";   stRet.iSchool=2;    stRet.sTargetType="0x09";     stRet.iCategory=13;     stRet.iLevel=3;};break;

    case 454: {stRet.sName="Spike_Growth";   stRet.iSchool=8;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=3;};break;

    case 455: {stRet.sName="Mass_Camoflage";   stRet.iSchool=8;    stRet.sTargetType="0x2F";     stRet.iCategory=9;     stRet.iLevel=4;};break;

    case 456: {stRet.sName="Expeditious_Retreat";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=10;     stRet.iLevel=1;};break;

    case 457: {stRet.sName="Tashas_Hideous_Laughter";   stRet.iSchool=4;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=2;};break;

    case 458: {stRet.sName="Displacement";   stRet.iSchool=6;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=3;};break;

    case 459: {stRet.sName="Bigbys_Interposing_Hand";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    case 460: {stRet.sName="Bigbys_Forceful_Hand";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=6;};break;

    case 461: {stRet.sName="Bigbys_Grasping_Hand";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=7;};break;

    case 462: {stRet.sName="Bigbys_Clenched_Fist";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=8;};break;

    case 463: {stRet.sName="Bigbys_Crushing_Hand";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=9;};break;

    //case 464: {stRet.sName="Grenade_Fire";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 465: {stRet.sName="Grenade_Tangle";   stRet.iSchool=8;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 466: {stRet.sName="Grenade_Holy";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 467: {stRet.sName="Grenade_Choking";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 468: {stRet.sName="Grenade_Thunderstone";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 469: {stRet.sName="Grenade_Acid";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 470: {stRet.sName="Grenade_Chicken";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 471: {stRet.sName="Grenade_Caltrops";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 472: {stRet.sName="ACTIVATE_ITEM_PORTAL";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 473: {stRet.sName="Divine_Might";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 474: {stRet.sName="Divine_Shield";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 475: {stRet.sName="SHADOW_DAZE";   stRet.iSchool=6;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=-1;};break;

    //case 476: {stRet.sName="SUMMON_SHADOW";   stRet.iSchool=6;    stRet.sTargetType="0x2C";     stRet.iCategory=2;     stRet.iLevel=-1;};break;

    //case 477: {stRet.sName="SHADOW_EVADE";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=10;     stRet.iLevel=-1;};break;

    //case 478: {stRet.sName="TYMORAS_SMILE";   stRet.iSchool=4;    stRet.sTargetType="0x09";     stRet.iCategory=9;     stRet.iLevel=-1;};break;

    //case 479: {stRet.sName="CRAFT_HARPER_ITEM";   stRet.iSchool=4;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    case 480: {stRet.sName="Sleep";   stRet.iSchool=4;    stRet.sTargetType="0x2E";     stRet.iCategory=1;     stRet.iLevel=1;};break;

    case 481: {stRet.sName="Cats_Grace";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    case 482: {stRet.sName="Eagle_Splendor";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    case 483: {stRet.sName="Invisibility";   stRet.iSchool=6;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    //case 484: {stRet.sName="";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    case 485: {stRet.sName="Flesh_to_stone";   stRet.iSchool=8;    stRet.sTargetType="0x0a";     stRet.iCategory=2;     stRet.iLevel=6;};break;

    case 486: {stRet.sName="Stone_to_flesh";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=6;};break;

    //case 487: {stRet.sName="Trap_Arrow";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 488: {stRet.sName="Trap_Bolt";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 489: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 490: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 491: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 492: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 493: {stRet.sName="Trap_Dart";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 494: {stRet.sName="Trap_Shuriken";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 495: {stRet.sName="Breath_Petrify";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    //case 496: {stRet.sName="Touch_Petrify";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    //case 497: {stRet.sName="Gaze_Petrify";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    case 498: {stRet.sName="Manticore_Spikes";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    //case 499: {stRet.sName="RodOfWonder";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=-1;     stRet.iLevel=10;};break;

    //case 500: {stRet.sName="DeckOfManyThings";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=10;};break;

    //case 501: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 502: {stRet.sName="ElementalSummoningItem";   stRet.iSchool=5;    stRet.sTargetType="0x0c";     stRet.iCategory=-1;     stRet.iLevel=5;};break;

    //case 503: {stRet.sName="DeckAvatar";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=10;};break;

    //case 504: {stRet.sName="Gem_Spray";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=-1;     stRet.iLevel=5;};break;

    //case 505: {stRet.sName="Butterfly_Spray";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=-1;     stRet.iLevel=5;};break;

    //case 506: {stRet.sName="HealingKit";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 507: {stRet.sName="PowerStone";   stRet.iSchool=2;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 508: {stRet.sName="Spellstaff";   stRet.iSchool=2;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 509: {stRet.sName="Charger";   stRet.iSchool=4;    stRet.sTargetType="0x08";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 510: {stRet.sName="Decharger";   stRet.iSchool=4;    stRet.sTargetType="0x08";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 511: {stRet.sName="Kobold_Jump";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 512: {stRet.sName="Crumble";   stRet.iSchool=8;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=6;};break;

    case 513: {stRet.sName="Infestation_of_Maggots";   stRet.iSchool=7;    stRet.sTargetType="0x0A";     stRet.iCategory=3;     stRet.iLevel=3;};break;

    case 514: {stRet.sName="Healing_Sting";   stRet.iSchool=7;    stRet.sTargetType="0x2A";     stRet.iCategory=3;     stRet.iLevel=3;};break;

    case 515: {stRet.sName="Great_Thunderclap";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=7;};break;

    case 516: {stRet.sName="Ball_Lightning";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    case 517: {stRet.sName="Battletide";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=1;     stRet.iLevel=5;};break;

    case 518: {stRet.sName="Combust";   stRet.iSchool=5;    stRet.sTargetType="0x2A";     stRet.iCategory=3;     stRet.iLevel=2;};break;

    case 519: {stRet.sName="Death_Armor";   stRet.iSchool=7;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=2;};break;

    case 520: {stRet.sName="Gedlees_Electric_Loop";   stRet.iSchool=5;    stRet.sTargetType="0x0E";     stRet.iCategory=1;     stRet.iLevel=2;};break;

    case 521: {stRet.sName="Horizikauls_Boom";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=1;};break;

    case 522: {stRet.sName="Ironguts";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=1;};break;

    case 523: {stRet.sName="Mestils_Acid_Breath";   stRet.iSchool=2;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=3;};break;

    case 524: {stRet.sName="Mestils_Acid_Sheath";   stRet.iSchool=2;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=5;};break;

    case 525: {stRet.sName="Monstrous_Regeneration";   stRet.iSchool=2;    stRet.sTargetType="0x0B";     stRet.iCategory=10;     stRet.iLevel=5;};break;

    case 526: {stRet.sName="Scintillating_Sphere";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=3;};break;

    case 527: {stRet.sName="Stone_Bones";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=2;};break;

    case 528: {stRet.sName="Undeath_to_Death";   stRet.iSchool=7;    stRet.sTargetType="0x3E";     stRet.iCategory=1;     stRet.iLevel=6;};break;

    //case 529: {stRet.sName="Vine_Mine";   stRet.iSchool=2;    stRet.sTargetType="0x2F";     stRet.iCategory=-1;     stRet.iLevel=5;};break;

    //case 530: {stRet.sName="Vine_Mine_Entangle";   stRet.iSchool=8;    stRet.sTargetType="0x2F";     stRet.iCategory=11;     stRet.iLevel=1;};break;

    //case 531: {stRet.sName="Vine_Mine_Hamper_Movement";   stRet.iSchool=2;    stRet.sTargetType="0x2F";     stRet.iCategory=11;     stRet.iLevel=1;};break;

    //case 532: {stRet.sName="Vine_Mine_Camouflage";   stRet.iSchool=2;    stRet.sTargetType="0x2F";     stRet.iCategory=14;     stRet.iLevel=1;};break;

    case 533: {stRet.sName="Black_Blade_of_Disaster";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=9;};break;

    case 534: {stRet.sName="Shelgarns_Persistent_Blade";   stRet.iSchool=5;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=1;};break;

    case 535: {stRet.sName="Blade_Thirst";   stRet.iSchool=8;    stRet.sTargetType="0x0B";     stRet.iCategory=9;     stRet.iLevel=3;};break;

    case 536: {stRet.sName="Deafening_Clang";   stRet.iSchool=8;    stRet.sTargetType="0x0B";     stRet.iCategory=9;     stRet.iLevel=1;};break;

    case 537: {stRet.sName="Bless_Weapon";   stRet.iSchool=8;    stRet.sTargetType="0x0B";     stRet.iCategory=9;     stRet.iLevel=1;};break;

    case 538: {stRet.sName="Holy_Sword";   stRet.iSchool=5;    stRet.sTargetType="0x0B";     stRet.iCategory=9;     stRet.iLevel=4;};break;

    case 539: {stRet.sName="Keen_Edge";   stRet.iSchool=8;    stRet.sTargetType="0x0B";     stRet.iCategory=9;     stRet.iLevel=3;};break;

    //case 540: {stRet.sName="";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    case 541: {stRet.sName="Blackstaff";   stRet.iSchool=8;    stRet.sTargetType="0x0B";     stRet.iCategory=9;     stRet.iLevel=8;};break;

    case 542: {stRet.sName="Flame_Weapon";   stRet.iSchool=5;    stRet.sTargetType="0x0B";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    case 543: {stRet.sName="Ice_Dagger";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=1;};break;

    case 544: {stRet.sName="Magic_Weapon";   stRet.iSchool=8;    stRet.sTargetType="0x0B";     stRet.iCategory=9;     stRet.iLevel=1;};break;

    case 545: {stRet.sName="Greater_Magic_Weapon";   stRet.iSchool=8;    stRet.sTargetType="0x0B";     stRet.iCategory=9;     stRet.iLevel=3;};break;

    case 546: {stRet.sName="Magic_Vestment";   stRet.iSchool=8;    stRet.sTargetType="0x0B";     stRet.iCategory=9;     stRet.iLevel=3;};break;

    case 547: {stRet.sName="Stonehold";   stRet.iSchool=2;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=6;};break;

    case 548: {stRet.sName="Darkfire";   stRet.iSchool=5;    stRet.sTargetType="0x0B";     stRet.iCategory=9;     stRet.iLevel=3;};break;

    case 549: {stRet.sName="Glyph_of_Warding";   stRet.iSchool=1;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=3;};break;

    //case 550: {stRet.sName="";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 551: {stRet.sName="MONSTER_MindBlast";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 552: {stRet.sName="MONSTER_CharmMonster";   stRet.iSchool=4;    stRet.sTargetType="0x0A";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 553: {stRet.sName="Goblin_Ballista_Fireball";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=3;};break;

    //case 554: {stRet.sName="Ioun_Stone_Dusty_Rose";   stRet.iSchool=1;    stRet.sTargetType="0x01";     stRet.iCategory=13;     stRet.iLevel=3;};break;

    //case 555: {stRet.sName="Ioun_Stone_Pale_Blue";   stRet.iSchool=1;    stRet.sTargetType="0x01";     stRet.iCategory=13;     stRet.iLevel=3;};break;

    //case 556: {stRet.sName="Ioun_Stone_Scarlet_Blue";   stRet.iSchool=1;    stRet.sTargetType="0x01";     stRet.iCategory=13;     stRet.iLevel=3;};break;

    //case 557: {stRet.sName="Ioun_Stone_Blue";   stRet.iSchool=1;    stRet.sTargetType="0x01";     stRet.iCategory=13;     stRet.iLevel=3;};break;

    //case 558: {stRet.sName="Ioun_Stone_Deep_Red";   stRet.iSchool=1;    stRet.sTargetType="0x01";     stRet.iCategory=13;     stRet.iLevel=3;};break;

    //case 559: {stRet.sName="Ioun_Stone_Pink";   stRet.iSchool=1;    stRet.sTargetType="0x01";     stRet.iCategory=13;     stRet.iLevel=3;};break;

    //case 560: {stRet.sName="Ioun_Stone_Pink_Green";   stRet.iSchool=1;    stRet.sTargetType="0x01";     stRet.iCategory=13;     stRet.iLevel=3;};break;

    //case 561: {stRet.sName="Whirlwind";   stRet.iSchool=5;    stRet.sTargetType="0x01";     stRet.iCategory=16;     stRet.iLevel=1;};break;

    //case 562: {stRet.sName="AuraOfGlory_X2";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=9;     stRet.iLevel=2;};break;

    //case 563: {stRet.sName="Haste_Slow_X2";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=3;};break;

    //case 564: {stRet.sName="Summon_Shadow_X2";   stRet.iSchool=7;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=6;};break;

    //case 565: {stRet.sName="Tide_of_Battle";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=9;};break;

    //case 566: {stRet.sName="Evil_Blight";   stRet.iSchool=8;    stRet.sTargetType="0x0E";     stRet.iCategory=3;     stRet.iLevel=5;};break;

    //case 567: {stRet.sName="Cure_Critical_Wounds_Others";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=5;     stRet.iLevel=4;};break;

    //case 568: {stRet.sName="Restoration_Others";   stRet.iSchool=2;    stRet.sTargetType="0x2B";     stRet.iCategory=7;     stRet.iLevel=4;};break;

    case 569: {stRet.sName="Cloud_of_Bewilderment";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=2;};break;

    //case 570: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 571: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 572: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 573: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 574: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 575: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 576: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 577: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 578: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 579: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 580: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 581: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 582: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 583: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 584: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 585: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 586: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 587: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 588: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 589: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 590: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 591: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 592: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 593: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 594: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 595: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 596: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 597: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 598: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 599: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 600: {stRet.sName="ARImbueArrow";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=3;     stRet.iLevel=1;};break;

    //case 601: {stRet.sName="ARSeekerArrow";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=3;     stRet.iLevel=1;};break;

    //case 602: {stRet.sName="ARSeekerArrow2";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=3;     stRet.iLevel=1;};break;

    //case 603: {stRet.sName="ARHailOfArrows";   stRet.iSchool=8;    stRet.sTargetType="0x09";     stRet.iCategory=11;     stRet.iLevel=1;};break;

    //case 604: {stRet.sName="ARArrowOfDeath";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=3;     stRet.iLevel=1;};break;

    //case 605: {stRet.sName="ASGhostlyVisage";   stRet.iSchool=6;    stRet.sTargetType="0x09";     stRet.iCategory=12;     stRet.iLevel=-1;};break;

    //case 606: {stRet.sName="ASDarkness";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 607: {stRet.sName="ASInvisibility";   stRet.iSchool=6;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=-1;};break;

    //case 608: {stRet.sName="ASImprovedInvisibility";   stRet.iSchool=6;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=-1;};break;

    //case 609: {stRet.sName="BGCreateDead";   stRet.iSchool=7;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=1;};break;

    //case 610: {stRet.sName="BGFiendish";   stRet.iSchool=2;    stRet.sTargetType="0x2E";     stRet.iCategory=3;     stRet.iLevel=5;};break;

    //case 611: {stRet.sName="BGInflictSerious";   stRet.iSchool=7;    stRet.sTargetType="0x3A";     stRet.iCategory=3;     stRet.iLevel=3;};break;

    //case 612: {stRet.sName="BGInflictCritical";   stRet.iSchool=7;    stRet.sTargetType="0x3A";     stRet.iCategory=3;     stRet.iLevel=4;};break;

    //case 613: {stRet.sName="BK_Contagion";   stRet.iSchool=7;    stRet.sTargetType="0x2A";     stRet.iCategory=3;     stRet.iLevel=-1;};break;

    //case 614: {stRet.sName="BK_BullsStrength";   stRet.iSchool=8;    stRet.sTargetType="0x2B";     stRet.iCategory=9;     stRet.iLevel=-1;};break;

    //case 615: {stRet.sName="Twinfists";   stRet.iSchool=1;    stRet.sTargetType="0x09";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 616: {stRet.sName="LichLyrics";   stRet.iSchool=1;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 617: {stRet.sName="Iceberry";   stRet.iSchool=1;    stRet.sTargetType="0x2A";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 618: {stRet.sName="Flameberry";   stRet.iSchool=1;    stRet.sTargetType="0x2A";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 619: {stRet.sName="PrayerBox";   stRet.iSchool=1;    stRet.sTargetType="0x08";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 620: {stRet.sName="Flying_Debris";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 621: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 622: {stRet.sName="DC_Divine_Wrath";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=10;     stRet.iLevel=-1;};break;

    //case 623: {stRet.sName="PM_Animate_Dead";   stRet.iSchool=7;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=2;};break;

    //case 624: {stRet.sName="PM_Summon_Undead";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=4;};break;

    //case 625: {stRet.sName="PM_Undead_Graft1";   stRet.iSchool=5;    stRet.sTargetType="0x02";     stRet.iCategory=3;     stRet.iLevel=6;};break;

    //case 626: {stRet.sName="PM_Undead_Graft2";   stRet.iSchool=5;    stRet.sTargetType="0x02";     stRet.iCategory=3;     stRet.iLevel=6;};break;

    //case 627: {stRet.sName="PM_Summon_Greater_Undead";   stRet.iSchool=2;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=9;};break;

    //case 628: {stRet.sName="PM_Deathless_Master_Touch";   stRet.iSchool=5;    stRet.sTargetType="0x02";     stRet.iCategory=3;     stRet.iLevel=10;};break;

    //case 629: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 630: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 631: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 632: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 633: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 634: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 635: {stRet.sName="PADDING";   stRet.iSchool=0;    stRet.sTargetType="";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 636: {stRet.sName="Hellball";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=10;};break;

    //case 637: {stRet.sName="Mummy_Dust";   stRet.iSchool=2;    stRet.sTargetType="0x05";     stRet.iCategory=15;     stRet.iLevel=10;};break;

    //case 638: {stRet.sName="Dragon_Knight";   stRet.iSchool=2;    stRet.sTargetType="0x05";     stRet.iCategory=15;     stRet.iLevel=10;};break;

    //case 639: {stRet.sName="Epic_Mage_Armor";   stRet.iSchool=7;    stRet.sTargetType="0x01";     stRet.iCategory=12;     stRet.iLevel=10;};break;

    //case 640: {stRet.sName="Ruin";   stRet.iSchool=5;    stRet.sTargetType="0x32";     stRet.iCategory=2;     stRet.iLevel=10;};break;

    //case 641: {stRet.sName="DWDEF_Defensive_Stance";   stRet.iSchool=5;    stRet.sTargetType="0x01";     stRet.iCategory=16;     stRet.iLevel=1;};break;

    //case 642: {stRet.sName="Mighty_Rage";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=16;     stRet.iLevel=1;};break;

    //case 643: {stRet.sName="PlanarTurning";   stRet.iSchool=5;    stRet.sTargetType="0x01";     stRet.iCategory=1;     stRet.iLevel=1;};break;

    //case 644: {stRet.sName="Curse_Song";   stRet.iSchool=5;    stRet.sTargetType="0x01";     stRet.iCategory=8;     stRet.iLevel=1;};break;

    //case 645: {stRet.sName="Improved_Whirlwind";   stRet.iSchool=5;    stRet.sTargetType="0x01";     stRet.iCategory=16;     stRet.iLevel=1;};break;

    //case 646: {stRet.sName="Greater_Wild_Shape_1";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 647: {stRet.sName="Epic_Blinding_speed";   stRet.iSchool=5;    stRet.sTargetType="0x01";     stRet.iCategory=9;     stRet.iLevel=3;};break;

    //case 648: {stRet.sName="Dye_Armor_cloth1";   stRet.iSchool=4;    stRet.sTargetType="0x08";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 649: {stRet.sName="Dye_Armor_Cloth2";   stRet.iSchool=4;    stRet.sTargetType="0x08";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 650: {stRet.sName="Dye_Armor_Leather1";   stRet.iSchool=4;    stRet.sTargetType="0x08";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 651: {stRet.sName="Dye_Armor_Leather2";   stRet.iSchool=4;    stRet.sTargetType="0x08";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 652: {stRet.sName="Dye_Armor_Metal1";   stRet.iSchool=4;    stRet.sTargetType="0x08";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 653: {stRet.sName="Dye_Armor_Metal2";   stRet.iSchool=4;    stRet.sTargetType="0x08";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 654: {stRet.sName="Add_Item_Property";   stRet.iSchool=4;    stRet.sTargetType="0x08";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 655: {stRet.sName="Poison_Weapon";   stRet.iSchool=4;    stRet.sTargetType="0x08";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 656: {stRet.sName="Craft_Weapon";   stRet.iSchool=4;    stRet.sTargetType="0x08";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 657: {stRet.sName="Craft_Armor";   stRet.iSchool=4;    stRet.sTargetType="0x08";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 658: {stRet.sName="Greater_Wild_Shape_Wyrmling_Red";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 659: {stRet.sName="Greater_Wild_Shape_Wyrmling_Blue";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 660: {stRet.sName="Greater_Wild_Shape_Wyrmling_Black";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 661: {stRet.sName="Greater_Wild_Shape_Wyrmling_White";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 662: {stRet.sName="Greater_Wild_Shape_Wyrmling_Green";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 663: {stRet.sName="WyrmlingPCBreathCold";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 664: {stRet.sName="WyrmlingPCBreathAcid";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 665: {stRet.sName="WyrmlingPCBreathFire";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 666: {stRet.sName="WyrmlingPCBreathGas";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 667: {stRet.sName="WyrmlingPCBreathLightning";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 668: {stRet.sName="ITEM_Teleport";   stRet.iSchool=5;    stRet.sTargetType="0x0B";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 669: {stRet.sName="ITEM_Chaos_Shield";   stRet.iSchool=5;    stRet.sTargetType="0x0B";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 670: {stRet.sName="Greater_Wild_Shape_Basilisk";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 671: {stRet.sName="Greater_Wild_Shape_Beholder";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 672: {stRet.sName="Greater_Wild_Shape_Harpy";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 673: {stRet.sName="Greater_Wild_Shape_Drider";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 674: {stRet.sName="Greater_Wild_Shape_Manticore";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 675: {stRet.sName="Greater_Wild_Shape_2";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 676: {stRet.sName="Greater_Wild_Shape_3";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 677: {stRet.sName="Greater_Wild_Shape_4";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 678: {stRet.sName="Greater_Wild_Shape_Gargoyle";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 679: {stRet.sName="Greater_Wild_Shape_Medusa";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 680: {stRet.sName="Greater_Wild_Shape_Minotaur";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 681: {stRet.sName="Humanoid_Shape";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 682: {stRet.sName="Humanoid_Shape_Drow";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 683: {stRet.sName="Humanoid_Shape_Lizardfolk";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 684: {stRet.sName="Humanoid_Shape_KoboldAssa";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 685: {stRet.sName="Undead_shape";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 686: {stRet.sName="Harpysong";   stRet.iSchool=5;    stRet.sTargetType="0x01";     stRet.iCategory=11;     stRet.iLevel=4;};break;

    //case 687: {stRet.sName="GWildShape_Stonegaze";   stRet.iSchool=5;    stRet.sTargetType="0x0A";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    //case 688: {stRet.sName="GWildShape_DriderDarkness";   stRet.iSchool=5;    stRet.sTargetType="0x2F";     stRet.iCategory=-1;     stRet.iLevel=2;};break;

    //case 689: {stRet.sName="SlayRakshasa";   stRet.iSchool=5;    stRet.sTargetType="0x0B";     stRet.iCategory=-1;     stRet.iLevel=-1;};break;

    //case 690: {stRet.sName="RedDragonDiscipleBreath";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=9;};break;

    //case 691: {stRet.sName="Greater_Wild_Shape_Mindflayer";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 692: {stRet.sName="Greater_Wild_Shape_Spikes";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=5;};break;

    //case 693: {stRet.sName="GWildShape_Mindblast";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 694: {stRet.sName="Greater_Wild_Shape_DireTiger";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 695: {stRet.sName="Epic_Warding";   stRet.iSchool=5;    stRet.sTargetType="0x01";     stRet.iCategory=13;     stRet.iLevel=10;};break;

    //case 696: {stRet.sName="OnHitFireDamage";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 697: {stRet.sName="ACTIVATE_ITEM_L";   stRet.iSchool=2;    stRet.sTargetType="0x7f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 698: {stRet.sName="Dragon_Breath_Negative";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 699: {stRet.sName="";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 700: {stRet.sName="ACTIVATE_ITEM_ONHITSPELLCAST";   stRet.iSchool=2;    stRet.sTargetType="0x7f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 701: {stRet.sName="Summon_Baatezu";   stRet.iSchool=5;    stRet.sTargetType="0x2C";     stRet.iCategory=15;     stRet.iLevel=5;};break;

    //case 702: {stRet.sName="OnHitPlanarRift";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 703: {stRet.sName="OnHitDarkfire";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 704: {stRet.sName="Undead_Shape_risen_lord";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 705: {stRet.sName="Undead_Shape_Vampire";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 706: {stRet.sName="Undead_Shape_Spectre";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 707: {stRet.sName="Greater_Wild_Shape_Red_dragon";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 708: {stRet.sName="Greater_Wild_Shape_Blue_dragon";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 709: {stRet.sName="Greater_Wild_Shape_Green_dragon";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 710: {stRet.sName="EyeballRay0";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=1;};break;

    //case 711: {stRet.sName="EyeballRay1";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=1;};break;

    //case 712: {stRet.sName="EyeballRay2";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=1;};break;

    //case 713: {stRet.sName="Mindflayer_Mindblast_10";   stRet.iSchool=4;    stRet.sTargetType="0x01";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    //case 714: {stRet.sName="Mindflayer_Paragon_Mindblast";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 715: {stRet.sName="Golem_Ranged_Slam";   stRet.iSchool=5;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=6;};break;

    //case 716: {stRet.sName="SuckBrain";   stRet.iSchool=1;    stRet.sTargetType="0x2B";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 717: {stRet.sName="ACTIVATE_ITEM_SEQUENCER_1";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 718: {stRet.sName="ACTIVATE_ITEM_SEQUENCER_2";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 719: {stRet.sName="ACTIVATE_ITEM_SEQUENCER_3";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 720: {stRet.sName="CLEAR_SEQUENCER";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 721: {stRet.sName="OnHitFlamingSkin";   stRet.iSchool=2;    stRet.sTargetType="0x7f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 722: {stRet.sName="Mimic_Eat";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 723: {stRet.sName="Mimic_Gem_Thrower";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 724: {stRet.sName="Etherealness";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=7;};break;

    //case 725: {stRet.sName="Dragon_Shape";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 726: {stRet.sName="Mimic_Eat_Enemy";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 727: {stRet.sName="Beholder_Anti_Magic_Cone";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 728: {stRet.sName="";   stRet.iSchool=4;    stRet.sTargetType="0x02";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    //case 729: {stRet.sName="Mimic_Steal_armor";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 730: {stRet.sName="";   stRet.iSchool=1;    stRet.sTargetType="0x02";     stRet.iCategory=13;     stRet.iLevel=-1;};break;

    //case 731: {stRet.sName="Bebelith_Web";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=2;     stRet.iLevel=9;};break;

    //case 732: {stRet.sName="Outsider_Shape";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 733: {stRet.sName="Outsider_Shape_Azer";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 734: {stRet.sName="Outsider_Shape_Rakshasa";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 735: {stRet.sName="Outsider_Shape_DeathSlaad";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 736: {stRet.sName="Beholder_Special_Spell_AI";   stRet.iSchool=4;    stRet.sTargetType="0x02";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 737: {stRet.sName="Construct_Shape";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 738: {stRet.sName="Construct_Shape_StoneGolem";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 739: {stRet.sName="Construct_Shape_DemonFleshGolem";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 740: {stRet.sName="Construct_Shape_IronGolem";   stRet.iSchool=8;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=3;};break;

    //case 741: {stRet.sName="Psionic_Inertial_Barrier";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=13;     stRet.iLevel=4;};break;

    //case 742: {stRet.sName="Craft_Weapon_Component";   stRet.iSchool=4;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 743: {stRet.sName="Craft_Armor_Component";   stRet.iSchool=4;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 744: {stRet.sName="Grenade_FireBomb";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 745: {stRet.sName="Grenade_AcidBomb";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 746: {stRet.sName="Hell_Catapult_Male";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 747: {stRet.sName="Hell_Catapult_Female";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 748: {stRet.sName="Hell_Br_Catapult_Male";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 749: {stRet.sName="Hell_Brazier_Male";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 750: {stRet.sName="Hell_Fence_Male";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 751: {stRet.sName="Hell_Boulder_Male";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 752: {stRet.sName="Hell_Tree_Male";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 753: {stRet.sName="Hell_KNOWER_EFFECT1";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 754: {stRet.sName="Hell_KNOWER_EFFECT2";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 755: {stRet.sName="Hell_KNOWER_EFFECT3";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 756: {stRet.sName="OnHitBebilithAttack";   stRet.iSchool=2;    stRet.sTargetType="0x7f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 757: {stRet.sName="ShadowBlend";   stRet.iSchool=2;    stRet.sTargetType="0x1f";     stRet.iCategory=-1;     stRet.iLevel=8;};break;

    //case 758: {stRet.sName="OnHitDemilichTouch";   stRet.iSchool=2;    stRet.sTargetType="0x7f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 759: {stRet.sName="UndeadSelfHarm";   stRet.iSchool=7;    stRet.sTargetType="0x01";     stRet.iCategory=5;     stRet.iLevel=6;};break;

    //case 760: {stRet.sName="OnHitDracolichTouch";   stRet.iSchool=2;    stRet.sTargetType="0x7f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 761: {stRet.sName="Aura_of_Hellfire";   stRet.iSchool=5;    stRet.sTargetType="0x09";     stRet.iCategory=1;     stRet.iLevel=9;};break;

    //case 762: {stRet.sName="Hell_Inferno";   stRet.iSchool=8;    stRet.sTargetType="0x3A";     stRet.iCategory=2;     stRet.iLevel=9;};break;

    //case 763: {stRet.sName="Psionic_Mass_Concussion";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=1;     stRet.iLevel=5;};break;

    //case 764: {stRet.sName="GlyphOfWardingDefault";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=2;};break;

    //case 765: {stRet.sName="Hell_KNOWER_EFFECT4";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 766: {stRet.sName="Hell_KNOWER_EFFECT5";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 767: {stRet.sName="Intelligent_Weapon_Talk";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 768: {stRet.sName="Intelligent_Weapon_OnHit";   stRet.iSchool=2;    stRet.sTargetType="0x7f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 769: {stRet.sName="Shadow_Attack";   stRet.iSchool=7;    stRet.sTargetType="0x3A";     stRet.iCategory=3;     stRet.iLevel=-1;};break;

    //case 770: {stRet.sName="Slaad_Chaos_Spittle";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 771: {stRet.sName="Dragon_Breath_Prismatic";   stRet.iSchool=5;    stRet.sTargetType="0x2E";     stRet.iCategory=11;     stRet.iLevel=9;};break;

    //case 772: {stRet.sName="Spiral_Fireball";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=3;};break;

    //case 773: {stRet.sName="Battle_Boulder_Toss";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 774: {stRet.sName="Deflecting_Force";   stRet.iSchool=2;    stRet.sTargetType="0x01";     stRet.iCategory=13;     stRet.iLevel=6;};break;

    //case 775: {stRet.sName="Giant_hurl_rock";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 776: {stRet.sName="Beholder_Node_1";   stRet.iSchool=4;    stRet.sTargetType="0x02";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    //case 777: {stRet.sName="Beholder_Node_2";   stRet.iSchool=4;    stRet.sTargetType="0x02";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    //case 778: {stRet.sName="Beholder_Node_3";   stRet.iSchool=4;    stRet.sTargetType="0x02";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    //case 779: {stRet.sName="Beholder_Node_4";   stRet.iSchool=4;    stRet.sTargetType="0x02";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    //case 780: {stRet.sName="Beholder_Node_5";   stRet.iSchool=4;    stRet.sTargetType="0x02";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    //case 781: {stRet.sName="Bridge_VFX";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 782: {stRet.sName="Sphere_Spell";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 783: {stRet.sName="Beholder_Node_6";   stRet.iSchool=4;    stRet.sTargetType="0x02";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    //case 784: {stRet.sName="Beholder_Node_7";   stRet.iSchool=4;    stRet.sTargetType="0x02";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    //case 785: {stRet.sName="Beholder_Node_8";   stRet.iSchool=4;    stRet.sTargetType="0x02";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    //case 786: {stRet.sName="Beholder_Node_9";   stRet.iSchool=4;    stRet.sTargetType="0x02";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    //case 787: {stRet.sName="Beholder_Node_10";   stRet.iSchool=4;    stRet.sTargetType="0x02";     stRet.iCategory=11;     stRet.iLevel=8;};break;

    //case 788: {stRet.sName="OnHitParalyze";   stRet.iSchool=2;    stRet.sTargetType="0x7f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 789: {stRet.sName="Illithid_Mindblast";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=5;};break;

    //case 790: {stRet.sName="OnHitDeafenClang";   stRet.iSchool=2;    stRet.sTargetType="0x7f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 791: {stRet.sName="OnHitKnockDown";   stRet.iSchool=2;    stRet.sTargetType="0x7f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 792: {stRet.sName="OnHitFreeze";   stRet.iSchool=2;    stRet.sTargetType="0x7f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 793: {stRet.sName="Demonic_Grappling_Hand";   stRet.iSchool=8;    stRet.sTargetType="0x3E";     stRet.iCategory=2;     stRet.iLevel=3;};break;

    //case 794: {stRet.sName="Ballista_Bolt";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=11;     stRet.iLevel=1;};break;

    //case 795: {stRet.sName="ACTIVATE_ITEM_T";   stRet.iSchool=2;    stRet.sTargetType="0x7f";     stRet.iCategory=-1;     stRet.iLevel=1;};break;

    //case 796: {stRet.sName="Dragon_Breath_Lightning";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 797: {stRet.sName="Dragon_Breath_Fire";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 798: {stRet.sName="Dragon_Breath_Gas";   stRet.iSchool=5;    stRet.sTargetType="0x3E";     stRet.iCategory=19;     stRet.iLevel=9;};break;

    //case 799: {stRet.sName="Vampire_Invisibility";   stRet.iSchool=6;    stRet.sTargetType="0x01";     stRet.iCategory=9;     stRet.iLevel=4;};break;

    //case 800: {stRet.sName="Vampire_DominationGaze";   stRet.iSchool=5;    stRet.sTargetType="0x02";     stRet.iCategory=11;     stRet.iLevel=6;};break;

    //case 801: {stRet.sName="Azer_Fire_Blast";   stRet.iSchool=5;    stRet.sTargetType="0x02";     stRet.iCategory=2;     stRet.iLevel=4;};break;

    //case 802: {stRet.sName="Shifter_Spectre_Attack";   stRet.iSchool=7;    stRet.sTargetType="0x02";     stRet.iCategory=3;     stRet.iLevel=-1;};break;
    };


return stRet;
}












string pGetSpellLeveledLessThen(int iLevel=0, int iLessThan=0, int iTrustPercent=20)
{
string sRet="";

struct stSpellData stSpell;



int i;
for(i=0; i<=549; i++)
    {
    switch(i)
        {
        case 12: continue;
        case 68: continue;
        case 71: continue;
        case 109: continue;
        case 112: continue;
        case 158: continue;
        case 159: continue;
        };
    if(i>=195 && i<340) continue;
    if(i>=376 && i<414) continue;
    if(i>=550) break;

    if(pResponse(100-iTrustPercent)) continue;

    stSpell=pGetSpellInfo(i);

    if(stSpell.iLevel<=iLevel && stSpell.iLevel>=iLevel-iLessThan)  sRet+=(IntToString(i)+",");
    };
sRet=GetStringLeft(sRet, GetStringLength(sRet)-1);

return sRet;
}




string pGetSpellLeveledMoreThen(int iLevel=0, int iMoreThan=0, int iTrustPercent=20)
{
string sRet="";

struct stSpellData stSpell;



int i;
for(i=0; i<=549; i++)
    {
    switch(i)
        {
        case 12: continue;
        case 68: continue;
        case 71: continue;
        case 109: continue;
        case 112: continue;
        case 158: continue;
        case 159: continue;
        };
    if(i>=195 && i<340) continue;
    if(i>=376 && i<414) continue;
    if(i>=550) break;

    if(pResponse(100-iTrustPercent)) continue;

    stSpell=pGetSpellInfo(i);

    if(stSpell.iLevel>=iLevel && stSpell.iLevel<=iLevel+iMoreThan)  sRet+=(IntToString(i)+",");
    };
sRet=GetStringLeft(sRet, GetStringLength(sRet)-1);

return sRet;
}








string pGetSpellSchooled(int iSchool=0, int iTrustPercent=20)
{
string sRet="";

struct stSpellData stSpell;



int i;
for(i=0; i<=549; i++)
    {
    switch(i)
        {
        case 12: continue;
        case 68: continue;
        case 71: continue;
        case 109: continue;
        case 112: continue;
        case 158: continue;
        case 159: continue;
        };
    if(i>=195 && i<340) continue;
    if(i>=376 && i<414) continue;
    if(i>=550) break;

    if(pResponse(100-iTrustPercent)) continue;

    stSpell=pGetSpellInfo(i);

    if(stSpell.iSchool==iSchool)  sRet+=(IntToString(i)+",");
    };
sRet=GetStringLeft(sRet, GetStringLength(sRet)-1);

return sRet;
}








string pGetSpellCategored(int iCategory=0, int iTrustPercent=20)
{
string sRet="";

struct stSpellData stSpell;



int i;
for(i=0; i<=549; i++)
    {
    switch(i)
        {
        case 12: continue;
        case 68: continue;
        case 71: continue;
        case 109: continue;
        case 112: continue;
        case 158: continue;
        case 159: continue;
        };
    if(i>=195 && i<340) continue;
    if(i>=376 && i<414) continue;
    if(i>=550) break;

    if(pResponse(100-iTrustPercent)) continue;

    stSpell=pGetSpellInfo(i);

    if(stSpell.iCategory==iCategory)  sRet+=(IntToString(i)+",");
    };
sRet=GetStringLeft(sRet, GetStringLength(sRet)-1);

return sRet;
}



















/*
void main()
{
//string sString="";
//int i=0, iMaxI=802;
//while(i<=iMaxI)
//    {
//    string sSpellName=Get2DAString("spells", "Label", i);
//    string sSchool=Get2DAString("spells", "School", i);
//    string sTargetType=Get2DAString("spells", "TargetType", i);
//    string sImmunityType=Get2DAString("spells", "ImmunityType", i);
//    string sItemImmunity=Get2DAString("spells", "ItemImmunity", i);
//    string sCategory=Get2DAString("spells", "Category", i);
//    string sLevel=Get2DAString("spells", "Innate", i);
//    string sSpellName=Get2DAString("spells", "", i);

//    sString+="case "+IntToString(i)+": {sName='"+sSpellName+"';   sSchool='"+sSchool+"';    sTargetType='"+sTargetType+"';     sImmunityType='"+sImmunityType+"';    sItemImmunity='"+sItemImmunity+"';    sCategory='"+sCategory+"';     sLevel='"+sLevel+"';};\n\n";
//    i++;
//    };
}
*/
