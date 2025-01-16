this.legend_unleash_animal_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function addAnimalSkills(_entity)
	{
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_dogwhisperer"))
		{
			_entity.getSkills().add(this.new("scripts/skills/perks/perk_fortified_mind"));
			_entity.getSkills().add(this.new("scripts/skills/perks/perk_colossus"));
			_entity.getSkills().add(this.new("scripts/skills/perks/perk_underdog"));
		}

		if (!this.getContainer().hasSkill("perk.legend_doghandling"))
		{
			return;
		}


		local skill = ::new("scripts/skills/actives/legend_attack_target_skill");
		skill.addPet(_entity.getID());
		this.getContainer().add(skill);

		skill = ::new("scripts/skills/actives/legend_protect_target_skill");
		skill.addPet(_entity.getID());
		this.getContainer().add(skill);

		local ai = _entity.getAIAgent();
		ai.m.Properties.TargetPriorityHitchanceMult = 2.0;
		ai.m.Properties.EngageAgainstSpearwallMult = 0.5;
		ai.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.25;
	}

});

