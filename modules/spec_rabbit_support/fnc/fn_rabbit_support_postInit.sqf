#include "script_component.hpp"

if (!isDedicated && hasInterface) then {
    private _actions = [
        ["TestAction_call_help","Запросить поддержку","z\SSS\addons\main\ui\icons\heli.paa",{ [objNull, player, [player, QUOTE(CALL_HELP_VDV_TYPE)]] call SPEC_fnc_rabbit_support_selectPosition; }],
        ["TestAction_call_help","Запросить сброс транспорта","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa",{ [objNull, player, [player, QUOTE(CALL_DROP_TRANSPORT_TYPE)]] call SPEC_fnc_rabbit_support_selectPosition; }],
        ["TestAction_call_help","Запросить сброс тяжелого транспорта","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa",{ [objNull, player, [player, QUOTE(CALL_DROP_TRANSPORT_V2_TYPE)]] call SPEC_fnc_rabbit_support_selectPosition; }],
        ["TestAction_call_help","Запросить десантников","z\SSS\addons\main\ui\icons\gunship.paa",{ [objNull, player, [player, QUOTE(CALL_HELP_PARADROP_TYPE)]] call SPEC_fnc_rabbit_support_selectPosition; }]
    ];

    // Compile actions
    private _condition = { !([_this # 0, "transport"] call SSS_interaction_fnc_availableEntities isEqualTo []) };
    private _compiled = _actions apply { [_x # 0, _x # 1, _x # 2, _x # 3, _condition] call ace_interact_menu_fnc_createAction };
    { [typeOf player, 1, ["ACE_SelfActions","SSS_main"], _x] call ace_interact_menu_fnc_addActionToClass } forEach _compiled;
};

if (isServer) then {
    [] spawn SPEC_fnc_rabbit_support_vehicleOnFire;
};
