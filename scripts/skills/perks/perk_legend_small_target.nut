this.perk_legend_small_target <- this.inherit("scripts/skills/skill", {
	m = {
		BonusMin = 0,
		BonusUnburdenedMin = 30,
		bonusPercentage = 1.0
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSmallTarget);
		this.m.Description = "Use your physique to minimize your hit profile.";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.getContainer().getActor().getBodyItem() == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character is not wearing any body armor and receives no bonus from this perk."
			});
			return tooltip;
		}

		local bonus = this.getBonus();
		local currentBonus = this.getCurrentBonus();
		if (bonus > this.m.BonusMin)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + currentBonus + "[/color] Melee Defense"
			});
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + currentBonus + "[/color] Ranged Defense"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character has too much combined Hitpoints and Armor to make use of this perk."
			});
			return tooltip;
		}

		local sourcePerk = ::Legends.Perks.get(this, ::Legends.Perk.LegendBlendIn);
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendUnburdened) && bonus >= this.m.BonusUnburdenedMin && sourcePerk != null && sourcePerk.m.MeekStacks > 0)
		{
			tooltip.push({
				id = 6,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Increases the character\'s action points by [color=%positive%]1[/color]."
			});
		}

		return tooltip;
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();
		local headItem = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local bodyItem = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		if (bodyItem == null)
			return 0;

		local baseBonus = 100 - actor.getHitpointsMax();
		local bodyArmor = 0;
		local headArmor = 0;

		bodyArmor = actor.getArmor(this.Const.BodyPart.Body);
		if (headItem != null)
			headArmor = actor.getArmor(this.Const.BodyPart.Head);

		if (actor.getSkills().hasPerk(::Legends.Perk.LegendFashionable)) {
			local layer = bodyItem.getUpgrade(this.Const.Items.ArmorUpgrades.Tabbard);
			if (layer != null)
				bodyArmor -= layer.getRepair();
			layer = bodyItem.getUpgrade(this.Const.Items.ArmorUpgrades.Cloak);
			if (layer != null)
				bodyArmor -= layer.getRepair();

			if (headItem != null) {
				layer = headItem.getUpgrade(this.Const.Items.HelmetUpgrades.Vanity);
				if (layer != null)
					headArmor -= layer.getRepair();
			}

			if (actor.getSkills().hasPerk(::Legends.Perk.LegendUnburdened)) {
				if (bodyItem != null && bodyItem.m.StaminaModifier == 0) {
					bodyArmor -= bodyItem.m.Condition;
				}
				layer = bodyItem.getUpgrade(this.Const.Items.ArmorUpgrades.Attachment);
				if (layer != null)
					switch (layer.getID()) {
						case "legend_armor_upgrade.body.legend_armor_white_wolf_pelt":
						case "legend_armor_upgrade.body.legend_hyena_fur":
						case "legend_armor_upgrade.body.legend_direwolf_pelt":
						case "legend_armor_upgrade.body.legend_unhold_fur":
							bodyArmor -= layer.getRepair();
					}

				if (headItem != null && headItem.m.StaminaModifier == 0)
					headArmor -= headItem.m.Condition;
			}
		}

		local bonus = this.Math.max(0, baseBonus - bodyArmor - headArmor);
		return this.Math.floor(bonus);
	}

	function getCurrentBonus() {
		return this.Math.floor(this.Math.max(this.getBonus() * this.m.bonusPercentage, 0));
	}

	function onAdded() {
		this.m.bonusPercentage = 1.0;
	}

	function onMissed( _attacker, _skill ) {
		this.m.bonusPercentage -= 0.1;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor ) {
		this.m.bonusPercentage -= 0.1;
	}

	function onCombatStarted() {
		this.m.bonusPercentage = 1.0;
	}

	function onCombatFinished() {
		this.m.bonusPercentage = 1.0;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDefense += this.getCurrentBonus();
		_properties.RangedDefense += this.getCurrentBonus();

		local sourcePerk = ::Legends.Perks.get(this, ::Legends.Perk.LegendBlendIn);
		if (sourcePerk == null)
			return;

		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendUnburdened) && bonus >= this.m.BonusUnburdenedMin && sourcePerk.m.MeekStacks > 0)
		{
			_properties.ActionPoints += 1;
		}
	}
});
