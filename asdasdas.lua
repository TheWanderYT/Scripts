-- Decompiled with the Synapse X Luau decompiler.
 --NOTE: Currently in beta! Not representative of final product.
wait(0);
local t_LocalPlayer_1 = game.Players.LocalPlayer;
local u1 = t_LocalPlayer_1:GetMouse();
local t_Parent_2 = script.Parent;
local t_PlayerGui_3 = t_LocalPlayer_1.PlayerGui;
local v1 = game:GetService("RunService");
local v2 = game.ReplicatedStorage;
local t_ReplicatedStorage_4 = v2;
local t_Events_5 = v2.Events;
local u2 = false;
local v3 = game:GetService("UserInputService");
local u3 = t_LocalPlayer_1.Character;
if (not u3) then
	u3 = t_LocalPlayer_1.CharacterAdded:wait();
end
local t_PrimaryPart_6 = u3.PrimaryPart;
local u4 = u3:WaitForChild("Humanoid");
local t_Action_7 = t_Parent_2.Action;
local t_CurrentCamera_8 = workspace.CurrentCamera;
local v4 = v3.TouchEnabled;
if (v4) then
	v4 = not v3.MouseEnabled;
end
local v5, v6 = t_Events_5.GetPass:InvokeServer(v4);
local v7 = v5;
local v8 = require(t_ReplicatedStorage_4.Events.ClientFX.Effect);
local u5 = workspace[t_LocalPlayer_1.Name .. " Storage"];
local v9 = u3:WaitForChild("Effects");
local v10 = {};
local v11 = u3:WaitForChild("CurrentStamina");
local v12 = u3:WaitForChild("MaxStamina");
local v13 = u3:WaitForChild("MaxRunningSpeed");
local v14 = game:GetService("CollectionService");
local v15 = u3:WaitForChild("Rhythm");
local u6 = t_PrimaryPart_6:WaitForChild("RhythmUI");
local u7 = u6:WaitForChild("F"):WaitForChild("BarQ"):WaitForChild("Bar");
pcall(function() -- [line 30] anonymous function
	--[[
		Upvalues: 
			[1] = t_LocalPlayer_1
	--]]
	t_LocalPlayer_1.PlayerScripts.RbxCharacterSounds:Destroy();
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", false);
end);
v15.Changed:connect(function(p1) -- [line 36] anonymous function
	--[[
		Upvalues: 
			[1] = u7
			[2] = u6
	--]]
	u7:TweenSize(UDim2.new(0.6, 0, p1 / 100, 0), "Out", "Quad", 0.1, true);
	u6.Enabled = false;
	if (p1 > 0) then
		u6.Enabled = true;
	end
end);
local u8 = {};
local v16 = t_PlayerGui_3:WaitForChild("MainGui");
local v17 = v16;
local v18 = v16.ProtectionFr;
local t_ProtectionFr_9 = v18;
local t_Utility_10 = v16.Utility;
local v19 = u4.DisplayName;
local t_DisplayName_11 = v19;
t_Utility_10.RPName.Text = v19;
local v20 = v18.RemoveT.MouseButton1Click;
local u9 = t_Action_7;
local u10 = v5;
v20:Connect(function() -- [line 68] anonymous function
	--[[
		Upvalues: 
			[1] = u2
			[2] = u9
			[3] = u10
	--]]
	if (u2) then
		return;
	end
	u9:FireServer(u10, "RemoveProtection");
	wait(0.1);
	u2 = false;
end);
local v21, v22, v23 = pairs(v6);
local v24 = v21;
local v25 = v22;
local v26 = v23;
while true do
	local v27, v28 = v24(v25, v26);
	local v29 = v27;
	local v30 = v28;
	if (v27) then
		break;
	end
	v26 = v29;
	local v31 = Instance.new("Animation");
	v31.AnimationId = v30;
	table.insert(v10, u4:LoadAnimation(v31));
end
local f_CanUse;
f_CanUse = function(p2, p3, p4, p5) -- [line 81] CanUse
	--[[
		Upvalues: 
			[1] = u3
			[2] = u8
			[3] = u4
			[4] = u5
	--]]
	local t_Value_12 = u3.DB.Value;
	if (not (((t_Value_12 == true) or (u8.Hit and ((u8.Hit.count > 0) and (not p5)))) or (((u8.NoAction and (u8.NoAction.count > 0)) or u3:FindFirstChild("Attacking")) or (u8.Stun and (u8.Stun.count > 0))))) then
		local t_Health_13 = u4.Health;
		if (not (((t_Health_13 <= 0) or ((u4.PlatformStand and p4) or u5:FindFirstChild(""))) or ((not p3) and u3:FindFirstChild("Mounting")))) then
			return true;
		end
	end
	return false;
