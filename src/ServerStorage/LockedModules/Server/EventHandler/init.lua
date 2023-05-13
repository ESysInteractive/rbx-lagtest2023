--[[
	Lag Test 2023
	Server Helper Module/EventHandler (Locked Module) - April 27th, 2023
	
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

local EventHandler = {};
EventHandler.__index = EventHandler;
EventHandler.__newindex = function()
	return error("Cannot modify a LockedModule.");
end;

export type EventHandler = typeof(setmetatable({}, {})) & {
	--[[GetEvents: () -> {
		[string]: {
			[string]: Instance
		}
	};]]
};

local Loaded = false;
local EventHandlerInst: EventHandler = nil;

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MessagingService = game:GetService("MessagingService");
type TopicMessage = {
	Data: string;
	Sent: number;
};

local RandomizerModule = require(script:WaitForChild("Randomizer"));
local Randomizer: typeof(RandomizerModule) = nil;

local ClientPartHandlerModule = require(script:WaitForChild("ClientPartHandler"));
local ClientPartHandler: typeof(ClientPartHandlerModule) = nil;

--[[export type EventNameStorageProto = typeof(setmetatable({}, {})) & {
	Client: {
		StartClient: RemoteEvent | nil;
		CheckClient: RemoteFunction | nil;
		CheckGamePass: RemoteEvent | nil;
		SaveClient: RemoteFunction | nil;
	};
	Server: {
		SpawnPart: RemoteEvent | nil;
		ClearPart: RemoteEvent | nil;
		ChangePart: RemoteEvent | nil;
		ReserveServ: RemoteFunction | nil;
	};
};

local EventHandler = setmetatable({}, {
	__call = function()
		if not Loaded then
			-- Randomizer Module
			local RandomizerModule = require(script:WaitForChild("Randomizer"));
			Randomizer = RandomizerModule.new();
			
			-- Event Names
			local StartClient_EventStr = Randomizer:Generate(20);
			local CheckClient_EventStr = Randomizer:Generate(20);
			local CheckGamePass_EventStr = Randomizer:Generate(20);
			local SaveClient_EventStr = Randomizer:Generate(20);
			
			local SpawnPart_EventStr = Randomizer:Generate(25);
			local ClearPart_EventStr = Randomizer:Generate(25);
			local ChangePart_EventStr = Randomizer:Generate(25);
			
			local ReserveServ_EventStr = Randomizer:Generate(15);
			
			-- Events Creation (Client)
			local StartClient = Instance.new("RemoteEvent", EventStorage);
			StartClient.Name = StartClient_EventStr;
			EventNameStorage.Client.StartClient = StartClient;
			
			local CheckClient = Instance.new("RemoteFunction", EventStorage);
			CheckClient.Name = CheckClient_EventStr;
			EventNameStorage.Client.CheckClient = CheckClient;
			
			local CheckGamePass = Instance.new("RemoteEvent", EventStorage);
			CheckGamePass.Name = CheckGamePass_EventStr;
			EventNameStorage.Client.CheckGamePass = CheckGamePass;
			
			local SaveClient = Instance.new("RemoteFunction", EventStorage);
			SaveClient.Name = SaveClient_EventStr;
			EventNameStorage.Client.SaveClient = SaveClient;
			
			-- Events Creation (Server)
			local SpawnPart = Instance.new("RemoteEvent", EventStorage);
			SpawnPart.Name = SpawnPart_EventStr;
			EventNameStorage.Server.SpawnPart = SpawnPart;
			
			local ClearPart = Instance.new("RemoteEvent", EventStorage);
			ClearPart.Name = ClearPart_EventStr;
			EventNameStorage.Server.ClearPart = ClearPart;
			
			local ChangePart = Instance.new("RemoteEvent", EventStorage);
			ChangePart.Name = ChangePart_EventStr;
			EventNameStorage.Server.ChangePart = ChangePart;
			
			
			local ReserveServ = Instance.new("RemoteFunction", EventStorage);
			ReserveServ.Name = ReserveServ_EventStr;
			EventNameStorage.Server.ReserveServ = ReserveServ;
			
			return self;
		end;
	end,
	__index = function(self, idx, args)
		if Loaded then
			print(self, idx, args);
		end;
	end,
	__metatable = "Cannot access a LockedModule."
});]]

function EventHandler.new() : EventHandler
	if not Loaded then		
		local self = {};
		local self = setmetatable(self :: any, EventHandler);
		
		--local AESModule = require(script:WaitForChild("AES"));
		--local ServerHash;
		
		--local EventStorage = ReplicatedStorage:WaitForChild("Events", 5);
		local EventStorage = ReplicatedStorage:FindFirstChild("Events");
		if not EventStorage then
			local NewStorage = Instance.new("Folder");
			NewStorage.Name = "Events";
			NewStorage.Parent = ReplicatedStorage;
			EventStorage = NewStorage;
		end;
		
		local ServerState = Instance.new("RemoteFunction");
		ServerState.Name = "ServerState";
		ServerState.Parent = EventStorage;
		
		ServerState.OnServerInvoke = function(Client, ...)
			return {
				ServerReady = Loaded,
				ServerTime = os.time()
			};
		end;
		
		-- Randomizer Module
		Randomizer = RandomizerModule.new();

		-- Event Names
		local StartClient_EventStr = Randomizer:Generate(20);
		local CheckClient_EventStr = Randomizer:Generate(20);
		local CheckGamePass_EventStr = Randomizer:Generate(20);
		local SaveClient_EventStr = Randomizer:Generate(20);

		local SpawnPart_EventStr = Randomizer:Generate(25);
		local ClearPart_EventStr = Randomizer:Generate(25);
		local ChangePart_EventStr = Randomizer:Generate(25);

		local ReserveServ_EventStr = Randomizer:Generate(15);

		-- Events Creation (Client)
		local StartClient = Instance.new("RemoteEvent");
		StartClient.Name = "StartClient";
		StartClient.Parent = EventStorage;

		local CheckClient = Instance.new("RemoteFunction");
		CheckClient.Name = "CheckClient";
		CheckClient.Parent = EventStorage;

		local CheckGamePass = Instance.new("RemoteEvent");
		CheckGamePass.Name = "CheckGamePass";
		CheckGamePass.Parent = EventStorage;

		local SaveClient = Instance.new("RemoteFunction");
		SaveClient.Name = "SaveClient";
		SaveClient.Parent = EventStorage;

		-- Events Creation (Server)
		local SpawnPart = Instance.new("RemoteEvent");
		SpawnPart.Name = "SpawnPart";
		SpawnPart.Parent = EventStorage;

		local ClearPart = Instance.new("RemoteEvent");
		ClearPart.Name = "ClearPart";
		ClearPart.Parent = EventStorage;

		local ChangePart = Instance.new("RemoteEvent");
		ChangePart.Name = "ChangePart";
		ChangePart.Parent = EventStorage;


		local ReserveServ = Instance.new("RemoteFunction");
		ReserveServ.Name = "ReserveServ";
		ReserveServ.Parent = EventStorage;
		
		-- Client Part Handler Module
		ClientPartHandler = ClientPartHandlerModule.new();

		local GlobalTopic = Instance.new("RemoteFunction");
		GlobalTopic.Name = "GlobalTopic";
		GlobalTopic.Parent = EventStorage;

		MessagingService:SubscribeAsync("GlobalAnnouncement", function(msg: TopicMessage)
			for _, Player in next, Players:GetPlayers() do
				GlobalTopic:InvokeClient(Player, {
					Type = "GlobalAnnouncement",
					Data = msg.Data,
					PublishedAt = msg.Sent
				});
			end;
		end);
		
		Loaded = true;
		EventHandlerInst = self;
	end;
	
	return EventHandlerInst;
end;

--[[function EventHandler:GetEvents()
	return EventHandlerInst.Events;
end;]]

function EventHandler:AddUser(obj: Player)
	if Loaded then
		
	end;
end;

return EventHandler;