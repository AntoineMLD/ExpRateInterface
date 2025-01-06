local AIO = AIO or require("AIO")

local function CreateIcon()
    -- Crée l'icône principale comme un bouton
    local frame = CreateFrame("Button", "ExpRateIcon", PlayerFrame)
    frame:SetSize(20, 20)
    frame:SetPoint("TOPRIGHT", PlayerFrame, "TOPRIGHT", -130, -80)

    -- Ajout de la texture de l'icône
    local texture = frame:CreateTexture(nil, "OVERLAY")
    texture:SetTexture("Interface\\Icons\\Spell_Holy_ChampionsBond") 
    texture:SetAllPoints(frame)
    texture:SetTexCoord(0.08, 0.92, 0.08, 0.92) 

    -- Effet de survol (tooltip)
    frame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Taux d'Expérience")
        GameTooltip:AddLine("Cliquez pour modifier votre taux d'XP", 1, 1, 1)
        GameTooltip:Show()
    end)

    frame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- Gestion du clic sur l'icône
    frame:SetScript("OnClick", function(self)
        -- Création du menu déroulant
        local menuFrame = CreateFrame("Frame", "ExpRateMenu", UIParent, "UIDropDownMenuTemplate")
        
        local rates = {1, 2, 3, 4, 5}
        local function OnClick(self)
            local rate = tonumber(self.value)
            if rate then
                AIO.Handle("ExpRateAIO", "SetRate", rate)
            end
            CloseDropDownMenus()
        end
        
        local function Initialize(self, level)
            local info = UIDropDownMenu_CreateInfo()
            info.fontObject = GameFontHighlight
            info.notCheckable = true
            
            for _, rate in ipairs(rates) do
                info.text = rate .. "x XP"
                info.value = rate
                info.func = OnClick
                UIDropDownMenu_AddButton(info, level)
            end
        end
        
        UIDropDownMenu_Initialize(menuFrame, Initialize)
        ToggleDropDownMenu(1, nil, menuFrame, self:GetName(), 0, 0)
    end)
end

-- Création de l'icône au chargement
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        CreateIcon()
    end
end)

-- Handler pour les mises à jour
AIO.AddHandlers("ExpRateClient", {
    RateUpdated = function(player, newRate)
        -- Animation de confirmation
        local flash = CreateFrame("Frame", nil, ExpRateIcon)
        flash:SetAllPoints()
        flash:SetAlpha(0)
        local texture = flash:CreateTexture(nil, "OVERLAY")
        texture:SetAllPoints()
        texture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Glow")
        flash:SetScript("OnUpdate", function(self, elapsed)
            local alpha = self:GetAlpha() + elapsed * 3
            if alpha >= 1 then
                self:SetScript("OnUpdate", nil)
                self:Hide()
            else
                self:SetAlpha(alpha)
            end
        end)
        flash:Show()
    end
})
