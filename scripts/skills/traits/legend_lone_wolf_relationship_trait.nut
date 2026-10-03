this.legend_lone_wolf_relationship_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},

	function create() {
		this.character_trait.create();
		::Legends.Traits.onCreate(this, ::Legends.Trait.LegendLoneWolfRelationship);
		this.m.Description = "If you can see this something is fucked up";
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.Trait;
		this.m.IsHidden = true;
	}

	function getTooltip() {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/money.png",
				text = "[color=%positive%]Costs no upkeep[/color]"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]Gains bonuses based on how many allies are nearby, this is amplified by their current level[/color]"
			},
		];
	}

	function onUpdate(_properties) {
		_properties.DailyWageMult *= 0;
	}

	function onAdded() {
		if (!this.m.Container.hasEffect(::Legends.Effect.LegendBandOfBrothers)) {
			::Legends.Effects.grant(this, ::Legends.Effect.LegendBandOfBrothers);
		}
	}

	function onRemoved() {
		::Legends.Effects.remove(this, ::Legends.Effect.LegendBandOfBrothers);
	}
});
