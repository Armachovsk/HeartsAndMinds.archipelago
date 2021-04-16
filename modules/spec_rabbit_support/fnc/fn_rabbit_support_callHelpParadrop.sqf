params [
    ["_position", getPos player, [[]]]
];

if(isNil "Call_help_paradrop")then{
	Call_help_paradrop = false;
	publicVariable "Call_help_paradrop";
};
if(Call_help_paradrop)exitWith{hint "Самолет еще не готов для взлета!"};
[5, [_position], {
    (_this # 0) params ["_position"];
	[_position] spawn {
        params ["_position"];
		Call_help_paradrop = true;
		publicVariable "Call_help_paradrop";
		[[], {systemChat "По вашим координатам выслан борт десантом, сброс будет по вашим текущим координатм, ожидайте!"}] remoteExec ["call"];
		//Записуем позицию игрока
		_Position_player = getPos player;
		//спуним самолет
		_C_130 = [[0,0,1000], 180, "RHS_C130J_Cargo", WEST] call BIS_fnc_spawnVehicle;
		{_x setSkill ["courage", 1]} forEach units (_C_130 select 2);
		// Приказываем самолету двигаться куда над
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
		// создаю группу десанта
		private _group_desant = createGroup [WEST, true];
		_pos_C_130 = getPosATL (_C_130 select 0);
		for "_i" from 0 to 15 do
		{
			_pos_X = (_pos_C_130 select 0) + random [-100,0,100];
			_pos_Y = (_pos_C_130 select 1) + random [-100,0,100];
			_pos_Z = (_pos_C_130 select 2) + random [-100,0,100];

			_unit_desant = _group_desant createUnit ["B_officer_F",[_pos_X, _pos_Y, _pos_Z], [], 0, "FORM"];
			_unit_desant setSkill 1;

			comment "Remove existing items";
			removeAllWeapons _unit_desant;
			removeAllItems _unit_desant;
			removeAllAssignedItems _unit_desant;
			removeUniform _unit_desant;
			removeVest _unit_desant;
			removeBackpack _unit_desant;
			removeHeadgear _unit_desant;
			removeGoggles _unit_desant;

			comment "Add weapons";
			_unit_desant addWeapon "rhs_weap_m4a1_blockII_grip_KAC_d";
			_unit_desant addPrimaryWeaponItem "Tier1_SandmanS_Desert";
			_unit_desant addPrimaryWeaponItem "rhsusf_acc_anpeq15side";
			_unit_desant addPrimaryWeaponItem "Tier1_Eotech553_3xMag_Tan_Up";
			_unit_desant addPrimaryWeaponItem "rhs_mag_30Rnd_556x45_Mk318_SCAR_Ranger";
			_unit_desant addPrimaryWeaponItem "Tier1_Gangster_Grip_Tan";

			comment "Add containers";
			_unit_desant forceAddUniform "rhs_uniform_cu_ocp";
			_unit_desant addVest "rhsusf_iotv_ocp_Squadleader";

			comment "Add binoculars";
			_unit_desant addWeapon "Binocular";

			comment "Add items to containers";
			for "_i" from 1 to 2 do {_unit_desant addItemToUniform "ACE_epinephrine";};
			for "_i" from 1 to 2 do {_unit_desant addItemToUniform "ACE_tourniquet";};
			for "_i" from 1 to 2 do {_unit_desant addItemToUniform "ACE_morphine";};
			for "_i" from 1 to 4 do {_unit_desant addItemToUniform "ACE_quikclot";};
			for "_i" from 1 to 5 do {_unit_desant addItemToUniform "ACE_elasticBandage";};
			for "_i" from 1 to 2 do {_unit_desant addItemToUniform "ACE_fieldDressing";};
			for "_i" from 1 to 5 do {_unit_desant addItemToUniform "ACE_packingBandage";};
			for "_i" from 1 to 2 do {_unit_desant addItemToUniform "ACE_splint";};
			for "_i" from 1 to 10 do {_unit_desant addItemToVest "rhs_mag_30Rnd_556x45_Mk318_SCAR_Ranger";};
			for "_i" from 1 to 3 do {_unit_desant addItemToVest "rhs_mag_an_m8hc";};
			for "_i" from 1 to 2 do {_unit_desant addItemToVest "HandGrenade";};
			_unit_desant addHeadgear "rhsusf_ach_helmet_ocp_norotos";
			_unit_desant addGoggles "shemagh2_goggclr_tan";

			comment "Add items";
			_unit_desant linkItem "ItemMap";
			_unit_desant linkItem "ItemCompass";
			_unit_desant linkItem "ItemWatch";
			_unit_desant linkItem "ItemRadio";
			_unit_desant linkItem "ItemGPS";
			_unit_desant linkItem "Louetta_GPNVG_2";

			sleep 1;
		};
        // ждем пока дистанция до земли будет 200 м
        waitUntil{
            private _centerPos = [];
            {
                _centerPos pushBack (getPos _x);
            } forEach (units _group_desant);
            private _sortedNumbers = [_centerPos, [], {_x}, "ASCEND"] call BIS_fnc_sortBy;
            ((_centerPos # 0) # 2) <= 500
        };
        {
            unAssignVehicle _x;
            _x allowDamage false;
            moveOut _x;
            sleep 0.35;
            _chute = createVehicle ["NonSteerable_Parachute_F", (getPos _x), [], 0, "NONE"];
            _chute setPos (getPos _x);
            _x moveinDriver _chute;
            _x allowDamage true;
            sleep 0.5;
        } forEach units _group_desant;
		// группе ботов охранять зону игрока
 		_wp = _group_desant addWaypoint [_Position_player, 0];
   		_wp setWaypointType "HOLD";
		//ждать пока игроков не будет для удаления группы
		[_group_desant, _Position_player] spawn{
			params ["_group_desant","_Position_player"];
			waitUntil{
				sleep 10;
				_player_in_area = allPlayers inAreaArray [_Position_player, 1000, 1000, 100, false];
    			isNil {_player_in_area select 0}
			};
			{deleteVehicle _x} forEach (units _group_desant);
		};
		// удаляю С 130
		(_C_130 select 0) flyInHeight 4000;
		waitUntil{
			sleep 5;
			(getPosATL(_C_130 select 0)select 2) >=3000
		};
        deleteGroup (_C_130 # 2);
        {(_C_130 # 0) deleteVehicleCrew _x} forEach (_C_130 # 1);
        deleteVehicle (_C_130 # 0);
		sleep 2400;
		Call_help_paradrop = false;
		publicVariable "Call_help_paradrop";

	};
}, {hint "Отмена передачи"}, "Определение и передача координат..."] call ace_common_fnc_progressBar;
