// arry vehicle in fire
vehicle_on_fire = [];

if(isNil "STOP_burning_vehicle_car")then{STOP_burning_vehicle_car = true};

while {STOP_burning_vehicle_car} do {
	// all vehicle
	_vehicle = nearestObjects [[0,0,0], ["Car"], 15000];
		{ if(_x getHitPointDamage "hitEngine" > 0.8) then{
			if(_x in vehicle_on_fire or !alive _x)exitWith{};
			vehicle_on_fire pushBack _x;
			[_x] spawn {
				params ["_vehicle_select"];
				//find engine
				_pos_fire_in_vehicle = [0, 1.5, -0.7];
				if(_vehicle_select selectionPosition "hit_engine" isNotEqualTo [0,0,0])then{
					_pos_fire_in_vehicle = _vehicle_select selectionPosition "hit_engine";
					_pos_fire_in_vehicle set [0,0];
				};
				if(_vehicle_select selectionPosition "motor" isNotEqualTo [0,0,0])then{
					_pos_fire_in_vehicle = _vehicle_select selectionPosition "motor";
					_pos_fire_in_vehicle set [0,0];
				};
				// create fire
				_Fire = "#particlesource" createVehicle [0,0,0];
				_Fire setParticleClass "MediumDestructionFire";
				_Fire attachTo [_vehicle_select, _pos_fire_in_vehicle];
				// create smoke
				_Smoke = "#particlesource" createVehicle [0,0,0];
				_Smoke setParticleClass "MediumDestructionSmoke";
				_Smoke attachTo [_vehicle_select, _pos_fire_in_vehicle];
				// create light
				_light = createVehicle ["#lightpoint", [0,0,0], [], 0, "CAN_COLLIDE"];
				_light attachTo [_vehicle_select, _pos_fire_in_vehicle];
				_light setLightBrightness 1.0;
				_light setLightColor [1,0.85,0.6];
				_light setLightAmbient [1,0.3,0];
				_light setLightIntensity 400;
				_light setLightAttenuation [0,0,0,2];
				_light setLightDayLight true;
				// time to destroid
				_time_to_destroid = 60 + round random 40;
				// talk about vehicle in fine
				[[], {
					hint(parseText "<t color='#ff0000'><t size='2.0'>Двигатель горит!!!</t></t>");
					sleep 10;
					hint "";
				}] remoteExec ["spawn", crew _vehicle_select apply {parseNumber ((_x call BIS_fnc_netId splitString ":") # 1)}];
				// wait until !alive vehicle or "hitEngine" <= 0.6
				waitUntil{
					sleep 1;
					_time_to_destroid = _time_to_destroid - 1;
					if(_time_to_destroid in [8,16,24,32,40,48,56,64,72,80,88,96])then{playSound3D ["A3\Sounds_F\sfx\fire1_loop.wss", _Fire]};
					if(_time_to_destroid <= 0)exitWith{true};
					!alive _vehicle_select or _vehicle_select getHitPointDamage "hitEngine" <= 0.6;
				};
				if(_time_to_destroid <=0)then{
					_vehicle_select setDamage 1;
					{_x setDamage 1} forEach crew _vehicle_select;
				};
				deleteVehicle _Fire;
				deleteVehicle _Smoke;
				deleteVehicle _light;
				vehicle_on_fire = vehicle_on_fire - [_vehicle_select];
			}
		}
	} forEach _vehicle;
	sleep 15;
};