end;
_G.CanUse = f_CanUse;
local v32 = {};
local v33 = {};
local v34 = {};
local u11 = {};
local u12 = nil;
local v35 = t_Events_5.UpdateStats.OnClientEvent;
local u13 = v33;
local u14 = t_Utility_10;
local u15 = v32;
local u16 = v8;
local u17 = t_LocalPlayer_1;
local u18 = t_DisplayName_11;
local u19 = v17;
local u20 = t_ProtectionFr_9;
local u21 = v34;
v35:connect(function(p6, p7) -- [line 98] anonymous function
	--[[
		Upvalues: 
			[1] = u13
			[2] = u14
			[3] = u15
			[4] = u16
			[5] = u12
			[6] = u17
			[7] = u18
			[8] = u19
			[9] = u20
			[10] = u11
			[11] = u21
	--]]
	if ((p6 == "ExtraAttribute") or p6:match("Aptitudes")) then
		if (p6 == "Aptitudes") then
			print(p7.name);
			u11[p7.name] = p7.val;
			return;
		end
		if (p6 == "AptitudeSetup") then
			print("set");
			u11 = p7;
			return;
		end
		u21[p7.name] = p7.val;
	else
		u13[p6] = p7;
		if (p6 == "Stomach") then
			u14.StomachBar.BarF.Bar:TweenSize(UDim2.new(p7[1] / (p7[2] or 100), 0, 1, 0), "Out", "Quad", 0.1, true);
			return;
		end
		if (p6 == "Calories") then
			u14.StomachBar.Calories.Bar:TweenSize(UDim2.new(p7[1] / (p7[2] or 100), 0, 1, 0), "Out", "Quad", 0.1, true);
			return;
		end
		if (p6 == "LimbInjuries") then
			u15[p7.Name] = p7.Info;
			return;
		end
		if (((p6 == "Money") or (p6 == "BodyFatigue")) or (p6 == "ModeFatigue")) then
			local v36 = u14[p6];
			local v37 = v36;
			v36.Text = "$" .. u16.round(p7, 2);
			if (p6 == "BodyFatigue") then
				v37.Text = "Body Fatigue: " .. (u16.round(p7, 2) .. "%");
				return;
			end
			if (p6 == "ModeFatigue") then
				v37.Text = "";
				v37.Txt.Text = "Mode Fatigue: " .. (u16.round(p7, 2) .. "%");
				return;
			end
			if (u12) then
				local v38 = u16.round(p7, 2) - u12;
				if (v38 ~= 0) then
					local v39 = false;
					local v40;
					if (v38 < 0) then
						v40 = v38 * -1;
						if (not v40) then
							v39 = true;
						end
					else
						v39 = true;
					end
					if (v39) then
						v40 = v38;
					end
					local v41;
					if (v38 > 0) then
						v41 = "+$";
					else
						v41 = "-$";
					end
					local v42 = u14.MoneyTxt:clone();
					local v43 = v42;
					v42.Text = v41 .. u16.round(v40, 2);
					if (v38 < 0) then
						v43.TextColor3 = Color3.fromRGB(225, 87, 87);
					end
					v43.Visible = true;
					v43.Parent = u14;
					local v44 = u16.Tween;
					local v45 = u17;
					local v46 = v43;
					local v47 = {};
					v47.TextTransparency = 0;
					v47.TextStrokeTransparency = 0;
					v47.Position = UDim2.new(0.539, 0, 0.8, 0);
					v44(v45, v46, 0.5, v47);
					local g_delay_15 = delay;
					local u22 = v43;
					g_delay_15(1.5, function() -- [line 130] anonymous function
						--[[
							Upvalues: 
								[1] = u16
								[2] = u17
								[3] = u22
						--]]
						local v48 = u16.Tween;
						local v49 = u17;
						local v50 = u22;
						local v51 = {};
						v51.TextTransparency = 1;
						v51.TextStrokeTransparency = 1;
						v51.Position = UDim2.new(0.539, 0, 0.9, 0);
						v48(v49, v50, 0.25, v51);
						wait(0.25);
						u22:Destroy();
					end);
				end
			end
			u12 = u16.round(p7, 2);
			return;
		end
		if (p6 == "Trait") then
			u14[p6].Text = "Trait: " .. p7;
			return;
		end
		if (p6 == "Title") then
			u14.RPName.Text = u18;
			if (p7 ~= "") then
				return;
			end
		else
			if (p6 == "JailTime") then
				local v52 = u19.JailF;
				v52.Visible = 0 < p7;
				v52.Timer.Text = "Jail Time: " .. (p7 .. "s");
				return;
			end
			if ((p6 == "BehelitNotifier") and u14:FindFirstChild("Notifier")) then
				local t_Notifier_14 = u14.Notifier;
				if (p7 <= 0) then
					t_Notifier_14.Visible = false;
					return;
				end
				t_Notifier_14.Visible = true;
				t_Notifier_14.Text = "Behelit Notifier: " .. string.format("%02i:%02i:%02i", p7 / 3600, (p7 / 60) % 60, p7 % 60);
				return;
			end
			if (p6 == "PlayerProtection") then
				local v53 = p7;
				local v54 = (v53 - (v53 % 60)) / 60;
				local v55 = v53 - (v54 * 60);
				local v56 = (v54 - (v54 % 60)) / 60;
				local v57 = v54 - (v56 * 60);
				local v58 = (v56 - (v56 % 24)) / 24;
				u20.Time.Text = v58 .. (" Days " .. ((v56 - (v58 * 24)) .. (" Hours " .. (v57 .. " Minutes"))));
				u20.Visible = 0 < p7;
				return;
			end
		end
	end
end);
local u23 = nil;
local v59 = {};
v59.w = false;
v59.a = false;
v59.s = false;
v59.d = false;
local u24 = false;
local v60 = u3:FindFirstChild("Block");
local u25 = 0;
local u26 = false;
local u27 = "";
local u28 = "";
local u29 = false;
local u30 = 3;
local u31 = tick();
local u32 = false;
local u33 = false;
local v61 = Instance.new("BoolValue");
v61.Name = "Sprinting";
local u34 = v61;
local u35 = v10;
local u36 = t_Action_7;
local u37 = v7;
local u38 = u4;
local f_stopSprint;
f_stopSprint = function() -- [line 195] stopSprint
	--[[
		Upvalues: 
			[1] = u26
			[2] = u34
			[3] = u23
			[4] = u25
			[5] = u35
			[6] = u36
			[7] = u37
			[8] = u33
			[9] = u38
	--]]
	if (u26) then
		u34.Parent = nil;
		if (u23) then
			u23:Stop();
		end
		u25 = 0;
		u26 = false;
		u35[1]:Stop();
		u36:FireServer(u37, "RunToggle", {
			false
		});
		u33 = false;
		u35[6]:Stop();
		local v62, v63, v64 = pairs(u38:GetPlayingAnimationTracks());
		local v65 = v62;
		local v66 = v63;
		local v67 = v64;
		while true do
			local v68, v69 = v65(v66, v67);
			local v70 = v68;
			local v71 = v69;
			if (v68) then
				break;
			end
			v67 = v70;
			local t_Name_16 = v71.Name;
			if (t_Name_16 == "StyleWalk") then
				v71.Priority = Enum.AnimationPriority.Movement;
			end
		end
	end
end;
stopSprint = f_stopSprint;
local u39 = "";
local u40 = u4;
local u41 = v10;
local u42 = v33;
local u43 = u3;
local u44 = t_Action_7;
local u45 = v7;
local u46 = t_PrimaryPart_6;
local f_Dash;
f_Dash = function(p8, p9) -- [line 210] Dash
	--[[
		Upvalues: 
			[1] = u29
			[2] = u30
			[3] = u39
			[4] = u40
			[5] = u41
			[6] = u42
			[7] = u43
			[8] = u44
			[9] = u45
			[10] = u28
			[11] = u46
			[12] = u32
			[13] = u31
	--]]
	if (not u29) then
		local v72 = u30;
		if (not (v72 <= 0)) then
			local v73 = u39;
			if (v73 ~= p8) then
				local t_FloorMaterial_17 = u40.FloorMaterial;
				if ((not (t_FloorMaterial_17 == Enum.Material.Air)) and _G.CanUse(nil, nil, nil, true)) then
					u29 = true;
					u39 = p8;
					local v74 = u41[5];
					local v75 = u42.LowerBodyMuscle;
					local t_RunningSpeed_18 = u42.RunningSpeed;
					local v76 = u42.UpperBodyMuscle;
					local t_UpperBodyMuscle_19 = v76;
					local v77 = v75 + v76;
					local v78 = u42.Height or 1;
					local v79 = v78;
					local t_Fat_20 = u42.Fat;
					local v80 = 140 * (1 + (1 - u42.MuscleDensity));
					local v81 = 1;
					if (v78 > 1.2) then
						v81 = v79 - 0.1;
					end
					local v82 = 15 * (v81 / 1.9);
					local t_Clan_21 = u42.Clan;
					local v83;
					if (t_Clan_21 == "Mikazuchi") then
						v83 = 1550;
					else
						v83 = 1300;
					end
					local v84 = t_Fat_20 / 45;
					local v85 = 24 + v82;
					local v86 = 14 + v82;
					local v87;
					if (v77 >= 1300) then
						if (v77 > 2000) then
							v77 = 2000 + ((v77 - 2000) * 0.6);
						end
						v87 = (v77 / 1.1) / (20 + v82);
					else
						if (v80 < t_UpperBodyMuscle_19) then
							local v88 = (t_UpperBodyMuscle_19 - v80) / 40;
						end
						if (v80 < v75) then
							v75 = v75 - ((v75 - v80) / 45);
						end
						if (t_RunningSpeed_18 > 800) then
							local v89 = t_RunningSpeed_18 - 800;
							local v90 = v89;
							local v91;
							if (v89 > 0) then
								v91 = v90 * 0.3;
							else
								v91 = 0;
							end
							local v92 = 800 + v91;
							v87 = ((v75 / v85) + (v92 / v86)) - v84;
							if (v83 < v92) then
								v87 = ((v75 / v85) + (v83 / v86)) - v84;
							end
						else
							v87 = ((v75 / v85) + (t_RunningSpeed_18 / v86)) - v84;
						end
					end
					if (v87 <= 0) then
						v87 = 0;
					end
					local v93 = 30 + v87;
					if (v93 < 20) then
						v93 = 20;
					end
					local v94 = v93 - ((v93 * 0.3) * (1 - (u30 / 2)));
					if (v94 >= 120) then
						v94 = 120;
					end
					if (p8 == "Front") then
						v74 = u41[2];
					else
						if (p8 == "Left") then
							v74 = u41[3];
						else
							if (p8 == "Right") then
								v74 = u41[4];
							end
						end
					end
					v74:Play();
					v74:AdjustSpeed(1.15);
					local v95 = u40.Health / u40.MaxHealth;
					local v96 = Instance.new("BodyVelocity", u43.UpperTorso);
					local v97 = v96;
					v96.Name = "DashV";
					local v98 = ((1 + (t_Fat_20 / 400)) + (v77 / 800)) + ((v81 - 1) / 1.4);
					if ((v95 <= 0.3) and (v77 > 800)) then
						v98 = v98 * (v95 + 0.5);
					end
					if (u43:FindFirstChild("SpeedDebuff")) then
						v98 = v98 * (1 - (u43.SpeedDebuff.Value / 100));
					end
					v97.MaxForce = Vector3.new(1, 0, 1) * (70000 * v98);
					stopSprint();
					u44:FireServer(u45, "Dash", u30);
					local v99 = Instance.new("BodyVelocity", u43.Head);
					local v100 = v99;
					v97.Name = "DashV";
					v99.MaxForce = Vector3.new(0, 1, 0) * (175000 * v98);
					v99.Velocity = Vector3.new(0, 11, 0);
					game.Debris:AddItem(v99, 0.13);
					local v101 = 1;
					local v102 = v101;
					if (not (v102 >= 5)) then
						while true do
							if (string.len(u28) > 5) then
							end
							local t_CFrame_22 = u46.CFrame;
							if (p8 == "Front") then
								v97.Velocity = t_CFrame_22.LookVector * v94;
							else
								if (p8 == "Left") then
									v97.Velocity = t_CFrame_22.rightVector * (-v94);
								else
									if (p8 == "Right") then
										v97.Velocity = t_CFrame_22.rightVector * v94;
									else
										v97.Velocity = t_CFrame_22.LookVector * (-v94);
									end
								end
							end
							wait(0);
							local v103 = v101 + 1;
							v101 = v103;
							if (v103 > 5) then
								break;
							end
						end
					end
					local g_pcall_23 = pcall;
					local u47 = v100;
					g_pcall_23(function() -- [line 320] anonymous function
						--[[
							Upvalues: 
								[1] = u47
						--]]
						u47:Destroy();
					end);
					v97:Destroy();
					u30 = u30 - 1;
					local v104 = u30;
					if (v104 == 0) then
						u32 = true;
						delay(0.6, function() -- [line 327] anonymous function
							--[[
								Upvalues: 
									[1] = u32
							--]]
							u32 = false;
						end);
					end
					u31 = tick();
					local v105 = u31;
					local g_delay_24 = delay;
					local u48 = v105;
					g_delay_24(3, function() -- [line 333] anonymous function
						--[[
							Upvalues: 
								[1] = u30
								[2] = u48
								[3] = u31
								[4] = u39
						--]]
						u30 = u30 + 1;
						local v106 = u48;
						if (v106 == u31) then
							local v107 = false;
							u39 = "";
							if (u30 > 3) then
								v107 = true;
							else
								local v108 = u30;
								if (v108 == 1) then
									v107 = true;
								end
							end
							if (v107) then
								local v109 = 0;
								local v110 = u30;
								if (v110 == 1) then
									v109 = 1;
									u30 = 0;
								end
								wait(v109);
								u30 = 3;
							end
						end
					end);
					wait(0.3);
					u29 = false;
					return;
				end
			end
		end
	end
