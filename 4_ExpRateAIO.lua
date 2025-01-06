local AIO = AIO or require("AIO")

local controller = ExpRateController:GetInstance()

local ExpRateAIOHandlers = AIO.AddHandlers("ExpRateAIO", {
    SetRate = function(player, rate)
        local numRate = tonumber(rate)
        if not numRate then
            player:SendBroadcastMessage("[ERROR] Rate invalide")
            return
        end
        
        if numRate >= 1 and numRate <= 5 then
            controller:OnRateChanged(player, numRate)
            local newRate = controller.model:GetRate(player) 
            AIO.Handle(player, "ExpRateClient", "RateUpdated", newRate)
        end
        print("========= FIN SETRATE =========")
    end
})
