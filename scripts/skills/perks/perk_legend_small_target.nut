this.perk_legend_small_target <- this.inherit("scripts/skills/skill", {
	m = {
		BonusMin = 0,
		BonusUnburdenedMin = 30,
		bonusPercentage = 1.0

	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendSmallTarget);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
				text = "This character is not wearing any body armor and receives no bonus from this perk"
			});
			return tooltip;
		}

		local bonus = this.getBonus();
		if (bonus > this.m.BonusMin)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Defense"
			});
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Ranged Defense"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character has too much Hitpoints or Armor to make use of this perk"
			});
			return tooltip;
		}

		local sourceEffect = this.getContainer().getSkillByID("effects.legend_blend_in");
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_unburdened") && bonus >= this.m.BonusUnburdenedMin && sourceEffect != null && sourceEffect.m.MeekStacks > 0)
		{
			tooltip.push({
				id = 6,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Increases the character\'s action points by [color=" + this.Const.UI.Color.PositiveValue + "]1[/color]."
			});
		}

		return tooltip;
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();
		local bodyItem = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		if (bodyItem == null)
		{
			return 0;
		}

		local stackTotal = 0;
		local health = 0;
		health = actor.getHitpointsMax();
		local bodyArmor = actor.getArmor(this.Const.BodyPart.Body);
		local headItem = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local headArmor = 0;

		if (headItem != null)
		{
			headArmor = actor.getArmor(this.Const.BodyPart.Head);
		}

		local stackTotal = health + headArmor + bodyArmor;

		if (actor.getSkills().hasSkill("perk.legend_fashionable"))
		{
			if (bodyItem != null)
			{
				foreach (upgrade in bodyItem.m.Upgrades)
				{
					if (upgrade == null)
						continue;
					if (upgrade.isItemType(this.Const.Items.ArmorUpgrades.Tabbard) || upgrade.isItemType(this.Const.Items.ArmorUpgrades.Cloak)) {
						stackTotal -= body.getRepair();
						continue;
					}
					switch (upgrade.getID()) {
						case "legend_armor_upgrade.body.legend_armor_white_wolf_pelt":
						case "legend_armor_upgrade.body.legend_hyena_fur":
						case "legend_armor_upgrade.body.legend_direwolf_pelt":
						case "legend_armor_upgrade.body.legend_serpent_skin":
						case "legend_armor_upgrade.body.legend_unhold_fur":
							stackTotal -= body.getRepair();
							continue;
					}
				}
			}

			if (headItem != null)
			{
				local vanity = headItem.getUpgrade(this.Const.Items.HelmetUpgrades.Vanity);
				local extra = headItem.getUpgrade(this.Const.Items.HelmetUpgrades.ExtraVanity);

				if (vanity != null)
				{
					local vanityArmor = vanity.getRepair();
					stackTotal -= vanityArmor;
				}

				if (extra != null)
				{
					local extraArmor = extra.getRepair();
					stackTotal -= extraArmor;
				}
			}
		}

		if (actor.getSkills().hasSkill("perk.legend_unburdened"))
		{
			local bodyItem = actor.getBodyItem();
			if (bodyItem != null && bodyItem.m.StaminaModifier == 0)
			{
				stackTotal -= bodyItem.m.ConditionMax;
			}

			local headItem = actor.getHeadItem();
			if (headItem != null && headItem.m.StaminaModifier == 0)
			{
				stackTotal -= headItem.m.ConditionMax;
			}
		}
		local bonus = this.Math.max(0, 100 - stackTotal);
		return this.Math.floor(bonus);
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		this.m.bonusPercentage -= 0.1;
	}

	function onCombatStarted()
	{
		this.m.bonusPercentage = 1.0;
	}

	function onCombatFinished()
	{
		this.m.bonusPercentage = 1.0;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDefense += this.Math.floor(bonus * this.Math.min(this.m.bonusPercentage, 0));
		_properties.RangedDefense += this.Math.floor(bonus * this.Math.min(this.m.bonusPercentage, 0));

		local sourceEffect = this.getContainer().getSkillByID("effects.legend_blend_in");
		if (sourceEffect == null)
			return;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_unburdened") && bonus >= this.m.BonusUnburdenedMin && sourceEffect.m.MeekStacks > 0)
		{
			_properties.ActionPoints += 1;
		}
	}
});
