-- Defining zones with center coordinates and radius
local musicZones = {
    -- Example
    {name = "Valentine", coords = vector3(-290.31, 792.39, 118.55), radius = 200.0, soundFile = "SeeTheFireInYourEyes.mp3"},
    -- Add other zones
    {name = "Zone2", coords = vector3(2500.0, 3500.0, 50.0), radius = 100.0, soundFile = "your_sound_file2.mp3"},
    {name = "Zone3", coords = vector3(2500.0, 3500.0, 50.0), radius = 100.0, soundFile = "your_sound_file3.mp3"}
}

local isInMusicZone = false
local currentMusic = nil

function PlayMusic(file)
    if not currentMusic then
        SendNUIMessage({
            type = "playMusic",
            file = file
        })
        currentMusic = file
    end
end

function StopMusic()
    if currentMusic then
        SendNUIMessage({
            type = "stopMusic"
        })
        currentMusic = nil
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        isInMusicZone = false

        for _, zone in pairs(musicZones) do
            local distance = #(playerCoords - zone.coords)

            if distance <= zone.radius then
                isInMusicZone = true
                if currentMusic ~= zone.soundFile then
                    StopMusic()
                    PlayMusic(zone.soundFile)
                end
                break
            end
        end

        if not isInMusicZone and currentMusic then
            StopMusic()
        end
    end
end)

RegisterNetEvent('vlab-soundzones:playMusic')
AddEventHandler('vlab-soundzones:playMusic', function(fileName, volume)
    SendNUIMessage({
        type = "playMusic",
        file = fileName,
        volume = volume or 0.05
    })
    print("Evento ricevuto: Riproduzione audio avviata:", fileName)
end)

RegisterNetEvent('vlab-soundzones:stopMusic')
AddEventHandler('vlab-soundzones:stopMusic', function()
    SendNUIMessage({
        type = "stopMusic"
    })
    print("Evento ricevuto: Riproduzione audio interrotta.")
end)

local soundEnabled = false

RegisterCommand('soundon', function()
    if not soundEnabled then
        soundEnabled = true
        print("Musica abilitata.")
        TriggerEvent('vlab-soundzones:toggleSound', true)
    else
        print("La musica è già abilitata.")
    end
end, false)

RegisterCommand('soundoff', function()
    if soundEnabled then
        soundEnabled = false
        print("Musica disabilitata.")
        TriggerEvent('vlab-soundzones:toggleSound', false)
    else
        print("La musica è già disabilitata.")
    end
end, false)

RegisterNetEvent('vlab-soundzones:toggleSound')
AddEventHandler('vlab-soundzones:toggleSound', function(enable)
    if enable then
        SendNUIMessage({
            type = "playMusic",
            file = "music.mp3",
            volume = 0.5
        })
        print("Riproduzione della musica avviata.")
    else
        SendNUIMessage({
            type = "stopMusic"
        })
        print("Riproduzione della musica interrotta.")
    end
end)
