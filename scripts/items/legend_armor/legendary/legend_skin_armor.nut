this.legend_skin_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.ID = "legend_armor.body.legend_skin_armor";
		this.m.Description = "This disgusting design is made by nailing metal pieces to layers of flesh taken from skin ghouls. It smells awful, is quite heavy, and feels as if it is healing itself on to your body.";
		this.m.ArmorDescription = "This disgusting design is made by nailing metal pieces to layers of flesh taken from skin ghouls. It smells awful, is quite heavy, and feels as if it is healing itself on to your body.";
		this.m.Name = "";
		this.m.NameList = [
			"Skin suit",
			"Naked armor",
			"Ghoulish bastion",
			"Flayed Bulwark"
		];
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.Variants = [1, 2];
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 5000;
		this.m.Condition = 130;
		this.m.ConditionMax = 130;
		this.m.StaminaModifier = -14;
		this.randomizeValues();
		this.resetValues();
	}

	function resetValues() {
		this.m.Condition = 130;
		this.m.ConditionMax = 130;
		this.m.StaminaModifier = -14;
	}

	function onArmorTooltip(_result)
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Heals [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of the hitpoints of the wearer each turn"
		});
	}

	function getTooltip()
	{
		local result = this.legend_named_armor_upgrade.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = "Heals [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of the hitpoints of the wearer each turn"
		});
		return result;
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();
		if (actor == null)
		{
			return;
		}

		if (actor.getHitpoints() > 0)
		{
			actor.setHitpoints(actor.getHitpointsMax());
			actor.setDirty(true);
		}
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = this.Math.min(healthMissing, actor.getHitpointsMax() * 0.1);

		if (healthAdded <= 0)
		{
			return;
		}

		actor.setHitpoints(actor.getHitpoints() + healthAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
		}
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_skin_armor" + "_" + variant;
		this.m.SpriteDamagedBack = "bust_skin_armor" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_skin_armor" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_skin_armor" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_skin_armor" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_skin_armor" + "_" + variant + ".png";
	}
});

