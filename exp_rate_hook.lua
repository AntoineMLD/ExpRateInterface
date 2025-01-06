local instances = {
    -- Classic Dungeons
    [1581] = true, -- Les Mortemines
    [209] = true, -- Donjon d'Ombrecroc
    [491] = true, -- Kraal de Tranchebauge
    [636] = true, -- Souilles de Tranchebauge
    [718] = true, -- Cavernes des Lamentations
    [719] = true, -- Profondeurs de Brassenoire
    [1337] = true, -- Uldaman
    [721] = true, -- Gnomeregan
    [1477] = true, -- Temple englouti
    [717] = true, -- Prison de Hurlevent
    [796] = true, -- Monastère écarlate
    [2100] = true, -- Maraudon
    [2557] = true, -- Hache-tripes
    [2437] = true, -- Gouffre de Ragefeu
    [1176] = true,
    [1417] = true,
    [2057] = true,
    [1584] = true,
    [1583] = true,


    -- Classic Raids
    [2717] = true, -- Cœur du Magma
    [2677] = true, -- Repaire de l'Aile noire
    [3429] = true, -- Ruines d'Ahn'Qiraj
    [3428] = true, -- Temple d'Ahn'Qiraj
    [3456] = true, -- Naxxramas

    -- Burning Crusade Dungeons
    [3714] = true, -- Citadelle des Flammes infernales : les Salles brisées
    [3713] = true, -- Citadelle des Flammes infernales : la Fournaise du sang
    [3562] = true, -- Citadelle des Flammes infernales : les Remparts
    [3715] = true, -- Glissecroc : le Caveau de la vapeur
    [3716] = true, -- Glissecroc : la Basse-tourbière
    [3717] = true, -- Glissecroc : les Enclos aux esclaves
    [3789] = true, -- Auchindoun : Labyrinthe des ombres
    [3791] = true, -- Auchindoun : Salles des Sethekk
    [3792] = true, -- Auchindoun : Tombes-mana
    [3790] = true, -- Auchindoun : Cryptes Auchenaï
    [4131] = true, -- Terrasse des magistères

    -- Burning Crusade Raids
    [3959] = true, -- Temple noir
    [3923] = true, -- Le repaire de Gruul
    [3836] = true, -- Repaire de Magtheridon
    [3607] = true, -- Glissecroc : caverne du sanctuaire du Serpent
    [9318] = true, -- Le Puits de soleil
    [3845] = true, -- Donjon de la Tempête
    [3457] = true, -- Karazhan
    [3606] = true, -- La bataille du mont Hyjal

    -- WotLK Dungeons
    [206] = true, -- Donjon d'Utgarde
    [1196] = true, -- Cime d'Utgarde
    [4265] = true, -- Le Nexus
    [4228] = true, -- L'Oculus
    [4264] = true, -- Les salles de Pierre
    [4196] = true, -- Donjon de Drak'Tharon
    [4277] = true, -- Azjol-Nérub
    [4494] = true, -- Ahn'kahet : l'Ancien royaume
    [4272] = true, -- Les salles de Foudre
    [4416] = true, -- Gundrak
    [4415] = true, -- Le fort Pourpre
    [4813] = true, -- Fosse de Saron
    [4820] = true, -- Salles des Reflets
    [4809] = true, -- La Forge des âmes
    [4100] = true, -- L'Épuration de Stratholme
    [4723] = true, -- Trial of the champion

    -- WotLK Raids
    [4273] = true, -- Ulduar
    [4493] = true, -- Le sanctum Obsidien
    [4500] = true, -- L'Œil de l'éternité
    [4987] = true, -- Le sanctum Rubis
    [12952] = true, -- Citadelle de la Couronne de glace
    [4812] = true, -- Citadelle de la Couronne de glace
    [7695] = true, -- Citadelle de la Couronne de glace
    [10355] = true, -- Citadelle de la Couronne de glace
    [7734] = true, -- Citadelle de la Couronne de glace
    [4603] = true, -- Caveau d'Archavon
    [4722] = true -- trial of the crusader 

}

local function IsPlayerInInstance(player)
    local zoneId = player:GetZoneId()
    local isInInstance = instances[zoneId] ~= nil
    return isInInstance
end

local function OnGiveXP(event, player, amount, victim)
    local controller = ExpRateController:GetInstance()
    if not controller then
        print("[ERROR] Controller is nil in OnGiveXP")
        return false
    end

    local rate = ExpRateModel:GetRate(player)
    if not amount then
        print("[ERROR] 'amount' is nil in OnGiveXP.")
        return false
    end

    local finalRate = rate
    if IsPlayerInInstance(player) then
        finalRate = rate * 10
        print(string.format("[DEBUG] Instance multiplier applied. Final Rate: %.2f", finalRate))
    end

    local adjustedXP = math.floor(amount * finalRate)

    player:GiveXP(adjustedXP)
    return false
end


local function OnQuestReward(event, player, quest, xp)
    if not quest then
        print("[DEBUG] OnQuestReward appelé sans quest valide")
        return
    end

    local controller = ExpRateController:GetInstance()
    local rate = controller and controller:GetRate(player) or 1

    if not xp then
        print("[DEBUG] XP est nil dans OnQuestReward")
        return
    end

    local adjustedXP = math.floor(xp * rate)
    player:GiveXP(adjustedXP)
    return false
end

RegisterPlayerEvent(12, OnGiveXP)
RegisterPlayerEvent(28, OnQuestReward)