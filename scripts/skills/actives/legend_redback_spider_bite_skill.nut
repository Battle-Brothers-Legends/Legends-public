this.legend_redback_spider_bite_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendRedbackSpiderBite);
		this.m.Description = "";
		this.m.KilledString = "Ripped to shreds";
		this.m.Icon = "skills/active_115.png";
		this.m.Overlay = "active_115";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/giant_spider_attack_01.wav",
			"sounds/enemies/dlc2/giant_spider_attack_02.wav",
			"sounds/enemies/dlc2/giant_spider_attack_03.wav",
			"sounds/enemies/dlc2/giant_spider_attack_04.wav",
			"sounds/enemies/dlc2/giant_spider_attack_05.wav"
		];
		this.m.SoundOnHit = [
			"sounds/enemies/dlc2/giant_spider_attack_hit_01.wav",
			"sounds/enemies/dlc2/giant_spider_attack_hit_02.wav",
			"sounds/enemies/dlc2/giant_spider_attack_hit_03.wav",
			"sounds/enemies/dlc2/giant_spider_attack_hit_04.wav",
			"sounds/enemies/dlc2/giant_spider_attack_hit_05.wav",
			"sounds/enemies/dlc2/giant_spider_attack_hit_06.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 30;
		this.m.ChanceSmash = 0;
	}

	function onUpdate( _properties )
	{
		_properties.DamageRegularMin += 30;
		_properties.DamageRegularMax += 50;
		_properties.DamageArmorMult *= 0.8;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});

