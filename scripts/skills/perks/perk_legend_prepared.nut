//Author: WNTR Jimmy
this.perk_legend_prepared <- this.inherit("scripts/skills/skill", {
	m  = {
		PoisonChance = 33
	},

	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPrepared);
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
			return;

		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();

		if (item == null)
			return;

		if (item.isWeaponType(this.Const.Items.WeaponType.Dagger) && _damageInflictedHitpoints > 0)
		{
			if(this.Math.rand(1, 100) < this.m.PoisonChance)
			{
				::Legends.Effects.grant(_targetEntity, ::Legends.Effect.SpiderPoison, function(_effect) {
					_effect.setActor(actor);
				}.bindenv(this));
			}
		}
	}
});