end;
Dash = f_Dash;
local u49 = false;
local u50 = true;
local u51 = 0;
local u52 = nil;
local u53 = true;
local u54 = false;
local u55 = v32;
local u56 = u8;
local u57 = u4;
local u58 = v33;
local u59 = v34;
local u60 = v8;
local u61 = u3;
local u62 = v10;
local u63 = t_Action_7;
local u64 = v7;
local u65 = v61;
local u66 = t_PrimaryPart_6;
local f_runPrompt;
f_runPrompt = function() -- [line 357] runPrompt
	--[[
		Upvalues: 
			[1] = u55
			[2] = u24
			[3] = u56
			[4] = u26
			[5] = u57
			[6] = u58
			[7] = u59
			[8] = u60
			[9] = u61
			[10] = u54
			[11] = u62
			[12] = u23
			[13] = u63
			[14] = u64
			[15] = u65
			[16] = u66
			[17] = u25
			[18] = u33
			[19] = u51
	--]]
	local v111 = false;
	local v112;
	if (u55.RightUpperLeg) then
		v112 = true;
		if (not (u55.RightUpperLeg.BoneDamage >= 45)) then
			v111 = true;
		end
	else
		v111 = true;
	end
	if (v111) then
		v112 = u55.LeftUpperLeg;
		if (v112) then
			v112 = 45 <= u55.LeftUpperLeg.BoneDamage;
		end
	end
	local v113 = false;
	local v114;
	if (u55.RightLowerLeg) then
		v114 = true;
		if (not (u55.RightLowerLeg.BoneDamage >= 45)) then
			v113 = true;
		end
	else
		v113 = true;
	end
	if (v113) then
		v114 = u55.LeftLowerLeg;
		if (v114) then
			v114 = 45 <= u55.LeftLowerLeg.BoneDamage;
		end
	end
	if ((_G.CanUse() and (not u24)) and (not ((u56.RunDisable or v114) or v112))) then
		u26 = true;
		local t_Value_25 = u57.BodyDepthScale.Value;
		if (t_Value_25 < 1) then
		end
		local v115 = false;
		local v116 = u58.LowerBodyMuscle;
		local t_LowerBodyMuscle_26 = v116;
		local v117 = u58.UpperBodyMuscle;
		local t_UpperBodyMuscle_27 = v117;
		local t_Fat_28 = u58.Fat;
		local t_RunningSpeed_29 = u58.RunningSpeed;
		local t_RunningSpeed_30 = u59.RunningSpeed;
		local v118 = v116 + v117;
		local t_MuscleDensity_31 = u58.MuscleDensity;
		local v119, v120 = u60.VestInfo(u61);
		local v121 = v119;
		local v122;
		if (v119) then
			v122 = v121.SpeedReduction;
			if (not v122) then
				v115 = true;
			end
		else
			v115 = true;
		end
		if (v115) then
			v122 = 0;
		end
		local v123 = false;
		local v124;
		if (v121) then
			v124 = v121.AccelerationReduction;
			if (not v124) then
				v123 = true;
			end
		else
			v123 = true;
		end
		if (v123) then
			v124 = 0;
		end
		local v125 = 240 * (1 + (1 - t_MuscleDensity_31));
		local v126 = 0;
		if (v125 < v118) then
			local v127 = false;
			v118 = v118 - v125;
			local v128 = v118 / 1100;
			local v129;
			if (v128 < 0.9) then
				v129 = v118 / 1100;
				if (not v129) then
					v127 = true;
				end
			else
				v127 = true;
			end
			if (v127) then
				v129 = 0.9;
			end
			v126 = v129;
			if (v118 >= 1500) then
				v126 = 1;
			end
		end
		local v130 = false;
		local v131;
		if (u58.Clan) then
			local t_Clan_32 = u58.Clan;
			if (t_Clan_32 == "Mikazuchi") then
				v131 = 1600;
			else
				v130 = true;
			end
		else
			v130 = true;
		end
		if (v130) then
			v131 = 1300;
		end
		local v132 = false;
		local v133;
		if (u58.Clan) then
			local t_Clan_33 = u58.Clan;
			if (t_Clan_33 == "Jigoro") then
				v133 = 1300;
			else
				v132 = true;
			end
		else
			v132 = true;
		end
		if (v132) then
			v133 = 1100;
		end
		local v134 = false;
		local v135 = t_Fat_28 / v133;
		local v136;
		if (v135 < 1) then
			v136 = t_Fat_28 / v133;
			if (not v136) then
				v134 = true;
			end
		else
			v134 = true;
		end
		if (v134) then
			v136 = 1;
		end
		local v137 = 1 - (v136 + v126);
		local v145;
		if (t_RunningSpeed_29 > 800) then
			local v138 = t_RunningSpeed_29 - 800;
			local v139 = v138;
			local v140;
			if (v138 > 0) then
				v140 = v139 * 0.3;
			else
				v140 = 0;
			end
			local v141 = false;
			local v142 = 800 + v140;
			local v143 = v142;
			local v144;
			if (v131 < v142) then
				v144 = v131;
				if (not v144) then
					v141 = true;
				end
			else
				v141 = true;
			end
			if (v141) then
				v144 = v143;
			end
			v145 = 12 + (((4 + ((v144 + (t_RunningSpeed_30 / 5)) / 60)) - v122) * v137);
		else
			v145 = 12 + ((((4 + ((t_RunningSpeed_29 + (t_RunningSpeed_30 / 5)) / 60)) - v122) * v137) * 1);
		end
		if ((v118 >= 1300) or (v126 >= 0.8)) then
			local v146 = v118 - 1300;
			if (v146 > 2000) then
				v146 = 2000 + ((v146 - 2000) * 0.55);
			end
			v145 = v145 + (v146 / 250);
		else
			if (t_Fat_28 >= 400) then
				local v147 = t_Fat_28 - 300;
				if (v118 <= (t_Fat_28 - 200)) then
					v145 = v145 + (v147 / 180);
				end
			end
		end
		if ((not ((u55.RightUpperLeg and (u55.RightUpperLeg.Bruising >= 45)) and u55.RightUpperLeg.Bruising)) and (u55.LeftUpperLeg and (u55.LeftUpperLeg.Bruising >= 45))) then
			local v148 = u55.LeftUpperLeg.Bruising;
		end
		if ((not ((u55.RightLowerLeg and (u55.RightLowerLeg.Bruising >= 45)) and u55.RightLowerLeg.Bruising)) and (u55.LeftLowerLeg and (u55.LeftLowerLeg.Bruising >= 45))) then
			local v149 = u55.LeftLowerLeg.Bruising;
		end
		local v150 = v118 / 2;
		local v151 = ((t_LowerBodyMuscle_26 / v150) + (t_UpperBodyMuscle_27 / v150)) / 2;
		local v152 = ((0.03 + ((t_LowerBodyMuscle_26 / 1400) * v151)) - v124) * (1 - (((0.21 + ((1 - v151) * 0.8)) + ((v118 / 5900) * t_MuscleDensity_31)) - (t_Fat_28 / 600)));
		if (v152 < 0.008) then
			v152 = 0.008;
		end
		local v153 = false;
		local v154;
		if (u54) then
			v154 = u62[6];
			if (not v154) then
				v153 = true;
			end
		else
			v153 = true;
		end
		if (v153) then
			v154 = u62[1];
		end
		if (u23) then
			u54 = false;
			v154 = u23;
		end
		local v155, v156, v157 = pairs(u57:GetPlayingAnimationTracks());
		local v158 = v155;
		local v159 = v156;
		local v160 = v157;
		while true do
			local v161, v162 = v158(v159, v160);
			local v163 = v161;
			local v164 = v162;
			if (v161) then
				break;
			end
			v160 = v163;
			local t_Name_34 = v164.Name;
			if (t_Name_34 == "StyleWalk") then
				v164.Priority = Enum.AnimationPriority.Core;
			end
		end
		v154:Play();
		v154:AdjustSpeed(0.8);
		u63:FireServer(u64, "RunToggle", {
			true,
			u54
		});
		u65.Parent = u66;
		if (v152 < 1) then
			local v165 = 0.8;
			while true do
				local v166 = u25;
				if ((v166 < v145) and u26) then
					u25 = u25 + (v145 * v152);
					if (v165 < 1.2) then
						v165 = v165 + 0.02;
					end
					if (u54 and (v165 > 1)) then
						v165 = 1;
					end
					v154:AdjustSpeed(v165);
					wait(0);
				else
					break;
				end
			end
		end
		if (u26) then
			u33 = true;
			u25 = v145;
			u51 = v145;
			local v167;
			if (u54) then
				v167 = 1;
			else
				v167 = 1.2;
			end
			v154:AdjustSpeed(v167);
		end
	end
