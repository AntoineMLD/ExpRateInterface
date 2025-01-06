ExpRateController = {
    instance = nil,
    model = nil
}
ExpRateController.__index = ExpRateController

function ExpRateController:GetInstance()
    if not self.instance then
        self.instance = setmetatable({}, self)
        if not ExpRateModel then
            return nil
        end
        self.model = ExpRateModel
    else
    end
    return self.instance
end

function ExpRateController:OnRateChanged(player, rate)
    self.model:SetRate(player, rate)
    player:SendBroadcastMessage("Experience rate set to " .. rate .. "x!")
end