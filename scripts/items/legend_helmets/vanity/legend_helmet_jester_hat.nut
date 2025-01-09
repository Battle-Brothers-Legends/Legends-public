
this.legend_helmet_jester_hat <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.ID = "armor.head.legend_helmet_jester_hat";
		this.m.Name = "Jester Hat";
		this.m.Description = "The quintessential hat of performing folk in noble court. Wearing it makes you feel like a fool, but the jingling bells make you an irritating target for all.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [];
		for(local i = 1; i < 65; i++)
		{
			this.m.Variants.push(i);
		}
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 200;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -1;
		this.m.Vision = 0;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		//option for bhc range
		// this.m.BonusHeadChance = this.Math.rand(this.m.HCMin, this.m.HCMax);
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Adds the \'Taunt\' skill"
		});
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = "Makes enemies more likely to attack you"
		});
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-3[/color] Melee Defense per surrounding enemy"
		});

		return _result;
	}

	function onUpdateProperties(_properties)
	{
		this.legend_helmet_upgrade.onUpdateProperties(_properties);
  		_properties.SurroundedDefense -= 3; // -3 defence per enemy surrounding this unit while equipped
		_properties.TargetAttractionMult *= 1.2; // 1.0 = normal aggression, 0.1 = minimal aggression
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_jester_hat" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_jester_hat" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_jester_hat" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_jester_hat" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function onEquip()
	{
		this.legend_helmet_upgrade.onEquip();
		if (!this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.Taunt))
		{
			this.addSkill(this.new("scripts/skills/actives/taunt"));
		}
	}
});
