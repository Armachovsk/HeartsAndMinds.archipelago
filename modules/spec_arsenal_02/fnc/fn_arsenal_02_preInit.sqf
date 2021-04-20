if (isServer) then {
    ["SPEC_arsenal_02_compile", {
        private _virtualCargo = [] call SPEC_fnc_arsenal_02_addAllVirtualCargo;
        private _presets = ["rhs_blufor"] call SPEC_fnc_arsenal_02_initBlacklistPresets;
        ["SPEC_arsenal_02_readyToCreate", {
            _this call SPEC_fnc_arsenal_02_addArsenalAction;
            ["SPEC_arsenal_02_presetsCompiled", _thisArgs] call CBA_fnc_globalEvent;
        }, [_virtualCargo, _presets]] call CBA_fnc_addEventHandlerArgs;
    }] call CBA_fnc_addEventHandler;
};

["SPEC_arsenal_02_arsenalReady", {
    ["SPEC Arsenal v2 Locked & Loaded", "SPEC_arsenal_02_loadgun", 3, 2] call SPEC_fnc_arsenal_02_displayText;
}] call CBA_fnc_addEventHandler;
