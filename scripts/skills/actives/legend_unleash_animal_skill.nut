this.legend_unleash_animal_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function addAnimalSkills(entity)
	{

		if (this.getContainer().getActor().getSkills().hasPerk(::Const.Perks.PerkDefs.LegendDogWhisperer))
		{
			::Legends.Perks.grant(entity, ::Const.Perks.PerkDefs.FortifiedMind);
			::Legends.Perks.grant(entity, ::Const.Perks.PerkDefs.Colossus);
			::Legends.Perks.grant(entity, ::Const.Perks.PerkDefs.Underdog);
		}

		if (!this.getContainer().hasPerk(::Const.Perks.PerkDefs.LegendDogHandling))
			return;


		if (!this.getContainer().hasSkill("actives.legend_attack_target"))
		{
			this.getContainer().add(this.new("scripts/skills/actives/legend_attack_target_skill"));
		}
		local skill = this.getContainer().getSkillByID("actives.legend_attack_target");
		skill.addPet(entity.getID());

		if (!this.getContainer().hasSkill("actives.legend_protect_target"))
		{
			this.getContainer().add(this.new("scripts/skills/actives/legend_protect_target_skill"));
		}
		skill = this.getContainer().getSkillByID("actives.legend_protect_target");
		skill.addPet(entity.getID());

		local ai = entity.getAIAgent();
		ai.m.Properties.TargetPriorityHitchanceMult = 2.0;
		ai.m.Properties.EngageAgainstSpearwallMult = 0.5;
		ai.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.25;

	}

});

