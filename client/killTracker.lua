QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler("gameEventTriggered", function(name, args)
	if not (name == "CEventNetworkEntityDamage") then return end

	
	if not (GetEntityHealth(args[1]) <= 0) then return end

	if not (NetworkGetPlayerIndexFromPed(args[1]) == PlayerId()) then return end

	local victimId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(args[1]))
	local killerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(args[2]))

	if (victimId == 0) then return end

	QBCore.Functions.TriggerCallback("vectorSystems:generateToken", function(token)
		TriggerServerEvent("vectorSystems:registerKillDeath", killerId, victimId, token)
	end)

end)