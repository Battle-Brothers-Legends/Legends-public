this.legend_tower_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.legend_tower_shield";
		this.m.Name = "Tower Shield";
		this.m.Description = "A large square shield that offers excellent protection for yourself and others. It is stout, heavy and broad - offering excellent protection from attacks aimed at the sides.";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13,
			14,
			15,
			16,
			17,
			18,
			19,
			20,
			21,
			22,
			23,
			24,
			25,
			26,
			27,
			28,
			29,
			30,
			31,
			32,
			33,
			34,
			35,
			36,
			37,
			38,
			39,
			40,
			41,
			42,
			104
		];
		this.m.Variant = this.Math.rand(1, 21); //random one is only 1-21 though
		this.updateVariant();
		this.m.Value = 1000;
		this.m.MeleeDefense = 25;
		this.m.RangedDefense = 20;
		this.m.StaminaModifier = -30;
		this.m.Condition = 96;
		this.m.ConditionMax = 96;
	}

	function updateVariant()
	{
		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;
		this.m.Sprite = "towershield_" + variant;
		this.m.SpriteDamaged = "towershield_" + variant + "_damaged";
		this.m.ShieldDecal = "towershield_" + variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_towershield_" + variant + ".png";
		this.m.Icon = "shields/icon_towershield_" + variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendFortify);
		::Legends.Actives.grant(this, ::Legends.Active.LegendSafeguard);
	}

	function onPaintSpecificColor( _color )
	{
		this.setVariant(_color);
		this.updateAppearance();
	}

	function onPaintInCompanyColors()
	{
		local bannerID = this.World.Assets.getBannerID() > 100 ? this.World.Assets.getBannerID() : this.World.Assets.getBannerID() + 11
		this.setVariant(bannerID);
		this.updateAppearance();
	}

});

