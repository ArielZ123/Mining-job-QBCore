local QBCore = exports['qb-core']:GetCoreObject()

---- Script Settings ----
local Stones_remove_table = { -- The stones name and the numbers to remove after smelt, add more as your stones list.
	  { Stone = "granite", Amount = 15 },
	  { Stone = "limestone", Amount = 15 },
	  { Stone = "marble", Amount = 15 },
	  { Stone = "onyx", Amount = 15 },
}

local Rocks_remove_table = { -- The rocks name and the numbers to remove after smelt, add more as your rocks list.
	  { Rock = "emerald", Amount = 15 },
	  { Rock = "jadeite", Amount = 15 },
	  { Rock = "diamond", Amount = 15 },
	  { Rock = "taaffeite", Amount = 15 },
	  { Rock = "grandidierite", Amount = 15 },
	  { Rock = "serendibite", Amount = 15 },
	  { Rock = "musgravite", Amount = 15 },
}

local Stones_list = { -- Add more stones to list.
  "granite",
  "limestone",
  "marble",
  "onyx"
}

local Rocks_list = { -- Add more rocks to list. 
  "emerald",
  "jadeite",
  "diamond",
  "taaffeite",
  "grandidierite",
  "serendibite",
  "musgravite"
}
---- Script Settings ----

-- Pickaxe check --
QBCore.Functions.CreateCallback('mining:server:haspickaxe', function(source, cb)
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local PickaxeQuantity = xPlayer.Functions.GetItemByName('pickaxe')
    if PickaxeQuantity ~= nil then 
       if PickaxeQuantity.amount >= 1 then
          cb(true)
       else
          cb(false)
       end
    else
      cb(false)
    end
end)

function Stones_amount()
	return math.random(1,2) -- numbers of the stones that a player can get.
end

function Rocks_amount()
	return math.random(1,2) -- numbers of the rocks that a player can get.
end

