// PLAYER GEAR SCRIPT /////////////////////////////////////////////////////////////////////////////
/*
	- This file is a player gear loadout file.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull]];
if !(local _unit) exitWith {};

#include "..\..\..\settings\cfg_Player.sqf"


// APPLY NEW ROLE SPECIFIC LOADOUT ////////////////////////////////////////////////////////////////
private _bContentMedic = [(selectRandom _Backpack_Medic),[["ACE_elasticBandage",30],["ACE_packingBandage",30],["ACE_salineIV",10],["ACE_epinephrine",10],["ACE_morphine",10],["ACE_personalAidKit",1]]];
if (ace_medical_level == 1) then {
	_bContentMedic = [(selectRandom _Backpack_Medic),[["ACE_fieldDressing",60],["ACE_bloodIV",15],["ACE_epinephrine",10],["ACE_morphine",20]]];
};
_unit setUnitLoadout [
	[
		[_Carbine,_Carbine_Attach1,_Carbine_Attach2,_Carbine_Optic,[],[],_Carbine_Bipod],
		[],
		[],
		[(selectRandom _Uniform),[]],
		[(selectRandom _Vest),[[_Carbine_Ammo,5,999],[_Carbine_Ammo_T,3,999],[_Grenade,2,1],[_Grenade_Smoke,6,1]]],
		_bContentMedic,(selectRandom _Headgear),(selectRandom _Goggles),
		[],
		["","","ItemRadioAcreFlagged","","ItemWatch",""]
	],true
];

//RADIO
if (var_personalRadio) then {_unit addItem _ACRE_PRR};

//MAP
if (var_playerMaps == 0) then {
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit addItem "ACE_Flashlight_XL50";
};

//REST
for "_i" from 1 to 2 do {_unit addItem "FirstAidKit"};

//NVG
if (var_playerNVG == 0) then {_unit linkItem _NVG};

//PISTOL
if (var_pistolAll) then {
	_unit addWeapon _Pistol;
	_unit addHandgunItem _Pistol_Attach1;
	_unit addHandgunItem _Pistol_Attach2;
	for "_i" from 1 to 3 do {_unit addItem _Pistol_Ammo};
};

//RANK
_unit setRank "CORPORAL";