end;
runPrompt = f_runPrompt;
local u67 = false;
local u68 = false;
local u69 = t_Action_7;
local u70 = v7;
local u71 = v10;
local u72 = t_PrimaryPart_6;
local u73 = u3;
local f_rhythm_or_jogSwitch;
f_rhythm_or_jogSwitch = function() -- [line 469] rhythm_or_jogSwitch
	--[[
		Upvalues: 
			[1] = u25
			[2] = u33
			[3] = u50
			[4] = u23
			[5] = u54
			[6] = u51
			[7] = u69
			[8] = u70
			[9] = u68
			[10] = u67
			[11] = u71
			[12] = u52
			[13] = u53
			[14] = u72
			[15] = u73
	--]]
	if (not (((u25 > 0) and u33) and (u50 and (not u23)))) then
		if (u52 and u53) then
			u53 = false;
			delay(1, function() -- [line 497] anonymous function
				--[[
					Upvalues: 
						[1] = u53
				--]]
				u53 = true;
			end);
			if (u52.Stance.IsPlaying) then
				u52.Stance:Stop();
			else
				local t_tool_35 = u52.tool;
				u52.Stance:Play();
				u69:FireServer(u70, "RhythmStance", true);
				while true do
					local t_magnitude_36 = u72.Velocity.magnitude;
					if (((t_magnitude_36 <= 0.5) and u52) and ((u52.Stance.IsPlaying and u73:FindFirstChild("Block")) and (t_tool_35 == u52.tool))) then
						wait(0);
					else
						break;
					end
				end
				if (u52 and u52.Stance.IsPlaying) then
					u52.Stance:Stop();
				end
				u69:FireServer(u70, "RhythmStance", false);
				return;
			end
		end
		return;
	end
	local v168 = false;
	u50 = false;
	u54 = not u54;
	local v169 = u25;
	local v170;
	if (v169 == u51) then
		v170 = u25 * 0.6;
		if (not v170) then
			v168 = true;
		end
	else
		v168 = true;
	end
	if (v168) then
		v170 = u51;
	end
	u25 = v170;
	u69:FireServer(u70, "JogToggle");
	if (u54) then
		if (not u68) then
			u68 = true;
			u67 = true;
			delay(0.5, function() -- [line 479] anonymous function
				--[[
					Upvalues: 
						[1] = u67
						[2] = u68
				--]]
				u67 = false;
				wait(4.5);
				u68 = false;
			end);
		end
		u71[1]:Stop();
		u71[6]:Play();
	else
		u71[1]:Play();
		u71[6]:Stop();
	end
	delay(0.6, function() -- [line 491] anonymous function
		--[[
			Upvalues: 
				[1] = u50
		--]]
		u50 = true;
	end);
