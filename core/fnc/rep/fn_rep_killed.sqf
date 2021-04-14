
/* ----------------------------------------------------------------------------
Function: BTC_fnc_rep_killed

Description:
    Change reputation when a player kill a unit.

Parameters:
    _unit - Unit killed. [Object]
    _killer - Killer. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject, player] call BTC_fnc_rep_killed;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]],
    ["_killer", objNull, [objNull]]
];

if (!isServer) exitWith {
    _this remoteExecCall ["BTC_fnc_rep_killed", 2];
};

if (isPlayer _killer) then {
    btc_rep_malus_civ_killed call BTC_fnc_rep_change;
    if (btc_global_reputation < 600) then {
        [getPos _unit] spawn BTC_fnc_rep_eh_effects;
    };

    if (btc_debug_log) then {
        [format ["GREP %1 THIS = %2", btc_global_reputation, _this], __FILE__, [false]] call BTC_fnc_debug_message;
    };
};

private _vehicle = assignedVehicle _unit;
if !(_vehicle isEqualTo objNull) then {
    [[], [_vehicle]] call BTC_fnc_delete;
};
