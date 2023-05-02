--!strict

--[[
	Lag Test 2023
	Server Helper Module/EventHandler/PlayerHandler (Locked Module) - April 27th, 2023
	
	Copyright (c) 2023 EmeraldSys Interactive / EmeraldSys Media

	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]

local Players = game:GetService("Players");

local PlayerAddedHandler = {};
PlayerAddedHandler.__index = PlayerAddedHandler;
PlayerAddedHandler.__newindex = function()
	return error("Cannot modify a LockedModule.");
end;

export type PlayerAddedHandler = typeof(setmetatable({}, {})) & {
	AddedEvent: RBXScriptSignal;
	RemovingEvent: RBXScriptSignal;
};

PlayerAddedHandler.AddedEvent = Players.PlayerAdded;
PlayerAddedHandler.RemovingEvent = Players.PlayerRemoving;

return PlayerAddedHandler;