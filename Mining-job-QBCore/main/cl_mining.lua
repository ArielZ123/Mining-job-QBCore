local QBCore = exports['qb-core']:GetCoreObject()

local mineActive = false
local IsPlayerConnected = false
local has_pickaxe = false

local Stones_mining_pos = { -- Add more positions to the stones area.
    {x= 2945.58, y= 2818.35, z= 42.7},  -- 2945.58, 2818.35, 42.7
    {x= 2927.05, y= 2793.39, z= 40.6}   -- 2927.05, 2793.39, 40.6
}

local Rocks_mining_pos ={ -- Add more positions to the rocks area.
    {x= -602.36 , y= 2092.97 , z= 131.04} -- -602.36, 2092.97, 130.04
}

local Stones_smelt = { -- Add more positions to the stones smelt.
    {x= 1107.89, y= -2012.26, z= 34.60},  -- 1107.89, -2012.26, 35.44
}

local Rocks_smelt = { -- Add more positions to the rocks smelt.
    {x= 1109.67, y= -2013.05, z= 34.57},  -- 1109.67, -2013.05, 35.45
}

local Stones_sell_pos = { -- Add more positions to the stones sell.
    {x= 510.94, y= -1951.43, z= 24.0},  -- 510.94, -1951.43, 24.99
}

local Rocks_sell_pos = { -- Add more positions to the rocks sell.
    {x= 1395.54, y= 3623.73, z= 34.10},  -- 1395.54, 3623.73, 35.01
}

AddEventHandler('onResourceStart', function(resourceName)
  if resourceName == 'Mining-job' then --> If you change the script name please put the new name here!.
     IsPlayerConnected = true
  end
end)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    IsPlayerConnected = true
end)

