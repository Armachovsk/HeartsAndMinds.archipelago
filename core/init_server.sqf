[] call BTC_fnc_city_init;

["btc_m", -1, objNull, "", false, false] call BTC_fnc_task_create;
[["btc_dft", "btc_m"], 0] call BTC_fnc_task_create;
[["btc_dty", "btc_m"], 1] call BTC_fnc_task_create;

if (btc_db_load && {profileNamespace getVariable [format ["btc_hm_%1_db", worldName], false]}) then {
    if ((profileNamespace getVariable [format ["btc_hm_%1_version", worldName], 1.13]) in [1.193, 1.2, btc_version select 1]) then {
        [] call BTC_fnc_db_load;
    } else {
        [] call BTC_fnc_db_load_old;
    };
} else {
    for "_i" from 1 to btc_hideout_n do {[] call BTC_fnc_mil_create_hideout;};
    [] call BTC_fnc_cache_init;

    private _date = date;
    _date set [3, btc_p_time];
    setDate _date;

    {
        [{!isNull _this}, {_this call BTC_fnc_db_add_veh;}, _x] call CBA_fnc_waitUntilAndExecute;
    } forEach btc_vehicles;
};

[] call BTC_fnc_eh_server;
[btc_ied_list] call BTC_fnc_ied_fired_near;
[] call BTC_fnc_chem_checkLoop;
[] call BTC_fnc_chem_handleShower;
[] call BTC_fnc_spect_checkLoop;

["Initialize"] call BIS_fnc_dynamicGroups;

setTimeMultiplier btc_p_acctime;

{[_x, 30] call BTC_fnc_eh_veh_add_respawn;} forEach btc_helo;
{[_x, 30] call BTC_fnc_eh_veh_add_respawn;} forEach btc_vehicles;

if (btc_p_side_mission_cycle > 0) then {
    for "_i" from 1 to btc_p_side_mission_cycle do {
        [true] spawn BTC_fnc_side_create;
    };
};
