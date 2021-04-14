
/* ----------------------------------------------------------------------------
Function: BTC_fnc_patrol_eh_remove

Description:
    Remove events.

Parameters:
    _veh - Object with events.  [Object]

Returns:
	_bool - Events ID found. [Boolean]

Examples:
    (begin example)
        [cursorTarget] call BTC_fnc_patrol_eh_remove;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_veh", objNull, [objNull]]
];

[_veh, "Fuel", "BTC_fnc_patrol_eh"] call BTC_fnc_eh_removePersistOnLocalityChange;
[_veh, "GetOut", "BTC_fnc_patrol_eh"] call BTC_fnc_eh_removePersistOnLocalityChange;
[_veh, "HandleDamage", "BTC_fnc_patrol_disabled"] remoteExecCall ["BTC_fnc_eh_removePersistOnLocalityChange", _veh];
[_veh, "HandleDamage", "BTC_fnc_rep_hd"] remoteExecCall ["BTC_fnc_eh_removePersistOnLocalityChange", _veh];