-- Pickaxe check --
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPlayerConnected then
            QBCore.Functions.TriggerCallback('mining:server:haspickaxe', function(cb)
                if cb then
                    has_pickaxe = true
                else
                    has_pickaxe = false
                end
            end)
        end
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local plyCoords = GetEntityCoords(ped)
        local MiningHour = GetClockHours()
        local NearMarker = false
        for k in pairs(Stones_mining_pos) do
           if mineActive == false then
              local PlyCoords = vector3(plyCoords.x, plyCoords.y, plyCoords.z)
	          local StonesLoc = vector3(Stones_mining_pos[k].x, Stones_mining_pos[k].y, Stones_mining_pos[k].z)
              local dist = #(PlyCoords - StonesLoc)
              if dist <= 1.1 and not NearMarker then
                 DrawMarker(2, Stones_mining_pos[k].x, Stones_mining_pos[k].y, Stones_mining_pos[k].z, 0, 0, 0, 0, 0, 0, 0.4, 0.4, 0.4, 0, 175, 249, 77 ,2 ,0 ,0 ,0)
                 NearMarker = true
                 if has_pickaxe then
                    mine_text(Stones_mining_pos[k].x, Stones_mining_pos[k].y, Stones_mining_pos[k].z, tostring('Press ~y~[Right click]~w~ to mine this stone'))
                 else
                    mine_text(Stones_mining_pos[k].x, Stones_mining_pos[k].y, Stones_mining_pos[k].z, tostring('you need to hold a pickaxe'))
                 end
                 if IsControlJustPressed(0,25) and dist <= 1.1 then
                    if has_pickaxe then
                       Stonesmining()
                       mineActive = true
                    end
                 end
              end
           end
        end

        for k in pairs(Rocks_mining_pos) do
           if mineActive == false then
              local PlyCoords = vector3(plyCoords.x, plyCoords.y, plyCoords.z)
	          local RocksLoc = vector3(Rocks_mining_pos[k].x, Rocks_mining_pos[k].y, Rocks_mining_pos[k].z)
              local dist = #(PlyCoords - RocksLoc)
              if dist <= 1.1 and not NearMarker then
                 if MiningHour >= 6 and MiningHour < 23 then
                    DrawMarker(2, Rocks_mining_pos[k].x, Rocks_mining_pos[k].y, Rocks_mining_pos[k].z, 0, 0, 0, 0, 0, 0, 0.4, 0.4, 0.4, 0, 175, 249, 77 ,2 ,0 ,0 ,0)
                    NearMarker = true
                    if has_pickaxe then
                       mine_text(Rocks_mining_pos[k].x, Rocks_mining_pos[k].y, Rocks_mining_pos[k].z, tostring('Press ~y~[Right click]~w~ to mine this rock'))
                    else
                       mine_text(Rocks_mining_pos[k].x, Rocks_mining_pos[k].y, Rocks_mining_pos[k].z, tostring('you need to hold a pickaxe'))
                    end
                    if IsControlJustPressed(0,25) and dist <= 1.1 then
                       if has_pickaxe then
                          Rocksmining()
                          mineActive = true
                       end
                    end
                 end
              end
           end
        end

        for k in pairs(Stones_smelt) do
              local PlyCoords = vector3(plyCoords.x, plyCoords.y, plyCoords.z)
	          local SmeltLoc = vector3(Stones_smelt[k].x, Stones_smelt[k].y, Stones_smelt[k].z)
              local dist = #(PlyCoords - SmeltLoc)
              if dist <= 1.0 and not NearMarker then
                 DrawMarker(1, Stones_smelt[k].x, Stones_smelt[k].y, Stones_smelt[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.2001, 0, 246, 191, 109 ,0 ,0 ,0 ,0)
                 mine_text(Stones_smelt[k].x, Stones_smelt[k].y, Stones_smelt[k].z+0.8, tostring('Press ~o~[E]~w~ to smelt your stones'))
                 NearMarker = true
                 if IsControlJustPressed(0,38) then
                    TriggerServerEvent('mining:stones:smelt')
                 end
              end
        end

        for k in pairs(Rocks_smelt) do
              local PlyCoords = vector3(plyCoords.x, plyCoords.y, plyCoords.z)
	          local SmeltLoc_2 = vector3(Rocks_smelt[k].x, Rocks_smelt[k].y, Rocks_smelt[k].z)
              local dist = #(PlyCoords - SmeltLoc_2)
              if dist <= 1.0 and not NearMarker then
                 DrawMarker(1, Rocks_smelt[k].x, Rocks_smelt[k].y, Rocks_smelt[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.2001, 0, 246, 191, 109 ,0 ,0 ,0 ,0)
                 mine_text(Rocks_smelt[k].x, Rocks_smelt[k].y, Rocks_smelt[k].z+0.8, tostring('Press ~o~[E]~w~ to smelt your rocks'))
                 NearMarker = true
                 if IsControlJustPressed(0,38) then
                    TriggerServerEvent('mining:rocks:smelt')
                 end
              end
        end

        for k in pairs(Stones_sell_pos) do
              local PlyCoords = vector3(plyCoords.x, plyCoords.y, plyCoords.z)
	          local StoneSellLoc = vector3(Stones_sell_pos[k].x, Stones_sell_pos[k].y, Stones_sell_pos[k].z)
              local dist = #(PlyCoords - StoneSellLoc)
              if dist <= 1.0 and not NearMarker then
                 DrawMarker(1, Stones_sell_pos[k].x, Stones_sell_pos[k].y, Stones_sell_pos[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.2001, 0, 246, 191, 109 ,0 ,0 ,0 ,0)
                 mine_text(Stones_sell_pos[k].x, Stones_sell_pos[k].y, Stones_sell_pos[k].z+0.8, tostring('Press ~g~[E]~w~ to sell your stones'))
                 NearMarker = true
                 if IsControlJustPressed(0,38) then
                    TriggerServerEvent('mining:stones:sell')
                 end
              end
        end

        for k in pairs(Rocks_sell_pos) do
              local PlyCoords = vector3(plyCoords.x, plyCoords.y, plyCoords.z)
	          local RockSellLoc = vector3(Rocks_sell_pos[k].x, Rocks_sell_pos[k].y, Rocks_sell_pos[k].z)
              local dist = #(PlyCoords - RockSellLoc)
              if dist <= 1.0 and not NearMarker then
                 DrawMarker(1, Rocks_sell_pos[k].x, Rocks_sell_pos[k].y, Rocks_sell_pos[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.2001, 0, 246, 191, 109 ,0 ,0 ,0 ,0)
                 mine_text(Rocks_sell_pos[k].x, Rocks_sell_pos[k].y, Rocks_sell_pos[k].z+0.8, tostring('Press ~g~[E]~w~ to sell your rocks'))
                 NearMarker = true
                 if IsControlJustPressed(0,38) then
                    TriggerServerEvent('mining:rocks:sell')
                 end
              end
        end
			
	if not NearMarker then
           Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
       if mineActive == true then
          DisableControlAction(0, 24, true)
		  DisableControlAction(0, 257, true)
          DisableControlAction(0, 263, true)
          DisableControlAction(0, 32, true)
		  DisableControlAction(0, 34, true)
		  DisableControlAction(0, 31, true)
		  DisableControlAction(0, 30, true)
          DisableControlAction(0, 45, true)
		  DisableControlAction(0, 22, true)
		  DisableControlAction(0, 44, true)
		  DisableControlAction(0, 37, true)
          DisableControlAction(0, 264, true)
		  DisableControlAction(0, 257, true)
		  DisableControlAction(0, 140, true)
		  DisableControlAction(0, 141, true)
		  DisableControlAction(0, 142, true)
		  DisableControlAction(0, 143, true)
       end
       Citizen.Wait(0)
    end
end)

-- Mining Blips
Citizen.CreateThread(function()
    -- Stones Spot
	local Stones_Blip = AddBlipForCoord(2933.66, 2780.44, 39.15)
    SetBlipSprite(Stones_Blip, 618)
	SetBlipScale(Stones_Blip, 0.85)
    SetBlipColour(Stones_Blip, 10)
    SetBlipAsShortRange(Stones_Blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Stones Spot')
	EndTextCommandSetBlipName(Stones_Blip)

    -- Rocks Spot
    local Rocks_Blip = AddBlipForCoord(-596.34, 2092.29, 131.59)
    SetBlipSprite(Rocks_Blip, 618)
	SetBlipScale(Rocks_Blip, 0.85)
    SetBlipColour(Rocks_Blip, 10)
    SetBlipAsShortRange(Rocks_Blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Rocks Spot')
	EndTextCommandSetBlipName(Rocks_Blip)

    -- Smelt Center
    local Smelt_Blip = AddBlipForCoord(1108.86, -2015.75, 35.67)
    SetBlipSprite(Smelt_Blip, 436)
	SetBlipScale(Smelt_Blip, 0.85)
    SetBlipColour(Smelt_Blip, 17)
    SetBlipAsShortRange(Smelt_Blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Smelt Center')
	EndTextCommandSetBlipName(Smelt_Blip)

    -- Stones Sell
    local Stones_Sell = AddBlipForCoord(510.94, -1951.43, 24.99)
    SetBlipSprite(Stones_Sell, 431)
	SetBlipScale(Stones_Sell, 0.85)
    SetBlipColour(Stones_Sell, 69)
    SetBlipAsShortRange(Stones_Sell, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Stones Sell')
	EndTextCommandSetBlipName(Stones_Sell)

    -- Rocks Sell
    local Rocks_Sell = AddBlipForCoord(1395.54, 3623.73, 35.01)
    SetBlipSprite(Rocks_Sell, 431)
	SetBlipScale(Rocks_Sell, 0.85)
    SetBlipColour(Rocks_Sell, 69)
    SetBlipAsShortRange(Rocks_Sell, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Rocks Sell')
	EndTextCommandSetBlipName(Rocks_Sell)
end)

function Stonesmining()
    Citizen.CreateThread(function()
        local impacts = 0
        while impacts < 5 do
            Citizen.Wait(0)
		    local ped = PlayerPedId()
            local plyCoords = GetEntityCoords(ped)
            local FrontStone = GetEntityForwardVector(ped)
            local x, y, z = table.unpack(plyCoords + FrontStone * 1.0)
            if not HasNamedPtfxAssetLoaded("core") then
	           RequestNamedPtfxAsset("core")
	             while not HasNamedPtfxAssetLoaded("core") do
		         Wait(0)
	           end
            end
            if impacts == 0 then
               pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
               AttachEntityToEntity(pickaxe, ped, GetPedBoneIndex(ped, 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, true, true, false, true, 1, true)
            end
            LoadDict('melee@large_wpn@streamed_core')
            TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot',  8.0, 8.0, -1, 80, 0, 0, 0, 0)
            Citizen.Wait(730)
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10.5, "mining", 35.10)
            UseParticleFxAssetNextCall("core")
            effect = StartParticleFxLoopedAtCoord("ent_amb_stoner_landing",x, y, z-1.0, 0.0, 0.0, 0.0, 1.6, false, false, false, false)
            Citizen.Wait(1000)
            StopParticleFxLooped(effect, 0)
            Citizen.Wait(1500)
            ClearPedTasks(ped)
            impacts = impacts+1
            print('mining loop->',impacts)
            if impacts == 5 then
               impacts = 0
               DeleteEntity(pickaxe)
               TriggerServerEvent('mining:stones:find')
               mineActive = false
               break
            end
        end
    end)
end

function Rocksmining()
    Citizen.CreateThread(function()
        local impacts = 0
        while impacts < 5 do
            Citizen.Wait(0)
		    local ped = PlayerPedId()
            local plyCoords = GetEntityCoords(ped)
            local FrontRock = GetEntityForwardVector(ped)
            local x, y, z   = table.unpack(plyCoords + FrontRock * 1.0)
            if not HasNamedPtfxAssetLoaded("core") then
	           RequestNamedPtfxAsset("core")
	             while not HasNamedPtfxAssetLoaded("core") do
		         Wait(0)
	           end
            end
            if impacts == 0 then
               pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
               AttachEntityToEntity(pickaxe, ped, GetPedBoneIndex(ped, 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, true, true, false, true, 1, true)
            end
            LoadDict('melee@large_wpn@streamed_core')
            TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot',  8.0, 8.0, -1, 80, 0, 0, 0, 0)
            Citizen.Wait(730)
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10.5, "mining", 35.10)
            UseParticleFxAssetNextCall("core")
            effect = StartParticleFxLoopedAtCoord("ent_amb_stoner_landing",x, y, z-1.0, 0.0, 0.0, 0.0, 1.6, false, false, false, false)
            Citizen.Wait(1000)
            StopParticleFxLooped(effect, 0)
            Citizen.Wait(1500)
            ClearPedTasks(ped)
            impacts = impacts+1
            print('mining loop->',impacts)
            if impacts == 5 then
               impacts = 0
               DeleteEntity(pickaxe)
               TriggerServerEvent('mining:rocks:find')
               mineActive = false
               break
            end
        end
    end)
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

function mine_text(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.30)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
