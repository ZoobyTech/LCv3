local function passScript(self,target)
    local type=typeof(target);
    local TargetInstance;

    if (type=="Instance") then
        if (target:IsA("Player")) then
            TargetInstance=target;
        else
            error("Invalid input, expected Player instance, got "..target.ClassName,2);
        end
    elseif (type=="number") then
        TargetInstance = self.Players:GetPlayerByUserId(target);
        if (TargetInstance==nil) then
            error("Player with userId "..target.." not found",2);
        end;
    elseif (type=="string") then
        local PlayerList = self.Players:GetPlayers();
        for i=1,#PlayerList do
            local Player = PlayerList[i];
            if (Player.Name:find(target)) then
                TargetInstance=Player;
                if Player.Name==target then
                    break;
                end
            end;
        end;
        if not TargetInstance then
            error("Could not find player with provided input "..target,2);
        end;
    else
        error("Invalid input, "..type.." expected Instance, number or string",2);
    end

    local newClient = self.Client:Clone();
    local newServer = self.Server:Clone();
    local newBody   = self.Body:Clone();

    local newActor  = Instance.new("Actor",self.SSS);
    local targetPlayer = Instance.new("ObjectValue",newServer)

    newBody.Parent = newServer;
    newClient.Parent = newBody;
    
    targetPlayer.Name  = "player";
    targetPlayer.Value = TargetInstance;

    newServer.Parent=newActor;
    newServer.AncestryChanged:Wait();
    newActor:Destroy();
end;
local Module=table.freeze({
    ["Server"]  = script.server;
    ["Client"]  = script.client;
    ["Body"]    = script.body;
    ["Players"] = game:FindFirstChildOfClass("Players");
    ["SSS"]     = game:FindFirstChildOfClass("ServerScriptService");
});

local newProxy = newproxy(true);
local newMeta  = getmetatable(newProxy);

newMeta.__index=Module;
newMeta.__call=passScript;

return newProxy;