this.legend_armor_mountain_named <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.legend_mountain_armor_named";
		this.m.Name = "";
		this.m.NameList = [
			"Titan Coat",
			"Mountain Hide",
			"Giant\'s Coat",
			"Earthquake Harness",
			"Landslide Coat",
			"Boulder Plates",
			"Coat of the Mountain"
		];
		this.m.Description = "Armor crafted from the skin and bones of a mighty rock unhold, the beast may be dead, but it continues to mend itself even after death.";
		this.m.ArmorDescription = "Has a mighty rock unhold plate.";
		this.m.Variants = [1, 2];
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 7500;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
		this.randomizeValues();
		this.resetStats();
	}

	function resetStats() {
		this.m.Condition = 250;
		this.m.ConditionMax = 250;
		this.m.StaminaModifier = -32;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Repairs [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of its armor each turn"
		});
	}

	function getTooltip()
	{
		local result = this.legend_named_armor_upgrade.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Repairs [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of its armor each turn"
		});
		return result;
	}

	function onCombatFinished()
	{
		this.m.Condition = this.m.ConditionMax;
		this.updateAppearance();
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local body = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local bodyMissing = body.getArmorMax() - body.getArmor();
		local bodyAdded = this.Math.min(bodyMissing, this.Math.floor(body.getArmorMax() * 0.1));


		if (bodyAdded <= 0)
		{
			return;
		}

		body.setArmor(body.getArmor() + bodyAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorized(this.m.Name, "#1e468f") + " heals for " + bodyAdded + " points");
		}
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_mountain_armor" + "_" + variant;
		this.m.SpriteDamagedBack = "bust_mountain_armor" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_mountain_armor" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_mountain_armor" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_mountain_armor" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_mountain_armor" + "_" + variant + ".png";
	}
});

