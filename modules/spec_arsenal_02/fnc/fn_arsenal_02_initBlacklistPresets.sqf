params ["_preset"];

private _common = ["common"] call SPEC_fnc_arsenal_02_compileBlacklistPreset;
private _main = [_preset] call SPEC_fnc_arsenal_02_compileBlacklistPreset;

_main + _common
