local Requests = script.Parent:WaitForChild("Requests")
local Assets = game.ReplicatedStorage.Assets
local Animations = Assets.Animations

local Player = game.Players.LocalPlayer
repeat task.wait() until Player.Character
local Character = Player.Character
local Root, Humanoid = Character:WaitForChild("HumanoidRootPart"), Character:WaitForChild("Humanoid")

local CharacterData = game.ReplicatedStorage.AliveData:WaitForChild(Character.Name)

local LoadedAnimations = {
	Sprint = Humanoid:LoadAnimation(Animations.Movement.Sprint),
	Jog = Humanoid:LoadAnimation(Animations.Movement.Jog)
}

--LoadedAnimations.Sprint.Priority = Enum.AnimationPriority.Action4
--LoadedAnimations.Jog.Priority = Enum.AnimationPriority.Action4
local Variables = {
	Idle = nil,
	WalkAnimation = nil,
	StanceAnimation = nil,
	Sprint = false,
	Jog = false,
	SprintTick = 0.2,
	HitKeys = {},
	Dodges = 3,
	RecentDodges = {},
	SprintStart = 0,
	LastStep = 0,
	InAir = false
}

LoadedAnimations.Sprint:GetMarkerReachedSignal("Footstep"):Connect(function()
	if InAir() or Variables.InAir then return end
	Footstep()

end)

LoadedAnimations.Jog:GetMarkerReachedSignal("Footstep"):Connect(function()
	if InAir() or Variables.InAir then return end
	Footstep()
end)

Root:WaitForChild("Running").Volume = 0

local RhythmUI = Assets.RhythmUI:Clone()
RhythmUI.Parent = Root

for i,v in pairs(RhythmUI:GetDescendants()) do
	if v.Name ~= "F" and v:IsA("ImageLabel") then
		v.ImageTransparency = 1
	end
	if v.Name == "Bar" and v:IsA("ImageLabel") then
		v.BackgroundTransparency = 1
	end
end

local function GetTool()
	local Tool = Character:FindFirstChildWhichIsA("Tool")

	return Tool
end

local function GetCombatTool()
	for i,v in pairs(Player.Character:children()) do
		if v:IsA("Tool") and v:FindFirstChild("Style") then
			return v
		end
	end

	for i,v in pairs(Player.Backpack:children()) do
		if v:IsA("Tool") and v:FindFirstChild("Style") then
			return v
		end
	end

	return nil
end



local function LoadingScreen()
	local Gui = game.ReplicatedStorage.Assets:WaitForChild("LoadMenu", 1):Clone()
	Gui.Parent = Player.PlayerGui
	Gui.LocalScript.Disabled = false
end

local cd = false

local function stmDrain(i)

	if cd == true then return end

	if i == nil then
		i = 1
	end

	game.ReplicatedStorage.Requests.DrainRemote:FireServer(i)

	cd = true

	wait()

	cd = false

end

local animsFolder = {}

Requests.returnAnims.OnClientInvoke = function(properties)
	animsFolder = properties
end

local function GetStyleAnimations()
	local CombatTool = GetCombatTool()

	local Style = CombatTool and CombatTool.Style.Value
	local Animations = CombatTool and CombatTool.Config.Stance.Value

	local Folder = game.ReplicatedStorage.Assets.Animations.Styles:FindFirstChild(Style)

	Folder = Folder and Folder:FindFirstChild(Animations)

	return Folder
end


function InAir()
	return Humanoid.FloorMaterial == Enum.Material.Air
end

local function IsMoving()
	return (Root.Velocity * Vector3.new(1, 0, 1)).Magnitude > 1
end

local function StopSprintAnimations()
	LoadedAnimations.Sprint:Stop()
	LoadedAnimations.Jog:Stop()
end

