params [
    ["_globalVehicle", objNull, [objNull]]
];

if (isNil "_globalVehicle") exitWith {false};

[_globalVehicle] call SPEC_fnc_cbps_deploy_handleVehicleSpawn;

if (isServer) then {
    [_globalVehicle, 10] call BTC_fnc_eh_veh_add_respawn;
};

["btc_veh_spawned", {
    _this params ["_vehicle"];
    [_vehicle] call SPEC_fnc_cbps_deploy_handleVehicleSpawn;
}] call CBA_fnc_addEventHandler;

true
