
/* ----------------------------------------------------------------------------
Function: BTC_fnc_fob_killed

Description:
    Delete FOB from the btc_fobs array and remove the flag.

Parameters:
    _struc - Object the event handler is assigned to. [Object]
    _killer - Object that killed the unit. Contains the unit itself in case of collisions. [Object]
    _instigator - Person who pulled the trigger. [Object]
    _delete - Delete the FOB/Rallypoint. [Boolean]
    _useEffects - Same as useEffects in setDamage alt syntax. [Boolean]
    _fobs - Array containing FOB data. [Array]

Returns:
    _this - Arguments passed. [Array]

Examples:
    (begin example)
        _result = [btc_fobs select 1 select 0] call BTC_fnc_fob_killed;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_struc", objNull, [objNull]]
];

private _btcRespawn = _struc getVariable ["btc_mob_respawn", []];
_btcRespawn params ["_marker", "_truck"];

if (btc_debug || btc_debug_log) then {
    [format ["named %1", _truck], __FILE__, [btc_debug, btc_debug_log]] call BTC_fnc_debug_message;
};

deleteMarker _marker;

_truck setVariable ["ace_medical_isMedicalFacility", false, true];
_truck setVariable ["btc_mob_respawn", [], true];

_this
