
/* ----------------------------------------------------------------------------
Function: BTC_fnc_fob_init

Description:
    Store FOB data in btc_fobs global variable.

Parameters:
    _truck - Structure/rallypoint of the FOB. [Object]
    _flag - Flag of the FOB. [Object]
    _marker - Marker. [String]
    _fobs - GLobal variable. [Array]

Returns:

Examples:
    (begin example)
        [cursorObject] call BTC_fnc_fob_init;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_truck", objNull, [objNull]],
    ["_marker", "", [""]]
];

_truck setVariable ["ace_medical_isMedicalFacility", true, true];
_truck setVariable ["btc_tickets", -1, true];
_truck setVariable ["btc_mob_respawn", [_marker, _truck], true];
