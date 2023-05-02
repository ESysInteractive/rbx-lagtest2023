--[[
	Lag Test 2023
	Part Settings GUI Loader - April 27th, 2023
	
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

-- {0.59, 0},{0.648, 0}
local TweenService = game:GetService("TweenService");
local TInfo = TweenInfo.new(2, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut);
local TInfoFast = TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut);

local Tween = TweenService:Create(script.Parent, TInfo, {
	Position = UDim2.fromScale(0.59, 0.648)
});

Tween:Play();

------------------

function Round(n: number, decimals: number)
	decimals = decimals or 0
	return math.floor(n * 10^decimals) / 10^decimals
end;

------------------
-- Viewport Frame Load

local PreviewFrame = script.Parent:WaitForChild("PreviewFrame");

local ViewportCam = Instance.new("Camera");
ViewportCam.Name = "PreviewCamera";
ViewportCam.Parent = PreviewFrame;
PreviewFrame.CurrentCamera = ViewportCam;
ViewportCam.DiagonalFieldOfView = 110;
ViewportCam.FieldOfViewMode = Enum.FieldOfViewMode.Diagonal;

local ViewportCamPos = Vector3.new(0, 5, 5);
local ViewportCamCF = CFrame.new(ViewportCamPos) * CFrame.Angles(math.rad(-45), 0, 0);
ViewportCam.CFrame = ViewportCamCF;

local PreviewPart = Instance.new("Part");
PreviewPart.Name = "PreviewPart";
PreviewPart.Parent = PreviewFrame;
PreviewPart.Anchored = true;

ViewportCam.CameraSubject = PreviewPart;
ViewportCam.CameraType = Enum.CameraType.Follow;

coroutine.resume(coroutine.create(function()
	while true do
		PreviewPart.CFrame = PreviewPart.CFrame * CFrame.Angles(0, 0.025, 0);
		task.wait(0.001);
	end;
end));

PreviewFrame.MouseEnter:Connect(function()
	local Tween = TweenService:Create(PreviewFrame, TInfoFast, {
		Size = UDim2.fromOffset(128, 128),
		Position = UDim2.fromScale(0.758, 0.012)
	});
	
	Tween:Play();
end);

PreviewFrame.MouseLeave:Connect(function()
	local Tween = TweenService:Create(PreviewFrame, TInfoFast, {
		Size = UDim2.fromOffset(64, 64),
		Position = UDim2.fromScale(0.873, 0.012)
	});
	
	Tween:Play();
end);

------------------
-- UI Initialization

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local PlayerMouse = Players.LocalPlayer:GetMouse();

local ScreenGui = script:FindFirstAncestorWhichIsA("ScreenGui");
local Properties = script.Parent:WaitForChild("Properties");

local PartType = Properties:WaitForChild("PartType");
local PartTypeButton = PartType:WaitForChild("Button");
PartTypeButton.Text = PreviewPart.Shape.Name;

PartTypeButton.MouseButton1Click:Connect(function()
	local Idx: number;
	local OldSize = PreviewPart.Size;
	
	local EnumItems = Enum.PartType:GetEnumItems();
	
	for i, v in next, EnumItems do
		if v == PreviewPart.Shape then
			Idx = i;
			break;
		end;
	end;
	
	if Idx >= #EnumItems then
		Idx = 1;
	else
		Idx = Idx + 1;
	end;
	
	PreviewPart.Shape = EnumItems[Idx];
	PreviewPart.Size = OldSize;
	PartTypeButton.Text = EnumItems[Idx].Name;
end);

local PartSize = Properties:WaitForChild("PartSize");
local PartSizeX = PartSize:WaitForChild("SizeX");
local PartSizeY = PartSize:WaitForChild("SizeY");
local PartSizeZ = PartSize:WaitForChild("SizeZ");
PartSizeX.Text = Round(PreviewPart.Size.X, 1);
PartSizeY.Text = Round(PreviewPart.Size.Y, 1);
PartSizeZ.Text = Round(PreviewPart.Size.Z, 1);

PartSizeX.FocusLost:Connect(function(EnterPressed)
	if EnterPressed then
		PreviewPart.Size = Vector3.new(tonumber(PartSizeX.Text), PreviewPart.Size.Y, PreviewPart.Size.Z);
	end;
end);

PartSizeY.FocusLost:Connect(function(EnterPressed)
	if EnterPressed then
		PreviewPart.Size = Vector3.new(PreviewPart.Size.X, tonumber(PartSizeY.Text), PreviewPart.Size.Z);
	end;
end);

PartSizeZ.FocusLost:Connect(function(EnterPressed)
	if EnterPressed then
		PreviewPart.Size = Vector3.new(PreviewPart.Size.X, PreviewPart.Size.Y, tonumber(PartSizeZ.Text));
	end;
end);

local PartMaterial = Properties:WaitForChild("PartMaterial");
local PartMaterialButton = PartMaterial:WaitForChild("Button");
PartMaterialButton.Text = PreviewPart.Material.Name;

PartMaterialButton.MouseButton1Click:Connect(function()
	local Idx: number;
	local OldSize = PreviewPart.Size;
	
	local EnumItems = Enum.Material:GetEnumItems();
	
	for i, v in next, EnumItems do
		if v == PreviewPart.Material then
			Idx = i;
			break;
		end;
	end;
	
	if Idx >= #EnumItems then
		Idx = 1;
	else
		Idx = Idx + 1;
	end;
	
	PreviewPart.Material = EnumItems[Idx];
	PreviewPart.Size = OldSize;
	PartMaterialButton.Text = EnumItems[Idx].Name;
end);

local ColorModule = require(Modules:WaitForChild("Color"));

local PartColor = Properties:WaitForChild("PartColor");
local PartColorButton = PartColor:WaitForChild("Button");
PartColorButton.BackgroundColor3 = PreviewPart.Color;

PartColorButton.MouseButton1Click:Connect(function()
	if ScreenGui ~= nil then
		local self = ColorModule.New(ScreenGui, PlayerMouse);
		self.Finished:Connect(function(color: Color3)
			PartColorButton.BackgroundColor3 = color;
			PreviewPart.Color = color;
		end);
	end;
end);

-- Spawn Parts
local PartStateButton = script.Parent:WaitForChild("PartStateButton");
PartStateButton.MouseButton1Click:Connect(function()
	
end);