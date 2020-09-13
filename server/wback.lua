

local weapons_players = {}

AddEvent("OnPlayerJoin", function(ply)
   local tbl = {}
   tbl.ply = ply
   tbl.weap1 = {
       1, false
   }
   tbl.weap2 = {
    1, false
   }
   tbl.weap3 = {
    1, false
   }
   tbl.lastslot = 1
   tbl.wasinvehicle = false
   table.insert(weapons_players, tbl)
end)

AddEvent("OnPlayerQuit", function(ply)
   for i, v in ipairs(weapons_players) do
      if v.ply == ply then
         table.remove(weapons_players, i)
      end
   end
end)

local function IsPistol(weapon)
    for i, v in ipairs(pistols) do
       if weapon == v then
          return true
       end
    end
    return false
 end

local function IsRifle(weapon)
   for i, v in ipairs(rifles) do
      if weapon == v then
         return true
      end
   end
   return false
end

local function GetNumberOfAttachedWeapons(ply)
    for i, v in ipairs(weapons_players) do
        if v.ply == ply then
           local nb1 = 0
           local nb2 = 0
           if v.weap1[2] then
              if IsRifle(v.weap1[1]) then
                 nb1 = nb1 + 1
              elseif IsPistol(v.weap1[1]) then
                 nb2 = nb2 + 1
              end
           end
           if v.weap2[2] then
                if IsRifle(v.weap2[1]) then
                    nb1 = nb1 + 1
                elseif IsPistol(v.weap2[1]) then
                    nb2 = nb2 + 1
                end
           end
           if v.weap3[2] then
                if IsRifle(v.weap3[1]) then
                    nb1 = nb1 + 1
                elseif IsPistol(v.weap3[1]) then
                    nb2 = nb2 + 1
                end
           end
           return nb1, nb2
        end
     end
end

local function Spawn_attached_object(ply, weapon)
   if weapons_objects[tostring(weapon)] then
      local x, y, z = GetPlayerLocation(ply)
      local obj = CreateObject(weapons_objects[tostring(weapon)], x, y, 0)
      local nb1, nb2 = GetNumberOfAttachedWeapons(ply)
      local x2, y2, z2, rx, ry, rz, socket
      if IsRifle(weapon) then
         x2 = rifle_offset[nb1 + 1][1]
         y2 = rifle_offset[nb1 + 1][2]
         z2 = rifle_offset[nb1 + 1][3]
         rx = rifle_offset[nb1 + 1][4]
         ry = rifle_offset[nb1 + 1][5]
         rz = rifle_offset[nb1 + 1][6]
         socket = rifle_offset[nb1 + 1][7]
      else
         x2 = pistol_offset[nb2 + 1][1]
         y2 = pistol_offset[nb2 + 1][2]
         z2 = pistol_offset[nb2 + 1][3]
         rx = pistol_offset[nb2 + 1][4]
         ry = pistol_offset[nb2 + 1][5]
         rz = pistol_offset[nb2 + 1][6]
         socket = pistol_offset[nb2 + 1][7]
      end
      SetObjectAttached(obj, 1, ply, x2, y2, z2, rz, ry, rx, socket)
      return obj
   end
end

