::mods_hookExactClass("skills/actives/unleash_wolf", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Name = "Unleash Wolf";
		this.m.Description = "Unleash your wolf and send him charging into the enemy. Needs a free tile adjacent.";
		this.m.Order = this.Const.SkillOrder.Last + 5;
	}

	o.onUse = function ( _user, _targetTile )
	{
		local entity = this.Tactical.spawnEntity(this.m.Item.getScript(), _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(this.Const.Faction.PlayerAnimals);
		entity.setItem(this.m.Item);
		entity.setName(this.m.Item.getName());
		this.m.Item.setEntity(entity);

		if (this.getContainer().hasSkill("background.houndmaster"))
		{
			entity.setMoraleState(this.Const.MoraleState.Confident);
		}

		this.addAnimalSkills(entity);

		if (!this.World.getTime().IsDaytime)
		{
			entity.getSkills().add(this.new("scripts/skills/special/night_effect"));
		}

		this.m.IsHidden = true;
		return true;
	}

	o.addAnimalSkills <- function( _entity )
	{
		if (this.getContainer().getActor().getSkills().hasPerk(::Const.Perks.PerkDefs.LegendDogWhisperer))
		{
			::Legends.Perks.grant(_entity, ::Const.Perks.PerkDefs.FortifiedMind);
			::Legends.Perks.grant(_entity, ::Const.Perks.PerkDefs.Colossus);
			::Legends.Perks.grant(_entity, ::Const.Perks.PerkDefs.Underdog);
		}

		if (!this.getContainer().hasPerk(::Const.Perks.PerkDefs.LegendDogHandling))
		{
			return;
		}

		if (!this.getContainer().hasSkill("actives.legend_attack_target"))
		{
			this.getContainer().add(this.new("scripts/skills/actives/legend_attack_target"));
		}

		local skill = this.getContainer().getSkillByID("actives.legend_attack_target");
		skill.addPet(_entity.getID());

		if (!this.getContainer().hasSkill("actives.legend_protect_target"))
		{
			this.getContainer().add(this.new("scripts/skills/actives/legend_protect_target"));
		}

		skill = this.getContainer().getSkillByID("actives.legend_protect_target");
		skill.addPet(_entity.getID());
		local ai = _entity.getAIAgent();
		ai.m.Properties.TargetPriorityHitchanceMult = 2.0;
		ai.m.Properties.EngageAgainstSpearwallMult = 0.5;
		ai.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.25;
	}
});
