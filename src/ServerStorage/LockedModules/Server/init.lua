--[[
	Lag Test 2023
	Server Helper Module (Locked Module) - April 27th, 2023
	
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

local EventHandlerModule = require(script:WaitForChild("EventHandler"));

local ServerEnv = setmetatable({
	Loaded = false;
	
	-- Modules
	EventHandler = nil;
}, {});

return setmetatable({}, {
	--- Initializes the server when called.
	__call = function()
		if not ServerEnv.Loaded then
			--local PartStorage = workspace:WaitForChild("Parts", 5);
			local PartStorage = workspace:FindFirstChild("Parts");
			if not PartStorage then
				local NewStorage = Instance.new("Folder");
				NewStorage.Name = "Parts";
				NewStorage.Parent = workspace;
				PartStorage = NewStorage;
			end;
			
			local EventHandler = EventHandlerModule.new();
			ServerEnv.EventHandler = EventHandler;
		end;
	end,
	__metatable = "Cannot access a LockedModule."
});