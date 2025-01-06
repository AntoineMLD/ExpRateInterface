ExpRateModel = {}
ExpRateModel.__index = ExpRateModel

function ExpRateModel:GetRate(player)
    local playerGuid = player:GetGUIDLow()
    
    local query = string.format("SELECT `rate` FROM `player_exp_rates` WHERE `player_guid` = %d", playerGuid)
    
    local result = CharDBQuery(query)
    if result then
        local rate = result:GetInt32(0)
        return rate
    else
        return 1
    end
end

function ExpRateModel:SetRate(player, rate)
    local playerGuid = player:GetGUIDLow()
    
    local query = string.format("REPLACE INTO `player_exp_rates` (`player_guid`, `rate`) VALUES (%d, %d)", playerGuid, rate)
    
    local success = CharDBExecute(query)
    
    -- Vérifions immédiatement si l'insertion a fonctionné
    local verifyQuery = string.format("SELECT `rate` FROM `player_exp_rates` WHERE `player_guid` = %d", playerGuid)
    local result = CharDBQuery(verifyQuery)
end