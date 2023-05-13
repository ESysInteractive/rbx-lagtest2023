local StarterGui = game:GetService("StarterGui");
local HttpService = game:GetService("HttpService");

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Events = ReplicatedStorage:WaitForChild("Events");

local GlobalTopic: RemoteFunction = Events:WaitForChild("GlobalTopic");
type ClientMessage = {
    Type: string;
	Data: string;
	PublishedAt: number;
};

GlobalTopic.OnClientInvoke = function(Message: ClientMessage)
    if string.lower(Message.Type) == "globalannouncement" then
        StarterGui:SetCore("SendNotification", {
            Title = "Global Announcement",
            Text = Message.Data,
            Duration = 10
        });
    end;
end;