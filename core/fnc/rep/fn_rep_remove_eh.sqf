
/* ----------------------------------------------------------------------------
Function: BTC_fnc_rep_remove_eh

Description:
    Remove event to civilian.

Parameters:
    _civilian - Civilian. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call BTC_fnc_rep_remove_eh;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_civilian", objNull, [objNull]]
];

[_civilian, "FiredNear", "BTC_fnc_rep_firednear"] call BTC_fnc_eh_removePersistOnLocalityChange;
[_civilian, "HandleDamage", "BTC_fnc_rep_hd"] remoteExecCall ["BTC_fnc_eh_removePersistOnLocalityChange", _civilian];
[_civilian, "Killed", "BTC_fnc_rep_killed"] remoteExecCall ["BTC_fnc_eh_removePersistOnLocalityChange", _civilian];
