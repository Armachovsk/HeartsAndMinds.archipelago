#define TYPE_MUZZLE 101
#define TYPE_OPTICS 201
#define TYPE_FLASHLIGHT 301
#define TYPE_BIPOD 302
#define TYPE_VEST 701
#define TYPE_UNIFORM 801
#define TYPE_HEADGEAR 605
#define TYPE_BINOCULAR_AND_NVG 4096
#define TYPE_WEAPON_PRIMARY 1
#define TYPE_WEAPON_HANDGUN 2
#define TYPE_WEAPON_SECONDARY 4
#define TYPE_UAV_TERMINAL 621
#define TYPE_FIRST_AID_KIT 401
#define TYPE_MEDIKIT 619
#define TYPE_TOOLKIT 620
#define TYPE_MAGAZINE_HANDGUN_AND_GL 16 // mainly
#define TYPE_MAGAZINE_PRIMARY_AND_THROW 256
#define TYPE_MAGAZINE_SECONDARY_AND_PUT 512 // mainly

params [["_items", [], [true, []]]];

if (_items isEqualType [] && {count _items == 0}) exitWith {};

private _cargo = [
    [[], [], []], // Weapons 0, primary, secondary, handgun
    [[], [], [], []], // WeaponAccessories 1, optic,side,muzzle,bipod
    [ ], // Magazines 2
    [ ], // Headgear 3
    [ ], // Uniform 4
    [ ], // Vest 5
    [ ], // Backpacks 6
    [ ], // Goggles 7
    [ ], // NVGs 8
    [ ], // Binoculars 9
    [ ], // Map 10
    [ ], // Compass 11
    [ ], // Radio slot 12
    [ ], // Watch slot  13
    [ ], // Comms slot 14
    [ ], // WeaponThrow 15
    [ ], // WeaponPut 16
    [ ] // InventoryItems 17
];

private _configCfgWeapons = configFile >> "CfgWeapons"; //Save this lookup in variable for perf improvement

