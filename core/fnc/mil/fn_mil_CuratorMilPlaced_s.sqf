
/* ----------------------------------------------------------------------------
Function: BTC_fnc_mil_CuratorMilPlaced_s

Description:
    Fill me when you edit me !

Parameters:
    _unit - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call BTC_fnc_mil_CuratorMilPlaced_s;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]]
];

[group _unit] call BTC_fnc_mil_unit_create;

if (btc_debug_log) then {
    [format ["%1", _unit], __FILE__, [false]] call BTC_fnc_debug_message;
};
