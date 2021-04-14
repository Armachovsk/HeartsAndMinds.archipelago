
/* ----------------------------------------------------------------------------
Function: BTC_fnc_fob_create_s

Description:
   Create the FOB.

Parameters:
    _pos - Position of the FOB. [Array]
    _direction - Direction of the FOB between 0 to 360 degree. [Number]
    _FOB_name - Name of the FOB. [String]
    _fob_structure - FOB structure. [Array]
    _fob_flag - Flag type. [Array]
    _fobs - Array of FOB. [Array]

Returns:
    _array - Return marker, structure and flag object. [Array]

Examples:
    (begin example)
        [getPos player, random 360, "My FOB"] call BTC_fnc_fob_create_s;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_pos", [], [[]]],
    ["_FOB_name", "FOB ", [""]],
    ["_fob_truck", btc_fob_truck, [objNull]]
];

private _marker = createMarker [_FOB_name, _pos];
_marker setMarkerSize [1, 1];
_marker setMarkerType "b_hq";
_marker setMarkerText _FOB_name;
_marker setMarkerColor "ColorBlue";
_marker setMarkerShape "ICON";

[_fob_truck, _FOB_name] call SPEC_fnc_cbps_deploy_btc_hm_fobInit;

_fob_truck addEventHandler ["Killed", SPEC_fnc_cbps_deploy_btc_hm_fobKilled];

[_marker, _fob_truck]