end;
rhythm_or_jogSwitch = f_rhythm_or_jogSwitch;
local f_block_or_m2;
f_block_or_m2 = function() -- [line 519] block_or_m2
end;
block_or_m2 = f_block_or_m2;
local u74 = nil;
if (v4) then
	local g_delay_37 = delay;
	local u75 = t_PlayerGui_3;
	local u76 = u3;
	local u77 = t_Events_5;
	local u78 = v7;
	local u79 = t_Action_7;
	local u80 = u8;
	local u81 = u4;
	local u82 = t_CurrentCamera_8;
	g_delay_37(2, function() -- [line 525] anonymous function
		--[[
			Upvalues: 
				[1] = u75
				[2] = u74
				[3] = u2
				[4] = u76
				[5] = u26
				[6] = u33
				[7] = u50
				[8] = u25
				[9] = u54
				[10] = u24
				[11] = u77
				[12] = u78
				[13] = u49
				[14] = u79
				[15] = u80
				[16] = u81
				[17] = u82
				[18] = u28
		--]]
		local v171 = u75:FindFirstChild("BackpackGUI");
		local v172 = v171;
		if (v171 and v171:FindFirstChild("MobileFrame")) then
			u74 = v172:FindFirstChild("MobileFrame");
			local v173, v174, v175 = pairs(u74:GetChildren());
			local v176 = v173;
			local v177 = v174;
			local v178 = v175;
			while true do
				local v179, v180 = v176(v177, v178);
				local v181 = v179;
				local v182 = v180;
				if (v179) then
					break;
				end
				v178 = v181;
				if (v182:IsA("ImageButton")) then
					local v183 = v182.Name;
					local v184 = v182.MouseButton1Click;
					local t_Name_38 = v183;
					v184:connect(function() -- [line 533] anonymous function
						--[[
							Upvalues: 
								[1] = u2
								[2] = u76
								[3] = t_Name_38
								[4] = u26
								[5] = u74
								[6] = u33
								[7] = u50
								[8] = u25
								[9] = u54
								[10] = u24
								[11] = u77
								[12] = u78
								[13] = u49
								[14] = u79
								[15] = u80
								[16] = u81
								[17] = u82
								[18] = u28
						--]]
						if (u2) then
							return;
						end
						u2 = true;
						local v185 = u76:FindFirstChildWhichIsA("Tool");
						local v186 = t_Name_38;
						if (v186 == "Sprint_Toggle") then
							if (u26) then
								stopSprint();
								u74.Jog_Toggle.Visible = false;
							else
								spawn(function() -- [line 541] anonymous function
									--[[
										Upvalues: 
											[1] = u74
									--]]
									u74.Jog_Toggle.Visible = true;
									runPrompt();
								end);
							end
						else
							local v187 = t_Name_38;
							if (v187 == "Jog_Toggle") then
								if ((u33 and u50) and (u25 > 0)) then
									rhythm_or_jogSwitch();
									local t_Txt_39 = u74.Jog_Toggle.Txt;
									local v188;
									if (u54) then
										v188 = "Jogging";
									else
										v188 = "Sprinting";
									end
									t_Txt_39.Text = v188;
									local t_Icon_40 = u74.Jog_Toggle.Icon;
									local v189;
									if (u54) then
										v189 = "6556331887";
									else
										v189 = "6556339039";
									end
									t_Icon_40.Image = "http://www.roblox.com/asset/?id=" .. v189;
								end
							else
								local v190 = t_Name_38;
								if (((v190 == "Mount") and _G.CanUse("", true)) and (not u24)) then
									if (u76:FindFirstChild("Mounting")) then
										u77.Mount:FireServer(u78, "Unmount");
									else
										u77.Mount:FireServer(u78, "Mount");
									end
								else
									local v191 = t_Name_38;
									if (v191 == "Rhythm") then
										rhythm_or_jogSwitch();
									else
										local v192 = t_Name_38;
										if ((v192 == "Rob") and (not u49)) then
											u49 = true;
											u79:FireServer(u78, "Rob");
											delay(0.5, function() -- [line 567] anonymous function
												--[[
													Upvalues: 
														[1] = u49
												--]]
												u49 = false;
											end);
										else
											local v193 = false;
											local v194 = t_Name_38;
											if ((v194 == "Dash") and (not u80.DashDisable)) then
												local t_FloorMaterial_41 = u81.FloorMaterial;
												if ((t_FloorMaterial_41 == Enum.Material.Air) or u80.NoMovement) then
													v193 = true;
												else
													local v195 = u76.Humanoid.MoveDirection;
													local t_MoveDirection_42 = v195;
													if (v195:Dot(u82.CFrame.LookVector) > 0.75) then
														Dash("Front");
													else
														local v196 = t_MoveDirection_42:Dot(u82.CFrame.LookVector);
														if (v196 < -0.75) then
															Dash("Back");
														else
															if (t_MoveDirection_42:Dot(u82.CFrame.RightVector) > 0.75) then
																Dash("Right");
															else
																local v197 = t_MoveDirection_42:Dot(u82.CFrame.RightVector);
																if (v197 < -0.75) then
																	Dash("Left");
																end
															end
														end
													end
													wait(0.2);
													u28 = "";
												end
											else
												v193 = true;
											end
											if (v193) then
												local v198 = t_Name_38;
												if (v198 == "Guardbreak") then
													if (v185 and (v185:FindFirstChild("Skill") or v185:FindFirstChild("Style"))) then
														u79:FireServer(u78, "GuardBreak", {
															true
														});
													end
												else
													local v199 = t_Name_38;
													if (v199 == "BlockToggle") then
														if (u24) then
															u24 = false;
															u79:FireServer(u78, "Block", {
																false
															});
														else
															if (v185 and (v185:FindFirstChild("Skill") or v185:FindFirstChild("Style"))) then
																spawn(function() -- [line 590] anonymous function
																	--[[
																		Upvalues: 
																			[1] = u24
																			[2] = u80
																			[3] = u79
																			[4] = u78
																	--]]
																	u24 = true;
																	if (not ((_G.CanUse() and (not u80.BlockDisable)) and (not u80.Slashing))) then
																		while true do
																			wait(0);
																			if ((_G.CanUse() and (not u80.BlockDisable)) and (not u80.Slashing)) then
																				break;
																			end
																		end
																	end
																	if (u24) then
																		stopSprint();
																		u79:FireServer(u78, "Block", {
																			true
																		});
																	end
																end);
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
						wait(0);
						u2 = false;
					end);
				end
			end
		end
	end);
