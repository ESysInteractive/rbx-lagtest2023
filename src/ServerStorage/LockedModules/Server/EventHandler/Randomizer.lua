--!strict

--[[
	Lag Test 2023
	Server Helper Module/EventHandler/Randomizer (Locked Module) - April 27th, 2023
	
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

local Randomizer = {};
Randomizer.__index = Randomizer;
Randomizer.__newindex = function()
	return error("Cannot modify a LockedModule.");
end;

export type Randomizer = typeof(setmetatable({}, {})) & {
	Generate: (length: number) -> string;
};

local Loaded = false;
local RandomizerInst: Randomizer = nil;

local character_set = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";

local string_sub = string.sub;
local math_random = math.random;
local table_concat = table.concat;
local character_set_amount = #character_set;
local number_one = 1;
local default_length = 10;

function Randomizer.new() : Randomizer
	if not Loaded then
		local self = {};
		local self = setmetatable(self :: any, Randomizer);
		
		Loaded = true;
		RandomizerInst = self;
	end;
	
	return RandomizerInst;
end;

function Randomizer:Generate(length: number)
	math.randomseed(math_random(1000, 100000));

	local random_string = {};

	for int = number_one, length or default_length do
		local random_number = math_random(number_one, character_set_amount);
		local character = string_sub(character_set, random_number, random_number);

		random_string[#random_string + number_one] = character;
	end;

	return table_concat(random_string);
end;

return Randomizer;