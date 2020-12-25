---

-- "AceHook-3.0", "AceComm-3.0"
JamPack = LibStub("AceAddon-3.0"):NewAddon("JamPack", "AceConsole-3.0", "AceEvent-3.0")
-- local L = LibStub("AceLocale-3.0"):GetLocale("JamPack")
-- local AceGUI = LibStub("AceGUI-3.0")

local options = {
  name = "JamPack",
  handler = JamPack,
  type = 'group',
  args = {
    -- ...
  },
}

local defaults = {
  profile = {
  },
}

function JamPack:OnInitialize()
  -- Called when the addon is loaded
  self:Print('Initialized')
  self.db = LibStub("AceDB-3.0"):New("JamPackDB", defaults, true)

  LibStub("AceConfig-3.0"):RegisterOptionsTable("JamPack", options)
  self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("JamPack", "JamPack")
  self:RegisterChatCommand("jam", "ChatCommand")
  self:RegisterChatCommand("jampack", "ChatCommand")

end

function JamPack:ChatCommand()
  if not input or input:trim() == "" then
    InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
  else
    LibStub("AceConfigCmd-3.0"):HandleCommand("jam", "JamPack", input)
  end
end

function JamPack:OnEnable()
  -- Called when the addon is enabled
  self:RegisterEvent("ZONE_CHANGED")
end

function JamPack:OnDisable()
  -- Called when the addon is disabled
  self:Print('Disabled')
end

function JamPack:ZONE_CHANGED()
  if GetBindLocation() == GetSubZoneText() then
    if self.db.profile.showInChat then
      self:Print(self.db.profile.message)
    end

    if self.db.profile.showOnScreen then
      UIErrorsFrame:AddMessage(self.db.profile.message, 1.0, 1.0, 1.0, 5.0)
    end
  end
end
