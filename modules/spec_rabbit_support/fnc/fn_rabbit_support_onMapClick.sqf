#include "script_component.hpp"

params ["_player","_entity","_request","_position"];

if (isNull _entity) exitWith {};

if (count _position isEqualTo 2) then {
	_position set [2,0];
};

[{[ACE_player, objNull, []] call ace_common_fnc_canInteractWith}, {
    _this params ["_player","_entity","_request","_position"];
    switch (_request) do {
        case QUOTE(CALL_DROP_TRANSPORT_V2_TYPE): {
            [_position] call SPEC_fnc_rabbit_support_callDropTransport_V2;
        };
        case QUOTE(CALL_DROP_TRANSPORT_TYPE): {
            [_position] call SPEC_fnc_rabbit_support_callDropTransport;
        };
        case QUOTE(CALL_HELP_PARADROP_TYPE): {
            [_position] call SPEC_fnc_rabbit_support_callHelpParadrop;
        };
        case QUOTE(CALL_HELP_VDV_TYPE): {
            [_position] call SPEC_fnc_rabbit_support_callHelpVdv;
        };
        default {};
    };
}, [_player,_entity,_request,_position]] call CBA_fnc_waitUntilAndExecute;
