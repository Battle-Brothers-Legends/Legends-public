this.legend_white_wolf_bite_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsRestrained = false,
		IsSpent = false
	},
	function setRestrained( _f )
	{
		this.m.IsRestrained = _f;
	}
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendWhiteWolfBite);
		this.m.Description = "";
		this.m.KilledString = "Ripped to shreds";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/wolf_bite", 4);
		this.m.SoundOnHitHitpoints = ::Legends.S.setSounds("sounds/enemies/werewolf_claw_hit", 3);
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 0;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.m.IsSpent;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin += 45;
			_properties.DamageRegularMax += 75;
			_properties.DamageArmorMult *= 0.8;
		}
	}

	function onUse( _user, _targetTile )
	{
		if (this.m.IsRestrained)
		{
			this.m.IsSpent = true;
		}
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

});

