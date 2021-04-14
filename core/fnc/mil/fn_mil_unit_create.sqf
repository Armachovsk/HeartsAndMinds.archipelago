
/* ----------------------------------------------------------------------------
Function: BTC_fnc_mil_unit_create

Description:
    Fill me when you edit me !

Parameters:
    _group - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call BTC_fnc_mil_unit_create;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]]
];

private _units = units _group select {!(_x getVariable ["btc_init", false])};

btc_curator addCuratorEditableObjects [_units, false];

{
    _x setVariable ["btc_init", true];
    _x call BTC_fnc_mil_add_eh;

    if (btc_p_set_skill) then {
        _x call BTC_fnc_mil_set_skill;
    };
} forEach _units;