end
local v200 = v3.InputBegan;
local u83 = v3;
local u84 = v7;
local u85 = v33;
local u86 = v59;
local u87 = u8;
local u88 = u4;
local u89 = u3;
local u90 = t_Action_7;
local u91 = t_Events_5;
v200:connect(function(p10, p11) -- [line 617] anonymous function
	--[[
		Upvalues: 
			[1] = u83
			[2] = u84
			[3] = u85
			[4] = u86
			[5] = u27
			[6] = u24
			[7] = u87
			[8] = u88
			[9] = u28
			[10] = u89
			[11] = u90
			[12] = u91
			[13] = u49
	--]]
	local v201 = u83:GetFocusedTextBox();
	if (not ((((v201 == nil) and (not p11)) and u84) and u85.RunningSpeed)) then
		return;
	end
	local v202 = p10.KeyCode.Name:lower();
	if ((((v202 == "w") or (v202 == "a")) or ((v202 == "s") or (v202 == "d"))) or ((v202 == "down") or (v202 == "up"))) then
		if (not ((v202 == "up") or (v202 == "down"))) then
			u86[v202] = true;
		end
		if (v202 == "w") then
			u27 = u27 .. v202;
			delay(0.2, function() -- [line 626] anonymous function
				--[[
					Upvalues: 
						[1] = u27
				--]]
				u27 = "";
			end);
			local v203 = u27;
			if (((v203 == "ww") and _G.CanUse()) and (not u24)) then
				runPrompt();
				return;
			end
		else
			if (((v202 == "s") or (v202 == "down")) or (v202 == "up")) then
				stopSprint();
				return;
			end
		end
	else
		if (v202 == "r") then
			rhythm_or_jogSwitch();
			return;
		end
		if ((v202 == "q") and (not u87.DashDisable)) then
			local t_FloorMaterial_43 = u88.FloorMaterial;
			if (not ((t_FloorMaterial_43 == Enum.Material.Air) or u87.NoMovement)) then
				u28 = u28 .. v202;
				if (u86.w) then
					Dash("Front");
				else
					if (u86.a) then
						Dash("Left");
					else
						if (u86.d) then
							Dash("Right");
						else
							Dash("Back");
						end
					end
				end
				wait(0.2);
				u28 = "";
				return;
			end
		end
		local v204 = false;
		if (v202 == "f") then
			v204 = true;
		else
			local t_UserInputType_44 = p10.UserInputType;
			if (t_UserInputType_44 == Enum.UserInputType.MouseButton2) then
				v204 = true;
			else
				if (((v202 == "v") and _G.CanUse("", true)) and (not u24)) then
					if (u89:FindFirstChild("Mounting")) then
						u91.Mount:FireServer(u84, "Unmount");
						return;
					end
					u91.Mount:FireServer(u84, "Mount");
					return;
				end
				if ((v202 == "c") and (not u49)) then
					u49 = true;
					u90:FireServer(u84, "Rob");
					delay(0.5, function() -- [line 673] anonymous function
						--[[
							Upvalues: 
								[1] = u49
						--]]
						u49 = false;
					end);
				end
			end
		end
		if (v204) then
			local v205 = u89:FindFirstChildWhichIsA("Tool");
			if (v205 and (v205:FindFirstChild("Skill") or v205:FindFirstChild("Style"))) then
				local t_UserInputType_45 = p10.UserInputType;
				if (t_UserInputType_45 == Enum.UserInputType.MouseButton2) then
					u90:FireServer(u84, "GuardBreak", {
						true
					});
					return;
				end
				u24 = true;
				if (not ((_G.CanUse(nil, nil, nil, true) and (not u87.BlockDisable)) and (not u87.Slashing))) then
					while true do
						wait(0);
						if ((_G.CanUse(nil, nil, nil, true) and (not u87.BlockDisable)) and (not u87.Slashing)) then
							break;
						end
					end
				end
				if (u24) then
					stopSprint();
					u90:FireServer(u84, "Block", {
						true
					});
					return;
				end
			end
		end
	end
end);
local v206 = v3.InputEnded;
local u92 = v59;
local u93 = t_Action_7;
local u94 = v7;
v206:connect(function(p12) -- [line 679] anonymous function
	--[[
		Upvalues: 
			[1] = u92
			[2] = u26
			[3] = u24
			[4] = u93
			[5] = u94
	--]]
	local v207 = p12.KeyCode.Name:lower();
	if (((v207 == "w") or (v207 == "a")) or ((v207 == "s") or (v207 == "d"))) then
		u92[v207] = false;
		if ((v207 == "w") and u26) then
			stopSprint();
			return;
		end
	else
		if ((v207 == "f") and u24) then
			u24 = false;
			u93:FireServer(u94, "Block", {
				false
			});
		end
	end
end);
local u95 = nil;
local v208 = t_Action_7.OnClientEvent;
local u96 = v8;
local u97 = t_LocalPlayer_1;
local u98 = t_Utility_10;
local u99 = u4;
local u100 = t_Action_7;
local u101 = v7;
local u102 = v17;
local u103 = u8;
local u104 = u3;
v208:Connect(function(p13, p14) -- [line 693] anonymous function
	--[[
		Upvalues: 
			[1] = u96
			[2] = u97
			[3] = u98
			[4] = u23
			[5] = u99
			[6] = u24
			[7] = u100
			[8] = u101
			[9] = u102
			[10] = u103
			[11] = u95
			[12] = u104
			[13] = u52
			[14] = u74
	--]]
	if (p13 == "StopRunning") then
		stopSprint();
		return;
	end
	if (p13 == "StamIndicator1") then
		local v209 = false;
		local t_Tween_46 = u96.Tween;
		local v210 = u97;
		local t_Bar_47 = u98.StamBar.BarF.Bar;
		local v211 = {};
		local v212;
		if (p14) then
			v212 = Color3.fromRGB(255, 92, 92);
			if (not v212) then
				v209 = true;
			end
		else
			v209 = true;
		end
		if (v209) then
			v212 = Color3.fromRGB(30, 90, 255);
		end
		v211.BackgroundColor3 = v212;
		t_Tween_46(v210, t_Bar_47, 0.35, v211);
		return;
	end
	if (p13 == "RunReplace") then
		if (not p14) then
			u23 = nil;
			return;
		end
		local v213 = Instance.new("Animation");
		v213.AnimationId = p14;
		u23 = u99:LoadAnimation(v213);
		v213:Destroy();
		stopSprint();
		return;
	end
	if (p13 == "RemoveBlock") then
		u24 = false;
		u100:FireServer(u101, "Block", {
			false
		});
		return;
	end
	if ((p13 == "InCombat") and u102) then
		u98.CombatTag.Visible = p14;
		return;
	end
	if ((p13 == "AddValue") or (p13 == "RemoveValue")) then
		local v214 = u103[p14.name];
		if (p13 == "AddValue") then
			if (v214) then
				v214.count = v214.count + 1;
				table.insert(v214.values, p14.Value);
				return;
			end
			local v215 = u103;
			local v216 = p14.name;
			local v217 = {};
			v217.count = 1;
			v217.values = {
				p14.val
			};
			v215[v216] = v217;
			return;
		end
		if (v214) then
			v214.count = v214.count - 1;
			local v218, v219, v220 = pairs(v214.values);
			local v221 = v218;
			local v222 = v219;
			local v223 = v220;
			while true do
				local v224, v225 = v221(v222, v223);
				local v226 = v224;
				local v227 = v225;
				if (not v224) then
					v223 = v226;
					if (v227 == p14.val) then
						table.remove(v214.values, v226);
					else
						continue;
					end
				end
				local t_count_48 = v214.count;
				if (not (t_count_48 <= 0)) then
				end
				break;
			end
			u103[p14.name] = nil;
			return;
		end
	else
		if (p13 == "ToolRegister") then
			local v228 = p14[1];
			local u105 = nil;
			local u106 = nil;
			if (p14[2]) then
				local v229 = Instance.new("Animation");
				v229.AnimationId = p14[2][1];
				u105 = u99:LoadAnimation(v229);
				u105.Priority = Enum.AnimationPriority.Idle;
				local v230 = Instance.new("Animation");
				v230.AnimationId = p14[2][2];
				u106 = u99:LoadAnimation(v230);
				if (not u95) then
					u95 = {
						u105,
						u106
					};
				end
				u95 = {
					u105,
					u106
				};
			end
			local u107 = false;
			local v231 = v228.Equipped;
			local u108 = v228;
			local u109 = p14;
			v231:connect(function() -- [line 756] anonymous function
				--[[
					Upvalues: 
						[1] = u105
						[2] = u95
						[3] = u106
						[4] = u107
						[5] = u104
						[6] = u52
						[7] = u108
						[8] = u74
						[9] = u109
				--]]
				if (not u105) then
					u105 = u95[1];
					u106 = u95[2];
				end
				u105 = u95[1];
				u106 = u95[2];
				u107 = true;
				if (u104:FindFirstChild("Mounted") or u104:FindFirstChild("Mounting")) then
					while true do
						wait(0.1);
						if (not ((u104:FindFirstChild("Mounted") or u104:FindFirstChild("Mounting")) and u107)) then
							break;
						end
					end
				end
				if (u107) then
					u105:Play();
					u105.Priority = Enum.AnimationPriority.Idle;
					local v232 = {};
					v232.Stance = u106;
					v232.tool = u108;
					u52 = v232;
				end
				if (u74) then
					if (u109[2]) then
						u74.Guardbreak.Visible = true;
					end
					u74.BlockToggle.Visible = true;
					u74.Rhythm.Visible = true;
				end
			end);
			v228.Unequipped:connect(function() -- [line 778] anonymous function
				--[[
					Upvalues: 
						[1] = u107
						[2] = u105
						[3] = u52
						[4] = u74
				--]]
				u107 = false;
				u105:Stop();
				if (u52) then
					u52.Stance:Stop();
				end
				u52 = nil;
				if (u74) then
					u74.Rhythm.Visible = false;
					u74.Guardbreak.Visible = false;
					u74.BlockToggle.Visible = false;
				end
			end);
		end
	end
end);
local v233 = v10[1]:GetMarkerReachedSignal("Footstep");
local u110 = u4;
local u111 = u8;
local u112 = v8;
local u113 = u3;
v233:Connect(function(p15) -- [line 790] anonymous function
	--[[
		Upvalues: 
			[1] = u110
			[2] = u111
			[3] = u29
			[4] = u112
			[5] = u113
	--]]
	local t_FloorMaterial_49 = u110.FloorMaterial;
	if (((t_FloorMaterial_49 == Enum.Material.Air) or u111.Stun) or ((u111.Hit or u110.PlatformStand) or u29)) then
		return;
	end
	u112.FootstepSound(true, u113, u113.RightFoot.Position, true);
end);
local v234 = v10[6]:GetMarkerReachedSignal("Footstep");
local u114 = u4;
local u115 = u8;
local u116 = v8;
local u117 = u3;
v234:Connect(function(p16) -- [line 795] anonymous function
	--[[
		Upvalues: 
			[1] = u114
			[2] = u115
			[3] = u29
			[4] = u116
			[5] = u117
	--]]
	local t_FloorMaterial_50 = u114.FloorMaterial;
	if (((t_FloorMaterial_50 == Enum.Material.Air) or u115.Stun) or ((u115.Hit or u114.PlatformStand) or u29)) then
		return;
	end
	u116.FootstepSound(true, u117, u117.RightFoot.Position, true);
end);
local u118 = true;
local u119 = false;
u4.StateChanged:connect(function(p17, p18) -- [line 802] anonymous function
	--[[
		Upvalues: 
			[1] = u118
			[2] = u119
	--]]
	if ((p18 == Enum.HumanoidStateType.Jumping) and u118) then
		u118 = false;
		return;
	end
	if (not (((p18 == Enum.HumanoidStateType.Jumping) or (p18 == Enum.HumanoidStateType.FallingDown)) or (u118 or u119))) then
		u119 = true;
		delay(2, function() -- [line 807] anonymous function
			--[[
				Upvalues: 
					[1] = u119
					[2] = u118
			--]]
			u119 = false;
			u118 = true;
		end);
	end
end);
u4.HealthChanged:connect(function(p19) -- [line 815] anonymous function
	--[[
		Upvalues: 
			[1] = t_Utility_10
			[2] = u4
	--]]
	t_Utility_10.HPBar.BarF.Bar:TweenSize(UDim2.new(p19 / u4.MaxHealth, 0, 1, 0), "Out", "Quad", 0.1, true);
end);
t_Parent_2.GetMouse.OnClientInvoke = function() -- [line 820] anonymous function
	--[[
		Upvalues: 
			[1] = u1
	--]]
	return u1.Hit, u1.Target;
