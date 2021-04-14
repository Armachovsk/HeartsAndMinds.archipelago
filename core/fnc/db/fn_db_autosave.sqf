
/* ----------------------------------------------------------------------------
Function: BTC_fnc_db_autosave

Description:
    Save game when all players disconnected.

Parameters:

Returns:
    _this - Passed arguments. [Array]

Examples:
    (begin example)
        [] call BTC_fnc_db_autosave;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

if ((allPlayers - entities "HeadlessClient_F") isEqualTo []) then {
    removeMissionEventHandler ["HandleDisconnect", _thisEventHandler];
    [] spawn {
        [] call BTC_fnc_db_save;
        addMissionEventHandler ["HandleDisconnect", BTC_fnc_db_autosave];
    };
};

_this
