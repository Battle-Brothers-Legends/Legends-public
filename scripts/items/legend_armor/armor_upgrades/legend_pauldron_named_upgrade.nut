this.legend_pauldron_named_upgrade <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {
		Potential = {
			Condition = { min = 60, max = 70 },
			StaminaModifier = { min = 8, max = 4 },
			DirectDamageModifier = { min = 40, max = 45 }
		}
	},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_pauldron_named";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "";
		this.m.Description = "Sturdy segments of worked iron, beautifully decorated and excellent for protecting shoulders and arms. Worn over armor, they can help deflect incoming blows.";
		this.m.ArmorDescription = "Includes a set of sturdy decorated pauldrons.";
		this.m.Variants = [1,2,3,4,5,6,7,8,9,10];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 3600;
		this.randomizeValues();
		this.m.NameList = ["Aurelian Mantle","Midas\' Curse","Tyrant\'s Gilt","Gilded Pauldrons","Gilded Bulwark","Imperial Epaulets","Vanguard\'s Radiance"];
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_named_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_named_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_named_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_named_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_named_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_named_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_named_"  + variant + ".png";
	}

	function onSerialize( _out )
	{
		_out.writeI16(this.m.DirectDamageModifier);
		this.legend_named_armor_upgrade.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.m.DirectDamageModifier = _in.readI16();
		this.legend_named_armor_upgrade.onDeserialize(_in);
	}
});

