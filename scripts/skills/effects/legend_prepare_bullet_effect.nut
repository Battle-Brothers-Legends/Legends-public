this.legend_prepare_bullet_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPrepareBullet);
		this.m.Description = "This character is preparing a shot with a sling, increasing velocity and damage.";
		this.m.Icon = "ui/perks/perk_slinger_spins.png";
		this.m.IconMini = "slinger_spins_mini";
		this.m.Overlay = "slinger_spins_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getBonus() + "[/color] Ranged Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Switching your weapon will remove this effect"
			}
		];
		if (::Legends.Perks.has(this, ::Legends.Perk.LegendBallistics))
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.getBonus() + "%[/color] Armor Penetration"
			});
		}
		return ret;
	}

	function getBonus()
	{
		return this.getContainer().getActor().getCurrentProperties().Initiative * 0.1;
	}

	function onUpdate( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null)
			this.removeSelf();
		if (weapon.getID() != "weapon.legend_sling")
			this.removeSelf();
	}

	function onAfterUpdate( _properties )
	{
		local skill = ::Legends.Actives.get(this, ::Legends.Active.SlingStone);
		if (skill != null)
			skill.m.ActionPointCost -= 1;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.removeSelf();
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.removeSelf();
	}

	function onMovementCompleted( _tile )
	{
		this.removeSelf();
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		this.removeSelf();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isGarbage() || _skill.getID() != ::Legends.Actives.getID(::Legends.Active.SlingStone))
			return;
		local bonus = this.getBonus();
		_properties.DamageRegularMin += bonus;
		_properties.DamageRegularMax += bonus;
		if (::Legends.Perks.has(this, ::Legends.Perk.LegendBallistics))
			_properties.DirectDamageAdd += bonus * 0.01;
	}
});
