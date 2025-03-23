-- // CombatHandler Module
local CombatHandler = {}

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- // Variables
CombatHandler.Humanoid = nil
CombatHandler.Variables = nil
CombatHandler.CharacterRequests = nil
CombatHandler.ReplicatedRequests = nil
CombatHandler.CharacterData = nil
CombatHandler.Root = nil

-- // Initialize Function
function CombatHandler:Initialize(characterData, root, humanoid, variables, characterRequests, replicatedRequests)
	self.CharacterData = characterData
	self.Humanoid = humanoid
	self.Variables = variables
	self.CharacterRequests = characterRequests
	self.ReplicatedRequests = replicatedRequests
	self.Root = root
end

-- // Update Function
function CombatHandler:Update()
	--self:UpdateRhythm()
	--self:UpdateIdle()
end

-- // Rhythm Check Function
function CombatHandler:RhythmCheck()
	if require(game.ReplicatedStorage.Modules.MovementHandler):IsMoving() or require(game.ReplicatedStorage.Modules.Utility).InAir(self.Humanoid) then
		return false
	end

	if not require(ReplicatedStorage.Modules.ActionChecks).RhythmCheck(self.CharacterData) then
		return false
	end

	local Tool = self:GetTool()

	if not Tool or (not Tool:FindFirstChild("Style") and not Tool:FindFirstChild("Skill")) then
		return false
	end

	return true
end

-- // Idle Check Function
function CombatHandler:IdleCheck()
	if not require(ReplicatedStorage.Modules.ActionChecks).IdleCheck(self.CharacterData) then
		return false
	end

	return true
end

-- // Charge Rhythm Function
function CombatHandler:ChargeRhythm()
	if self.CharacterData:FindFirstChild("ClientRhythm") then
		self.CharacterData:FindFirstChild("ClientRhythm"):Destroy()
		return
	end

	if not self:RhythmCheck() then
		return
	end

	local Animations = game:GetService("StarterPlayer").StarterPlayerScripts:FindFirstChild("ClientController").AnimsFolder

	if Animations and Animations.Stance then
		local Animation = self.Humanoid:LoadAnimation(Animations.Stance)
		Animation:Play()

		self.Variables.StanceAnimation = Animation
	end

	local Part, Pos = workspace:FindPartOnRayWithIgnoreList(Ray.new(self.Root.Position, Vector3.new(0, -10, 0)), {workspace.Effects, workspace.Live, workspace.Spawns})

	if Part then
		local RhythmEffect = game:GetService("ReplicatedStorage").Assets.Rhythm:Clone()
		RhythmEffect.Parent = workspace.Effects
		RhythmEffect.Position = Pos
		RhythmEffect.Attachment.Smoke:Emit(30)
		game.Debris:AddItem(RhythmEffect, 3)
	end

	local Tag = Instance.new("Folder")
	Tag.Name = "ClientRhythm"
	Tag.Parent = self.CharacterData

	self.CharacterRequests.ChargeRhythm:FireServer(true)

	while true do
		if not self.CharacterData:FindFirstChild("ClientRhythm") or not self:RhythmCheck() then
			break
		end

		task.wait()
	end

	self.CharacterRequests.ChargeRhythm:FireServer(false)

	if Tag then
		Tag:Destroy()
	end

	if self.Variables.StanceAnimation then
		self.Variables.StanceAnimation:Stop()
		self.Variables.StanceAnimation = nil
	end
end

