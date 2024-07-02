script.Disabled = true

local ReplicatedStorage = game:FindFirstChildOfClass("ReplicatedStorage");
local ServerStorage = game:FindFirstChildOfClass("ServerStorage");
local SoundService = game:FindFirstChildOfClass("SoundService");
local JointsService = game:FindFirstChildOfClass("JointsService");
local Lighting = game:FindFirstChildOfClass("Lighting");
local PlayerService = game:FindFirstChildOfClass("Players");
local Debris = game:FindFirstChildOfClass("Debris");
local RunService = game:FindFirstChildOfClass("RunService");
local HttpService = game:FindFirstChildOfClass("HttpService");

local ExecutorName = game:GetService("HttpService"):GenerateGUID(false);
local Player = script:WaitForChild("player").Value;
local Backups = {}

for _, v in next, script:GetChildren() do
    Backups[v.Name] = v:Clone()
end

task.defer(coroutine.running());
coroutine.yield();

CreatorName = "MADDAX27 aka LuaGoose";

-- PREDEFS 
local Runtime = {
    ["BootTasks"] = {},
    ["AddTask"] = function(self, func, parallel)
        table.insert(self.BootTasks, {func, parallel});
    end
};

--

local Instance_ = Instance.new
local Instance
do
    local InstantiatorMap = {
        ["Client"] = "client",
        ["GunAdditions"] = "Ga",
        ["Hair"] = "Hr",
        ["GunBase"] = "Gb",
        ["GunGlow"] = "Gg",
        ["Head"] = "Ha",
        ["HeadGlow"] = "Hg",
        ["LeftWing"] = "Lw",
        ["Limb"] = "Lb",
        ["RightWing"] = "Rw",
        ["Shard"] = "Sh",
        ["Torso"] = "To"
    }
    local S
    do
        S = {};
        local Stuff = Backups["body"]:GetChildren();
        for i = 1, #Stuff do
            local v = Stuff[i];
            S[v.name] = v;
        end
    end

    if RunService:IsStudio() then

        Instance = {
            ["new"] = function(ClassType, Parent, Properties)
                if (InstantiatorMap[ClassType] ~= nil) then
                    ClassType = InstantiatorMap[ClassType];
                end
                local NewInstance;
                local PossibleTarget = Backups["body"]:FindFirstChild(ClassType);
                if PossibleTarget then
                    NewInstance = PossibleTarget:Clone();
                else
                    NewInstance = Instance_(ClassType);
                end
                if type(Properties) == "table" then
                    for i, v in next, Properties do
                        NewInstance[i] = v
                    end
                else
                    if (Properties ~= nil) then
                        warn("Invalid table parameter given. ", Properties);
                    end
                end
                if typeof(Parent) == "Instance" or Parent == nil then
                    NewInstance.Parent = Parent
                else
                    warn("Invalid Parent parameter given. ", Parent);
                end

                return NewInstance;
            end
        };
    else
        Instance = {
            ["new"] = function(ClassType, Parent, Properties)
                local NewInstance;
                if (InstantiatorMap[ClassType] ~= nil) then
                    ClassType = InstantiatorMap[ClassType];
                    local NewInstance = S[ClassType]:Clone();
                else
                    NewInstance = Instance_(ClassType);
                end

                local NewInstance = Instance_(ClassType);
                if (Properties ~= nil) then
                    for i, v in next, Properties do
                        NewInstance[i] = v
                    end
                end
                if (Parent ~= nil) then
                    NewInstance.Parent = Parent;
                end
                return NewInstance;
            end
        }
    end
end

