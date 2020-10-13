local E, L, V, P, G = unpack(select(2, ...)); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

-- 9.0 Shadowlands
function S:Blizzard_BarbershopUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.barber) then return end

	local frame = _G.BarberShopFrame

	S:HandleButton(frame.ResetButton)
	S:HandleButton(frame.CancelButton)
	S:HandleButton(frame.AcceptButton)
end
S:AddCallbackForAddon('Blizzard_BarbershopUI')

local function ReskinCustomizeButton(button)
	S:HandleButton(button)
	button.backdrop:SetInside(nil, 3, 3)
end

function S:Blizzard_CharacterCustomize()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.barber) then return end -- yes, it belongs also to tbe BarberUI

	local frame = _G.CharCustomizeFrame

	-- backdrop is ugly, so dont use a style
	S:HandleButton(frame.SmallButtons.ResetCameraButton, nil, nil, true)
	S:HandleButton(frame.SmallButtons.ZoomOutButton, nil, nil, true)
	S:HandleButton(frame.SmallButtons.ZoomInButton, nil, nil, true)
	S:HandleButton(frame.SmallButtons.RotateLeftButton, nil, nil, true)
	S:HandleButton(frame.SmallButtons.RotateRightButton, nil, nil, true)

	hooksecurefunc(frame, 'SetSelectedCatgory', function(self)
		for button in self.selectionPopoutPool:EnumerateActive() do
			if not button.IsSkinned then
				S:HandleNextPrevButton(button.DecrementButton)
				S:HandleNextPrevButton(button.IncrementButton)

				local popoutButton = button.SelectionPopoutButton
				popoutButton.HighlightTexture:SetAlpha(0)
				popoutButton.NormalTexture:SetAlpha(0)

				popoutButton.Popout:StripTextures()
				popoutButton.Popout:CreateBackdrop('Transparent')
				popoutButton.Popout.backdrop:SetFrameLevel(popoutButton.Popout:GetFrameLevel())
				ReskinCustomizeButton(popoutButton)

				button.IsSkinned = true
			end
		end

		local optionPool = self.pools:GetPool('CharCustomizeOptionCheckButtonTemplate')
		for button in optionPool:EnumerateActive() do
			if not button.IsSkinned then
				S:HandleCheckBox(button.Button)
				button.IsSkinned = true
			end
		end
	end)
end
S:AddCallbackForAddon('Blizzard_CharacterCustomize')
