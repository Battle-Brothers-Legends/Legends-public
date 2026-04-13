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
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistGravedigger);
		this.m.IconMini = "perk_spec_shovel_mini";
	}

	function getDescription()
	{
		return this.getDefaultSpecialistSkillDescription("Two Handed Handed Maces");
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
