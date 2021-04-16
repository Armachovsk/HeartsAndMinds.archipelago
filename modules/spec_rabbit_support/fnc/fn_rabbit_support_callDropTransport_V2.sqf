params [
    ["_position", getPos player, [[]]]
];

if(isNil "Call_transport_V2")then{
	Call_transport_V2 = false;
	publicVariable "Call_transport_V2";
};
if(Call_transport_V2)exitWith{hint "Запрос отклонен! Идет погрузка нового транспорта в самолет ожидайте..."};
[5, [_position], {
    (_this # 0) params ["_position"];
	[_position] spawn {
        params ["_position"];
		Call_transport_V2 = true;
		publicVariable "Call_transport_V2";
		[[], {systemChat "По вашим координатам выслан борт с танспортом, сброс будет по вашим текущим координатм, ожидайте!"}] remoteExec ["call"];
		//спуним самолет
		_C_130 = [[0,0,1000], 180, "USAF_C17", WEST] call BIS_fnc_spawnVehicle;
		{_x setSkill ["courage", 1]} forEach units (_C_130 select 2);
		// Приказываем самолету двигаться куда надо
		private _wp_C_130 = (_C_130 select 2) addWaypoint [_position, 0];
		_wp_C_130 setWaypointType "MOVE";
		_wp_C_130 setWaypointSpeed "FULL";
		[(_C_130 select 2), 0] setWaypointCombatMode "BLUE";

		(_C_130 select 0) flyInHeight 1000;
		// жду пока самолет булет над точкой
		waitUntil{
			sleep 1;
			((getPos (_C_130 select 0)) inArea [_position, 150, 150, 0, false])
		};
			[_C_130] spawn {
				params ["_C_130"];
				// спауним джип
				_jeep = "rhsusf_m1151_m2_v2_usarmy_d" createVehicle [0,0,1000];
				_pos_plane = getPosATL (_C_130 select 0);
				sleep 1;
				_jeep setPosATL _pos_plane;
				// ждем пока дистанция до земли будет 200 м
				waitUntil{
					_pos_jeep = getPosATl _jeep ;
					(_pos_jeep select 2) <= 100
				};
				//прикрепляю парашут
				_Parachute = createVehicle ["B_Parachute_02_F",GetPosAtl _jeep, [], 0, "FLY"];
				_Parachute disableCollisionWith _jeep;
				_Parachute setPos(getPos _jeep);
				_jeep attachTo [_Parachute, [0, 0, 1.8]];
				//если день тогда добавить дым если ноч ик маяк
				if(daytime <= 6 or daytime >= 20) then{
					_ir_signal = "B_IRStrobe" createVehicle [0,0,0];
					_ir_signal disableCollisionWith _jeep;
					_ir_signal attachTo [_jeep, [0, 0, 0.3]];
				}
				else{
					_smoke = "G_40mm_SmokeGreen" createVehicle [0,0,0];
					_smoke disableCollisionWith _jeep;
					_smoke attachTo [_jeep, [0, 0, 0.3]];
				};
			};

		// возвращаю самолет на позицию 0 и удаляю

		(_C_130 select 0) flyInHeight 4000;
		sleep 30;
		{(_C_130 select 0) deleteVehicleCrew _x } forEach (_C_130 select 1);
		deleteVehicle (_C_130 select 0);
		sleep 1800;
		Call_transport_V2 = true;
		publicVariable "Call_transport_V2";
	};

}, {hint "Передача координат отменена!"}, "Передача координат для сброса транспорта..."] call ace_common_fnc_progressBar;

