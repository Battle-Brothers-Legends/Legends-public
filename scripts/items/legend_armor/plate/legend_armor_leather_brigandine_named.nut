
this.legend_armor_leather_brigandine_named <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate
		this.m.ID = "legend_armor.leather_brigandine_named";
        this.m.Name = "";
		this.m.NameList = [
			"Harness",
			"Ward",
			"Defense",
			"Barrier",
			"Studded Vest",
			"Lifesaver",
			"Skin",
			"Peel",
			"Guard",
			"Tarnished Harness",
			"Duty",
			"Honor"
		];
		this.m.Description = "A rare thick leather brigandine studded with steel rivets for added protection. A piece of true craftsmanship!";
		this.m.ArmorDescription = "Includes rare leather brigandine armor.";
		this.m.Value = 5500;
		this.m.Variants = [1,2,3,4,5];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Condition = 70;
		this.m.ConditionMax = 70;
		this.m.StaminaModifier = -6;
		this.randomizeValues();
	}

	function randomizeValues()
	{
		this.m.StaminaModifier = this.Math.rand(6, 9) * -1;
		this.m.Condition = this.Math.rand(70, 85);
		this.m.ConditionMax = this.m.Condition;
	}

	function updateVariant()
	{
		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;
		this.m.SpriteBack = "bust_legend_leather_brigandine_named_" + variant ;
		this.m.SpriteDamagedBack = "bust_legend_leather_brigandine_named_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_legend_leather_brigandine_named_" + variant + "_dead";
		this.m.Icon = "legend_armor/plate/legend_leather_brigandine_named_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/plate/icon_legend_leather_brigandine_named_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/plate/inventory_legend_leather_brigandine_named_"  + variant + ".png";
	}

});

