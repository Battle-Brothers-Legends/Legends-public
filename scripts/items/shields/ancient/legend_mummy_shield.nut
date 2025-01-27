this.legend_mummy_shield <- this.inherit("scripts/items/shields/shield", {
	m = {
		PrimaryOffhandAttack = null
		},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.legend_mummy_shield";
		this.m.Name = "Ancient Southern Shield";
		this.m.Description = "A small shield made of wood and reinforced with bronze. Time has taken its toll and the wood has become brittle, but it is still an agile parrying tool.";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [
			1,
			2,
			3,
			4,
			5
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Value = 200;
		this.m.MeleeDefense = 8;
		this.m.RangedDefense = 8;
		this.m.StaminaModifier = -6;
		this.m.Condition = 26;
		this.m.ConditionMax = 26;
	}

	function updateVariant()
	{
		this.m.Sprite = "mummy_shield_0" + this.m.Variant;
		this.m.SpriteDamaged = "mummy_shield_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "mummy_shield_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_mummy_shield_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/icon_mummy_shield_0" + this.m.Variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.KnockBack);
		::Legends.Actives.grant(this, ::Legends.Active.LegendBucklerBash, function (_skill) {
			this.m.PrimaryOffhandAttack = ::MSU.asWeakTableRef(_skill);
		}.bindenv(this));
		::Legends.Effects.grant(this, ::Legends.Effect.LegendBuckler, function(_effect) {
			_effect.m.Order = this.Const.SkillOrder.UtilityTargeted + 1;
			_effect.setItem(this);
			this.m.SkillPtrs.push(_effect);
		}.bindenv(this));
	}

	function onUnequip ()
	{
		shield.onUnequip();
		m.PrimaryOffhandAttack = null;
	}

	function getPrimaryOffhandAttack ()
	{
		return m.PrimaryOffhandAttack;
	}

});

