::mods_hookExactClass("skills/actives/unleash_wardog", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Order = this.Const.SkillOrder.Last + 5;
	}

	o.onUse = function ( _user, _targetTile )
	{
		local entity = this.Tactical.spawnEntity(this.m.Item.getScript(), _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(this.Const.Faction.PlayerAnimals);
		entity.setItem(this.m.Item);
		entity.setName(this.m.Item.getName());
		entity.setVariant(this.m.Item.getVariant());
		this.m.Item.setEntity(entity);

		if (this.m.Item.getArmorScript() != null)
		{
			local item = this.new(this.m.Item.getArmorScript());
			entity.getItems().equip(item);
		}

		if (this.getContainer().hasSkill("background.houndmaster"))
		{
			entity.setMoraleState(this.Const.MoraleState.Confident);
		}

		this.addAnimalSkills(entity);

		if (!this.World.getTime().IsDaytime)
		{
			::Legends.Effects.grant(entity, ::Legends.Effect.Night);
		}

		this.m.IsHidden = true;
		return true;
	}

	o.addAnimalSkills <- function( _entity )
	{
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendDogWhisperer))
		{
			::Legends.Perks.grant(_entity, ::Legends.Perk.FortifiedMind);
			::Legends.Perks.grant(_entity, ::Legends.Perk.Colossus);
			::Legends.Perks.grant(_entity, ::Legends.Perk.Underdog);
		}

		if (!this.getContainer().hasPerk(::Legends.Perk.LegendDogHandling))
			return;

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