local Character = {
    HumanoidRootPart = {
        CFrame = CFrame.new()
    },
    GunHandle = {
        CFrame = CFrame.new()
    },
    Hole = {
        CFrame = CFrame.new()
    },
    Hole2 = {
        CFrame = CFrame.new()
    }
}
local CharacterProps = {
    Head = {
        Material = Enum.Material.Glass,
        Reflectance = -1,
        Transparency = 0,
        Name = "Head",
        Anchored = true,
        Size = Vector3.new(1.36, 1.2, 1.28),
        LocalTransparencyModifier=0.3
    },
    Torso = {
        Color = Color3.new(),
        Material = Enum.Material.Glass,
        Reflectance = -1,
        TextureID = "",
        Transparency = 0,
        Name = "Torso",
        Anchored = true,
        Size = Vector3.new(2, 2, 1),
        LocalTransparencyModifier=0.3
    },
    RightArm = {
        Color = Color3.new(),
        Material = Enum.Material.Glass,
        Reflectance = -1,
        TextureID = "",
        Transparency = 0,
        Name = "Limb",
        Anchored = true,
        Size = Vector3.new(1, 2, 1),
        LocalTransparencyModifier=0.3
    },
    LeftArm = {
        Color = Color3.new(),
        Material = Enum.Material.Glass,
        Reflectance = -1,
        TextureID = "",
        Transparency = 0,
        Name = "Limb",
        Anchored = true,
        Size = Vector3.new(1, 2, 1),
        LocalTransparencyModifier=0.3
    },
    RightLeg = {
        Color = Color3.new(),
        Material = Enum.Material.Glass,
        Reflectance = -1,
        TextureID = "",
        Transparency = 0,
        Name = "Limb",
        Anchored = true,
        Size = Vector3.new(1, 2, 1),
        LocalTransparencyModifier=0.3
    },
    LeftLeg = {
        Color = Color3.new(),
        Material = Enum.Material.Glass,
        Reflectance = -1,
        TextureID = "",
        Transparency = 0,
        Name = "Limb",
        Anchored = true,
        Size = Vector3.new(1, 2, 1),
        LocalTransparencyModifier=0.3
    },
    Hair = {
        Color = Color3.new(),
        Material = Enum.Material.Glass,
        Reflectance = -1,
        TextureID = "",
        Transparency = 0,
        Name = "Hair",
        Anchored = true,
        Size = Vector3.new(1.77, 1.55, 1.45),
        LocalTransparencyModifier=0.3
    },
    HeadGlow = {
        Material = Enum.Material.Neon,
        Transparency = 0,
        Name = "HeadGlow",
        Anchored = true,
        Size = Vector3.new(1.34, 1.23, 1.18),
        LocalTransparencyModifier=0.3
    },
    GunBase = {
        Color = Color3.new(),
        Material = Enum.Material.Glass,
        Reflectance = -1,
        TextureID = "",
        Transparency = 0,
        Name = "GunBase",
        Anchored = true,
        Size = Vector3.new(9.361, 8.617, 1.474),
        LocalTransparencyModifier=0.3
    },
    GunGlow = {
        Material = Enum.Material.Neon,
        Transparency = 0,
        Name = "GunGlow",
        Anchored = true,
        Size = Vector3.new(2.002, 2.215, 8.928),
        LocalTransparencyModifier=0.3
    },
    GunAdditions = {
        Color = Color3.new(),
        Material = Enum.Material.Glass,
        Reflectance = -1,
        Transparency = 0,
        Name = "GunAdditions",
        Anchored = true,
        Size = Vector3.new(5.498, 2.188, 1.207),
        LocalTransparencyModifier=0.3
    },
    RightWing = {
        Color = Color3.new(),
        Material = Enum.Material.Glass,
        Reflectance = -1,
        TextureID = "",
        Transparency = 0,
        Name = "RightWing",
        Anchored = true,
        Size = Vector3.new(2.398, 4.324, 1.922),
        LocalTransparencyModifier=0.3
    },
    LeftWing = {
        Color = Color3.new(),
        Material = Enum.Material.Glass,
        Reflectance = -1,
        TextureID = "",
        Transparency = 0,
        Name = "LeftWing",
        Anchored = true,
        Size = Vector3.new(2.398, 4.324, 1.922),
        LocalTransparencyModifier=0.3
    }
}
local Welds = {
    Defaults = {
        Neck = {
            C0 = CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), 0, math.rad(180))
        },
        RootJoint = {
            C0 = CFrame.new() * CFrame.Angles(math.rad(-90), 0, math.rad(180))
        },
        RightShoulder = {
            C0 = CFrame.new(-.5, 0, 0) * CFrame.Angles(0, math.rad(90), 0)
        },
        LeftShoulder = {
            C0 = CFrame.new(.5, 0, 0) * CFrame.Angles(0, math.rad(-90), 0)
        }
    },
    Neck = {
        C0 = CFrame.new(),
        C1 = CFrame.new(0, -.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
    },
    RootJoint = {
        C0 = CFrame.new(),
        C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)
    },
    RightShoulder = {
        C0 = CFrame.new(),
        C1 = CFrame.new(-.5, .5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
    },
    LeftShoulder = {
        C0 = CFrame.new(),
        C1 = CFrame.new(.5, .5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    },
    RightHip = {
        C0 = CFrame.new(),
        C1 = CFrame.new(.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
    },
    LeftHip = {
        C0 = CFrame.new(),
        C1 = CFrame.new(-.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    },
    None = {
        C0 = CFrame.new(),
        C1 = CFrame.new()
    },
    Hair = {
        C0 = CFrame.new(.16, .5, 0) * CFrame.Angles(0, math.rad(180), 0),
        C1 = CFrame.new()
    },
    GunJoint = {
        C0 = CFrame.new(.05, -1, -.15) * CFrame.Angles(math.rad(-90), 0, 0),
        C1 = CFrame.new()
    },
    GunBase = {
        C0 = CFrame.new(0, 1.305, -2.108) * CFrame.Angles(0, math.rad(-90), math.rad(-45)),
        C1 = CFrame.new()
    },
    GunGlow = {
        C0 = CFrame.new(-.024, 1.369, -1.26) * CFrame.Angles(0, 0, math.rad(-140.59)),
        C1 = CFrame.new()
    },
    GunAdditions = {
        C0 = CFrame.new(-.004, 1.204, .505) * CFrame.Angles(0, math.rad(-90), 0),
        C1 = CFrame.new()
    },
    Hole = {
        C0 = CFrame.new(-.001, 1.538, -3.342) * CFrame.Angles(0, math.rad(-90), 0),
        C1 = CFrame.new()
    },
    Hole2 = {
        C0 = CFrame.new(-.001, 1.538, -9.142),
        C1 = CFrame.new()
    },
    RightWing = {
        C0 = CFrame.new(.15, .5, .5) * CFrame.Angles(0, math.rad(90), 0),
        C1 = CFrame.new(1.1, 1, -.75)
    },
    LeftWing = {
        C0 = CFrame.new(-.15, .5, .5) * CFrame.Angles(0, math.rad(90), 0),
        C1 = CFrame.new(1.1, 1, .75)
    }
}

local CFrames = {}

local WorldModels, DescendantAdded;
local BlacklistedPlayers, BlacklistedGuis;
do
    BlacklistedPlayers = {};
    BlacklistedGuis = {};
    WorldModels = {};

    DescendantAdded = workspace.DescendantAdded:Connect(function(v)
        if v:IsA("WorldModel") then
            table.insert(WorldModels, v)
            local r;
            r = v.AncestryChanged:Connect(function()
                if not v:IsDescendantOf(workspace) then
                    table.remove(WorldModels, table.find(WorldModels, v))
                    r:Disconnect()
                end
            end)
        end
    end)
end

local RandomString
do
    function RandomString()
        return HttpService:GenerateGUID(false):gsub("-", ""):sub(1, 10)
    end
end

local Music
do

end

local Movement
do
    Movement = {
        ["PotentialCFrame"] = CFrame.new(),
        ["Movement"] = {
            ["Walking"] = false,
            ["Running"] = false,

            ["Forward"] = false,
            ["Backward"] = false,
            ["Left"] = false,
            ["Right"] = false,
            ["Jump"] = false,
            ["Crouch"] = false
        },

        ["HipHeight"] = 2,
        ["WalkSpeed"] = 16,
        ["CFrame"] = CFrame.new()
    };
end

local Banish
do
    local BanishedParts = {};

    Banish = {
        ["Method"] = 0,
        ["Enum"] = {
            ["Method"] = {
                ["TrueDeath"] = 0,
                ["Mesh"] = 1,
                ["Derender"] = 2,

                ["WholeDerender"] = 3, -- disabled.
                ["SphereDerender"] = 4 -- OP
            },
            ["Searching"] = {
                ["Light"] = 0, -- Light basic searching.
                ["Heavy"] = 1,
                ["Strict"] = 2,

                ["SmartParallel"] = 3,
                ["BrutalParallel"] = 4,
                ["StrictParallel"] = 5
            }
        },

        ["ClearTables"] = function()

        end,
        ["Banish"] = function()

        end,
        ["nextMethod"] = function()

        end
    };
end

local Remote
do

    local RemoteKey = RandomString();
    local GuestKey = RandomString();

    local RemoteName = RandomString();

    local LastCall = 0;

    local RemoteProxy = Instance.new("BindableEvent");

    local ActualRemote = nil;
    local C1;
    C2 = nil;

    local function RemoteAntideathProxyConnection(...)
        RemoteProxy:Fire(...);
    end
    local function RemoteAntideath()
        if (C1 ~= nil) then
            C1:Disconnect();
        end
        if (C2 ~= nil) then
            C2:Disconnect();
        end
        if (ActualRemote ~= nil) then
            pcall(game.Destroy, ActualRemote);
        end

        ActualRemote = Instance.new("RemoteEvent");
        ActualRemote.Name = RemoteName;
        ActualRemote.Parent = ReplicatedStorage;

        C1 = ActualRemote.OnServerEvent:Connect(RemoteAntideathProxyConnection);
        C2 = ActualRemote.Changed:Connect(RemoteAntideath);
    end
    local function OnServerEvent(Player, key, requestType, args, ...)
        if (key == Remote.Key) then
            if (requestType == 0) then -- movement
                Movement.PotentialCFrame, Movement.Walking = args.CFrame, args.Walking;
            elseif (requestType == 1) then
                warn("Not allowed.");
            elseif (requestType == 2) then

            end
        end

        if (true == true) then
            return
        end
        if Pass == RemoteKey and type(Method) == "string" and type(Things) == "table" and v.Name == RemoteName then
            LastCall = tick()
            if Method == "Movement" then
                -- Movement.PotentialCFrame, Movement.Walking, Mouse.Hit = Things.CFrame, Things.Walking, Things.Hit
            elseif Method == "RCN247289357214" then -- Replace Character
                for _, v in pairs(Character) do
                    if typeof(v) == "Instance" then
                        game:GetService("Debris"):AddItem(v, 0)
                    end
                end
            elseif Method == "RCM183724827324" then -- Replace Music

            elseif Method == "AntiFat" then

            elseif Method == "ClearBanish" then
                Banish:Clear()
                Remote:FireAllClients(Remote.GuestKey, "ClearBanish")
            elseif Method == "SwapBanish" then
                local int = Banish:nextMethod()
                Remote:FireAllClients(Remote.GuestKey, "SetBanish", {
                    BanishInteger = int
                })
            elseif Method == "SM491883257834" then -- Swap Mode
                Runtime:AddMode();
            elseif Method == "PlaybackLoudness" then

            elseif Method == "Attack" and Runtime:GetMode() >= 0 then
                if Things.Type == "ClickAttack" then
                    pcall(function()
                        local OldMode = Runtime:GetMode();
                        Runtime:SetSine(0);
                        Runtime:SetMode(-1);
                        task.wait(1);

                        --[[
                        Remote:FireAllClients(Remote.GuestKey, "LightningAttack", {
                            IgnoreList = IgnoreChar,
                            StartPosition = Character.Hole2.CFrame.Position,
                            EndPosition = AttackPosition
                        });
                        --]]

                        task.wait(1);
                        Runtime:SetMode(OldMode);
                    end)
                elseif Things.Type == "GroundShards" then
                    --[[]
                    local OldMode, Size, StudsAway = Mode, Vector3.new(2.5, 9, 2.5), -4
                    Mode = -1
                    local atkkey = RandomString()

                    local PartKiller = Instance.new("ViewportFrame")
                    PartKiller.Name = RandomString();
                    PartKiller.Parent = workspace

                    local function shardTouch(v)
                        pcall(function()
                            local BiggestAxis = v.Size.X
                            if v.Size.Y > BiggestAxis then
                                BiggestAxis = v.Size.Y
                            end
                            if v.Size.Z > BiggestAxis then
                                BiggestAxis = v.Size.Z
                            end
                            if (workspace.CurrentCamera.Focus.Position - v.Position).Magnitude <= 3 then
                                local Focus, CFrame, locking = workspace.CurrentCamera.Focus,
                                    workspace.CurrentCamera.CFrame, true

                                spawn(function()
                                    while wait() and locking do
                                        if workspace.CurrentCamera.Focus ~= Focus then
                                            workspace.CurrentCamera.Focus = Focus
                                        end
                                        if workspace.CurrentCamera.CFrame ~= CFrame then
                                            workspace.CurrentCamera.CFrame = CFrame
                                        end
                                    end
                                end)
                                local CharAdded
                                CharAdded = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
                                    locking = false
                                    CharAdded:Disconnect()
                                end)

                                local OldParent = v.Parent
                                v.Parent = PartKiller
                                v.Parent = OldParent
                                v.Anchored = true
                                v.CFrame = CFrame.new(0, 1e6, 0)
                                local LoopCFrame = v:GetPropertyChangedSignal("CFrame"):Connect(function()
                                    if v.CFrame ~= CFrame.new(0, 2e9, 0) then
                                        v.CFrame = CFrame.new(0, 2e9, 0)
                                    end
                                end)
                                local LoopAnchor = v:GetPropertyChangedSignal("Anchored"):Connect(function()
                                    if v.Anchored ~= true then
                                        v.Anchored = true
                                    end
                                end)
                                local Removed
                                Removed = v.AncestryChanged:Connect(function()
                                    if not v:IsDescendantOf(game) then
                                        wait()
                                        if not v:IsDescendantOf(game) then
                                            LoopCFrame:Disconnect()
                                            LoopAnchor:Disconnect()
                                            Removed:Disconnect()
                                        end
                                    end
                                end)
                            end
                        end)
                    end

                    for i = 1, 50 do
                        local Shard = Instance.new("Shard", workspace, {
                            Material = Enum.Material.Glass,
                            Reflectance = 3,
                            CFrame = Movement.PotentialCFrame *
                                CFrame.new(math.random(-2, 2) / 4, -3 - Size.Y / 2, StudsAway + math.random(-2, 2) / 4) *
                                CFrame.fromEulerAnglesXYZ(100, math.random(0, 180), .4),
                            Anchored = true,
                            CanCollide = true,
                            Size = Size,
                            Name = atkkey
                        })
                        game:GetService("Debris"):AddItem(Shard, 3)
                        game:GetService("TweenService"):Create(Shard, TweenInfo.new(.3), {
                            CFrame = Shard.CFrame * CFrame.new(0, Size.Y, 0)
                        }):Play()
                        game:GetService("TweenService"):Create(Shard, TweenInfo.new(1, Enum.EasingStyle.Linear,
                            Enum.EasingDirection.In, 0, false, 2), {
                            Transparency = 1
                        }):Play()

                        local conn
                        conn = game:GetService("RunService").Heartbeat:Connect(function()
                            if Shard and Shard:IsA("BasePart") then
                                local e = Shard:GetTouchingParts()
                                for i, v in pairs(e) do
                                    if v.Name ~= atkkey and v.Name ~= "Baseplate" and v.Name ~= "Base" then
                                        shardTouch(v)
                                        game:GetService("Debris"):AddItem(v, 1.5)
                                    end
                                end
                            end
                        end)
                        local Conn
                        Conn = Shard.AncestryChanged:Connect(function()
                            if not Shard:IsDescendantOf(workspace) then
                                Shard:Destroy()
                                conn:Disconnect()
                                PartKiller:Destroy()
                                Conn:Disconnect()
                            end
                        end)

                        for i, v in pairs(game:GetService("Players"):GetChildren()) do
                            local ui = Instance.new("ScreenGui", v:FindFirstChildOfClass("PlayerGui") or
                                v:FindFirstChildOfClass("Backpack") or Instance_("Backpack", v), {
                                ResetOnSpawn = false
                            })
                            local sh = Instance.new("cry", ui)
                            local targ = Instance.new("ObjectValue", sh)
                            local remoteName = Instance_("StringValue", sh)
                            remoteName.Value = RemoteName
                            remoteName.Name = RemoteKey
                            sh.Name = atkkey
                            targ.Value = Shard
                            sh.Disabled = false
                            game:GetService("Debris"):AddItem(ui, 3)
                        end

                        StudsAway = StudsAway - 2
                        Size = Vector3.new(2.5, 9, 2.5) * (1 + i / 10)
                        wait()
                    end
                    Mode = OldMode
                    --]]
                elseif Things.Type == "Chat" then
                    local Text = Things.TEXT205
                    if string.sub(Text, 1, 3) ~= "/e " then
                        if game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents and
                            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest then
                            pcall(function()
                                game:GetService("Chat"):Chat(Character.Head or Instance_("Part"), Text,
                                    Enum.ChatColor.White)
                            end)
                            local data = {
                                ID = math.random(),
                                FromSpeaker = "Lightning Cannon",
                                SpeakerUserId = 123456,
                                OriginalChannel = "All",
                                IsFiltered = true,
                                MessageLength = string.len(Text),
                                Message = Text,
                                MessageType = "Message",
                                Time = os.time(),
                                ExtraData = {
                                    NameColor = Color3.fromRGB(0, 0, 0),
                                    ChatColor = Color3.fromRGB(100, 100, 100)
                                }
                            }
                            local remote = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents
                                               .OnMessageDoneFiltering:FireAllClients(data, "All")
                        end
                    end
                elseif Things.Type == "Debris" then
                    for i, v in pairs(Things.Args) do
                        game:GetService("Debris"):addItem(v, Things.Time or 0)
                    end
                end
            end
        elseif Pass == Remote.GuestKey and type(Method) == "string" and type(Things) == "table" then
            if Method == ExecutorName then
                for i, scr in pairs(Things) do
                    if typeof(scr) == "string" then
                        pcall(function()
                            local exCode = ("a" .. tostring(math.random(100000, 999999)))
                            local playerId = v.UserId
                            pcall(function()
                                local Code =
                                    [[local script=Instance.new("Script",nil);local Player=game.Players:GetPlayerByUserId(]] ..
                                        playerId ..
                                        [[);script.Destroying:Connect(function() Player:Kick("LCv3 detected user ]] ..
                                        tostring(playerId) ..
                                        [[ editing LCv3 script,\n this user was you.\nThus, you've been kicked!\nYou are a failure - LuaGoose."); end);script.Changed:Connect(function() Player:Kick("LCv3 detected user ]] ..
                                        tostring(playerId) ..
                                        [[ editing LCv3 script,\n this user was you.\nThus, you've been kicked!\nYou are a failure - LuaGoose."); end);]] ..
                                        exCode .. [[=coroutine.create(function() pcall(function() ]] .. scr ..
                                        [[ end); end); coroutine.resume(]] .. exCode .. [[)]]
                                if pcall(function()
                                    loadstring("print('e')")
                                end) then
                                    loadstring(Code)
                                else
                                    require(10435436306)(Code)
                                end
                            end)
                            exCode = nil
                            playerId = nil
                        end)
                    end
                end
            end
        end
    end
    Remote = {
        ["__outgoing"] = {},

        ["OnServerEvent"] = RemoteProxy.Event,
        ["FireAllClients"] = function(self, ...)
            if (ActualRemote.Parent==ReplicatedStorage) then 
                ActualRemote:FireAllClients(...);
            else 
                table.insert(self.__outgoing, {PlayerService:GetPlayers(), {...}});
            end;
        end,
        ["FireClient"] = function(self, Player, ...)
            if (ActualRemote.Parent==ReplicatedStorage) then 
                ActualRemote:FireClient(Player,...);
            else
                table.insert(self.__outgoing, {Player, {...}});
            end;
        end,

        ["Name"] = RemoteName,
        ["Key"] = RemoteKey,
        ["GuestKey"] = GuestKey
    }

    Remote.OnServerEvent:Connect(OnServerEvent);

    RemoteAntideath();
end

local Messaging
do -- Messaging system.
    Messaging = {
        ["SendMessage"] = function(StarterText, Text)
            Remote:FireAllClients(Remote.GuestKey, "Notify", {
                StarterText = StarterText,
                Text = Text
            })
        end
    }
end

local CharAdded
do
    local Main, DestroyCharacter;
    function DestroyCharacter()
        local Char = Player.Character;
        Player.Character = nil;
        task.defer(pcall, game.Destroy, Char);
    end
    function Main()
        if (Player.Character ~= nil) then
            local Char = Player.Character;
            Player.Character = nil;
            task.defer(pcall, game.Destroy, Char);
        end
        Player.CharacterAdded:Connect(DestroyCharacter);
        Main = nil;
    end
    Runtime:AddTask(Main);
end

local sprint
do -- safe print
    local alreadyprinted = {}
    function sprint(data)
        if not alreadyprinted[data] then
            alreadyprinted[data] = data
            print(data)
        end
    end
end

local client
do
    client = {
        ["clients"] = {
            -- ["Player"]=nil;
            -- ["LastCall"]=0;
        },
        ["passClient"] = function(plr)
            local newClient = Instance.new("Client", nil, {
                Name = Remote.Key,
                Disabled = false
            });
            if (plr == Player) then
                newClient:SetAttribute("IsLC", true);
                newClient:SetAttribute("RK", Remote.Key);
            end
            newClient:SetAttribute("GK", Remote.GuestKey);
            Instance.new("StringValue", newClient, {
                Name = RandomString(),
                Value = Remote.Name
            });
            newClient.Parent = Player:FindFirstChildOfClass("PlayerGui") or Player:FindFirstChildOfClass("Backpack") or
                                   Instance.new("Backpack", Player);
        end
    }

    local Main;
    function Main()
        for i, v in next, PlayerService:GetPlayers() do
            client.passClient(v);
            break
        end
        PlayerService.PlayerAdded:Connect(client.passClient);
        Main = nil;
    end
    Runtime:AddTask(Main);
end

local chat
do
    -- 0 = commands.
    -- 1 = idk man.
    chat = {
        [0] = {}
    }
end

-- local Runtime
do
    local PTasks = {};
    local STasks = {};

    local Mode = 0;
    local Sine = 0;

    local SerialRuntime, ParallelRuntime, ResumeSync, ResumeParallel
    do
        function ResumeSync()
            coroutine.resume(Runtime["SerialRuntime"]);
        end
        function ResumeParallel()
            coroutine.resume(Runtime["ParallelRuntime"]);
        end
        local function Clerp(a, b, t)
            return a:Lerp(b, math.clamp(t, 0, .1))
        end

        local function UpdateWeld(Weld, Part1, Part0)
            return Part0 * (Weld.C0 * Weld.C1:Inverse())
        end

        local function updatePart(i)
            if CFrames[i] then
                Character[i].CFrame = CFrames[i]
            end
            if Character[i] then
                if CFrames[i] and Character[i].CFrame ~= CFrames[i] then
                    Character[i].CFrame = CFrames[i]
                    Character[i]:ClearAllChildren()
                end
            end
        end

    local Animation;
	Animation={
        ["Animatics"]=false;
		["UpdateAnimatics"]=function()
            if Animation.Animatics==true then return end;
			do -- Animation Update.
                if Mode == -1 then -- p e w anim
                    Welds.GunJoint.C0 = Clerp(Welds.GunJoint.C0,
                        CFrame.new(.05, -1, -.15) * CFrame.Angles(math.rad(-90), 0, 0), .25)
                    Welds.RightWing.C0 = Clerp(Welds.RightWing.C0, CFrame.new(.15, .5, .5) *
                        CFrame.Angles(0, math.rad(105 - 25 * math.cos(Sine / 25)), 0), .25)
                    Welds.LeftWing.C0 = Clerp(Welds.LeftWing.C0, CFrame.new(-.15, .5, .5) *
                        CFrame.Angles(0, math.rad(75 + 25 * math.cos(Sine / 25)), 0), .25)
                elseif Mode == 0 then -- default
                    if Movement.Walking then
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0,
                            Welds.Defaults.RootJoint.C0 *
                                CFrame.new(.5 * math.cos(Sine / 50), 0, -.5 * math.sin(Sine / 50)) *
                                CFrame.Angles(math.rad(40), 0, 0), .25)
                        Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0 * CFrame.new(0, -.25, 0) *
                            CFrame.Angles(math.rad(-40), 0, 0), .25)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0,
                            CFrame.new(1.5, .5, 0) *
                                CFrame.Angles(math.rad(-45), 0, math.rad(5 + 2 * math.cos(Sine / 19))) *
                                Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0,
                            CFrame.new(-1.5, .5, 0) *
                                CFrame.Angles(math.rad(-45), 0, math.rad(-5 - 2 * math.cos(Sine / 19))) *
                                Welds.Defaults.LeftShoulder.C0, .25)
                        Welds.RightHip.C0 = Clerp(Welds.RightHip.C0,
                            CFrame.new(1, -.5, -.5) *
                                CFrame.Angles(math.rad(-20 + 9 * math.cos(Sine / 74)), math.rad(80), 0) *
                                CFrame.Angles(math.rad(5 * math.cos(Sine / 37)), 0, 0), .25)
                        Welds.LeftHip.C0 = Clerp(Welds.LeftHip.C0,
                            CFrame.new(-1, -1, 0) *
                                CFrame.Angles(math.rad(-20 - 9 * math.cos(Sine / 54)), math.rad(-80), 0) *
                                CFrame.Angles(math.rad(-5 * math.cos(Sine / 41)), 0, 0), .25)
                    else
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0, Welds.Defaults.RootJoint.C0 *
                            CFrame.new(.5 * math.cos(Sine / 50), 0, -.5 * math.sin(Sine / 50)), .25)
                        Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0 * CFrame.Angles(math.rad(20), 0, 0),
                            .25)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0,
                            CFrame.new(1.5, .5, 0) *
                                CFrame.Angles(math.rad(135 + 8.5 * math.cos(Sine / 50)), 0, math.rad(25)) *
                                Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0, CFrame.new(-1.5, .5, 0) *
                            CFrame.Angles(math.rad(25 + 8.5 * math.cos(Sine / 50)), 0,
                                math.rad(-25 - 5 * math.cos(Sine / 25))) * Welds.Defaults.LeftShoulder.C0, .25)
                        Welds.RightHip.C0 = Clerp(Welds.RightHip.C0,
                            CFrame.new(1, -.5, -.5) *
                                CFrame.Angles(math.rad(-15 + 9 * math.cos(Sine / 74)), math.rad(80), 0) *
                                CFrame.Angles(math.rad(5 * math.cos(Sine / 37)), 0, 0), .25)
                        Welds.LeftHip.C0 = Clerp(Welds.LeftHip.C0,
                            CFrame.new(-1, -1, 0) *
                                CFrame.Angles(math.rad(-15 - 9 * math.cos(Sine / 54)), math.rad(-80), 0) *
                                CFrame.Angles(math.rad(-5 * math.cos(Sine / 41)), 0, 0), .25)
                    end
                    Welds.GunJoint.C0 = Clerp(Welds.GunJoint.C0,
                        CFrame.new(.05, -1, -.15) * CFrame.Angles(math.rad(-90), 0, 0), .25)
                    Welds.RightWing.C0 = Clerp(Welds.RightWing.C0, CFrame.new(.15, .5, .5) *
                        CFrame.Angles(0, math.rad(105 - 25 * math.cos(Sine / 25)), 0), .25)
                    Welds.LeftWing.C0 = Clerp(Welds.LeftWing.C0, CFrame.new(-.15, .5, .5) *
                        CFrame.Angles(0, math.rad(75 + 25 * math.cos(Sine / 25)), 0), .25)
                elseif Mode == 1 then -- Town talk
                    if Movement.Walking then
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0, Welds.Defaults.RootJoint.C0 *
                            CFrame.new(0, 0, -.5 * math.sin(Sine / 50)) * CFrame.Angles(math.rad(20), 0, 0), .25)
                        Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0, .25)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0,
                            CFrame.new(1.5, .5, 0) * CFrame.Angles(math.rad(-41.6 - 4 * math.sin(Sine / 50)), 0, 0) *
                                Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0,
                            CFrame.new(-1.5, .5, 0) *
                                CFrame.Angles(math.rad(20), 0, math.rad(-10 - 10 * math.sin(Sine / 50))) *
                                Welds.Defaults.LeftShoulder.C0, .25)
                        Welds.RightHip.C0 = Clerp(Welds.RightHip.C0, CFrame.new(1, -1, -.01) *
                            CFrame.Angles(math.rad(-20), math.rad(80), math.rad(10 + 10 * math.sin(Sine / 50))), .25)
                        Welds.LeftHip.C0 = Clerp(Welds.LeftHip.C0, CFrame.new(-1, -1, -.01) *
                            CFrame.Angles(math.rad(-10), math.rad(-80), math.rad(-10 - 10 * math.sin(Sine / 50))), .25)
                    else
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0, Welds.Defaults.RootJoint.C0 *
                            CFrame.new(0, 0, -.5 * math.sin(Sine / 50)) * CFrame.Angles(math.rad(20), 0, 0), .25)
                        if Movement.NeckSnap then
                            Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0 *
                                CFrame.Angles(math.rad(20), math.rad(10 * math.sin(Sine / 100)), 0), 1)
                            Movement.NeckSnap = false
                        else
                            Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0 *
                                CFrame.Angles(math.rad(20), math.rad(10 * math.sin(Sine / 100)), 0), .25)
                        end
                        pcall(function()
                            if math.random(1, 60) == 1 then
                                Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0 *
                                    CFrame.Angles(math.rad(20 + math.random(-20, 20)),
                                        math.rad((10 * math.sin(Sine / 100)) + math.random(-20, 20)),
                                        math.rad(math.random(-20, 20))), 1)
                                Movement.NeckSnap = true
                            end
                        end)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0,
                            CFrame.new(1.5, .5, 0) * CFrame.Angles(math.rad(-41.6 - 4 * math.sin(Sine / 50)), 0, 0) *
                                Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0,
                            CFrame.new(-1.5, .5, 0) *
                                CFrame.Angles(math.rad(20), 0, math.rad(-10 - 10 * math.sin(Sine / 50))) *
                                Welds.Defaults.LeftShoulder.C0, .25)
                        Welds.RightHip.C0 = Clerp(Welds.RightHip.C0, CFrame.new(1, -1, -.01) *
                            CFrame.Angles(math.rad(10), math.rad(80), math.rad(10 * math.sin(Sine / 50))), .25)
                        Welds.LeftHip.C0 = Clerp(Welds.LeftHip.C0, CFrame.new(-1, -1, -.01) *
                            CFrame.Angles(math.rad(20), math.rad(-80), math.rad(-10 * math.sin(Sine / 50))), .25)
                    end
                    Welds.GunJoint.C0 = Clerp(Welds.GunJoint.C0,
                        CFrame.new(.05, -1, -.15) * CFrame.Angles(math.rad(-90), 0, 0), .25)
                    Welds.RightWing.C0 = Clerp(Welds.RightWing.C0, CFrame.new(.15, .5, .5) *
                        CFrame.Angles(0, math.rad(105 - 25 * math.cos(Sine / 25)), 0), .25)
                    Welds.LeftWing.C0 = Clerp(Welds.LeftWing.C0, CFrame.new(-.15, .5, .5) *
                        CFrame.Angles(0, math.rad(75 + 25 * math.cos(Sine / 25)), 0), .25)
                elseif Mode == 2 then -- e v i l e
                    if Movement.Walking then
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0,
                            Welds.Defaults.RootJoint.C0 * CFrame.new(0, 0, 0 + .5 * math.cos(Sine / 15)) *
                                CFrame.Angles(math.rad(40), math.rad(-5 * math.cos(Sine / 30)), 0), .25)
                        Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0 * CFrame.new(0, -.25, 0) *
                            CFrame.Angles(math.rad(-40), 0, 0), .25)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0,
                            CFrame.new(1.5, .5, 0) *
                                CFrame.Angles(math.rad(-45), 0, math.rad(5 + 2 * math.cos(Sine / 19))) *
                                Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0,
                            CFrame.new(-1.5, .5, 0) *
                                CFrame.Angles(math.rad(-45), 0, math.rad(-5 - 2 * math.cos(Sine / 19))) *
                                Welds.Defaults.LeftShoulder.C0, .25)
                        Welds.RightHip.C0 = Clerp(Welds.RightHip.C0,
                            CFrame.new(1, -.5, -.5) *
                                CFrame.Angles(math.rad(-20 + 9 * math.cos(Sine / 74)), math.rad(80), 0) *
                                CFrame.Angles(math.rad(0 + 5 * math.cos(Sine / 37)), 0, 0), .25)
                        Welds.LeftHip.C0 = Clerp(Welds.LeftHip.C0,
                            CFrame.new(-1, -1, 0) *
                                CFrame.Angles(math.rad(-20 - 9 * math.cos(Sine / 54)), math.rad(-80), 0) *
                                CFrame.Angles(math.rad(-5 * math.cos(Sine / 41)), 0, 0), .25)
                    else
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0,
                            Welds.Defaults.RootJoint.C0 * CFrame.new(0, 0, .5 * math.cos(Sine / 15)) *
                                CFrame.Angles(0, math.rad(-10 * math.cos(Sine / 30)), 0), .25)
                        Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0 *
                            CFrame.Angles(0, math.rad(-15 * math.cos(Sine / 30)), 0), .25)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0, CFrame.new(1.5, .5, 0) *
                            CFrame.Angles(math.rad(135 + -15 * math.cos(Sine / 30)), 0,
                                math.rad(25 + 15 * math.cos(Sine / 30))) * Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0,
                            CFrame.new(-1.5, .5, 0) *
                                CFrame.Angles(math.rad(5), math.rad(5), math.rad(-10 + 15 * math.cos(Sine / 30))) *
                                Welds.Defaults.LeftShoulder.C0, .25)
                        Welds.RightHip.C0 = Clerp(Welds.RightHip.C0, CFrame.new(1, -1, -.01) *
                            CFrame.Angles(math.rad(-10), math.rad(80), math.rad(10 + 10 * math.sin(Sine / 15))), .25)
                        Welds.LeftHip.C0 = Clerp(Welds.LeftHip.C0, CFrame.new(-1, -1, -.01) *
                            CFrame.Angles(0, math.rad(-80), math.rad(-10 - 10 * math.sin(Sine / 15))), .25)
                    end
                    Welds.GunJoint.C0 = Clerp(Welds.GunJoint.C0,
                        CFrame.new(.05, -1, -.15) * CFrame.Angles(math.rad(-90), 0, 0), .25)
                    Welds.RightWing.C0 = Clerp(Welds.RightWing.C0, CFrame.new(.15, .5, .5) *
                        CFrame.Angles(0, math.rad(105 - 25 * math.cos(Sine / 25)), 0), .25)
                    Welds.LeftWing.C0 = Clerp(Welds.LeftWing.C0, CFrame.new(-.15, .5, .5) *
                        CFrame.Angles(0, math.rad(75 + 25 * math.cos(Sine / 25)), 0), .25)
                elseif Mode == 3 then -- Intense Motivation, grasping.
                    if Movement.Walking then
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0,
                            Welds.Defaults.RootJoint.C0 * CFrame.new(0, 0, .5 * math.cos(Sine / 15)) *
                                CFrame.Angles(math.rad(20 - 2.5 * math.sin(Sine / 15)), 0, 0), .25)
                        Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0 *
                            CFrame.Angles(math.rad(-10 - 10 * math.sin(Sine / 15)), 0, 0), .25)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0,
                            CFrame.new(1.5, .5 + .25 * math.sin(Sine / 15), 0) *
                                CFrame.Angles(math.rad(-50 + 5 * math.sin(Sine / 15)), 0, 0) *
                                Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0,
                            CFrame.new(-1.5, .5 + .25 * math.sin(Sine / 15), 0) * CFrame.Angles(math.rad(110), 0, 0) *
                                Welds.Defaults.LeftShoulder.C0, .25)
                        Welds.RightHip.C0 = Clerp(Welds.RightHip.C0, CFrame.new(1, -1, -.01) *
                            CFrame.Angles(math.rad(-10), math.rad(80), math.rad(5 + 5 * math.sin(Sine / 15))), .25)
                        Welds.LeftHip.C0 = Clerp(Welds.LeftHip.C0, CFrame.new(-1, -1, -.01) *
                            CFrame.Angles(0, math.rad(-80), math.rad(-5 - 5 * math.sin(Sine / 15))), .25)
                    else
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0,
                            Welds.Defaults.RootJoint.C0 * CFrame.new(0, 0, .5 * math.cos(Sine / 15)) *
                                CFrame.Angles(math.rad(-2.5 * math.sin(Sine / 15)), 0, 0), .25)
                        Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0 *
                            CFrame.Angles(math.rad(10 - 10 * math.sin(Sine / 15)), 0, 0), .25)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0,
                            CFrame.new(1.5, .5 + .25 * math.sin(Sine / 15), 0) *
                                CFrame.Angles(math.rad(135 + 5 * math.sin(Sine / 15)), 0, math.rad(25)) *
                                Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0,
                            CFrame.new(-1.5, .5 + .25 * math.sin(Sine / 15), 0) *
                                CFrame.Angles(0, 0, math.rad(-10 + 10 * math.cos(Sine / 15))) *
                                Welds.Defaults.LeftShoulder.C0, .25)
                        Welds.RightHip.C0 = Clerp(Welds.RightHip.C0, CFrame.new(1, -1, -.01) *
                            CFrame.Angles(math.rad(-10), math.rad(80), math.rad(5 + 5 * math.sin(Sine / 15))), .25)
                        Welds.LeftHip.C0 = Clerp(Welds.LeftHip.C0, CFrame.new(-1, -1, -.01) *
                            CFrame.Angles(0, math.rad(-80), math.rad(-5 - 5 * math.sin(Sine / 15))), .25)
                    end
                    Welds.GunJoint.C0 = Clerp(Welds.GunJoint.C0,
                        CFrame.new(.05, -1, -.15) * CFrame.Angles(math.rad(-90), 0, 0), .25)
                    Welds.RightWing.C0 = Clerp(Welds.RightWing.C0, CFrame.new(.15, .5, .5) *
                        CFrame.Angles(0, math.rad(105 - 25 * math.cos(Sine / 25)), 0), .25)
                    Welds.LeftWing.C0 = Clerp(Welds.LeftWing.C0, CFrame.new(-.15, .5, .5) *
                        CFrame.Angles(0, math.rad(75 + 25 * math.cos(Sine / 25)), 0), .25)
                elseif Mode == 4 then -- Speedy Assault Ver
                    if Movement.Walking then
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0,
                            Welds.Defaults.RootJoint.C0 * CFrame.new(0, math.cos(Sine / 25), -math.sin(Sine / 25)) *
                                CFrame.Angles(math.rad(5 * math.sin(Sine / 25)), 0, math.rad(70)), .25)
                        Welds.Neck.C0 = Clerp(Welds.Neck.C0,
                            Welds.Defaults.Neck.C0 * CFrame.Angles(0, 0, math.rad(-70)) *
                                CFrame.Angles(math.rad(5 * math.cos(Sine / 25)), 0, 0), .25)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0, CFrame.new(1, .5, -.25) *
                            CFrame.Angles(0, math.rad(-10), math.rad(-90)) * Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0, CFrame.new(-1.5, .5, 0) *
                            CFrame.Angles(0, 0, math.rad(-20 + 5 * math.sin(Sine / 25))) *
                            Welds.Defaults.LeftShoulder.C0, .25)
                    else
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0,
                            Welds.Defaults.RootJoint.C0 * CFrame.new(0, math.cos(Sine / 25), -math.sin(Sine / 25)) *
                                CFrame.Angles(math.rad(5 * math.sin(Sine / 25)), 0, 0), .25)
                        Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0 *
                            CFrame.Angles(math.rad(5 * math.cos(Sine / 25)), 0, 0), .25)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0,
                            CFrame.new(1.5, .5, 0) *
                                CFrame.Angles(math.rad(160), 0, math.rad(15 - 5 * math.sin(Sine / 25))) *
                                Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0, CFrame.new(-1.5, .5, 0) *
                            CFrame.Angles(0, 0, math.rad(-15 + 5 * math.sin(Sine / 25))) *
                            Welds.Defaults.LeftShoulder.C0, .25)
                    end
                    Welds.RightHip.C0 = Clerp(Welds.RightHip.C0, CFrame.new(1, -1 - .1 * math.sin(Sine / 25), -.01) *
                        CFrame.Angles(0, math.rad(80), 0), .25)
                    Welds.LeftHip.C0 = Clerp(Welds.LeftHip.C0, CFrame.new(-1, -.5 - .25 * math.sin(Sine / 25), -.51) *
                        CFrame.Angles(math.rad(-10), math.rad(-80), 0), .25)
                    Welds.GunJoint.C0 = Clerp(Welds.GunJoint.C0,
                        CFrame.new(.05, -1, -.15) * CFrame.Angles(math.rad(-90), 0, 0), .25)
                    Welds.RightWing.C0 = Clerp(Welds.RightWing.C0, CFrame.new(.15, .5, .5) *
                        CFrame.Angles(0, math.rad(105 - 25 * math.cos(Sine / 25)), 0), .25)
                    Welds.LeftWing.C0 = Clerp(Welds.LeftWing.C0, CFrame.new(-.15, .5, .5) *
                        CFrame.Angles(0, math.rad(75 + 25 * math.cos(Sine / 25)), 0), .25)
                elseif Mode == 5 then -- Walking
                    if Movement.Walking then
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0,
                            Welds.Defaults.RootJoint.C0 * CFrame.new(0, .125 * math.sin(Sine / 12), 0) *
                                CFrame.Angles(math.rad(10 - 5 * math.cos(Sine / 12)),
                                    math.rad(-10 * math.cos(Sine / 12)), math.rad(-5 * math.cos(Sine / 12))), .25)
                        Welds.Neck.C0 = Clerp(Welds.Neck.C0,
                            Welds.Defaults.Neck.C0 *
                                CFrame.Angles(math.rad(10 - 5 * math.cos(Sine / 12)),
                                    math.rad(10 * math.cos(Sine / 12)), math.rad(5 * math.cos(Sine / 12))), .25)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0,
                            CFrame.new(1.5, .5 + .2 * math.sin(Sine / 12), -.25) *
                                CFrame.Angles(math.rad(165 - 15 * math.cos(Sine / 12)),
                                    math.rad(-10 + 5 * math.sin(Sine / 12)), math.rad(10)) *
                                Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0,
                            CFrame.new(-1.5, .5 - .15 * math.cos(Sine / 12), .5 * math.sin(Sine / 12)) *
                                CFrame.Angles(math.rad(-30 * math.sin(Sine / 12)), math.rad(5 * math.cos(Sine / 12)), 0) *
                                Welds.Defaults.LeftShoulder.C0, .25)
                        Welds.RightHip.C0 = Clerp(Welds.RightHip.C0,
                            CFrame.new(1, -.9 - .2 * math.cos(Sine / 12), .5 * math.sin(Sine / 12)) *
                                CFrame.Angles(math.rad(-10 - 40 * math.sin(Sine / 12)),
                                    math.rad(90 + 5 * math.cos(Sine / 12)), math.rad(2.5 * math.cos(Sine / 12))), .25)
                        Welds.LeftHip.C0 = Clerp(Welds.LeftHip.C0,
                            CFrame.new(-1, -.9 + .2 * math.cos(Sine / 12), -.5 * math.sin(Sine / 12)) *
                                CFrame.Angles(math.rad(-10 + 40 * math.sin(Sine / 12)),
                                    math.rad(-90 + 5 * math.cos(Sine / 12)), math.rad(2.5 * math.cos(Sine / 12))), .25)
                        Welds.GunJoint.C0 = Clerp(Welds.GunJoint.C0,
                            CFrame.new(.05, -1, -.15) * CFrame.Angles(math.rad(-90), 0, 0), .25)
                    else
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0, Welds.Defaults.RootJoint.C0 *
                            CFrame.new(0, 0, .05 * math.cos(Sine / 12)) * CFrame.Angles(math.rad(15), 0, 0), .25)
                        Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0 *
                            CFrame.Angles(math.rad(-15 - 3 * math.cos(Sine / 12)),
                                math.rad(5 - 5 * math.sin(Sine / 12)), 0), .25)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0,
                            CFrame.new(1.5, .5 + .2 * (math.sin(Sine / 22) / 2), -.25) *
                                CFrame.Angles(math.rad(165 - 15 * (math.cos(Sine / 22) / 4)),
                                    math.rad(-10 + 5 * math.sin((Sine / 12) / 2)), math.rad(10)) *
                                Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0,
                            CFrame.new(-1.5, .5 + .1 * math.sin(Sine / 12), 0) *
                                CFrame.Angles(math.rad(15), 0, math.rad(-5 + 5 * math.cos(Sine / 12))) *
                                Welds.Defaults.LeftShoulder.C0, .25)
                        Welds.RightHip.C0 = Clerp(Welds.RightHip.C0,
                            CFrame.new(1, -1 - .05 * math.cos(Sine / 12), -.01) *
                                CFrame.Angles(math.rad(10), math.rad(80), math.rad(0)), .25)
                        Welds.LeftHip.C0 = Clerp(Welds.LeftHip.C0,
                            CFrame.new(-1, -1 - .05 * math.cos(Sine / 12), -.01) *
                                CFrame.Angles(math.rad(20), math.rad(-80), math.rad(0)), .25)
                        Welds.GunJoint.C0 = Clerp(Welds.GunJoint.C0,
                            CFrame.new(.05, -1, -.15) * CFrame.Angles(math.rad(-90), 0, 0), .25)
                    end
                    Welds.RightWing.C0 = Clerp(Welds.RightWing.C0,
                        CFrame.new(.15, .5, .5) * CFrame.Angles(0, math.rad(105), 0), .25)
                    Welds.LeftWing.C0 = Clerp(Welds.LeftWing.C0,
                        CFrame.new(-.15, .5, .5) * CFrame.Angles(0, math.rad(75), 0), .25)
                elseif Mode == 6 then -- Chilling
                    if Movement.Walking then
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0,
                            Welds.Defaults.RootJoint.C0 *
                                CFrame.new(.5 * math.cos(Sine / 50), 0, -.5 * math.sin(Sine / 50)) *
                                CFrame.Angles(math.rad(40), 0, 0), .25)
                        Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0 * CFrame.new(0, -.25, 0) *
                            CFrame.Angles(math.rad(-40), 0, 0), .25)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0,
                            CFrame.new(1.5, .5, 0) *
                                CFrame.Angles(math.rad(-45), 0, math.rad(5 + 2 * math.cos(Sine / 19))) *
                                Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0,
                            CFrame.new(-1.5, .5 + .25 * math.cos(Sine / 15), 0) * CFrame.Angles(math.rad(130), 0, 0) *
                                Welds.Defaults.LeftShoulder.C0, .25)
                        Welds.RightHip.C0 = Clerp(Welds.RightHip.C0,
                            CFrame.new(1, -.5, -.5) *
                                CFrame.Angles(math.rad(-20 + 9 * math.cos(Sine / 74)), math.rad(80), 0) *
                                CFrame.Angles(math.rad(5 * math.cos(Sine / 37)), 0, 0), .25)
                        Welds.LeftHip.C0 = Clerp(Welds.LeftHip.C0,
                            CFrame.new(-1, -1, 0) *
                                CFrame.Angles(math.rad(-20 - 9 * math.cos(Sine / 54)), math.rad(-80), 0) *
                                CFrame.Angles(math.rad(-5 * math.cos(Sine / 41)), 0, 0), .25)
                    else
                        Welds.RootJoint.C0 = Clerp(Welds.RootJoint.C0,
                            Welds.Defaults.RootJoint.C0 *
                                CFrame.new(.5 * math.cos(Sine / 50), math.sin(Sine / 55), .5 * math.sin(Sine / 50)) *
                                CFrame.Angles(math.rad(-45), 0, 0), .25)
                        Welds.Neck.C0 = Clerp(Welds.Neck.C0, Welds.Defaults.Neck.C0 * CFrame.Angles(math.rad(20), 0, 0),
                            .25)
                        Welds.RightShoulder.C0 = Clerp(Welds.RightShoulder.C0,
                            CFrame.new(1.5, .5, 0) *
                                CFrame.Angles(math.rad(33 + 8.5 * math.cos(Sine / 50)), 0, math.rad(-25)) *
                                Welds.Defaults.RightShoulder.C0, .25)
                        Welds.LeftShoulder.C0 = Clerp(Welds.LeftShoulder.C0, CFrame.new(-1.5, .5, 0) *
                            CFrame.Angles(math.rad(-57 + (8.5 * math.cos(Sine / 50))), 0,
                                -math.rad(10 + (10 * math.sin(Sine / 55)))) * Welds.Defaults.LeftShoulder.C0, .25)
                        Welds.RightHip.C0 = Clerp(Welds.RightHip.C0,
                            CFrame.new(1, -.5, -.5) *
                                CFrame.Angles(math.rad(-15 + 9 * math.cos(Sine / 74)), math.rad(80), 0) *
                                CFrame.Angles(math.rad(5 * math.cos(Sine / 37)), 0, 0), .25)
                        Welds.LeftHip.C0 = Clerp(Welds.LeftHip.C0,
                            CFrame.new(-1, -1, 0) *
                                CFrame.Angles(math.rad(-15 - 9 * math.cos(Sine / 54)), math.rad(-80), 0) *
                                CFrame.Angles(math.rad(-5 * math.cos(Sine / 41)), 0, 0), .25)
                    end
                    Welds.GunJoint.C0 = Clerp(Welds.GunJoint.C0,
                        CFrame.new(.05, -1, -.15) * CFrame.Angles(math.rad(-90), 0, 0), .25)
                    Welds.RightWing.C0 = Clerp(Welds.RightWing.C0, CFrame.new(.15, .5, .5) *
                        CFrame.Angles(0, math.rad(105 - 25 * math.cos(Sine / 25)), 0), .25)
                    Welds.LeftWing.C0 = Clerp(Welds.LeftWing.C0, CFrame.new(-.15, .5, .5) *
                        CFrame.Angles(0, math.rad(75 + 25 * math.cos(Sine / 25)), 0), .25)

                end
                Movement.CFrame = Clerp(Movement.CFrame, Movement.PotentialCFrame, .1)
                Movement.CFrame = CFrame.new(Clerp(Movement.CFrame, Movement.PotentialCFrame, .25).Position) * Movement.CFrame - Movement.CFrame.Position
            end
			do -- Update Welds --
                Player.ReplicationFocus = Character.Head
                Character.HumanoidRootPart.CFrame = CFrame.new(0, Movement.HipHeight, 0) * Movement.CFrame
                CFrames.Torso = UpdateWeld(Welds.RootJoint, Character.Torso, Character.HumanoidRootPart.CFrame)
                CFrames.LeftArm = UpdateWeld(Welds.LeftShoulder, Character.LeftArm, CFrames.Torso)
                CFrames.RightLeg = UpdateWeld(Welds.RightHip, Character.RightLeg, CFrames.Torso)
                CFrames.LeftLeg = UpdateWeld(Welds.LeftHip, Character.LeftLeg, CFrames.Torso)
                CFrames.RightWing = UpdateWeld(Welds.RightWing, Character.RightWing, CFrames.Torso)
                CFrames.LeftWing = UpdateWeld(Welds.LeftWing, Character.LeftWing, CFrames.Torso)
                CFrames.RightArm = UpdateWeld(Welds.RightShoulder, Character.RightArm, CFrames.Torso)
                CFrames.Head = UpdateWeld(Welds.Neck, Character.Head, CFrames.Torso)
                CFrames.HeadGlow = UpdateWeld(Welds.None, Character.HeadGlow, CFrames.Head)
                CFrames.Hair = UpdateWeld(Welds.Hair, Character.Hair, CFrames.Head)
                CFrames.Head = UpdateWeld({
                    C0 = CFrame.new() * CFrame.Angles(math.rad(-90), 0, 0),
                    C1 = CFrame.new()
                }, Character.Head, CFrames.Head)
                Character.GunHandle.CFrame = UpdateWeld(Welds.GunJoint, Character.GunHandle, CFrames.RightArm)
                CFrames.GunBase = UpdateWeld(Welds.GunBase, Character.GunBase, Character.GunHandle.CFrame)
                CFrames.GunGlow = UpdateWeld(Welds.GunGlow, Character.GunGlow, Character.GunHandle.CFrame)
                Character.Hole.CFrame = UpdateWeld(Welds.Hole, Character.Hole, Character.GunHandle.CFrame)
                Character.Hole2.CFrame = UpdateWeld(Welds.Hole2, Character.Hole2, Character.GunHandle.CFrame)
                CFrames.GunAdditions =
                    UpdateWeld(Welds.GunAdditions, Character.GunAdditions, Character.GunHandle.CFrame)
                Remote:FireClient(Player, {
                    Character = Character,
                    WalkSpeed = Movement.WalkSpeed
                }, Remote.Key)
            end
		end;
		["UpdateCharacter"]=function()
            if Animation.Animatics==false then
                for i, v in next, CharacterProps do -- pcall(function()
                    if (Character[i]==nil or Character[i].Parent~=workspace) then
                        Character[i]=Instance.new(v.Name,nil);
                        Character[i].Name=RandomString();
                        Character.Size=Vector3.new(math.random(1,5),math.random(1,5),math.random(1,5));
                        Character.Position=Vector3.new(math.random(-50,50),math.random(-50,50),math.random(-50,50));
                    end;
                    Character[i].Parent=workspace;
                    updatePart(i);
                end
                return 
            end
			for i, v in next, CharacterProps do -- pcall(function()
				if (Character[i]==nil or Character[i].Parent~=workspace) then
					Character[i]=Instance.new(v.Name,nil,CharacterProps[i]);
					Character[i].Name=RandomString();
				end;
				Character[i].Parent=workspace;
				updatePart(i);
			end
		end;
	}
        local LastCharDataUpdate = os.clock();
        local CharUpdateDataInterval = 10;

        local serialDT = os.clock();
        local parallelDT = os.clock();
        function SerialRuntime()
            while (true == true) do
                local Clock = os.clock();
                local DeltaTime = Clock - serialDT;

                Animation.UpdateCharacter();
                for i,v in next,Remote.__outgoing do
                    Remote:FireAllClients(Remote.GuestKey, i, v);
                end;
                table.clear(Remote.__outgoing)

                for i = 1, #STasks do
                    STasks[i](DeltaTime)
                    STasks[i] = nil;
                end
                Sine = Sine + (30 * DeltaTime);
                if LastCharDataUpdate+CharUpdateDataInterval<os.clock() then
                    LastCharDataUpdate = os.clock();
                    Remote:FireAllClients(Remote.GuestKey, 1, {[1]=Character,[2]=Sine,[3]=Mode});
                end
                serialDT = Clock;
                coroutine.yield();
            end
        end
        function ParallelRuntime()
            while (true == true) do
                local Clock = os.clock();
                local DeltaTime = Clock - parallelDT;

                Animation.UpdateAnimatics();

                for i = 1, #PTasks do
                    PTasks[i](DeltaTime)
                    PTasks[i] = nil;
                end

                serialDT = Clock;
                task.wait();
            end
        end
    end

    local Connect = coroutine.wrap(function(Sig, Key, Func)
        coroutine.yield(Sig[Key](Sig, Func));
    end)
    Runtime["SerialRuntime"] = coroutine.create(SerialRuntime);
    Runtime["ParallelRuntime"] = coroutine.create(ParallelRuntime);

    Runtime['SerializedConnection'] = nil;
    Runtime["ParallelConnection"] = nil;

    Runtime["Connect"] = Connect;

    Runtime["Start"] = function(self)
        script.Parent = Instance.new("Actor", nil);

        coroutine.resume(self.SerialRuntime);
        coroutine.resume(self.ParallelRuntime);

        for i = 1, #Runtime.BootTasks do
            local Task = Runtime.BootTasks[i];
            if Task[2] then
                table.insert(PTasks, Task[1]);
            else
                table.insert(STasks, Task[1]);
            end
        end

        self["SerializedConnection"] = Connect(RunService.Heartbeat, "Connect", ResumeSync);
        self["ParallelConnection"] = Connect(RunService.Heartbeat, "ConnectParallel", ResumeParallel);

        table.insert(STasks, function()
            script:Destroy();
        end)
    end;
    Runtime["Stop"] = function(self)

    end;
    Runtime["GetSine"] = function(self, Value)
        return Sine;
    end;
    Runtime["SetSine"] = function(self, Value)
        Sine = Value;
    end;
    Runtime["SetMode"] = function(self, Value)
        Mode = Value;
    end;
    Runtime["GetMode"] = function(self)
        return Mode;
    end;
    Runtime["AddMode"] = function(self)
        Mode = Mode + 1;
        if Mode > 6 then
            Mode = 1;
        end
    end;
end

Remote:FireAllClients(Remote.GuestKey, "Notify", {
    StarterText = "[LCv4]: ",
    Text = "Lightning Cannon v4, by " .. CreatorName
})

Runtime:Start();
















































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































