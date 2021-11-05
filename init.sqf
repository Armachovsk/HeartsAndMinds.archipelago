[
    {
        [] call compile preprocessFileLineNumbers "define_mod.sqf";
        [] call compile preprocessFileLineNumbers "core\def\mission.sqf";

        true
    }
] call compile preprocessFileLineNumbers "HeartsAndMindsCore\init.sqf"
