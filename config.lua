


weapons_objects = {
    ["2"] = 4,
    ["3"] = 5,
    ["4"] = 6,
    ["5"] = 7,
    ["6"] = 8,
    ["7"] = 9,
    ["8"] = 10,
    ["9"] = 11,
    ["10"] = 12,
    ["11"] = 13,
    ["12"] = 14,
    ["13"] = 15,
    ["14"] = 16,
    ["15"] = 17,
    ["16"] = 18,
    ["17"] = 19,
    ["18"] = 20,
    ["19"] = 21,
    ["20"] = 22,
    ["21"] = 1408,
}

rifles = {
    6,
    7,
    8,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
}

pistols = {
    2,
    3,
    4,
    5,
    21
}

-- for up weapons offset :
-- -11, 16, 26, 120, -75, -5, "clavicle_r"
-- 11, -18, -26, 120, 105, 175, "clavicle_l"
rifle_offset = {
    {-18, 14, 11, -110, 110, 0, "clavicle_r"}, -- relx, rely, relz, rel rot x, rel rot y, rel rot z, bone for the first attached rifle
    {18, -14, -11, -110, -70, 180, "clavicle_l"},
}
pistol_offset = { -- 0, 0, 12, 180, 75, -80
    {0, 0, 12, 180, 75, -80, "thigh_r"}, -- relx, rely, relz, rel rot x, rel rot y, rel rot z, bone for the first attached pistol
    {0, 0, -12, 0, 75, -80, "thigh_l"},
}