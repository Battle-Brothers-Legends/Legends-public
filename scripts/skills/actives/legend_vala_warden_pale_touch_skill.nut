this.legend_vala_warden_pale_touch_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendValaWardenPaleTouch);
		this.m.Description = "";
		this.m.KilledString = "Frightened to death";
		this.m.Icon = "skills/active_42.png";
		this.m.IconDisabled = "skills/active_42.png";
		this.m.Overlay = "active_42";
		this.m.SoundOnUse = [
			"sounds/combat/legend_vala_warden_pale_touch.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}


	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}


	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local scaling = ::Legends.Effects.get(this, ::Legends.Effect.LegendValaWardenDamage);
			local fury = ::Legends.Effects.get(this, ::Legends.Effect.LegendValaChantFuryEffect);
			local bonus1 = 0;
			local bonus2 = 0;

			if (scaling != null)
			{
				bonus1 = scaling.getDamageBonus();
			}

			if (fury != null)
			{
				bonus2 = fury.getWardenDamage();
			}

			_properties.DamageRegularMin += 10 + this.Math.round(bonus1 * 0.67) + this.Math.round(bonus2 * 0.67);
			_properties.DamageRegularMax += 15 + this.Math.round(bonus1) + this.Math.round(bonus2);
			_properties.IsIgnoringArmorOnAttack = true;
		}
	}
});
