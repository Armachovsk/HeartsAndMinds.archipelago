/*
 * Author: commy2, Reidond
 * Display a message.
 *
 * Arguments:
 * 0: Message <STRING>
 * 1: Play a sound from CfgSounds (default: nil) <STRING>
 * 2: How long before hiding the message in seconds (default: 2) <NUMBER>
 * 3: Priority, higher priority messages will override lesser important ones (default: 0) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Message", "ACE_Sound_Click", 5, 2] call SPEC_fnc_arsenal_02_displayText
 *
 * Public: Yes
 */

params ["_text", ["_sound", nil], ["_delay", 2], ["_priority", 0]];

if (isNil "SPEC_arsenal_02_lastHint") then {
    SPEC_arsenal_02_lastHint = [0, 0];
};

if !(typeName _text in ["STRING", "TEXT"]) then {_text = str _text};

SPEC_arsenal_02_lastHint params ["_lastHintTime", "_lastHintPriority"];

private _time = CBA_missionTime;

if (_time > _lastHintTime + _delay || {_priority >= _lastHintPriority}) then {
    hintSilent _text;
    if (!(isNil "_sound")) then {playSound _sound};
    SPEC_arsenal_02_lastHint set [0, _time];
    SPEC_arsenal_02_lastHint set [1, _priority];

    [{if ((_this select 0) == SPEC_arsenal_02_lastHint select 0) then {hintSilent ""};}, [_time], _delay, 0] call CBA_fnc_waitAndExecute;
};
