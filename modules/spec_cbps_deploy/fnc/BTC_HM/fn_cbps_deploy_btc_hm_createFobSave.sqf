
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
    ["_direction", 0, [0]],
    ["_FOB_name", "FOB ", [""]],
    ["_FOB_type", "rhsusf_M1085A1P2_B_D_Medical_fmtv_usarmy", [""]]
];

private _struc = createVehicle [_FOB_type, _pos, [], 0, "CAN_COLLIDE"];

_struc setDir _direction;

private _marker = createMarker [_FOB_name, _pos];
_marker setMarkerSize [1, 1];
_marker setMarkerType "b_hq";
_marker setMarkerText _FOB_name;
_marker setMarkerColor "ColorBlue";
_marker setMarkerShape "ICON";

[_struc, _FOB_name] call SPEC_fnc_cbps_deploy_btc_hm_fobInit;

_struc addEventHandler ["Killed", SPEC_fnc_cbps_deploy_btc_hm_fobKilled];

_struc
