this.legend_helmet_mountain_helmet <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},

	function create() {
		this.legend_helmet_upgrade.create();
		this.m.ID = "armor.head.legend_helmet_mountain_helmet";
		this.m.Type = ::Const.Items.HelmetUpgrades.Helm;
		this.m.Name = "Mountain Helm";
		this.m.Description = "A helmet crafted from the skin and skull of a mighty rock unhold, which continues to mend itself even after the beast's death.";
		this.m.ArmorDescription = "Includes a heavy, stone-like helmet.";
		this.m.Variants = [1, 2, 3, 4, 5];
		this.m.Variant = this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 5000;
		this.m.Condition = 250;
		this.m.ConditionMax = 250;
		this.m.StaminaModifier = -18;
		this.m.Vision = -2;
		this.m.Lower = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
	}

	function updateVariant() {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_mountain_helmet_" + variant;
		this.m.SpriteDamaged = "legendhelms_mountain_helmet_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_mountain_helmet_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_mountain_helmet_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function getTooltip() {
		local result = this.legend_helmet_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}

	function onArmorTooltip(result) {
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Restores 10% helmet armor each turn"
		});
		return result;
	}

	function onCombatFinished() {
		this.setCondition(this.m.ConditionMax);
	}

	function onTurnStart() {
		local actor = this.getContainer().getActor();
		local helm = actor.getItems().getItemAtSlot(::Const.ItemSlot.Head);
		local helmMissing = helm.getArmorMax() - helm.getArmor();
		local helmAdded = ::Math.min(helmMissing, ::Math.floor(helm.getArmorMax() * 0.1));

		if (helmAdded <= 0) {
			return;
		}

		helm.setArmor(helm.getArmor() + helmAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer()) {
			::Tactical.spawnIconEffect("status_effect_79", actor.getTile(), ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
			::Sound.play("sounds/enemies/unhold_regenerate_02.wav", ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			::Tactical.EventLog.log(::Const.UI.getColorized(this.m.Name, "#1e468f") + " heals for " + helmAdded + " points");
		}
	}
});
