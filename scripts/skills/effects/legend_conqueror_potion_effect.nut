this.legend_conqueror_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendConquerorPotion);
		this.m.Description = "tbd";
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
				icon = "ui/icons/immunity.png",
				text = "Is immune to bleeding"
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
		local body = actor.getSprite("body");
		body.setBrush("bust_skeleton_body_0" + ::Math.rand(1, 2));
		body.Saturation = 0.8;
		body.varySaturation(0.2);
		body.varyColor(0.025, 0.025, 0.025);

		if (actor.getFlags().has("human")) {
			actor.getSprite("injury_body").setBrush("bust_skeleton_body_injured");
		}

		if (this.isKindOf(actor, "player")) {
			actor.improveMood = function (_change, _text = "") {};
			actor.worsenMood = function (_change, _text = "") {};
		}

		local head = actor.getSprite("head");
		head.setBrush("bust_skeleton_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		_properties.IsImmuneToBleeding = true;
	}

	function onDeath(_fatalityType) {
		if (_fatalityType != ::Const.FatalityType.Unconscious) {
			::World.Statistics.getFlags().set("isConquerorPotionAcquired", false);
		}
	}

	function onDismiss() {
		::World.Statistics.getFlags().set("isConquerorPotionAcquired", false);
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return ::Legends.S.inlineIcon("immunity") + " to Bleeding";
	}
});