-- // Show Rhythm Function
function CombatHandler:ShowRhythm()
	for i, v in pairs(self.Root.Parent:FindFirstChild("RhythmUI"):GetDescendants()) do
		if v.Name ~= "F" and v:IsA("ImageLabel") then
			TweenService:Create(v, TweenInfo.new(0.4), {ImageTransparency = 0}):Play()
		end
		if v.Name == "Bar" then
			TweenService:Create(v, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
		end
	end
end

-- // Hide Rhythm Function
function CombatHandler:HideRhythm()
	for i, v in pairs(self.Root.Parent:FindFirstChild("RhythmUI"):GetDescendants()) do
		if v.Name ~= "F" and v:IsA("ImageLabel") then
			TweenService:Create(v, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
		end
		if v.Name == "Bar" then
			TweenService:Create(v, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
		end
	end
end

-- // Update Rhythm Function
function CombatHandler:UpdateRhythm(characterData)
	self.CharacterData = characterData
	local RhythmUI = self.Root.Parent:FindFirstChild("RhythmUI")

	if RhythmUI and RhythmUI:FindFirstChild("F") then
		TweenService:Create(RhythmUI.F.BarQ.Bar,TweenInfo.new(0.2),{Size = UDim2.new(0.6, 0, self.CharacterData.Rhythm.Value / 100, 0)}):Play()

		if self.CharacterData and self.CharacterData.Rhythm.Value > 0 then
			self:ShowRhythm()
		else
			self:HideRhythm()
		end
	end
end

-- // Update Idle Function
function CombatHandler:UpdateIdle()
	local Tool = self:GetTool()

	if self:IdleCheck() and Tool and (Tool:FindFirstChild("Style") or Tool:FindFirstChild("Skill")) then
		if not self.Variables.Idle then
			local Animations = game:GetService("StarterPlayer").StarterPlayerScripts:FindFirstChild("ClientController").AnimsFolder

			if Animations and Animations.Idle then
				local Animation = self.Humanoid:LoadAnimation(Animations.Idle)
				Animation:Play()

				self.Variables.Idle = Animation
			end
		end
	elseif self.Variables.Idle then
		self.Variables.Idle:Stop()
		self.Variables.Idle = nil
	end
end

-- // Taunt Function
function CombatHandler:Taunt()
	self.CharacterRequests.Taunt:FireServer()
end

-- // Mount Function
function CombatHandler:Mount()
	ReplicatedStorage.Requests.Actions.Mount:FireServer()
end

-- // Rob Function
function CombatHandler:Rob()
	ReplicatedStorage.Requests.Actions.Rob:FireServer()
end

-- // Block Function
function CombatHandler:Block()
	self.CharacterRequests.Block:FireServer()
end

-- // Unblock Function
function CombatHandler:Unblock()
	self.CharacterRequests.Unblock:FireServer()
end

-- // Mode Function
function CombatHandler:Mode(Supreme)
	self.CharacterRequests.Mode:FireServer(Supreme)
end

-- // Left Click Function
function CombatHandler:LeftClick(Tool)
	self.CharacterRequests.LeftClick:FireServer(Tool)
end

-- // Right Click Function
function CombatHandler:RightClick(Tool)
	self.CharacterRequests.RightClick:FireServer(Tool)
end

-- // Get Tool Function
function CombatHandler:GetTool()
	local Tool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
	return Tool
end

-- // Get Anims Folder Function
function CombatHandler:GetAnimsFolder()
	local CombatTool = require(game.ReplicatedStorage.Modules.MovementHandler):GetCombatTool()
	local Style = CombatTool and CombatTool.Style.Value
	local Animations = CombatTool and CombatTool.Config.Stance.Value
	local Folder = game:GetService("ReplicatedStorage").Assets.Animations.Styles:FindFirstChild(Style)
	Folder = Folder and Folder:FindFirstChild(Animations)

	return Folder
end

-- // Handle Combat Input Began Function
function CombatHandler:HandleCombatInputBegan(Key)
	if Key.KeyCode == Enum.KeyCode.V then
		self:Mount()
	end

	if Key.KeyCode == Enum.KeyCode.C then
		self:Rob()
	end

	if Key.KeyCode == Enum.KeyCode.R and not require(game.ReplicatedStorage.Modules.MovementHandler):IsSprinting() then
		self:ChargeRhythm()
	end

	if Key.KeyCode == Enum.KeyCode.B then
		self:Taunt()
	end

	if Key.KeyCode == Enum.KeyCode.T then
		if game.Players.LocalPlayer.PlayerGui:FindFirstChild("FlowUI") and self.CharacterData:FindFirstChild("SupremeFlow") then
			local Supreme = false
			local Timer = 0
			while game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.T) do task.wait(0.1)
				Timer += 0.1
				if Timer >= 2 then
					Supreme = true
					if game.Players.LocalPlayer.PlayerGui:FindFirstChild("FlowUI") then
						local Tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.PlayerGui:FindFirstChild("FlowUI").Activate.UIGradient, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {Offset = Vector3.new(1, 0, 0)})
						Tween:Play()
						repeat
							task.wait()
						until not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.T)
						break
					end
				end
			end
			self:Mode(Supreme)
		else
			self:Mode(false)
		end
	end

	if Key.UserInputType == Enum.UserInputType.MouseButton1 then
		if not self:GetTool() and self.CharacterData:FindFirstChild("MountHit") then
			self.CharacterData:FindFirstChild("MountHit"):FireServer("Hit")
			return
		end

		local Tool = self:GetTool()
		self.CharacterRequests.LeftClick:FireServer(Tool)
	end

	if Key.UserInputType == Enum.UserInputType.MouseButton2 then
		if not self:GetTool() and self.CharacterData:FindFirstChild("MountHit") then
			self.CharacterData:FindFirstChild("MountHit"):FireServer("Pummel")
			return
		end

		local Tool = self:GetTool()
		self.CharacterRequests.RightClick:FireServer(Tool)
	end

	if Key.KeyCode == Enum.KeyCode.F and not self.cd then
		self:Block()
		self.cd = true
		task.delay(1.6, function()
			self.cd = false
		end)
	end
end

-- // Handle Combat Input Ended Function
function CombatHandler:HandleCombatInputEnded(Key)
	if Key.KeyCode == Enum.KeyCode.F then
		self:Unblock()
	end
end

-- // Return the module
return CombatHandler
