this.legend_nyctophobia_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},

	function create() {
		this.character_trait.create();
		::Legends.Traits.onCreate(this, ::Legends.Trait.LegendNyctophobia);
		this.m.Description = "A dislike of the dark can be a childish fear for some, but with what\'s been running around in the wilds lately, maybe it isn\'t as odd anymore...";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.NightOwl)
		];
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
				icon = "ui/icons/bravery.png",
				text = "[color=%negative%]-10[/color] Resolve during Nighttime"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%negative%]-20[/color] Resolve when attacked by mental effects during Nighttime"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+5[/color] Resolve during daytime"
			}
		];
	}

	function onUpdate(_properties) {
		if (this.getContainer().hasEffect(::Legends.Effect.Night) && _properties.IsAffectedByNight == true) {
			_properties.Bravery -= 10;
			_properties.MoraleCheckBravery[::Const.MoraleCheckType.MentalAttack] -= 20;
		} else {
			_properties.Bravery += 5;
		}
	}
});