function Random_stones()
  return Stones_list[math.random(#Stones_list)]
end

function Random_rocks()
  return Rocks_list[math.random(#Rocks_list)]
end

RegisterNetEvent('mining:stones:find', function()
  local _source = source
  local xPlayer = QBCore.Functions.GetPlayer(_source)
  local Stones_chance = math.random(100)
  if Stones_chance > 40 then -- The chance of the stones find, you can change to higher number for hard chance.
      math.randomseed(GetGameTimer())
      xPlayer.Functions.AddItem(Random_stones(), Stones_amount())
      TriggerClientEvent("pNotify:SendNotification", source, {
         text = "You found some stones.",
         type = "success",
         queue = "lmao",
         timeout = 7000,
         layout = "Centerleft"
      })
  else
      TriggerClientEvent("pNotify:SendNotification", source, {
         text = "You didnt find any stones.",
         type = "success",
         queue = "lmao",
         timeout = 7000,
         layout = "Centerleft"
      })
  end
end)


RegisterNetEvent('mining:rocks:find', function()
  local _source = source
  local xPlayer = QBCore.Functions.GetPlayer(_source)
  local Rocks_chance = math.random(100)
  if Rocks_chance > 40 then -- The chance of the rocks find, you can change to higher number for hard chance or reduce the number.
      math.randomseed(GetGameTimer())
      xPlayer.Functions.AddItem(Random_rocks(), Rocks_amount())
      TriggerClientEvent("pNotify:SendNotification", source, {
         text = "You found some rocks.",
         type = "success",
         queue = "lmao",
         timeout = 7000,
         layout = "Centerleft"
      })
  else
      TriggerClientEvent("pNotify:SendNotification", source, {
         text = "You didnt find any rocks.",
         type = "success",
         queue = "lmao",
         timeout = 7000,
         layout = "Centerleft"
      })
  end
end)

RegisterNetEvent('mining:stones:smelt', function()
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local GraniteQuantity = xPlayer.Functions.GetItemByName('granite')
    local LimestoneQuantity = xPlayer.Functions.GetItemByName('limestone')
    local MarbleQuantity = xPlayer.Functions.GetItemByName('marble')
    local OnyxQuantity = xPlayer.Functions.GetItemByName('onyx')
    -- 15 of stones types are needed for smelt, you can change the numbers of each stone to lesser or higher.
    if GraniteQuantity ~= nil and LimestoneQuantity ~= nil and MarbleQuantity ~= nil and OnyxQuantity ~= nil then
        if GraniteQuantity.amount >= 15 and LimestoneQuantity.amount >= 15 and MarbleQuantity.amount >= 15 and OnyxQuantity.amount >= 15 then
            for k,v in pairs(Stones_remove_table) do
               xPlayer.Functions.RemoveItem(v.Stone, v.Amount)
            end
            xPlayer.Functions.AddItem('Smelted_stones_pack', 1)
            TriggerClientEvent("pNotify:SendNotification", source, {
              text = "You smelted your stones, and got a pack of your smelted stones.",
              type = "success",
              queue = "lmao",
              timeout = 7000,
              layout = "Centerleft"
            })
        else
            TriggerClientEvent("pNotify:SendNotification", source, {
              text = "<b style=color:#ff0000>error: <b style=color:#e3a010> you dont have enough stones, you have: <b style=color:#9ef507> Granite "  .. GraniteQuantity.amount .." <b style=color:#edf507> -> Limestone -> " .. LimestoneQuantity.amount .. " <b style=color:#1388e8> Marble ->  " .. MarbleQuantity.amount   ..   "  <b style=color:#e84c13>  Onyx -> " .. OnyxQuantity.amount .. "</b>",
              type = "success",
              queue = "lmao",
              timeout = 7000,
              layout = "Centerleft"
            })
            TriggerClientEvent("pNotify:SendNotification", source, {
              text = "15 of stones types are needed for smelt.",
              type = "success",
              queue = "lmao",
              timeout = 7000,
              layout = "Centerleft"
            })
        end
    else
        TriggerClientEvent("pNotify:SendNotification", source, {
          text = "15 of stones types are needed for smelt.",
          type = "success",
          queue = "lmao",
          timeout = 7000,
          layout = "Centerleft"
        })
    end
end)

RegisterNetEvent('mining:rocks:smelt', function()
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local EmeraldQuantity = xPlayer.Functions.GetItemByName('emerald')
    local JadeiteQuantity = xPlayer.Functions.GetItemByName('jadeite')
    local DiamondQuantity = xPlayer.Functions.GetItemByName('diamond')
    local TaaffeiteQuantity = xPlayer.Functions.GetItemByName('taaffeite')
    local GrandidieriteQuantity = xPlayer.Functions.GetItemByName('grandidierite')
    local SerendibiteQuantity = xPlayer.Functions.GetItemByName('serendibite')
    local MusgraviteQuantity = xPlayer.Functions.GetItemByName('musgravite')
    -- 15 of rocks types are needed for smelt, you can change the numbers of each rock to lesser or higher.
    if EmeraldQuantity ~= nil and JadeiteQuantity ~= nil and DiamondQuantity ~= nil and TaaffeiteQuantity ~= nil and GrandidieriteQuantity ~= nil and SerendibiteQuantity ~= nil and MusgraviteQuantity ~= nil then
        if EmeraldQuantity.amount >= 15 and JadeiteQuantity.amount >= 15 and DiamondQuantity.amount >= 15 and TaaffeiteQuantity.amount >= 15 and GrandidieriteQuantity.amount >= 15 and SerendibiteQuantity.amount >= 15 and MusgraviteQuantity.amount >= 15 then
           for k,v in pairs(Rocks_remove_table) do
             xPlayer.Functions.RemoveItem(v.Rock, v.Amount)
           end
           xPlayer.Functions.AddItem('Smelted_rocks_pack', 1)
           TriggerClientEvent("pNotify:SendNotification", source, {
              text = "You smelted your rocks, and got a pack of your smelted rocks.",
              type = "success",
              queue = "lmao",
              timeout = 10000,
              layout = "Centerleft"
           })
        else
           TriggerClientEvent("pNotify:SendNotification", source, {
              text = "<b style=color:#ff0000>error: <b style=color:#e3a010> you dont have enough rocks, you have: <b style=color:#9ef507> Emerald "  .. EmeraldQuantity.amount .." <b style=color:#edf507> -> Jadeite -> " .. JadeiteQuantity.amount .. " <b style=color:#1388e8> Diamond ->  " .. DiamondQuantity.amount   ..   "  <b style=color:#e84c13>  Taaffeite -> " .. TaaffeiteQuantity.amount .. "  <b style=color:#0D98BA>  Grandidierite -> " .. GrandidieriteQuantity.amount .. "  <b style=color:#8fa3a1>  Serendibite -> " .. SerendibiteQuantity.amount .. "  <b style=color:#75816b>  Musgravite -> " .. MusgraviteQuantity.amount .. "</b>",
              type = "success",
              queue = "lmao",
              timeout = 10000,
              layout = "Centerleft"
           })
           TriggerClientEvent("pNotify:SendNotification", source, {
              text = "15 of rocks types are needed for smelt.",
              type = "success",
              queue = "lmao",
              timeout = 7000,
              layout = "Centerleft"
           })
        end
    else
        TriggerClientEvent("pNotify:SendNotification", source, {
           text = "15 of rocks types are needed for smelt.",
           type = "success",
           queue = "lmao",
           timeout = 7000,
           layout = "Centerleft"
        })
    end
end)

RegisterNetEvent('mining:stones:sell', function()
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local Stones_pack = xPlayer.Functions.GetItemByName('smelted_stones_pack')
    local Stones_payment = math.random (7000, 8900) -- Change the amount of the random payment to your choice.
    if Stones_pack ~= nil then
        if Stones_pack.amount >= 1 then -- The stone pack for sell, change the number to lesser or higher.
           xPlayer.Functions.RemoveItem('smelted_stones_pack', 1)
           xPlayer.Functions.AddMoney('cash', Stones_payment)
           TriggerClientEvent("pNotify:SendNotification", source, {
              text = "<b style=color:#d1d1d1> You sold your stone pack for <b style=color:#1588d4>"  .. Stones_payment .. "$ <b style=color:#d1d1d1> keep working</b>",
              type = "success",
              queue = "lmao",
              timeout = 7000,
              layout = "Centerleft"
           })
        else
           TriggerClientEvent("pNotify:SendNotification", source, {
              text = "1 stone pack is needed for sell.",
              type = "success",
              queue = "lmao",
              timeout = 7000,
              layout = "Centerleft"
           })
        end
    else
        TriggerClientEvent("pNotify:SendNotification", source, {
           text = "1 stone pack is needed for sell.",
           type = "success",
           queue = "lmao",
           timeout = 7000,
           layout = "Centerleft"
        })
    end
end)



RegisterNetEvent('mining:rocks:sell', function()
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local Rocks_pack = xPlayer.Functions.GetItemByName('smelted_rocks_pack')
    local Rocks_payment = math.random (8000, 9800) -- Change the amount of the random payment to your choice.
    if Rocks_pack ~= nil then
        if Rocks_pack.amount >= 1 then -- The rock pack for sell, change the number to lesser or higher.
           xPlayer.Functions.RemoveItem('smelted_rocks_pack', 1)
           xPlayer.Functions.AddMoney('cash', Rocks_payment)
           TriggerClientEvent("pNotify:SendNotification", source, {
              text = "<b style=color:#d1d1d1> You sold your rock pack for <b style=color:#1588d4>"  .. Rocks_payment .. "$ <b style=color:#d1d1d1> keep working</b>",
              type = "success",
              queue = "lmao",
              timeout = 7000,
              layout = "Centerleft"
           })
        else
           TriggerClientEvent("pNotify:SendNotification", source, {
              text = "1 rock pack is needed for sell.",
              type = "success",
              queue = "lmao",
              timeout = 7000,
              layout = "Centerleft"
           })
        end
    else
       TriggerClientEvent("pNotify:SendNotification", source, {
          text = "1 rock pack is needed for sell.",
          type = "success",
          queue = "lmao",
          timeout = 7000,
          layout = "Centerleft"
       })
    end
end)
