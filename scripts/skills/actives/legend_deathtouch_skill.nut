this.legend_deathtouch_skill <- this.inherit("scripts/skills/legend_magic_skill", {
	m = {},
	function create()
	{
		this.legend_magic_skill.create();
		this.m.AdditionalAccuracy = 10;
		this.m.DamageInitiativeMin = 15;
		this.m.DamageInitiativeMax = 35;
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDeathtouch);
		this.m.Description = "Your fingers turn ghostly and pass through steel and flesh, tearing at the soul of your victim. Uses Melee Skill to hit.";
		this.m.KilledString = "Frightened to death";
		this.m.Icon = "skills/deathtouch_square.png";
		this.m.IconDisabled = "skills/deathtouch_square_bw.png";
		this.m.Overlay = "deathtouch_square";
		this.m.SoundOnUse = [
			"sounds/enemies/ghastly_touch_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}
		function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Damage scales with current initiative and ignores armour."
		});
		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_magic_skill.onAnySkillUsed(_skill, _targetEntity, _properties );
		if (_skill == this)
		{
			_properties.IsIgnoringArmorOnAttack = true;
		}
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});