if (_items isEqualType true) then {
    if (_items) then {
        private _configItems = uiNamespace getVariable "ace_arsenal_configItems";

        {
            (_x select 0) append (_x select 1);
            (_x select 2) set [(_x select 3), (_x select 0) arrayIntersect (_x select 0)];
        } forEach [
            [(_cargo select 0 select 0),(_configItems select 0 select 0), _cargo select 0, 0],
            [(_cargo select 0 select 1),(_configItems select 0 select 1), _cargo select 0, 1],
            [(_cargo select 0 select 2),(_configItems select 0 select 2), _cargo select 0, 2],
            [(_cargo select 1 select 0),(_configItems select 1 select 0), _cargo select 1, 0],
            [(_cargo select 1 select 1),(_configItems select 1 select 1), _cargo select 1, 1],
            [(_cargo select 1 select 2),(_configItems select 1 select 2), _cargo select 1, 2],
            [(_cargo select 1 select 3),(_configItems select 1 select 3), _cargo select 1, 3]
        ];

        for "_index" from 2 to 17 do {
            (_cargo select _index) append (_configItems select _index);
            _cargo set [_index, (_cargo select _index) arrayIntersect (_cargo select _index)];
        };
    };

} else {
    {
        if (_x isEqualType "") then {
            private _configItemInfo = _configCfgWeapons >> _x >> "ItemInfo";
            private _simulationType = getText (_configCfgWeapons >> _x >> "simulation");
            switch true do {
                case (isClass (_configCfgWeapons >> _x)): {
                    switch true do {
                        /* Weapon acc */
                        case (
                                isClass (_configItemInfo) &&
                                {(getNumber (_configItemInfo >> "type")) in [TYPE_MUZZLE, TYPE_OPTICS, TYPE_FLASHLIGHT, TYPE_BIPOD]} &&
                                {!(_x isKindOf ["CBA_MiscItem", (_configCfgWeapons)])}
                            ): {
                            switch (getNumber (_configItemInfo >> "type")) do {
                                case TYPE_OPTICS: {
                                    (_cargo select 1) select 0 pushBackUnique _x;
                                };
                                case TYPE_FLASHLIGHT: {
                                    (_cargo select 1) select 1 pushBackUnique _x;
                                };
                                case TYPE_MUZZLE: {
                                    (_cargo select 1) select 2 pushBackUnique _x;
                                };
                                case TYPE_BIPOD: {
                                    (_cargo select 1) select 3 pushBackUnique _x;
                                };
                            };
                        };
                        /* Headgear */
                        case (isClass (_configItemInfo) &&
                            {getNumber (_configItemInfo >> "type") == TYPE_HEADGEAR}): {
                            (_cargo select 3) pushBackUnique _x;
                        };
                        /* Uniform */
                        case (isClass (_configItemInfo) &&
                            {getNumber (_configItemInfo >> "type") == TYPE_UNIFORM}): {
                            (_cargo select 4) pushBackUnique _x;
                        };
                        /* Vest */
                        case (isClass (_configItemInfo) &&
                            {getNumber (_configItemInfo >> "type") == TYPE_VEST}): {
                            (_cargo select 5) pushBackUnique _x;
                        };
                        /* NVgs */
                        case (_simulationType == "NVGoggles"): {
                            (_cargo select 8) pushBackUnique _x;
                        };
                        /* Binos */
                        case (_simulationType == "Binocular" ||
                            {(_simulationType == 'Weapon') && {(getNumber (_configCfgWeapons >> _x >> 'type') == TYPE_BINOCULAR_AND_NVG)}}): {
                            (_cargo select 9) pushBackUnique _x;
                        };
                        /* Map */
                        case (_simulationType == "ItemMap"): {
                            (_cargo select 10) pushBackUnique _x;
                        };
                        /* Compass */
                        case (_simulationType == "ItemCompass"): {
                            (_cargo select 11) pushBackUnique _x;
                        };
                        /* Radio */
                        case (_simulationType == "ItemRadio"): {
                            (_cargo select 12) pushBackUnique _x;
                        };
                        /* Watch */
                        case (_simulationType == "ItemWatch"): {
                            (_cargo select 13) pushBackUnique _x;
                        };
                        /* GPS */
                        case (_simulationType == "ItemGPS"): {
                            (_cargo select 14) pushBackUnique _x;
                        };
                        /* UAV terminals */
                        case (isClass (_configItemInfo) &&
                            {getNumber (_configItemInfo >> "type") == TYPE_UAV_TERMINAL}): {
                            (_cargo select 14) pushBackUnique _x;
                        };
                        /* Weapon, at the bottom to avoid adding binos */
                        case (isClass (_configCfgWeapons >> _x >> "WeaponSlotsInfo") &&
                            {getNumber (_configCfgWeapons >> _x >> 'type') != TYPE_BINOCULAR_AND_NVG}): {
                            switch (getNumber (_configCfgWeapons >> _x >> "type")) do {
                                case TYPE_WEAPON_PRIMARY: {
                                    private _weapon = [_x] call bis_fnc_baseWeapon;
                                    (_weapon isEqualTo _x) && {
                                        (_cargo select 0) select 0 pushBackUnique ([_x] call bis_fnc_baseWeapon) isNotEqualTo -1
                                    };
                                };
                                case TYPE_WEAPON_HANDGUN: {
                                    private _weapon = [_x] call bis_fnc_baseWeapon;
                                    (_weapon isEqualTo _x) && {
                                        (_cargo select 0) select 2 pushBackUnique ([_x] call bis_fnc_baseWeapon) isNotEqualTo -1
                                    };
                                };
                                case TYPE_WEAPON_SECONDARY: {
                                    private _weapon = [_x] call bis_fnc_baseWeapon;
                                    (_weapon isEqualTo _x) && {
                                        (_cargo select 0) select 1 pushBackUnique ([_x] call bis_fnc_baseWeapon) isNotEqualTo -1
                                    };
                                };
                            };
                        };
                        /* Misc items */
                        case (
                                isClass (_configItemInfo) &&
                                ((getNumber (_configItemInfo >> "type")) in [TYPE_MUZZLE, TYPE_OPTICS, TYPE_FLASHLIGHT, TYPE_BIPOD] &&
                                {(_x isKindOf ["CBA_MiscItem", (_configCfgWeapons)])}) ||
                                {(getNumber (_configItemInfo >> "type")) in [TYPE_FIRST_AID_KIT, TYPE_MEDIKIT, TYPE_TOOLKIT]} ||
                                {(getText (_configCfgWeapons >> _x >> "simulation")) == "ItemMineDetector"}
                            ): {
                            (_cargo select 17) pushBackUnique _x;
                        };
                    };
                };
                case (isClass (configFile >> "CfgMagazines" >> _x)): {
                    // Lists to check against
                    private _grenadeList = [];
                    {
                        _grenadeList append getArray (_configCfgWeapons >> "Throw" >> _x >> "magazines");
                        false
                    } count getArray (_configCfgWeapons >> "Throw" >> "muzzles");

                    private _putList = [];
                    {
                        _putList append getArray (_configCfgWeapons >> "Put" >> _x >> "magazines");
                        false
                    } count getArray (_configCfgWeapons >> "Put" >> "muzzles");

                    // Check what the magazine actually is
                    switch true do {
                        // Rifle, handgun, secondary weapons mags
                        case (
                                ((getNumber (configFile >> "CfgMagazines" >> _x >> "type") in [TYPE_MAGAZINE_PRIMARY_AND_THROW,TYPE_MAGAZINE_SECONDARY_AND_PUT,1536,TYPE_MAGAZINE_HANDGUN_AND_GL]) ||
                                {(getNumber (configFile >> "CfgMagazines" >> _x >> "ace_arsenal_hide")) == -1}) &&
                                {!(_x in _grenadeList)} &&
                                {!(_x in _putList)}
                            ): {
                            (_cargo select 2) pushBackUnique _x;
                        };
                        // Grenades
                        case (_x in _grenadeList): {
                            (_cargo select 15) pushBackUnique _x;
                        };
                        // Put
                        case (_x in _putList): {
                            (_cargo select 16) pushBackUnique _x;
                        };
                    };
                };
                case (isClass (configFile >> "CfgVehicles" >> _x)): {
                    if (getNumber (configFile >> "CfgVehicles" >> _x >> "isBackpack") == 1) then {
                        (_cargo select 6) pushBackUnique _x;
                    };
                };
                case (isClass (configFile >> "CfgGlasses" >> _x)): {
                    (_cargo select 7) pushBackUnique _x;
                };
            };
        };
    } foreach _items;
};

_cargo