local function UpdateAnimations()
	if Variables.WalkAnimation then
		Variables.WalkAnimation:AdjustSpeed(Humanoid.WalkSpeed / 36)
	end

	if IsMoving() and not Variables.Sprint and not InAir() and Variables.Idle then
		local Animations = animsFolder

		if not Variables.WalkAnimation and Animations and Animations.Walk then
			local Animation = Humanoid:LoadAnimation(Animations.Walk)
			Animation:Play(0.2)
			Animation:GetMarkerReachedSignal("Footstep"):Connect(function()
				if InAir() or Variables.InAir then return end
				Footstep()
			end)

			Variables.WalkAnimation = Animation
		end
	elseif Variables.WalkAnimation then
		Variables.WalkAnimation:Stop()
		Variables.WalkAnimation = nil
	end

	local SprintAnimation = not Variables.Jog and LoadedAnimations.Sprint or LoadedAnimations.Jog

	if --[[IsMoving() and ]] Variables.Sprint then

		if not SprintAnimation.IsPlaying then
			StopSprintAnimations()

			SprintAnimation:Play(0.2)
		end
	else
		StopSprintAnimations()
	end
end

local function UpdateHumanoid()
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
	Humanoid:SetStateEnabled(12, true)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)

	local BaseSpeed = (1 / (1 + (CharacterData.Stats.Fat.Value / 150)))
	local Speed, Jump = 14, 50

	Humanoid.PlatformStand = CharacterData:FindFirstChild("Ragdoll")
	Humanoid.AutoRotate = not CharacterData:FindFirstChild("No Rotate") and not CharacterData:FindFirstChild("Ragdoll") and not CharacterData:FindFirstChild("Mount") and not CharacterData:FindFirstChild("Mounted")

	if Variables.Sprint then
		local SpeedBoost = 14 * math.max(1.1, (1 + (CharacterData.Stats.RunningSpeed.Value / 1000) - (CharacterData.Stats.LowerMuscle.Value / 1250) - (CharacterData.Stats.UpperMuscle.Value / 1250)))

		if Variables.Jog then
			SpeedBoost /= 1.5
		end
		
		--if CharacterData["In Combat"].Value then
			SpeedBoost /= 1.2
		--end

		Speed += SpeedBoost * math.clamp(((CharacterData.Stats.UpperMuscle.Value + CharacterData.Stats.LowerMuscle.Value > 300) and tick() or tick() + 0.5) , 0, 1)
		if Humanoid.Health / Humanoid.MaxHealth <= 0.4 then
			Speed = Speed / 1.4
		end
		--LoadedAnimations.Sprint:AdjustSpeed(((1 * (1 + (CharacterData.Stats.RunningSpeed.Value / 6800))) * BaseSpeed))
		--LoadedAnimations.Jog:AdjustSpeed(((1 * (1 + (CharacterData.Stats.RunningSpeed.Value / 6800))) * BaseSpeed))
		LoadedAnimations.Sprint:AdjustSpeed(1)
		LoadedAnimations.Jog:AdjustSpeed(1)

		if Variables.Jog then
			stmDrain(1.5)
		else
			stmDrain(1)
		end

	end



	if CharacterData:FindFirstChild("Blocking") then
		Speed = math.max(0, Speed - 6)
		Jump = 0
	end

	if CharacterData:FindFirstChild("Slow") then
		Speed = math.max(0, Speed - 6)
		Jump = 0
	end

	if CharacterData:FindFirstChild("Heavy Slow") then
		Speed = math.max(0, Speed - 12)
		Jump = 0
	end

	if CharacterData:FindFirstChild("Stun") then
		Speed = math.max(0, Speed - 14)
		Jump = 0
	end

	if CharacterData:FindFirstChild("No Jump") then
		Jump = 0
	end

	if CharacterData:FindFirstChild("Full Stun") then
		Speed = 0
		Jump = 0
	end

	if CharacterData:FindFirstChild("Ragdoll") then
		Speed = 0
		Jump = 0
	end

	if CharacterData:FindFirstChild("Mount") then
		Speed = 0
		Jump = 0
	end

	if CharacterData:FindFirstChild("Mounted") then
		Speed = 0
		Jump = 0
	end

	if CharacterData:FindFirstChild("Raging Blow") then
		Speed = 100
		Jump = 0
	end

	--Humanoid.WalkSpeed = Speed * BaseSpeed
	Humanoid.WalkSpeed = Speed
	Humanoid.JumpPower = Jump
