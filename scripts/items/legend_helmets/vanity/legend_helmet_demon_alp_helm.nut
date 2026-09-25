this.legend_helmet_demon_alp_helm <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},

	function create() {
		this.legend_helmet_upgrade.create();
		this.m.ID = "armor.head.legend_helmet_demon_alp_helm";
		this.m.Type = ::Const.Items.HelmetUpgrades.Vanity;
		this.m.Name = "Demon Alp Helm";
		this.m.Description = "A trophy made from the visage of a demon that hunts in the night.";
		this.m.ArmorDescription = "Includes a terrifying mask.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = ::Const.Sound.ClothEquip;
		this.m.Value = 200;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -1;
		this.m.Vision = 0;
		this.m.Lower = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
	}

	function updateVariant() {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_demon_alp_helm_" + variant;
		this.m.SpriteDamaged = "legendhelms_demon_alp_helm_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_demon_alp_helm_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_demon_alp_helm_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function getTooltip() {
		local result = this.legend_helmet_upgrade.getTooltip();
		return this.onArmorTooltip(result);
	}

	function onArmorTooltip(result) {
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants the Horrific Scream active skill"
		});

		return result;
	}

	function onEquip() {
		this.legend_helmet_upgrade.onEquip();
		if (!::Legends.Perks.has(this, ::Legends.Perk.LegendHorrify)) {
			::Legends.Actives.grant(this, ::Legends.Effect.HorrificScream, function (_skill) {
				_skill.m.ActionPointCost = 6;
				_skill.m.FatigueCost = 30;
				_skill.m.MaxRange = 4;
			}.bindenv(this));
		}
	}

	function onUnequip() {
		local actor = this.getContainer().getActor();
		this.legend_helmet_upgrade.onUnequip();
		if (::Legends.Perks.has(actor, ::Legends.Perk.LegendHorrify) && !::Legends.Actives.has(actor, ::Legends.Active.HorrificScream)) {
			::Legends.Actives.grant(this, ::Legends.Active.HorrificScream);
		}
	}
});
