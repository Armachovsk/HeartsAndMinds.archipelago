params ["_virtualCargo", "_presets"];

private _virtualWeapons = [];
private _virtualMagazines = [];
private _virtualItems = [];
private _virtualBackpacks = [];

{if (!(_x in _presets)) then {_virtualWeapons pushBack _x};} forEach (_virtualCargo get "weapons");
{if (!(_x in _presets)) then {_virtualMagazines pushBack _x};} forEach (_virtualCargo get "magazines");
{if (!(_x in _presets)) then {_virtualItems pushBack _x};} forEach (_virtualCargo get "items");
{if (!(_x in _presets)) then {_virtualBackpacks pushBack _x};} forEach (_virtualCargo get "backpacks");

private _myMap = createHashMap;

_myMap set ["weapons", _virtualWeapons];
_myMap set ["magazines", _virtualMagazines];
_myMap set ["items", _virtualItems];
_myMap set ["backpacks", _virtualBackpacks];
_myMap set ["ace_items", _virtualWeapons + _virtualMagazines + _virtualItems + _virtualBackpacks];

_myMap
