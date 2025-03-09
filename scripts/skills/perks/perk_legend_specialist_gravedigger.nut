this.perk_legend_specialist_gravedigger <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.legend_shovel",
			"weapon.legend_named_shovel"
		],
		ApplicableItemTypes = [
			this.Const.Items.ItemType.TwoHanded
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Mace
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistGravedigger);
		this.m.IconMini = "perk_spec_shovel_mini.png";
	}

	function getDescription()
	{
		return this.getDefaultSpecialistSkillDescription("Two Handed Handed Maces");
	}

	function specialistWeaponTooltip (_item, _isRanged)
	{
		local properties = this.getContainer().getActor().getCurrentProperties();
		local tooltip = [];
		
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(this.m.BonusMelee, _item) + "[/color] Melee Skill"
		});

		if (::Legends.S.isCharacterWeaponSpecialized(properties, _item))
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(this.m.BonusDamage, _item) + "%[/color] Damage"
			});
		}
		return tooltip;
	}

	function onAdded()
	{
		if (!this.m.Container.hasEffect(::Legends.Effect.LegendGravedigging))
		{
			::Legends.Effects.grant(this, ::Legends.Effect.LegendGravedigging);
		}
	}

	function onRemoved()
	{
		::Legends.Effects.remove(this, ::Legends.Effect.LegendGravedigging);
	}

});
