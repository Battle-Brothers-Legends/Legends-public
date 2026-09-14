this.legend_cat_bite_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendCatBite);
		this.m.Description = "";
		this.m.KilledString = "Mangled";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/cat_attack", 5);
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
