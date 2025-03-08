this.legend_prepare_bullet_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPrepareBullet);
		this.m.Description = "This character is preparing a shot with a sling, increasing velocity and damage.";
		this.m.Icon = "ui/effects/slinger_spins.png";
		this.m.IconMini = "slinger_spins_mini.png";
		this.m.Overlay = "slinger_spins_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		ret = [
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.getBonus() + "%[/color] Ranged Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Switching your weapon will remove this effect"
			}
		];
		local sourcePerk = this.getContainer().getSkillByID("perk.legend_specialist_sling_skill");
		if (this.getContainer().getSkillByID("perk.legend_ballistics"))
			ret.push(
			{
				id = 12,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.getBonus() + "%[/color] Armor Penetration"
			});
		return ret;
	}

	function getBonus()
	{
		return this.getContainer().getActor().getCurrentProperties().RangedSkill * 0.2;
	}

	function onUpdate( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon.getID() != "weapon.legend_sling" || weapon.getID() != "weapon.named_sling")
			this.removeSelf();
	}

	function onAfterUpdate( _properties )
	{
		local skill = this.getContainer().getSkillByID("active.sling_stone");
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
		if (_skill.isGarbage() || !_skill.getID() == "actives.sling_stone")
			return;
		_properties.DamageRegularMin *= 1.0 + this.getBonus();
		_properties.DamageRegularMax *= 1.0 + this.getBonus();
		_properties.DirectDamageAdd += this.getBonus();
	}
});
