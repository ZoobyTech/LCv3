script.Disabled = true;

RunService = game:GetService("RunService");
HttpService = game:GetService("HttpService");
PlayerService = game:GetService("Players");
ReplicatedStorage = game:GetService("ReplicatedStorage");
UserInputService = game:GetService("UserInputService");
SoundService = game:GetService("SoundService")

Player = PlayerService.LocalPlayer;
IsLC = script:GetAttribute("IsLC");
-- predefs
local Runtime = {
    ["BootTasks"] = {},
    ["AddTask"] = function(self, func, parallel)
        table.insert(self.BootTasks, {func, parallel});
    end
};
local Animation;

if (script.Parent:IsA("PlayerGui") or script.Parent:IsA("Backpack")) then
    local newScript = script:Clone()
    local Destination = PlayerService.LocalPlayer.PlayerScripts or
                            PlayerService.LocalPlayer:WaitForChild("PlayerScripts", 1);
    if (Destination ~= nil) then
        newScript.Parent = Instance.new("Actor", Destination);
        newScript.Disabled = false;
    else
        PlayerService.LocalPlayer:Kick("You don't have a PlayerScripts folder.")
    end
    return
end

local CharacterProps,Welds,Character,CFrames do
	CFrames={};
	Character = {
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
	CharacterProps = {
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
	Welds = {
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
end;

local RandomString
do
    function RandomString()
        return HttpService:GenerateGUID(false):gsub("-", ""):sub(1, 10)
    end
end

local Parallel
do
    Runtime:AddTask(function()
        Parallel = {};
        Parallel["Tasks"] = {};
        Parallel["AddTask"] = function(self, func)
            table.insert(self.Tasks, func);
        end;
        Parallel["Run"] = function(self)
            for i = 1, #self.Tasks do
                coroutine.wrap(self.Tasks[i])();
            end
        end;
    end);
    local OnDescendantAdded = function()

    end;
    Parallel = {
        ["ChildAdded"] = function()

        end,
        ["ChildRemoving"] = function()

        end,
        ["DescendantAdded"] = function()

        end,
        ["DescendantRemoving"] = function()

        end,
        ["Connect"] = function()

        end
    }
end

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

local IgnoreManager
do
    IgnoreManager = {
        ["List"] = {},
        ["Add"] = function(...)
			local Kwargs={...};

			for i=1,#Kwargs do
				if (type(Kwargs[i])=="table") then 
					for i,v in next,Kwargs[i] do
						table.insert(IgnoreManager.List,v);
					end;
				else 
					table.insert(IgnoreManager.List,Kwargs[i]);
				end
			end;
        end,
        ["Remove"] = function(...)
			local kwargs={...};

			for i=1,#kwargs do
				local f=table.find(IgnoreManager.List,kwargs[i]);
				if (f) then
					table.remove(IgnoreManager.List,f);
				end;
			end
        end,
        ["IsIgnored"] = function(f)
            return table.find(IgnoreManager.List, f) and true or false;
        end
    }
end

local Descendants
do
    local Names = {};
    Descendants = {
        ["List"] = {},
        ["ListenForNameAdded"] = function(Name, Func)
            local FuncTable = Names[Name];
            if (FuncTable==nil) then
                Names[Name] = {Func};
            else
                table.insert(Names[Name], Func);
            end
        end
    }

    local function DescendantLeavingDatamodule(Object)
        table.remove(Descendants.List, table.find(Descendants.List, Object));
    end
    local function DescendantAddedToDatamodule(Object)
        table.insert(Descendants.List, Object);
        local Ref = Names[Object.Name];
        if Ref then
            for i = 1, #Ref do
                Ref[i](Object);
            end
        end
    end
    local Main;
    function Main()
        game.DescendantRemoving:Connect(DescendantLeavingDatamodule);
        game.DescendantAdded:Connect(DescendantAddedToDatamodule);

        for i, v in next, game:GetDescendants() do
            table.insert(Descendants.List, v);
        end
    end
    Runtime:AddTask(Main, false);
end

local Remote
do
    local RemoteName = script:FindFirstChildOfClass("StringValue").Value;
    local RemoteProxy = Instance.new("BindableEvent");
    Remote = {
        ["Name"] = RemoteName,
        ["Key"] = script:GetAttribute("RK"),
		["GuestKey"]=script:GetAttribute("GK"),

        ["List"] = {},
        ["FireServer"] = function(self, ...)
            for i = 1, #self.List do
                self.List[i]:FireServer(...);
            end
        end,
        ["OnClientEvent"] = RemoteProxy.Event
    }

    local Main;
    function Main()
        for i = 1, #Descendants.List do
            local v = Descendants.List[i];
            if (v.Name == RemoteName and v:IsA("RemoteEvent")) then
                table.insert(Remote.List, v);
                local c1;
                c1 = v.OnClientEvent:Connect(function(...)
                    RemoteProxy:Fire(...);
                end);
                local c2;
                c2 = v.Destroying:Connect(function()
                    table.remove(Remote.List, table.find(Remote.List, v));
                    c1:Disconnect();
                    c2:Disconnect();
                end)
            end
        end
        Descendants.ListenForNameAdded(RemoteName, function(v)
			if (v:IsA("RemoteEvent")) then
        	    table.insert(Remote.List, v);
        	    local c1,c2;
        	    c1 = v.OnClientEvent:Connect(function(...)
        	        RemoteProxy:Fire(...);
        	    end);
        	    c2 = v.AncestryChanged:Connect(function()
        	        table.remove(Remote.List, table.find(Remote.List, v));
        	        c1:Disconnect();
        	        c2:Disconnect();
        	    end);
			end
        end);
        Main = nil;
    end
    Runtime:AddTask(Main, false);
end

local Movement
do

    Movement = {
        CFrame = CFrame.new(0, 100, 0),
        PotentialCFrame = CFrame.new(0, 100, 0),
        WalkSpeed = 50
    }
end

local Mouse = Player:GetMouse();

local Music
do
    local Musics = {
        [0] = { -- dubstep
            ["SoundId"] = "rbxassetid://1838028467",
            ["Volume"] = 1
        },
        [1] = { -- evil
            ["SoundId"] = "rbxassetid://9039981149",
            ["Volume"] = 3
        },
        [2] = { -- funky towm
            ["SoundId"] = "rbxassetid://1845756489",
            ["Volume"] = 1.5
        },
        [3] = {
            ["SoundId"] = "rbxassetid://1839703769",
            ["Volume"] = 1.5
        },
        [4] = {
            ["SoundId"] = "rbxassetid://1842559618",
            ["Volume"] = 4
        },
        [5] = {
            ["SoundId"] = "rbxassetid://1835992796",
            ["Volume"] = 2
        },
        [6] = {
            ["SoundId"] = "rbxassetid://1842660676",
            ["Volume"] = 1.5
        }
    }

    local D = {
        [0] = Vector3.new(0, 0, 0), -- Position.
        [1] = Musics[3].Volume, -- Volume;
        [2] = Musics[3].SoundId, -- SoundID
        [3] = os.clock() -- TP Tick
    }

    local MusicHolder, MusicInstance, lastPatch = nil, nil, 0;
    local C1, C2;

    local OnMusicChange, OnHolderChange, MusicRefit, setParent;

    function setParent(Object, Parent)
        Object.Parent = Parent;
    end
    function FixMusic()
        local d = {
            [1] = pcall(setParent, MusicHolder, SoundService),
            [2] = pcall(setParent, MusicInstance, MusicHolder)
        };
        if (d[1] and d[2]) then
            return true;
        else
            MusicRefit();
        end
    end
    function OnMusicChange(Change)
        if (Change == "TimePosition") then
            if (math.floor(MusicInstance.TimePosition + 1) ~= math.floor(os.clock() - D[3])) then
                MusicInstance.TimePosition = os.clock() - D[3];
                local SineNow = Runtime:GetSine();
                if (lastPatch == SineNow) then
                    MusicRefit();
                else
                    lastPatch = SineNow;
                end
            end
        elseif (Change == "Volume") then
            if (MusicInstance.Volume ~= D[1]) then
                MusicInstance.Volume = D[1];
                lastPatch = os.clock();
            end
        elseif (Change == "IsLoaded" or Change == "TimeLength") then
            return;
        elseif (Change == "Parent") then
            if MusicInstance.Parent ~= MusicHolder then
                local SineNow = Runtime:GetSine();
                if (MusicInstance.Parent ~= MusicHolder and lastPatch ~= SineNow) then
                    lastPatch = SineNow;
                    task.defer(pcall, FixMusic);
                else
                    lastPatch = SineNow;
                    MusicRefit();
                end
            end
        elseif (Change == "Name") then
            return;
        else
            MusicRefit();
        end
    end
    function OnHolderChange(Change)
        if (Change == "Position" or Change == "CFrame") then
            if (MusicHolder.Position ~= D[0]) then
                MusicRefit();
            end
        elseif (Change == "Parent") then
            if MusicHolder.Parent ~= SoundService then
                MusicRefit();
            end
        else
            MusicRefit();
        end
    end
    function MusicRefit()
        if (C1) then
            C1:Disconnect();
        end
        if (C2) then
            C2:Disconnect();
        end
        if (MusicHolder) then
            MusicHolder:Destroy();
        end
        if (MusicInstance) then
            MusicInstance:Destroy();
        end

        MusicHolder = Instance.new("Part");
        MusicInstance = Instance.new("Sound", MusicHolder);

        MusicInstance.SoundId = D[2];
        MusicInstance.Volume = D[1];
        MusicInstance.TimePosition = os.clock() - D[3];
		MusicInstance.Looped=true;

        MusicHolder.Parent = SoundService;
        MusicInstance:Play();

        C2 = MusicInstance.Changed:Connect(OnMusicChange);
        C1 = MusicHolder.Changed:Connect(OnHolderChange);
    end

    Runtime:AddTask(MusicRefit, false);

    Music = {
        ["GetMusic"] = function()
            return Musics;
        end,
        ["AddMusic"] = function(Music)
            table.insert(Musics, Music);
        end,
        ["Data"] = setmetatable({}, {
            __index = function(key, index)

            end,
            __newindex = function(key, index, var)
                if (index == "Position") then
                    if (MusicHolder) then
                        D[0] = var;
                        MusicHolder.Position = var;
                    end
                elseif (index == "Volume") then
                    if (MusicInstance) then
                        D[1] = var;
                        MusicInstance.Volume = var;
                    end
                elseif (index == "SoundId") then
                    if (MusicInstance) then
                        D[3] = os.clock();

                        D[2] = var;
                        MusicInstance.SoundId = var;
                    end
                end
            end
        })
    }
end

local Key
do
    Key = {
        ["Down"] = {}
    }

    local function OnKeyPress(key)
        Key.Down[key.KeyCode.Name] = true;
    end
    local function OnKeyRelease(key)
        Key.Down[key.KeyCode.Name] = false;
    end

    local Main;
    function Main()
        UserInputService.InputBegan:Connect(OnKeyPress);
        UserInputService.InputEnded:Connect(OnKeyRelease);
        Main = nil;
    end
	Runtime:AddTask(Main, false);
end

local Camera
do
	if IsLC then
	
	local cambk=Instance.new("Part",nil);
	local C1,C2;
	local CameraRefit;

	local function OnCameraChange(change)
		if change == "CFrame" or  change=="Position" or change=="AssemblyCenterOfMass" or change=="Orientation" or change=="Rotation" then
			if (Animation.Animatics==false and Camera[0].CFrame ~= CFrame.new(0, -2.25, 0) * Movement.CFrame) or (Animation.Animatics==true and Camera[0].CFrame~=CFrames.Head) then
				Camera[0]:Destroy()
				C1:Disconnect()
				CameraRefit();
			end
		else
			Camera[0]:Destroy()
			C1:Disconnect();
			CameraRefit();
		end
	end;
	function CameraRefit()
		Camera[0] = cambk:Clone()
	    Camera[0].Size = Vector3.new(math.random(1, 10000), math.random(1, 10000), math.random(1, 10000))
	    Camera[0].Orientation = Vector3.new(math.random(1, 180), math.random(1, 180), math.random(1, 180))
	    Camera[0].CanCollide = false
	    Camera[0].CanTouch = false
	    Camera[0].CanQuery = false
	    Camera[0].Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
	    Camera[0].Name = RandomString()
	    Camera[0].Parent = nil;
		if (workspace.CurrentCamera) then
			workspace.CurrentCamera.CameraSubject=Camera[0]
		else
			workspace.CurrentCamera=Instance.new("Camera",workspace)
			workspace.CurrentCamera.CameraSubject=Camera[0]
		end;
	    C1 = Camera[0].Changed:Connect(OnCameraChange);
	end
	Runtime:AddTask(CameraRefit, false);
end
	Camera={
		[0]=nil;
	}

end;

-- local Runtime 
local RayProperties = RaycastParams.new()
RayProperties.FilterType = Enum.RaycastFilterType.Exclude;

do
    local PTasks = {};
    local STasks = {};

    local Sine = 0;
    local Mode = 0;


	local function Clerp(a, b, t)
        return a:Lerp(b, math.clamp(t, 0, 1))
    end

    local function UpdateWeld(Weld, Part1, Part0)
        return Part0 * (Weld.C0 * Weld.C1:Inverse())
    end
    
    local function updatePart(i)
		if CFrames[i] then
			Character[i].CFrame=CFrames[i]
		end
		if Character[i] then
			if CFrames[i] and Character[i].CFrame ~= CFrames[i] then
				Character[i].CFrame = CFrames[i]
				Character[i]:ClearAllChildren()
			end
			for prop,var in next,CharacterProps[i] do
                Character[i][prop]=var;
            end;  
		end
	end

	Animation={
		["Animatics"]=true;
		["UpdateAnimatics"]=function()
			if (not Animation.Animatics) then return end;
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
            end
		end;
		["UpdateCharacter"]=function()
			if (Animation.Animatics)==false then return end;
			for i, v in next, CharacterProps do -- pcall(function()
				if (Character[i]~=nil) then
					if (Character[i].Parent~=workspace) then
						Character[i].Parent = workspace
					end;
					for Property,Value in next,CharacterProps[i] do
						Character[i][Property]=Value;
					end
					updatePart(i);
				end
			end
		end;
	}

    local function ResumeSync()
        coroutine.resume(Runtime["SerialRuntime"]);
    end
    local function ResumeParallel()
        coroutine.resume(Runtime["ParallelRuntime"]);
    end

    local serialDT = os.clock();
    local parallelDT = os.clock();

    local SerialRuntime, ParallelRuntime;

    if (IsLC) then
        function SerialRuntime()
            task.synchronize();
            while true do
				
                local Clock = os.clock();
                local DeltaTime = Clock - serialDT;

                -- work.
				
				Animation.UpdateCharacter();
                do -- Movement.
                    if not workspace.CurrentCamera then
                        workspace.CurrentCamera = Instance.new("Camera", workspace)
                    end

                    workspace.CurrentCamera.FieldOfView = 70
                    workspace.CurrentCamera.CameraSubject = Camera[0];
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                    Player.CameraMode = Enum.CameraMode.Classic
                    Player.CameraMaxZoomDistance = math.huge
                    Player.CameraMinZoomDistance = -100000
                    Player.CameraMode = Enum.CameraMode.Classic
					if Camera[0] then
						if (Animation.Animatics==false) then
							Camera[0].CFrame=CFrame.new(0, -2.25, 0)*Movement.CFrame
						else
							Camera[0].CFrame=CFrames.Head or CFrame.new(0, -2.25, 0)*Movement.CFrame;
						end
					end;
					Remote:FireServer(Remote.Key, 0, {
                        CFrame = Movement.CFrame,
                        Walking = Movement.Walking,
                        Hit = Mouse.Hit,
                    })
                end
                for i = 1, #STasks do
                    STasks[i](DeltaTime)
                    STasks[i] = nil;
                end
                Sine = Sine + (30 * DeltaTime);
                serialDT = Clock;
                coroutine.yield();
            end
        end
		
        function ParallelRuntime()
            task.synchronize();
            while true do
                local Clock = os.clock();
                local DeltaTime = Clock - parallelDT;
                -- work.
                local LookVector
				Animation.UpdateAnimatics();
                do -- Movement
                    LookVector = workspace.CurrentCamera.CFrame.LookVector
                    if not Movement.Flying then
						
                        local Closest, Rays, Ray_ = math.huge, {}, nil
                        table.insert(Rays, workspace:Raycast(Movement.CFrame.Position - Vector3.new(0, 1, 0),
                            Vector3.new(0, -9e9, 0), RayProperties))
                        for _, v in next, WorldModels do
                            table.insert(Rays, v:Raycast(Movement.CFrame.Position - Vector3.new(0, 1, 0),
                                Vector3.new(0, -9e9, 0), RayProperties))
                        end
                        for _, v in next, Rays do
                            local Magnitude = (Movement.CFrame.Position - v.Position).Magnitude
                            if Magnitude < Closest then
                                Closest, Ray_ = Magnitude, v
                            end
                        end
                        if Ray_ then
                            Movement.CFrame = CFrame.new(0, (Ray_.Position.Y - Movement.CFrame.Y) + 3, 0) *
                                                  Movement.CFrame
                        else
                            local Base = nil
                            for i, v in next, workspace:GetDescendants() do
                                if v:IsA("SpawnLocation") then
                                    Base = v
                                    break
                                end
                            end
                            if Base then
                                Movement.CFrame = CFrame.new(Base.Position) * CFrame.new(0, (Base.Size.Y / 2) + 3, 0) *
                                                      Movement.CFrame - Movement.CFrame.Position
                            else
                                Movement.CFrame = CFrame.new(0, 100, 0) * Movement.CFrame - Movement.CFrame.Position
                            end
                        end
                    end
                    local OldCFrame = Movement.CFrame
                    if Movement.Flying then
                        Movement.PotentialCFrame = CFrame.new(Movement.CFrame.Position,
                            Movement.CFrame.Position + LookVector)
                    else
                        Movement.PotentialCFrame = CFrame.new(Movement.CFrame.Position, Vector3.new(
                            Movement.CFrame.X + LookVector.X, Movement.CFrame.Y, Movement.CFrame.Z + LookVector.Z))
                    end

                    do
                        local x, z = 0, 0
                        if Key.Down["W"] then
                            z = x - 1
                      end
                        if Key.Down["A"] then
                            x = x - 1
                        end
                        if Key.Down["S"] then
                            z = z + 1;
                        end
                        if Key.Down["D"] then
                            x = x + 1;
                        end

                        Movement.PotentialCFrame = Movement.PotentialCFrame * CFrame.new(x, 0, z)
                    end

                    if (Movement.PotentialCFrame.X ~= OldCFrame.X or Movement.PotentialCFrame.Z ~= OldCFrame.Z) then
                        Movement.Walking = true
                        Movement.CFrame = CFrame.new(Movement.CFrame.Position, Movement.PotentialCFrame.Position) *
                                              CFrame.new(0, 0, (DeltaTime) * -Movement.WalkSpeed)
                    else
                        Movement.Walking = false
                    end
                end
                for i = 1, #PTasks do
                    PTasks[i](DeltaTime)
                    PTasks[i] = nil;
                end
                parallelDT = Clock;
                task.wait();
                -- Movement POST.
                do
                    LookVector = workspace.CurrentCamera.CFrame.LookVector
                    if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
                        if Movement.Flying then
                            Movement.CFrame =
                                CFrame.new(Movement.CFrame.Position, Movement.CFrame.Position + LookVector)
                        else
                            Movement.CFrame = CFrame.new(Movement.CFrame.Position, Vector3.new(
                                Movement.CFrame.X + LookVector.X, Movement.CFrame.Y, Movement.CFrame.Z + LookVector.Z))
                        end
                    end
                end
            end
        end
    else
        function SerialRuntime()
            task.synchronize();
            while true do
                local Clock = os.clock();
                local DeltaTime = Clock - serialDT;

                -- work.
				Animation.UpdateCharacter();
                do -- Movement.
                    if not workspace.CurrentCamera then
                        workspace.CurrentCamera = Instance.new("Camera", workspace)
                    end

                    workspace.CurrentCamera.FieldOfView = 70
                    workspace.CurrentCamera.CameraSubject = nil;
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                    Player.CameraMode = Enum.CameraMode.Classic
                    Player.CameraMaxZoomDistance = math.huge
                    Player.CameraMinZoomDistance = -100000
                    Player.CameraMode = Enum.CameraMode.Classic
                end

                for i = 1, #STasks do
                    STasks[i](DeltaTime)
                    STasks[i] = nil;
                end
                Sine = Sine + (30 * DeltaTime);
                serialDT = Clock;
                coroutine.yield();
            end
        end

        function ParallelRuntime()
            task.desynchronize();
            while true do
                local Clock = os.clock();
                local DeltaTime = Clock - parallelDT;

                -- work.
				Animation.UpdateAnimatics();
                for i = 1, #PTasks do
                    PTasks[i](DeltaTime)
                    PTasks[i] = nil;
                end
                parallelDT = Clock;
                task.wait();
                -- Movement POST.
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

        self["SerializedConnection"] = Connect(RunService.PreRender, "Connect", ResumeSync);
        self["ParallelConnection"] = Connect(RunService.PreRender, "ConnectParallel", ResumeParallel);

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
 
-- Remote Response
do
	local OnClientEvent=function(key, requestType, args)
		if (key == Remote.Key) then
			if (requestType == 0) then
				warn("Not allowed.")
			elseif (requestType == 1) then
				if (args[1]~=nil) then
					IgnoreManager.List=args[1];
					Character=args[1];
				end
				if (args[2]~=nil) then
					Runtime:SetSine(args[2]);
				end;
				if (args[3]~=nil) then
					Runtime:SetMode(args[3]);
				end;
				local filt={};
				for i,v in next,Character do
					if (typeof(v)=="Instance") then
						table.insert(filt,v);
					end
				end;
				RayProperties.FilterDescendantsInstances = filt;
			elseif (requestType == 2) then

			elseif (requestType == 3) then

			elseif (requestType == 4) then

			elseif (requestType == 5) then

			elseif (requestType == 6) then

			elseif (requestType == 7) then

			elseif (requestType == 8) then

			elseif (requestType == 9) then
			end
		elseif (key == Remote.GuestKey) then
			if (requestType == 1) then
				if (args[1]~=nil) then
					IgnoreManager.List=args[1];
					Character=args[1];
				end
				if (args[2]~=nil) then
					Runtime:SetSine(args[2]);
				end;
				if (args[3]~=nil) then
					Runtime:SetMode(args[3]);
				end;
				local filt={};
				for i,v in next,Character do
					if (typeof(v)=="Instance") then
						table.insert(filt,v);
					end
				end;
				RayProperties.FilterDescendantsInstances = filt;
			end
		else
			
		end
	end;
	local function Main()
		Remote.OnClientEvent:Connect(OnClientEvent);
		Main = nil;
	end;
	Runtime:AddTask(Main, false);
end;

Runtime:Start();
--[[]]
if (true == true) then
    return
end

script.Disabled = true
local RemoteName = script:FindFirstChildOfClass("StringValue").Value
game:GetService("RunService").RenderStepped:Wait()
script:Destroy()
-- Sec

allowedItems = {}
watching = {}

local Movement = {
    CFrame = CFrame.new(0, 100, 0),
    PotentialCFrame = CFrame.new(0, 100, 0),
    WalkSpeed = 50
}
local CameraPart = Instance.new("Part")
local Remote = nil
local LastFrame = tick()
local Character = nil
local RemoteKey = script.Name
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local Music = nil
local WorldModels = {}

for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("WorldModel") then
        table.insert(WorldModels, v)
        local Reparented
        Reparented = v.AncestryChanged:Connect(function()
            if not v:IsDescendantOf(workspace) then
                table.remove(WorldModels, table.find(WorldModels, v))
                Reparented:Disconnect()
            end
        end)
    end
end
workspace.DescendantAdded:Connect(function(v)
    if v:IsA("WorldModel") then
        table.insert(WorldModels, v)
        local Reparented
        Reparented = v.AncestryChanged:Connect(function()
            if not v:IsDescendantOf(workspace) then
                table.remove(WorldModels, table.find(WorldModels, v))
                Reparented:Disconnect()
            end
        end)
    end
end)
CameraPart:Destroy()
local function RandomString(Length)
    return game:GetService("HttpService"):GenerateGUID(false)
end
local RealPos = Instance.new("SelectionSphere")
RealPos.Name = RandomString()
RealPos.Color3 = Color3.new()
RealPos.Transparency = .75
RealPos.Adornee = CameraPart
RealPos.Parent = workspace
local function MoveCharacter(X, Z)
    Movement.PotentialCFrame = Movement.PotentialCFrame * CFrame.new(X, 0, Z)
end
local function KeyDown(Key)
    return not game:GetService("UserInputService"):GetFocusedTextBox() and
               game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode[Key]) or false
end
Mouse.KeyDown:Connect(function(Key)
    if Key == "f" then
        Movement.Flying = not Movement.Flying
        local LookVector = Movement.CFrame.LookVector
        Movement.CFrame = CFrame.new(Movement.CFrame.Position,
            Movement.CFrame.Position + Vector3.new(LookVector.X, 0, LookVector.Z))
    elseif Key == "m" then
        Remote:FireServer(RemoteKey, "SM491883257834", {}) -- Switch Mode
    elseif Key == "z" then
        Remote:FireServer(RemoteKey, "Attack", {
            Type = "GroundShards"
        })
    elseif Key == "t" then
        Remote:FireServer(RemoteKey, "ClearBanish", {})
    elseif Key == "r" then
        Remote:FireServer(RemoteKey, "SwapBanish", {})
    end
end)
local cltrsh = {}
cltrsh.con = {}
cltrsh.tsh = {}
function onchat(Message)

    local Message, Message_ = Message, Message
    if string.sub(Message, 1, 3) == "/e " then
        Message = string.sub(Message, 4)
    end
    if string.sub(string.lower(Message), 1, 3) == "lc/" then
        Message = string.sub(Message, 4)
        local Arguments = string.split(Message, "/")
        local Command = type(Arguments[1]) == "string" and string.lower(Arguments[1]) or ""
        if Command then
            table.remove(Arguments, 1)
        end
        if Command == "ch" or Command == "chat" or Command == "msgsys" or Command == "cmsg" then
            for i, v in pairs(cltrsh.con) do
                v:Disconnect()
            end
            for i, v in pairs(cltrsh.tsh) do
                v:Destroy()
            end
            local E = Instance.new("ScreenGui")
            local F = Instance.new("Frame", E)
            local B = Instance.new("TextBox", F)

            F.Position = UDim2.fromScale(0.5, 0)
            F.Active = true
            F.Draggable = true
            F.Size = UDim2.fromScale(0.2, 0.1)
            B.Size = UDim2.fromScale(1, 0.9)
            B.Position = UDim2.fromScale(0, 0.1)
            B.PlaceholderText = "Your message here"
            B.Text = ""
            B.ClearTextOnFocus = false
            B.TextWrapped = true
            B.Transparency = 0.5
            F.Transparency = 0.5
            table.insert(cltrsh.tsh, E)
            table.insert(cltrsh.tsh, F)
            table.insert(cltrsh.tsh, B)

            local e = game:GetService("UserInputService").InputBegan:Connect(function(e, gp)
                if e.KeyCode == Enum.KeyCode.Slash and not gp then
                    wait()
                    B:CaptureFocus()
                    onchat(B.Text)
                    B.Text = ""
                end
            end)

            local a = B.FocusLost:Connect(function(loss)
                if loss and B and B.Text ~= "" and B.Text ~= " " then
                    Remote:FireServer(RemoteKey, "Attack", {
                        Type = "Chat",
                        TEXT205 = B.Text
                    })
                    B.Text = ""
                end
            end)

            table.insert(allowedItems, E);
            table.insert(allowedItems, F);
            table.insert(allowedItems, B);
            table.insert(cltrsh.con, e);
            table.insert(cltrsh.con, a);
            E.Parent = game:GetService("Players").LocalPlayer.PlayerGui
        end
    end
end
game:GetService("Players").LocalPlayer.Chatted:Connect(onchat)
Mouse.Button1Down:Connect(function()
    Remote:FireServer(RemoteKey, "Attack", {
        Type = "ClickAttack"
    })
end)
cambk = CameraPart:Clone()
opr222 = CameraPart.Parent
cambk.Parent = nil

function newcam()
    local f = cambk:Clone()
    f.Size = Vector3.new(math.random(1, 10000), math.random(1, 10000), math.random(1, 10000))
    f.Orientation = Vector3.new(math.random(1, 180), math.random(1, 180), math.random(1, 180))
    f.CanCollide = false
    f.CanTouch = false
    f.CanQuery = false
    f.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    f.Name = RandomString()
    f.Parent = opr222
    local ac
    ac = f.Changed:Connect(function(change)
        if change == "CFrame" then
            if f and f.CFrame ~= CFrame.new(0, -2.25, 0) * Movement.CFrame then
                f:Destroy()
                ac:Disconnect()
            end
        else
            f:Destroy()
        end
    end)
    return f
end
game:GetService("RunService"):BindToRenderStep(RandomString(), -math.huge, function()

end)
local function ConnectEvent(Event_)

end

-- Chat System--
-- LOL NOT DOING THIS YET!--

local FoundRemote = false
repeat
    game:GetService("RunService").RenderStepped:Wait()
    local PotentialRemote = game:FindFirstChild(RemoteName, true)
    if typeof(PotentialRemote) == "Instance" and PotentialRemote:IsA("StarterGear") and PotentialRemote.Name ==
        RemoteName then
        Remote = PotentialRemote:FindFirstChild(RemoteName, true)
        FoundRemote = true
    end
until FoundRemote
ConnectEvent(Remote)
-- ]]
