params ["_object","_condition"];

["SPEC_arsenal_02_presetsCompiled", {
    params ["_virtualCargo", "_presets"];
    _thisArgs params ["_object", "_condition"];

    private _virtualItems = [_virtualCargo, _presets] call SPEC_fnc_arsenal_02_filter;
    private _cargo = [(_virtualItems getOrDefault ["ace_items", true])] call SPEC_fnc_arsenal_02_aceVirtualItems;

    [missionNamespace, (_virtualItems get "weapons"), true] call BIS_fnc_addVirtualWeaponCargo;
    [missionNamespace, (_virtualItems get "magazines"), true] call BIS_fnc_addVirtualMagazineCargo;
    [missionNamespace, (_virtualItems get "items"), true] call BIS_fnc_addVirtualItemCargo;
    [missionNamespace, (_virtualItems get "backpacks"), true] call BIS_fnc_addVirtualBackpackCargo;

    [[_object, _condition], {
        params ["_object", "_condition"];
        _object addAction [localize "STR_BTC_HAM_ACTION_ARSENAL_OPEN_BIS", {['Open', [_this # 3 # 0, _this # 0]] call bis_fnc_arsenal;}, [_condition]];
    }] remoteExec ["call", [0, -2] select isMultiplayer, isMultiplayer];
    [[_object, _condition], {
        params ["_object", "_condition"];
        _object addAction [localize "STR_BTC_HAM_ACTION_ARSENAL_OPEN_ACE", {[_this # 3 # 0, player] call ace_arsenal_fnc_openBox;}, [_object]];
    }] remoteExec ["call", [0, -2] select isMultiplayer, isMultiplayer];

    _object setVariable ["ace_arsenal_virtualItems",_cargo,true];

    ["SPEC_arsenal_02_arsenalReady"] call CBA_fnc_globalEvent;
}, [_object, _condition]] call CBA_fnc_addEventHandlerArgs;