end;
local u120 = 0;
local u121 = 100;
local u122 = 100;
local u123 = false;
local u124 = t_PrimaryPart_6.Position;
local u125 = 0;
local u126 = true;
local u127 = true;
local u128 = true;
local u129 = t_PrimaryPart_6.Position;
while true do
	wait(0);
	if (v33.UpperBodyMuscle and v33.LowerBodyMuscle) then
		break;
	end
end
local v235 = v1.RenderStepped;
local u130 = u8;
local u131 = u4;
local u132 = t_Utility_10;
local u133 = v11;
local u134 = v12;
local u135 = v8;
local u136 = t_LocalPlayer_1;
local u137 = v33;
local u138 = t_PrimaryPart_6;
local u139 = t_Events_5;
local u140 = v7;
local u141 = u1;
local u142 = u3;
local u143 = v34;
v235:connect(function() -- [line 837] anonymous function
	--[[
		Upvalues: 
			[1] = u26
			[2] = u130
			[3] = u121
			[4] = u131
			[5] = u132
			[6] = u122
			[7] = u133
			[8] = u120
			[9] = u134
			[10] = u123
			[11] = u135
			[12] = u136
			[13] = u118
			[14] = u29
			[15] = u137
			[16] = u138
			[17] = u124
			[18] = u127
			[19] = u125
			[20] = u139
			[21] = u140
			[22] = u141
			[23] = u129
			[24] = u128
			[25] = u126
			[26] = u142
			[27] = u25
			[28] = u143
			[29] = u33
			[30] = u67
			[31] = u54
			[32] = u51
			[33] = u32
	--]]
	if (u26 and (not ((_G.CanUse() and (not u130.StopSprint)) and (not u130.RunDisable)))) then
		stopSprint();
	end
	local v236 = u121;
	if (v236 ~= u131.Cap.Value) then
		u121 = u131.Cap.Value;
		u132.HPBar.Cap.Bar:TweenSize(UDim2.new(u121 / u131.MaxHealth, 0, 1, 0), "Out", "Quad", 0.1, true);
	end
	local v237 = u122;
	if (v237 ~= u131.Conscious.Value) then
		u122 = u131.Conscious.Value;
		u132.HPBar.ConscioussnessF.Bar:TweenSize(UDim2.new(u122 / 100, 0, 1, 0), "Out", "Quad", 0.1, true);
	end
	local t_Value_51 = u133.Value;
	if (t_Value_51 ~= u120) then
		u120 = u133.Value;
		u132.StamBar.BarF.Bar:TweenSize(UDim2.new(u120 / u134.Value, 0, 1, 0), "Out", "Quad", 0.1, true);
		local t_Value_52 = u133.Value;
		if ((t_Value_52 < 0) and (not u123)) then
			spawn(function() -- [line 854] anonymous function
				--[[
					Upvalues: 
						[1] = u123
						[2] = u133
						[3] = u135
						[4] = u136
						[5] = u132
				--]]
				u123 = true;
				while true do
					local t_Value_53 = u133.Value;
					if (t_Value_53 < 0) then
						local v238 = u135.Tween;
						local v239 = u136;
						local v240 = u132.StamBar.BG;
						local v241 = {};
						v241.BackgroundColor3 = Color3.fromRGB(255, 73, 73);
						v238(v239, v240, 0.8, v241);
						wait(1);
						if (u133.Value > 0) then
							break;
						end
						local v242 = u135.Tween;
						local v243 = u136;
						local v244 = u132.StamBar.BG;
						local v245 = {};
						v245.BackgroundColor3 = Color3.fromRGB(90, 90, 90);
						v242(v243, v244, 0.8, v245);
						wait(1);
					else
						break;
					end
				end
				u123 = false;
				if (u133.Value > 0) then
					local v246 = u135.Tween;
					local v247 = u136;
					local v248 = u132.StamBar.BG;
					local v249 = {};
					v249.BackgroundColor3 = Color3.fromRGB(90, 90, 90);
					v246(v247, v248, 0.2, v249);
				end
			end);
		end
	end
	u131.PlatformStand = false;
	u131.AutoRotate = true;
	if (not (u118 and (not u29))) then
		u131.Jump = false;
	end
	local v250 = 14 - ((u137.Fat or 0.0001) / 350);
	local t_magnitude_54 = u138.Velocity.magnitude;
	if (((t_magnitude_54 < 3) and ((u138.Position - u124).magnitude > 6)) and u127) then
		u127 = false;
		u125 = u125 + 1;
		if (u125 >= 6) then
			local v251 = u125 % 2;
			if (v251 == 0) then
				u139.Detector:FireServer(u140, "F1ySuspicion");
			end
		end
		local v252 = u125;
		local g_delay_55 = delay;
		local u144 = v252;
		g_delay_55(0.3, function() -- [line 890] anonymous function
			--[[
				Upvalues: 
					[1] = u127
					[2] = u125
					[3] = u144
			--]]
			u127 = true;
			wait(1.2);
			local v253 = u125;
			if (v253 == u144) then
				u125 = 0;
			end
		end);
	end
	local v254 = false;
	local t_p_56 = u141.Hit.p;
	if ((u138.Position - u129).magnitude > 55) then
		v254 = true;
	else
		local t_magnitude_57 = (u138.Position - t_p_56).magnitude;
		if ((t_magnitude_57 < 5) and ((u138.Position - u129).magnitude > 20)) then
			v254 = true;
		end
	end
	if (v254) then
		if (u128) then
			u128 = false;
			u139.Detector:FireServer(u140, "TPSuspicion", {
				(u138.Position - u129).magnitude,
				(u138.Position - t_p_56).magnitude
			});
			delay(0.3, function() -- [line 904] anonymous function
				--[[
					Upvalues: 
						[1] = u128
				--]]
				u128 = true;
			end);
		end
	end
	u129 = u138.Position;
	if (u126) then
		u126 = false;
		u124 = u138.Position;
		delay(0.2, function() -- [line 912] anonymous function
			--[[
				Upvalues: 
					[1] = u126
			--]]
			u126 = true;
		end);
	end
	local v255 = false;
	local v256;
	if (u130.Slashing and (u130.Slashing.count > 0)) then
		v256 = u130.Slashing.values[1];
		if (not v256) then
			v255 = true;
		end
	else
		v255 = true;
	end
	if (v255) then
		v256 = nil;
	end
	local v257 = u130.Stun;
	if (v257) then
		v257 = 0 < u130.Stun.count;
	end
	local v258 = u130.Hit;
	if (v258) then
		v258 = 0 < u130.Hit.count;
	end
	local v259 = u142:FindFirstChild("Blocking");
	local v260 = u142:FindFirstChild("KO");
	local v261 = u142:FindFirstChild("Mounting");
	if (not v261) then
		v261 = u142:FindFirstChild("Mounted");
	end
	local v262 = u130.Casting;
	if (v262) then
		v262 = 0 < u130.Casting.count;
	end
	local v263 = u130.NoRotate;
	if (v263) then
		v263 = 0 < u130.NoRotate.count;
	end
	local v264 = u130.NoMovement;
	if (v264) then
		v264 = 0 < u130.NoMovement.count;
	end
	local v265 = u130.JumpDisable;
	if (v265) then
		v265 = 0 < u130.JumpDisable.count;
	end
	local v266 = u130.Eating;
	if (v266) then
		v266 = 0 < u130.Eating.count;
	end
	local v267 = u130.IgnoreHP_Speed_Debuff;
	if (v267) then
		v267 = 0 < u130.IgnoreHP_Speed_Debuff.count;
	end
	if (u25 > 0) then
		local v268 = false;
		local v269 = u137.LowerBodyMuscle;
		local v270 = u137.UpperBodyMuscle;
		local t_Fat_58 = u137.Fat;
		local t_MuscleDensity_59 = u137.MuscleDensity;
		local v271 = v270 + v269;
		local t_RunningSpeed_60 = u137.RunningSpeed;
		local t_RunningSpeed_61 = u143.RunningSpeed;
		local v272, v273 = u135.VestInfo(u142);
		local v274 = v272;
		local v275;
		if (v272) then
			v275 = v274.SpeedReduction;
			if (not v275) then
				v268 = true;
			end
		else
			v268 = true;
		end
		if (v268) then
			v275 = 0;
		end
		if (v274 and v274.AccelerationReduction) then
		end
		local v276 = 240 * (1 + (1 - t_MuscleDensity_59));
		local v277 = 0;
		if (v276 < v271) then
			local v278 = false;
			v271 = v271 - v276;
			local v279 = v271 / 1100;
			local v280;
			if (v279 < 0.9) then
				v280 = v271 / 1100;
				if (not v280) then
					v278 = true;
				end
			else
				v278 = true;
			end
			if (v278) then
				v280 = 0.9;
			end
			v277 = v280;
			if (v271 >= 1500) then
				v277 = 1;
			end
		end
		local v281 = false;
		local v282;
		if (u137.Clan) then
			local t_Clan_62 = u137.Clan;
			if (t_Clan_62 == "Mikazuchi") then
				v282 = 1600;
			else
				v281 = true;
			end
		else
			v281 = true;
		end
		if (v281) then
			v282 = 1300;
		end
		local v283 = false;
		local v284;
		if (u137.Clan) then
			local t_Clan_63 = u137.Clan;
			if (t_Clan_63 == "Jigoro") then
				v284 = 1300;
			else
				v283 = true;
			end
		else
			v283 = true;
		end
		if (v283) then
			v284 = 1100;
		end
		local v285 = false;
		local v286 = t_Fat_58 / v284;
		local v287;
		if (v286 < 1) then
			v287 = t_Fat_58 / v284;
			if (not v287) then
				v285 = true;
			end
		else
			v285 = true;
		end
		if (v285) then
			v287 = 1;
		end
		local v288 = 1 - (v287 + v277);
		if (v288 < 0) then
			v288 = 0;
		end
		local v296;
		if (t_RunningSpeed_60 > 800) then
			local v289 = t_RunningSpeed_60 - 800;
			local v290 = v289;
			local v291;
			if (v289 > 0) then
				v291 = v290 * 0.3;
			else
				v291 = 0;
			end
			local v292 = false;
			local v293 = 800 + v291;
			local v294 = v293;
			local v295;
			if (v282 < v293) then
				v295 = v282;
				if (not v295) then
					v292 = true;
				end
			else
				v292 = true;
			end
			if (v292) then
				v295 = v294;
			end
			v296 = 12 + (((4 + ((v295 + (t_RunningSpeed_61 / 5)) / 60)) - v275) * v288);
		else
			v296 = 12 + ((((4 + ((t_RunningSpeed_60 + (t_RunningSpeed_61 / 5)) / 60)) - v275) * v288) * 1);
		end
		if ((v271 >= 1300) or (v277 >= 0.8)) then
			local v297 = v271 - 1300;
			if (v297 > 1700) then
				v297 = 1700 + ((v297 - 1700) * 0.55);
			end
			v296 = v296 + (v297 / 250);
		else
			if (t_Fat_58 >= 400) then
				local v298 = t_Fat_58 - 300;
				if (v271 <= (t_Fat_58 - 200)) then
					local v299 = t_Fat_58 - 250;
					if (v299 <= v271) then
						v296 = v296 + (v298 / 180);
					end
				end
			end
		end
		if (u33) then
			if (u67 and (not u54)) then
				u51 = u51 * 1.25;
			end
			local v300 = false;
			u51 = v296;
			local v301;
			if (u54) then
				v301 = u51 * 0.6;
				if (not v301) then
					v300 = true;
				end
			else
				v300 = true;
			end
			if (v300) then
				v301 = u51;
			end
			u25 = v301;
		end
		local t_Health_64 = u131.Health;
		if ((t_Health_64 < (u131.MaxHealth * 0.45)) and (not v267)) then
			local v302 = false;
			local t_Trait_65 = u137.Trait;
			local v303;
			if (t_Trait_65 == "Coward") then
				v303 = u51 * 0.4;
				if (not v303) then
					v302 = true;
				end
			else
				v302 = true;
			end
			if (v302) then
				v303 = u51 * 0.7;
			end
			local v304 = u51 - (v303 * (1 - (u131.Health / (u131.MaxHealth * 0.45))));
			if (u33 and (v304 < u25)) then
				u25 = v304;
			end
		end
	end
	if (u142:FindFirstChild("SpeedDebuff")) then
		u25 = u25 * (1 - (u142.SpeedDebuff.Value / 100));
	end
	local v305 = v250 + u25;
	if (v260 and u142:FindFirstChild("Unconscious")) then
		u132.HPBar.ConscioussnessF.Visible = true;
	else
		u132.HPBar.ConscioussnessF.Visible = false;
	end
	if (not ((u118 and (not ((u32 or v256) or (v257 or v258)))) and (not (((v259 or v260) or (v261 or v262)) or (v265 or v266))))) then
		u131.Jump = false;
		if (v259) then
			v305 = 8;
		end
		if (v266) then
			v305 = 6;
		end
		if (u32 or v258) then
			v305 = 5;
		end
		if (v256 or v258) then
			stopSprint();
			if (v256 and (v256 < v305)) then
				v305 = v256;
			end
		end
		if ((v257 or v260) or (v261 or v262)) then
			v305 = 0;
			u131.AutoRotate = false;
			if (v260) then
				u131.PlatformStand = true;
			end
		end
	end
	if ((u130.SetSpeed and (u130.SetSpeed.count > 0)) and u130.SetSpeed.values[1]) then
		v305 = u130.SetSpeed.values[1];
	end
	if (v263) then
		u131.AutoRotate = false;
	end
	if (v264 or v261) then
		v305 = 0;
	end
	u131.WalkSpeed = v305;
end);
u4:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
u4:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
