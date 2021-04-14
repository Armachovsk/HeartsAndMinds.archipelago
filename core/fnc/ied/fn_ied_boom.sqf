
/* ----------------------------------------------------------------------------
Function: BTC_fnc_ied_boom

Description:
    Create the boom and the visual effect player side.

Parameters:
    _wreck - Simple object around the ied. [Object]
    _ied - ACE IED. [Object]

Returns:

Examples:
    (begin example)
        [wreck, ied] call BTC_fnc_ied_boom;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_wreck", objNull, [objNull]],
    ["_ied", objNull, [objNull]]
];

if (btc_debug_log) then {
    [format ["%1 - POS %2", [_wreck, _ied], getPos _wreck], __FILE__, [false]] call BTC_fnc_debug_message;
};

private _pos = getPos _ied;
_ied setDamage 1;
deleteVehicle _wreck;

[_pos] call BTC_fnc_deaf_earringing;
[_pos] remoteExecCall ["BTC_fnc_ied_effects", [0, -2] select isDedicated];