local function Replace_Attached_objects(i)
   local ply = weapons_players[i].ply
   local v = weapons_players[i]
   local nb1, nb2 = GetNumberOfAttachedWeapons(ply)
   if nb1 == 1 then
      if v.weap1[2] then
         if IsRifle(v.weap1[1]) then
            DestroyObject(weapons_players[i].weap1[2])
            weapons_players[i].weap1[2] = false
            local obj = Spawn_attached_object(ply, v.weap1[1])
            weapons_players[i].weap1[2] = obj
         end
      end
      if v.weap2[2] then
         if IsRifle(v.weap2[1]) then
            DestroyObject(weapons_players[i].weap2[2])
            weapons_players[i].weap2[2] = false
            local obj = Spawn_attached_object(ply, v.weap2[1])
            weapons_players[i].weap2[2] = obj
         end
      end
      if v.weap3[2] then
         if IsRifle(v.weap3[1]) then
            DestroyObject(weapons_players[i].weap3[2])
            weapons_players[i].weap3[2] = false
            local obj = Spawn_attached_object(ply, v.weap3[1])
            weapons_players[i].weap3[2] = obj
         end
      end
   end
   if nb2 == 1 then
      if v.weap1[2] then
         if IsPistol(v.weap1[1]) then
            DestroyObject(weapons_players[i].weap1[2])
            weapons_players[i].weap1[2] = false
            local obj = Spawn_attached_object(ply, v.weap1[1])
            weapons_players[i].weap1[2] = obj
         end
      end
      if v.weap2[2] then
         if IsPistol(v.weap2[1]) then
            DestroyObject(weapons_players[i].weap2[2])
            weapons_players[i].weap2[2] = false
            local obj = Spawn_attached_object(ply, v.weap2[1])
            weapons_players[i].weap2[2] = obj
         end
      end
      if v.weap3[2] then
         if IsPistol(v.weap3[1]) then
            DestroyObject(weapons_players[i].weap3[2])
            weapons_players[i].weap3[2] = false
            local obj = Spawn_attached_object(ply, v.weap3[1])
            weapons_players[i].weap3[2] = obj
         end
      end
   end
end

local function Spawn_attached_weapon(i, weapon, slot)
   local ply = weapons_players[i].ply
   if slot == 1 then
      if weapons_players[i].weap1[2] then
         DestroyObject(weapons_players[i].weap1[2])
         weapons_players[i].weap1[2] = false
         Replace_Attached_objects(i)
      end
      local obj = Spawn_attached_object(ply, weapon)
      weapons_players[i].weap1[2] = obj
   elseif slot == 2 then
      if weapons_players[i].weap2[2] then
         DestroyObject(weapons_players[i].weap2[2])
         weapons_players[i].weap2[2] = false
         Replace_Attached_objects(i)
      end
      local obj = Spawn_attached_object(ply, weapon)
      weapons_players[i].weap2[2] = obj
   elseif slot == 3 then
      if weapons_players[i].weap3[2] then
         DestroyObject(weapons_players[i].weap3[2])
         weapons_players[i].weap3[2] = false
         Replace_Attached_objects(i)
      end
      local obj = Spawn_attached_object(ply, weapon)
      weapons_players[i].weap3[2] = obj
   end
end

