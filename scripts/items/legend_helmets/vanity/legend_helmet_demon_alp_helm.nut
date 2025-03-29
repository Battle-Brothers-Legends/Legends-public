
this.legend_helmet_demon_alp_helm <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.ID = "armor.head.legend_helmet_demon_alp_helm";
		this.m.Name = "Demon Alp Helm";
		// this.m.NameList = [
		// 	"Nightmare visage",
		// 	"Helm of the demon",
		// 	"Demon Crown",
		// 	"Nightmare Helm",
		// 	"Nightmare Crown",
		// 	"Sleepless Crown"
		// ];
		// this.m.Name = this.m.NameList[this.Math.rand(0, this.m.NameList.len())];
		this.m.Description = "A trophy made from the face of a demon";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [1];
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
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		return this.onArmorTooltip(result);
	}

	function onArmorTooltip( result )
	{
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants the Horrific Scream active skill"
		});

		return result;
	}

	function onEquip()
	{
		this.legend_helmet_upgrade.onEquip();
		if (!this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendHorrify))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendHorrificScream)
		}
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_demon_alp_helm" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_demon_alp_helm" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_demon_alp_helm" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_demon_alp_helm" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}
});