end

local function SprintCheck()
	return require(game.ReplicatedStorage.Modules.ActionChecks).SprintCheck(CharacterData)
end

local function DodgeCheck()
	return require(game.ReplicatedStorage.Modules.ActionChecks).DodgeCheck(CharacterData)
end

local function Sprint(Value)
	Variables.SprintStart = Value and tick() or 0

	Variables.Sprint = Value or false
end

local uis = game:GetService("UserInputService")

local function GetDodges()
	local Dodges = 0

	for i,v in pairs(CharacterData:children()) do
		if v.Name == "FrontDodge" or v.Name == "LeftDodge" or v.Name == "RightDodge" or v.Name == "BackDodge" then
			Dodges += 1
		end
	end

	return Dodges
end

local function Mount()
	game.ReplicatedStorage.Requests.Actions.Mount:FireServer()
end

local function Rob()
	game.ReplicatedStorage.Requests.Actions.Rob:FireServer()
end

local function Dodge()
	if not DodgeCheck() or InAir() or CharacterData:FindFirstChild("No Dodge") or Variables.Dodges <= 0 then
		return
	end

	local LastHitKey = Variables.HitKeys[#Variables.HitKeys]

	local Direction = "Back"

	if LastHitKey == Enum.KeyCode.W then
		Direction = "Front"
	end

	if LastHitKey == Enum.KeyCode.A then
		Direction = "Left"
	end

	if LastHitKey == Enum.KeyCode.D then
		Direction = "Right"
	end

	if CharacterData:FindFirstChild(Direction.."Dodge") then
		return
	end

	local Dodges = GetDodges()

	if Dodges >= 3 then
		local Slow = Instance.new("Folder")
		Slow.Name = "Slow"
		Slow.Parent = CharacterData
		game.Debris:AddItem(Slow, 0.5)

		return
	end

	Sprint(false)
	--Requests.Unblock:FireServer()

	local Tag = Instance.new("Folder")
	Tag.Name = "No Jump"
	Tag.Parent = CharacterData
	game.Debris:AddItem(Tag, 0.5)

	local Tag = Instance.new("Folder")
	Tag.Name = "No Dodge"
	Tag.Parent = CharacterData
	game.Debris:AddItem(Tag, 0.5)

	local Tag = Instance.new("Folder")
	Tag.Name = Direction.."Dodge"
	Tag.Parent = CharacterData
	game.Debris:AddItem(Tag, 3)

	if GetDodges() >= 3 then
		local Tag = Instance.new("Folder")
		Tag.Name = "No Dodge"
		Tag.Parent = CharacterData
		game.Debris:AddItem(Tag, 3)
	end

	local Animation = Humanoid:LoadAnimation(Animations.Movement.Dashes:FindFirstChild(Direction))
	Animation:Play()
	Animation:AdjustSpeed(1.15)

	local Velocity = Instance.new("BodyVelocity")
	Velocity.MaxForce = Vector3.new(100000, 100000, 100000)
	Velocity.Parent = Root

	game.ReplicatedStorage.Requests.DrainRemote:FireServer(1.5)

	local BaseSpeed = 1

	local Start = tick()
	--[[local LowerMuscle = CharacterData.Stats.LowerMuscle.Value
	local TotalMuscle = LowerMuscle + CharacterData.Stats.UpperMuscle.Value
	local DensityCalc = 140 * (1+ (1 - 1))
	local Height = CharacterData.Stats.Height.Value and 1
	local WhatEver = 1
	if 1.2 < Height then
		WhatEver = Height - 0.1
	end
	local WhatEver2 = 15 * (WhatEver / 1.9)
	local SpeedCap = 1300
	local FatCalc = CharacterData.Stats.Fat.Value / 45
	local Whatever3 = 24 + WhatEver2
	local Whatever4 = 14 + WhatEver2

	if 1300 <= TotalMuscle then
		if 2000 < TotalMuscle then
			TotalMuscle = 2000 + (TotalMuscle - 2000) * 0.6;
		end;
		local Whatever5 = TotalMuscle / 1.1 / (20 + WhatEver2);
	else
		if DensityCalc < CharacterData.Stats.UpperMuscle.Value then

		end;
		if DensityCalc < LowerMuscle then
			LowerMuscle = LowerMuscle - (LowerMuscle - DensityCalc) / 45;
		end;
		if 800 < CharacterData.Stats.RunningSpeed.Value then
			local NewRS = CharacterData.Stats.RunningSpeed.Value - 800;
			if 0 < NewRS then
				local Zhinga = NewRS * 0.3;
			else
				Zhinga = 0;
			end;
			local Speeeedd = 800 + Zhinga
			Whatever5 = LowerMuscle / Whatever3 + Speeeedd / Whatever4 - FatCalc;
			if SpeedCap < Speeeedd then
				Whatever5 = LowerMuscle / Whatever3 + SpeedCap / Whatever4 - FatCalc;
			end;
		else
			Whatever5 = LowerMuscle / Whatever3 + CharacterData.Stats.RunningSpeed.Value / Whatever4 - FatCalc;
		end;
	end;
	if Whatever5 <= 0 then
		Whatever5 = 0;
	end;
	local Abb = 30 + Whatever5;
	if Abb < 20 then
		Abb = 20;
	end;
	local Distance = Abb - Abb * 0.3 * (1 - Variables.Dodges / 2);
	if 120 <= Distance then
		Distance = 120;
	end;]]

	local Distance = (55 * BaseSpeed) / (1 + (0.2 * Dodges)) * (1 + (CharacterData.Stats.RunningSpeed.Value / 2600) + (CharacterData.Stats.LowerMuscle.Value / 2000))

	local Duration = 0.15

	--Distance *= math.clamp((Humanoid.Health / Humanoid.MaxHealth) * 1.1, 0.4, 1)
	local density = 0.1
	local friction = 0.3
	local elasticity = 0.5
	local frictionweight = 1.0 
	local elasticityweight = 1.0

	local physProperties = PhysicalProperties.new(density, friction, elasticity, frictionweight, elasticityweight)

	for i,v in next, Root.Parent:GetChildren() do
		if v.ClassName == "MeshPart" or v.ClassName == "Part" then
			v.CustomPhysicalProperties = physProperties
		end
	end
	while true do
		if not DodgeCheck() then
			break
		end

		if not Velocity then
			break
		end

		if tick() - Start > Duration then
			break
		end

		if Direction == "Front" then
			Velocity.Velocity = Root.CFrame.LookVector*Distance
		end

		if Direction == "Left" then
			Velocity.Velocity = Root.CFrame.RightVector*-Distance
		end

		if Direction == "Right" then
			Velocity.Velocity = Root.CFrame.RightVector*Distance
		end

		if Direction == "Back" then
			Velocity.Velocity = Root.CFrame.LookVector*-Distance
		end

		Velocity.Velocity += Vector3.new(0, 10, 0)

		task.wait()
	end

	if Velocity then
		Velocity:Destroy()
	end
	local density = 0.7
	local friction = 0.3
	local elasticity = 0.5
	local frictionweight = 1.0 
	local elasticityweight = 1.0

	local physProperties = PhysicalProperties.new(density, friction, elasticity, frictionweight, elasticityweight)

	for i,v in next, Root.Parent:GetChildren() do
		if v.ClassName == "MeshPart" or v.ClassName == "Part" then
			v.CustomPhysicalProperties = physProperties
		end
	end
end

local function RhythmCheck()
	if IsMoving() or InAir() then
		return false
	end

	if not require(game.ReplicatedStorage.Modules.ActionChecks).RhythmCheck(CharacterData) then
		return false
	end

	local Tool = GetTool()

	if not Tool or (not Tool:FindFirstChild("Style") and not Tool:FindFirstChild("Skill")) then
		return false
	end

	return true
end

local function IdleCheck()
	if not require(game.ReplicatedStorage.Modules.ActionChecks).IdleCheck(CharacterData) then
		return false
	end

	return true
end

local function ChargeRhythm()
	if CharacterData:FindFirstChild("ClientRhythm") then
		CharacterData:FindFirstChild("ClientRhythm"):Destroy()
		return
	end

	if not RhythmCheck() then
		return
	end

	local Animations = animsFolder

	if Animations and Animations.Stance then
		local Animation = Humanoid:LoadAnimation(Animations.Stance)
		Animation:Play()

		Variables.StanceAnimation = Animation
	end

	local Part, Pos = workspace:FindPartOnRayWithIgnoreList(Ray.new(Root.Position, Vector3.new(0, -10, 0)), {workspace.Effects, workspace.Live, workspace.Spawns})

	if Part then
		local RhythmEffect = Assets.Rhythm:Clone()
		RhythmEffect.Parent = workspace.Effects
		RhythmEffect.Position = Pos
		RhythmEffect.Attachment.Smoke:Emit(30)			
		game.Debris:AddItem(RhythmEffect, 3)
	end

	local Tag = Instance.new("Folder")
	Tag.Name = "ClientRhythm"
	Tag.Parent = CharacterData

	Requests.ChargeRhythm:FireServer(true)

	while true do
		if not CharacterData:FindFirstChild("ClientRhythm") or not RhythmCheck() then
			break
		end

		task.wait()
	end

	Requests.ChargeRhythm:FireServer(false)

	if Tag then
		Tag:Destroy()
	end

	if Variables.StanceAnimation then
		Variables.StanceAnimation:Stop()
		Variables.StanceAnimation = nil
	end
end

local function ShowRhythm()
	for i,v in pairs(RhythmUI:GetDescendants()) do
		if v.Name ~= "F" and v:IsA("ImageLabel") then
			game.TweenService:Create(v, TweenInfo.new(0.4), {ImageTransparency = 0}):Play()
		end
		if v.Name == "Bar" then
			game.TweenService:Create(v, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
		end
	end
end

local function HideRhythm()
	for i,v in pairs(RhythmUI:GetDescendants()) do
		if v.Name ~= "F" and v:IsA("ImageLabel") then
			game.TweenService:Create(v, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
		end
		if v.Name == "Bar" then
			game.TweenService:Create(v, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
		end
	end
end

local function UpdateRhythm()
	if RhythmUI:FindFirstChild("F") then
		game.TweenService:Create(RhythmUI.F.BarQ.Bar,TweenInfo.new(0.2),{Size = UDim2.new(0.6, 0, CharacterData.Rhythm.Value / 100, 0)}):Play()
	end
end

local function UpdateIdle()
	local Tool = GetTool()

	if IdleCheck() and Tool and (Tool:FindFirstChild("Style") or Tool:FindFirstChild("Skill")) then
		if not Variables.Idle then
			local Animations = animsFolder

			if Animations and Animations.Idle then
				local Animation = Humanoid:LoadAnimation(Animations.Idle)
				Animation:Play()

				Variables.Idle = Animation
			end
		end
	elseif Variables.Idle then
		Variables.Idle:Stop()
		Variables.Idle = nil
	end
end

function Footstep()
	if not InAir() and not Variables.InAir then
		local Material = "Concrete"

		if Humanoid.FloorMaterial == Enum.Material.Grass then
			Material = "Grass"
		end

		if Humanoid.FloorMaterial == Enum.Material.Sand then
			Material = "Sand"
		end

		if Humanoid.FloorMaterial == Enum.Material.Wood or Humanoid.FloorMaterial == Enum.Material.WoodPlanks then
			Material = "Wood"
		end

		local Sound = game.ReplicatedStorage.Footstep_Sounds:FindFirstChild(Material)

		if Material == "Sand" then
			Sound.Volume = 0.3
		end

		if Sound then
			--[[if not Character.RightFoot:FindFirstChild("Footstep" .. Material) then
				local Clone = Sound:Clone()
				Clone.Name = "Footstep" .. Material
				Clone.Parent = Character.RightFoot
				Clone.Volume = 0.15
				Clone.PlaybackSpeed = Clone.PlaybackSpeed + math.random(-8, 10) / 100
				for i = 1,15 do
				local Clone = Sound:Clone()
				Clone.Name = "Footstep" .. Material .. i
				Clone.Parent = Character.RightFoot
				Clone.Volume = 0.15
				Clone.PlaybackSpeed = Clone.PlaybackSpeed + math.random(-8, 10) / 100
				end
			end
			local SoundInstance = Character.RightFoot:FindFirstChild("Footstep" .. Material .. math.random(1,15))--]]
			
			--[[if Variables.Sprint then
				SoundInstance.PlaybackSpeed = SoundInstance.PlaybackSpeed * 1.6
			elseif SoundInstance.Name:split("Grass") >= 2 then
				SoundInstance.PlaybackSpeed = 1.5
			elseif SoundInstance.Name:split("Sand") >= 2 then
				SoundInstance.PlaybackSpeed = 1.3
			elseif SoundInstance.Name:split("Wood") >= 2 then
				SoundInstance.PlaybackSpeed = 1.2
			else
				SoundInstance.PlaybackSpeed = 1
			end

			SoundInstance:Play()
			SoundInstance.Looped = false--]]
			local Clone = Sound:Clone()
			Clone.Parent = Character.RightFoot
			Clone.Volume = 0.25
			Clone.PlaybackSpeed = Clone.PlaybackSpeed + math.random(-8, 10) / 100

			if Variables.Sprint then
				Clone.PlaybackSpeed = Clone.PlaybackSpeed * 1.6
			end

			Clone:Play()

			Clone.Ended:connect(function()
				Clone:Destroy()
			end)
			
		end
	end
end
	spawn(function()
		while true do task.wait()
			if not SprintCheck() then
				Sprint(false)
			end

			if CharacterData and CharacterData.Rhythm.Value > 0 then
				ShowRhythm()
			else
				HideRhythm()
			end

			--[[f tick() - Variables.LastStep > 7.8 / Humanoid.WalkSpeed then
				if IsMoving() and not InAir() and not CharacterData:FindFirstChild("Raging Blow") then
					Footstep()

					Variables.LastStep = tick()
				end
			end

			if not InAir() and Variables.InAir then
				Footstep()
			end--]]
			pcall(function()
				if Character:FindFirstChild('FakeH'):FindFirstChild("granks") then
					Character.FakeH.granks.Head.Transparency = 1
				end
			end)

			Variables.InAir = InAir()

			UpdateIdle()
			UpdateRhythm()
			UpdateHumanoid()
			UpdateAnimations()
		end
	end)

if not Player:GetAttribute("LDS") then

	LoadingScreen()

	Player:SetAttribute("LDS", true)

end

local CD = false
local LastSprint = tick()

game:GetService("UserInputService").InputBegan:Connect(function(Key, Processed)
	if Processed then
		return
	end

	if Key.KeyCode == Enum.KeyCode.W then
		if tick() - Variables.SprintTick < 0.2 and tick() - LastSprint >= 0.25 then
			Sprint(true)

			Variables.SprintTick = 0
		else
			Variables.SprintTick = tick()
		end
	end

	if Key.KeyCode == Enum.KeyCode.Q then
		Dodge()
	end

	if Key.KeyCode == Enum.KeyCode.V then
		Mount()
	end

	if Key.KeyCode == Enum.KeyCode.C then
		Rob()
	end
	
	if Key.KeyCode == Enum.KeyCode.Up then
		if Variables.Sprint then
			LastSprint = tick()
			Variables.SprintTick = 0
		end
		Sprint(false)
	end
	
	if Key.KeyCode == Enum.KeyCode.Down then
		if Variables.Sprint then
			LastSprint = tick()
			Variables.SprintTick = 0
		end
		Sprint(false)
	end

	if Key.KeyCode == Enum.KeyCode.R and not Variables.Sprint then
		ChargeRhythm()
	end

	if Key.KeyCode == Enum.KeyCode.B then
		Requests.Taunt:FireServer()
	end

	if Key.KeyCode == Enum.KeyCode.T then
		if game.Players.LocalPlayer.PlayerGui:FindFirstChild("FlowUI") and CharacterData:FindFirstChild("SupremeFlow") then
			local Supreme = false
			local Timer = 0
			while game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.T) do task.wait(0.1)
				Timer += 0.1
				if Timer >= 2 then
					Supreme = true
					if game.Players.LocalPlayer.PlayerGui:FindFirstChild("FlowUI") then
						local Tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.PlayerGui:FindFirstChild("FlowUI").Activate.UIGradient, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {Offset = Vector2.new(5,0)})
						Tween:Play()
						repeat
							task.wait()
						until not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.T)
						break
					end
				end
			end
			Requests.Mode:FireServer(Supreme)
		else
			Requests.Mode:FireServer(false)
		end
	end

	if Key.KeyCode == Enum.KeyCode.R and Variables.Sprint then
		Variables.Jog = not Variables.Jog
	end

	if Key.UserInputType == Enum.UserInputType.MouseButton1 then
		if not GetTool() and CharacterData:FindFirstChild("MountHit") then
			CharacterData:FindFirstChild("MountHit"):FireServer("Hit")
			return
		end

		local Tool = GetTool()

		Requests.LeftClick:FireServer(Tool)
	end

	if Key.UserInputType == Enum.UserInputType.MouseButton2 then
		if not GetTool() and CharacterData:FindFirstChild("MountHit") then
			CharacterData:FindFirstChild("MountHit"):FireServer("Pummel")
			return
		end

		local Tool = GetTool()

		Requests.RightClick:FireServer(Tool)
	end

	if Key.KeyCode == Enum.KeyCode.F and not CD then
		Requests.Block:FireServer()
		CD = true
		task.delay(1.6, function()
			CD = false
		end)
	end

	if Key.KeyCode == Enum.KeyCode.W or Key.KeyCode == Enum.KeyCode.A or Key.KeyCode == Enum.KeyCode.S or Key.KeyCode == Enum.KeyCode.D then
		table.insert(Variables.HitKeys, Key.KeyCode)
	end
end)

game:GetService("UserInputService").InputEnded:Connect(function(Key)
	if Key.KeyCode == Enum.KeyCode.W then
		if Variables.Sprint then
			LastSprint = tick()
			Variables.SprintTick = 0
		end
		Sprint(false)
	end

	if Key.KeyCode == Enum.KeyCode.F then
		Requests.Unblock:FireServer()
	end

	if Key.KeyCode == Enum.KeyCode.W or Key.KeyCode == Enum.KeyCode.A or Key.KeyCode == Enum.KeyCode.S or Key.KeyCode == Enum.KeyCode.D then
		table.remove(Variables.HitKeys, table.find(Variables.HitKeys, Key.KeyCode))
	end
end)

game.ReplicatedStorage.Requests.BodyMover.OnClientEvent:Connect(function(Type, Properties)
	if Properties.Delay then
		task.wait(Properties.Delay)
	end

	if Properties.ClearMovers then
		for i,v in pairs(Root:children()) do
			if v:IsA("BodyMover") then
				v:Destroy()
			end
		end
	end

	if Type == "BodyVelocity" then
		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Properties.MaxForce
		BodyVelocity.Velocity = Properties.Velocity
		BodyVelocity.Parent = Properties.Parent
		game.Debris:AddItem(BodyVelocity, Properties.Duration)
	end

	if Type == "BodyPosition" then
		local BodyVelocity = Instance.new("BodyPosition")
		BodyVelocity.MaxForce = Properties.MaxForce
		BodyVelocity.Position = Properties.Position

		BodyVelocity.P = Properties.P or BodyVelocity.P
		BodyVelocity.D = Properties.D or BodyVelocity.D

		BodyVelocity.Parent = Properties.Parent
		game.Debris:AddItem(BodyVelocity, Properties.Duration)
	end

	if Type == "BodyGyro" then
		local BodyVelocity = Instance.new("BodyGyro")
		BodyVelocity.MaxTorque = Properties.MaxTorque
		BodyVelocity.CFrame = Properties.CFrame

		BodyVelocity.P = Properties.P or BodyVelocity.P
		BodyVelocity.D = Properties.D or BodyVelocity.D

		BodyVelocity.Parent = Properties.Parent
		game.Debris:AddItem(BodyVelocity, Properties.Duration)
	end
end)

game.ReplicatedStorage.Requests.GetMouse.OnClientInvoke = function()
	local Mouse = Player:GetMouse()

	return {
		Hit = Mouse.Hit
	}
end


local Cooldown = 2

local LastJump = time()

Humanoid.Changed:connect(function(Prop)
	if Prop and Prop == "Jump" and Humanoid.Jump then
		local CurrentTime = time()
		if LastJump + Cooldown > CurrentTime then
			Humanoid.Jump = false
		else
			LastJump = CurrentTime
		end
	end
end)

local coreCall do
	local MAX_RETRIES = 8

	local StarterGui = game:GetService('StarterGui')
	local RunService = game:GetService('RunService')

	function coreCall(method, ...)
		local result = {}
		for retries = 1, MAX_RETRIES do
			result = {pcall(StarterGui[method], StarterGui, ...)}
			if result[1] then
				break
			end
			RunService.Stepped:Wait()
		end
		return unpack(result)
	end
end

local stmGui = Player.PlayerGui.MainGui.Utility.StamBar

--local Regen = coroutine.wrap(function()

--while wait() do

--if CharacterData.Stamina.Value < 100 + CharacterData.MaxStamina.Value then

--Requests.ChargeStamina:FireServer()

--end

--end

--end)


--Regen()

local function CreateNoStamEffect()

	stmGui.BGC.Visible = true

	local Tween = game:GetService("TweenService"):Create(stmGui.BGC,TweenInfo.new(1),{BackgroundTransparency = 0.5})
	Tween:Play()

	Tween.Completed:Wait()

	local Tween = game:GetService("TweenService"):Create(stmGui.BGC,TweenInfo.new(1),{BackgroundTransparency = 1})
	Tween:Play()

	Tween.Completed:Wait()


	stmGui.BGC.Visible = false

end

spawn(function()
	while true do task.wait(0.1) 
		if Character:FindFirstChild("granks") and Character:FindFirstChild("granks").fnoid.DisplayDistanceType ~= Enum.HumanoidDisplayDistanceType.None then
			Character:FindFirstChild("granks").fnoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		end
	end
end)

--[[coroutine.wrap(function()

	while true do

		while CharacterData.Stamina.Value <= 1 do

			CreateNoStamEffect()

		end

		wait()

	end

end)()--]]

coreCall('SetCore', 'ResetButtonCallback', false)


