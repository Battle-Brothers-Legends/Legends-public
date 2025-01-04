//Author: WNTR Jimmy
this.perk_legend_prepared <- this.inherit("scripts/skills/skill", {
	m  = {
		PoisonChance = 33
	},

	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendPrepared);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local item = this.getContainer().getActor().getMainhandItem();
		if (item != null)
		{
			if (item.isWeaponType(this.Const.Items.WeaponType.Dagger))
			{
        		_properties.MeleeSkill += 12;
			}
		}
	}

	function onAfterUpdate( _properties )
	{
		local item = this.getContainer().getActor().getMainhandItem();
		if (item != null)
		{
			if (item.isWeaponType(this.Const.Items.WeaponType.Dagger))
			{
      		_properties.FatigueRecoveryRate += 3;
			}
		}
	}

   function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity == null || !_targetEntity.isAlive() || _targetEntity.getCurrentProperties().IsImmuneToPoison == true)
		{
			return;
		}

		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();

		if (item == null) return;

		local effect = new("scripts/skills/effects/spider_poison_effect");
		if (actor.getFaction() == this.Const.Faction.Player )
		{
			effect.setActor(actor);
		}
		if (item.isWeaponType(this.Const.Items.WeaponType.Dagger) && _damageInflictedHitpoints > 0)
		{
			if(this.Math.rand(1, 100) < this.m.PoisonChance)
			{
				_targetEntity.getSkills().add(effect);
			}
		}

	}

});

