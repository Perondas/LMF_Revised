// AI INFANTRY PATROL  ////////////////////////////////////////////////////////////////////////////
/*
	- Redone by Drgn V4karian with help of Diwako.
	- File to spawn a group of infantry that peforms a patrol task. Once it gets into combat,
	  it will move in to attack threats.
	- USAGE:
		1) Spawn Position.
		2) Group Type ("squad", "team", "sentry","atTeam","aaTeam") OR number of soldiers.
		3) Patrol Radius.
	- EXAMPLE: 0 = [this,"team",100] spawn lmf_ai_fnc_patrol;
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {CBA_missionTime > 0};
private _spawner = [] call lmf_ai_fnc_returnSpawner;
if !(_spawner) exitWith {};

#include "cfg_spawn.sqf"

params [["_spawnPos", [0,0,0]],["_grpType", "TEAM"],["_patrolRadius", 200]];
_spawnPos = _spawnPos call CBA_fnc_getPos;
private _patrolTarget = _spawnPos;

//WAIT A RANDOM BIT OF TIME (In case multiple functions are called on 1 location it make spawning a bit smoother)
sleep (random 10);

// PREPARE AND SPAWN THE GROUP ////////////////////////////////////////////////////////////////////
private _type = [_grptype] call _typeMaker;
private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;

// GIVE THEM ORDERS ///////////////////////////////////////////////////////////////////////////////
[_grp, _patrolTarget, _patrolRadius, 4, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [10,20,30]] call CBA_fnc_taskPatrol;
_grp deleteGroupWhenEmpty true;

//waitUntil {sleep 1; behaviour leader _grp == "COMBAT" OR {alive _x} count units _grp < 1};
//0 = [_grp] spawn a2k_fnc_taskUpdateWP;
//sleep 5;
//0 = [_grp] spawn a2k_fnc_taskAssault;