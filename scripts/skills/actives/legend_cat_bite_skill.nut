this.legend_cat_bite_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendCatBite);
		this.m.Description = "";
		this.m.KilledString = "Mangled";
		this.m.Icon = "skills/cat_bite.png";
		this.m.Overlay = "cat_bite";
		this.m.SoundOnUse = [
			"sounds/enemies/cat_attack_01.wav",
			"sounds/enemies/cat_attack_02.wav",
			"sounds/enemies/cat_attack_03.wav",
			"sounds/enemies/cat_attack_04.wav",
			"sounds/enemies/cat_attack_05.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function onUpdate( _properties )
	{
		_properties.DamageRegularMin += 20;
		_properties.DamageRegularMax += 40;
		_properties.DamageArmorMult *= 0.4;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});
