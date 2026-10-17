this.legend_necrosavant_lord_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendNecrosavantLordPotion);
		this.m.Description = "tbd";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/vampire_life_drain", 3);
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function getTooltip() {
		local ret = [
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
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Ignore Zone of Control(ZOC) if hitpoints are below [color=%negative%]50%[/color]"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		];
		return ret;
	}

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();

		if (actor.getHitpoints() < actor.getHitpointsMax() / 2) {
			_properties.IsImmuneToZoneOfControl = true;
		}
	}

	function onDeath(_fatalityType) {
		if (_fatalityType != ::Const.FatalityType.Unconscious) {
			::World.Statistics.getFlags().set("isNecrosavantLorePotionAcquired", false);
		}
	}

	function onDismiss() {
		::World.Statistics.getFlags().set("isNecrosavantLorePotionAcquired", false);
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return ::Legends.S.inlineIcon("immunity") + " to Zone of Control if " + ::Legends.S.inlineIcon("health") + " < [color=%positive%]50%[/color]";
	}
});
