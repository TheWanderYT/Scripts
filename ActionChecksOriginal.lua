local module = {}

module.AttackCheck = function(CharacterData)
	if CharacterData:FindFirstChild("Action") then
		return false
	end

	if CharacterData:FindFirstChild("Blocking") then
		return false
	end

	if CharacterData:FindFirstChild("Stun") then
		return false
	end

	if CharacterData:FindFirstChild("Ragdoll") then
		return false
	end

	if CharacterData:FindFirstChild("Mount") then
		return false
	end

	if CharacterData:FindFirstChild("Unconscious") then
		return false
	end

	if CharacterData:FindFirstChild("Mounted") then
		return false
	end

	return true
end

module.ModeCheck = function(CharacterData)
	if CharacterData:FindFirstChild("Action") then
		return false
	end

	if CharacterData:FindFirstChild("Blocking") then
		return false
	end

	if CharacterData:FindFirstChild("Stun") and not CharacterData:FindFirstChild('DuraTraining') then
		return false
	end

	if CharacterData:FindFirstChild("Ragdoll") then
		return false
	end

	if CharacterData:FindFirstChild("Mount") then
		return false
	end

	if CharacterData:FindFirstChild("Unconscious") then
		return false
	end

	if CharacterData:FindFirstChild("Mounted") then
		return false
	end

	return true
end

module.MountCheck = function(CharacterData)
	if CharacterData:FindFirstChild("Action") then
		return false
	end

	if CharacterData:FindFirstChild("Blocking") then
		return false
	end

	if CharacterData:FindFirstChild("Stun") then
		return false
	end

	if CharacterData:FindFirstChild("Ragdoll") then
		return false
	end
	
	if CharacterData:FindFirstChild("Mount") then
		return false
	end
	
	if CharacterData:FindFirstChild("Unconscious") then
		return false
	end
	
	if CharacterData:FindFirstChild("Mounted") then
		return false
	end
	
	return true
end

module.RobCheck = function(CharacterData)
	if CharacterData:FindFirstChild("Action") then
		return false
	end

	if CharacterData:FindFirstChild("Blocking") then
		return false
	end

	if CharacterData:FindFirstChild("Stun") then
		return false
	end

	if CharacterData:FindFirstChild("Ragdoll") then
		return false
	end

	if CharacterData:FindFirstChild("Mount") then
		return false
	end

	if CharacterData:FindFirstChild("Unconscious") then
		return false
	end

	if CharacterData:FindFirstChild("Mounted") then
		return false
	end

	return true
end

module.BlockCheck = function(CharacterData, Tool)
	if CharacterData:FindFirstChild("Stun") then
		return false
	end

	if CharacterData:FindFirstChild("Ragdoll") then
		return false
	end

	if CharacterData:FindFirstChild("Mount") then
		return false
	end

	if CharacterData:FindFirstChild("Mounted") then
		return false
	end

	if CharacterData:FindFirstChild("Unconscious") then
		return false
	end

	if not Tool or (not Tool:FindFirstChild("Style") and not Tool:FindFirstChild("Skill")) then
		return false
	end

	return true
end

module.IdleCheck = function(CharacterData)
	if CharacterData:FindFirstChild("Ragdoll") then
		return false
	end

	if CharacterData:FindFirstChild("Mount") then
		return false
	end

	if CharacterData:FindFirstChild("Mounted") then
		return false
	end

	if CharacterData:FindFirstChild("Unconscious") then
		return false
	end

	return true
end

module.SprintCheck = function(CharacterData)
	if CharacterData:FindFirstChild("Stun") then
		return false
	end
	
	if CharacterData:FindFirstChild("Ragdoll") then
		return false
	end

	if CharacterData:FindFirstChild("Blocking") then
		return false
	end

	if CharacterData:FindFirstChild("Action") then
		return false
	end

	if CharacterData:FindFirstChild("No Sprint") then
		return false
	end
	
	if CharacterData:FindFirstChild("Mount") then
		return false
	end
	
	if CharacterData:FindFirstChild("Unconscious") then
		return false
	end
	
	if CharacterData:FindFirstChild("Mounted") then
		return false
	end
	
	return true
end

module.DodgeCheck = function(CharacterData)
	if CharacterData:FindFirstChild("Stun") then
		return false
	end
	
	if CharacterData:FindFirstChild("Ragdoll") then
		return false
	end
	
	if CharacterData:FindFirstChild("Unconscious") then
		return false
	end
	
	if CharacterData:FindFirstChild("Action") then
		return false
	end
	
	if CharacterData:FindFirstChild("Mount") then
		return false
	end
	
	if CharacterData:FindFirstChild("Mounted") then
		return false
	end

	return true
end

module.RhythmCheck = function(CharacterData)
	if CharacterData:FindFirstChild("Stun") then
		return false
	end
	
	if CharacterData:FindFirstChild("Ragdoll") then
		return false
	end
	
	if CharacterData:FindFirstChild("Unconscious") then
		return false
	end

	if CharacterData:FindFirstChild("Blocking") then
		return false
	end
	
	if CharacterData:FindFirstChild("Mount") then
		return false
	end
	
	if CharacterData:FindFirstChild("Mounted") then
		return false
	end

	return true
end

return module
