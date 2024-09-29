RegisterServerEvent('vlab-soundzones:playMusicInZone')
AddEventHandler('vlab-soundzones:playMusicInZone', function(fileName, volume)
    local _source = source
    TriggerClientEvent('vlab-soundzones:playMusic', _source, fileName, volume or 0.05)
end)

RegisterServerEvent('vlab-soundzones:stopMusicInZone')
AddEventHandler('vlab-soundzones:stopMusicInZone', function()
    local _source = source
    TriggerClientEvent('vlab-soundzones:stopMusic', _source)
end)

AddEventHandler('onServerResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
    Wait(500)
	print(string.format("^5%s ^4vlab-soundzones^3 RESOURCE STARTED SUCCESSFULLY ✅ %s - Version %s^7", "^6VLAB:", "^5Author:AxelWarZ", "1.0.0"))
end)