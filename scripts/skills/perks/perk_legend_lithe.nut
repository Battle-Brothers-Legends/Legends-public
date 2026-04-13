this.perk_legend_lithe <- this.inherit("scripts/skills/skill", {
	m = {
		BonusMin = 0,
		BonusMax = 30
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendLithe);
		this.m.Description = "Lithe like a lizard! %name% is able to partially deflect attacks at the last moment, turning them into glancing hits.";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function isHidden()
	{
		return !(this.getBonus() > 0);
	}

	function getTooltip()
	{
		local bonus = this.getBonus(true);
		local bonusWithoutDura = this.getBonus(false);
		local tooltip = this.skill.getTooltip();

		if (bonus > this.m.BonusMin) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "Only receive [color=%positive%]" + (100 - bonus) + "%[/color] of any damage to Armor from attacks"
			});
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only receive [color=%positive%]" + (100 - bonusWithoutDura) + "%[/color] of any damage to Hitpoints from attacks"
			});
			return tooltip;
		}

		if (this.getContainer().getActor().getBodyItem() == null) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character is not wearing any body armor and hence receives no bonus damage reduction"
			});
		}

		return tooltip;
	}

	function getArmorFatPenMult(_totalArmorStaminaModifier)
	{
		_totalArmorStaminaModifier *= -1;

		local steepnessFactor = 2.6;
		local armorIdealMin = 25;
		local armorIdealMax = 35;

		local mult = 1;

		if (_totalArmorStaminaModifier < armorIdealMin)
		{
			mult = this.Math.maxf(0, 1 - 0.01 * this.Math.pow(armorIdealMin - _totalArmorStaminaModifier, steepnessFactor));
		}
		else if (_totalArmorStaminaModifier > armorIdealMax)
		{
			mult = this.Math.maxf(0, 1 - 0.01 * this.Math.pow(_totalArmorStaminaModifier - armorIdealMax, steepnessFactor));
		}

		return mult;
	}

	function getBonus(_useDurability = true)
	{
		local actor = this.getContainer().getActor();

		local bodyitem = actor.getBodyItem();

		if (bodyitem == null)
		{
			return 0;
		}

		local armorFatMult = this.getArmorFatPenMult(actor.getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]));

		local totalArmorDurability = actor.getArmor(this.Const.BodyPart.Head) + actor.getArmor(this.Const.BodyPart.Body);
		local maxArmorDurability = actor.getArmorMax(this.Const.BodyPart.Head) + actor.getArmorMax(this.Const.BodyPart.Body);

		local bonus = this.Math.maxf(this.m.BonusMin, this.Math.minf(this.m.BonusMax, this.m.BonusMax * armorFatMult));
		if (_useDurability)
			bonus *= 0.5 * totalArmorDurability/(maxArmorDurability * 1.0) + 0.5;

		return this.Math.floor(bonus);
	}

	function onBeforeDamageReceived ( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker == null || _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack())
			return;

		local bonus = this.getBonus(true);
		local bonusWithoutDura = this.getBonus(false);
		_properties.DamageReceivedArmorMult *= 1.0 - bonus * 0.01;
		_properties.DamageReceivedRegularMult *= 1.0 - bonusWithoutDura * 0.01;
	}
});