local function check_weapons()
    for i, v in ipairs(weapons_players) do
       local weap1 = GetPlayerWeapon(v.ply, 1)
       local weap2 = GetPlayerWeapon(v.ply, 2)
       local weap3 = GetPlayerWeapon(v.ply, 3)
       if weap1 ~= v.weap1[1] then
          weapons_players[i].weap1[1] = weap1
          if GetPlayerVehicle(v.ply) == 0 then
            if weapons_objects[tostring(weap1)] then
               if GetPlayerEquippedWeaponSlot(v.ply) ~= 1 then
                  Spawn_attached_weapon(i, weap1, 1)
               end
            elseif  weapons_players[i].weap1[2] then
               DestroyObject(weapons_players[i].weap1[2])
               weapons_players[i].weap1[2] = false
               Replace_Attached_objects(i)
            end
          end
       end
        if weap2 ~= v.weap2[1] then
            weapons_players[i].weap2[1] = weap2
            if GetPlayerVehicle(v.ply) == 0 then
               if weapons_objects[tostring(weap2)] then
                  if GetPlayerEquippedWeaponSlot(v.ply) ~= 2 then
                     Spawn_attached_weapon(i, weap2, 2)
                  end
               elseif  weapons_players[i].weap2[2] then
                  DestroyObject(weapons_players[i].weap2[2])
                  weapons_players[i].weap2[2] = false
                  Replace_Attached_objects(i)
               end
            end
        end
        if weap3 ~= v.weap3[1] then
            weapons_players[i].weap3[1] = weap3
            if GetPlayerVehicle(v.ply) == 0 then
               if weapons_objects[tostring(weap3)] then
                  if GetPlayerEquippedWeaponSlot(v.ply) ~= 3 then
                     Spawn_attached_weapon(i, weap3, 3)
                  end
               elseif  weapons_players[i].weap3[2] then
                  DestroyObject(weapons_players[i].weap3[2])
                  weapons_players[i].weap3[2] = false
                  Replace_Attached_objects(i)
               end
            end
         end
        if GetPlayerEquippedWeaponSlot(v.ply) ~= v.lastslot then
          if GetPlayerVehicle(v.ply) == 0 then
            local weap
            if v.lastslot == 1 then
               weap = v.weap1[1]
            elseif v.lastslot == 2 then
               weap = v.weap2[1]
            elseif v.lastslot == 3 then
               weap = v.weap3[1]
            end
               if (GetPlayerEquippedWeaponSlot(v.ply) == 1 and weapons_players[i].weap1[2]) then
                  DestroyObject(weapons_players[i].weap1[2])
                  weapons_players[i].weap1[2] = false
                  Replace_Attached_objects(i)
               elseif (GetPlayerEquippedWeaponSlot(v.ply) == 2 and weapons_players[i].weap2[2]) then
                  DestroyObject(weapons_players[i].weap2[2])
                  weapons_players[i].weap2[2] = false
                  Replace_Attached_objects(i)
               elseif (GetPlayerEquippedWeaponSlot(v.ply) == 3 and weapons_players[i].weap3[2]) then
                  DestroyObject(weapons_players[i].weap3[2])
                  weapons_players[i].weap3[2] = false
                  Replace_Attached_objects(i)
               end
             if weapons_objects[tostring(weap)] then
                Spawn_attached_weapon(i, weap, v.lastslot)
             end
           end
           v.lastslot = GetPlayerEquippedWeaponSlot(v.ply)
        end
        if (GetPlayerVehicle(v.ply) == 0 and v.wasinvehicle == true) then
           weapons_players[i].wasinvehicle = false
           if GetPlayerEquippedWeaponSlot(v.ply) == 1 then
              if weapons_objects[tostring(weapons_players[i].weap2[1])] then
                 Spawn_attached_weapon(i, weapons_players[i].weap2[1], 2)
              end
              if weapons_objects[tostring(weapons_players[i].weap3[1])] then
                 Spawn_attached_weapon(i, weapons_players[i].weap3[1], 3)
              end
           elseif GetPlayerEquippedWeaponSlot(v.ply) == 2 then
               if weapons_objects[tostring(weapons_players[i].weap1[1])] then
                  Spawn_attached_weapon(i, weapons_players[i].weap1[1], 1)
               end
               if weapons_objects[tostring(weapons_players[i].weap3[1])] then
                  Spawn_attached_weapon(i, weapons_players[i].weap3[1], 3)
               end
           elseif GetPlayerEquippedWeaponSlot(v.ply) == 3 then
               if weapons_objects[tostring(weapons_players[i].weap1[1])] then
                  Spawn_attached_weapon(i, weapons_players[i].weap1[1], 1)
               end
               if weapons_objects[tostring(weapons_players[i].weap2[1])] then
                  Spawn_attached_weapon(i, weapons_players[i].weap2[1], 2)
               end
           end
        end
    end
 end

AddEvent("OnPlayerEnterVehicle", function(ply, veh, seat)
   for i, v in ipairs(weapons_players) do
      if (v.ply == ply and GetPlayerVehicle(v.ply) ~= 0 and v.wasinvehicle == false) then
         weapons_players[i].wasinvehicle = true
         if weapons_players[i].weap1[2] then
            DestroyObject(weapons_players[i].weap1[2])
            weapons_players[i].weap1[2] = false
         end
         if weapons_players[i].weap2[2] then
            DestroyObject(weapons_players[i].weap2[2])
            weapons_players[i].weap2[2] = false
         end
         if weapons_players[i].weap3[2] then
            DestroyObject(weapons_players[i].weap3[2])
            weapons_players[i].weap3[2] = false
         end
      end
   end
end)
 
 
 AddEvent("OnPackageStart", function()
     CreateTimer(check_weapons, 100)
 end)



