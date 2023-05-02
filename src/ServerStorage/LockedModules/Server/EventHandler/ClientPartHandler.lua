--!strict

--[[
	Lag Test 2023
	Server Helper Module/EventHandler/ClientPartHandler (Locked Module) - April 27th, 2023
	
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

local ClientHandler = {};
ClientHandler.__index = ClientHandler;
ClientHandler.__newindex = function()
	return error("Cannot modify a LockedModule.");
end;

type HandlerResult<T> = {
	Success: boolean;
	Value: T;
};

--type MetatablePointer<T> = typeof(setmetatable({}, {}));

type InfoProto = {
	["InitTimestamp"]: number | nil;
	["Version"]: number | nil;
	["ReservedHost"]: any;
};

type UserStorageProto = {
	[string]: PlayerProto;
};

type PlayerProto = {
	["Name"]: string;
	["PlayerObject"]: Player;
	["ClientToggled"]: boolean;
	["IsReservedHost"]: boolean;
};

export type ClientHandler = typeof(setmetatable({}, {})) & {
	DebugInfo: () -> InfoProto;
	AddUser: (self: ClientHandler, obj: Player) -> HandlerResult<PlayerProto>;
};

local Loaded = false;
local ClientHandlerInst: ClientHandler = nil;
local Info: InfoProto = {};
local Users = {};
Users.__index = Users;

function ClientHandler.new() : ClientHandler
	if not Loaded then
		local self = {};
		local self = setmetatable(self :: any, ClientHandler);
		
		Info = {
			["InitTimestamp"] = os.time(),
			["Version"] = 1,
			["ReservedHost"] = nil
		};
		
		Loaded = true;
		ClientHandlerInst = self;
	end;
	
	return ClientHandlerInst;
end;

function ClientHandler:DebugInfo()
	return Info;
end;

------

function AddUserHandle(obj: Player)
	if type(obj) ~= "userdata" then
		error("Object is not userdata");
	else
		if not obj:IsA("Player") then
			error("Object is not a Player");
		end;
	end;
	
	local NewData: PlayerProto = {
		["Name"] = obj.Name,
		["PlayerObject"] = obj,
		["ClientToggled"] = false,
		["IsReservedHost"] = false
	};
	
	Users[tostring(obj.UserId)] = NewData;
	--setmetatable(Users[tostring(obj.UserId)], Users);
	return NewData;
end;

function ClientHandler:AddUser(obj: Player)
	local Success, Result = pcall(AddUserHandle, obj);
	local Data: HandlerResult<PlayerProto> = {
		Success = Success,
		Value = Result
	};
	
	return Data;
end;

return ClientHandler;