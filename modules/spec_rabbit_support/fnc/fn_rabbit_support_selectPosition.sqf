params ["_target","_player","_args"];
_args params ["_entity","_request"];

spec_rabbit_support_mapWasOpened = visibleMap;
spec_rabbit_support_mapClicked = false;

openMap [true,false];
titleText ["Select Position","PLAIN",0.5];

["spec_rabbit_support_selectPosition","onMapSingleClick",{
    params ["_units","_position","_alt","_shift","_player","_entity","_request"];

    ["spec_rabbit_support_selectPosition","onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;

    spec_rabbit_support_mapClicked = true;
    titleFadeOut 0.5;
    if (!spec_rabbit_support_mapWasOpened) then {
        openMap [false,false];
    };

    [_player,_entity,_request,_position] call SPEC_fnc_rabbit_support_onMapClick;
},[_player,_entity,_request]] call BIS_fnc_addStackedEventHandler;

[{!visibleMap || spec_rabbit_support_mapClicked},{
    if (!spec_rabbit_support_mapClicked) then {
        ["spec_rabbit_support_selectPosition","onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;

        titleFadeOut 0.5;
        titleText ["Request Cancelled","PLAIN",0.5];
	    [{titleFadeOut 0.5},[],1] call CBA_fnc_waitAndExecute;
    };
}] call CBA_fnc_waitUntilAndExecute;
