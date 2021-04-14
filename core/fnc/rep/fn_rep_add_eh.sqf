
/* ----------------------------------------------------------------------------
Function: BTC_fnc_rep_add_eh

Description:
    Add event handler link to the reputation system to a unit not initialised.

Parameters:
    _civilian - Unit. [Object]

Returns:

Examples:
    (begin example)
        [curosrTarget] call BTC_fnc_rep_add_eh;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_civilian", objNull, [objNull]]
];

[_civilian, "HandleDamage", "BTC_fnc_rep_hd"] call BTC_fnc_eh_persistOnLocalityChange;
[_civilian, "Killed", "BTC_fnc_rep_killed"] call BTC_fnc_eh_persistOnLocalityChange;
[_civilian, "FiredNear", "BTC_fnc_rep_firednear"] call BTC_fnc_eh_persistOnLocalityChange;
