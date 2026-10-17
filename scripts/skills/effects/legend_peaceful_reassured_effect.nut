this.legend_peaceful_reassured_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPeacefulReassured);
		this.m.Description = "The presence of nearby peaceful people is increasing this characters Resolve and experience gain.";
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local peaceful = this.countPeaceful();
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
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + (peaceful * 3) + "[/color] Resolve"
			},
			{
				id = 7,
				type = "hint",
				icon = "ui/icons/xp_received.png",
				text = "[color=%positive%]+" + peaceful + "%[/color] Experience Gain"
			}
		];
		return ret;
	}

	function countPeaceful() {
		return (::Tactical.isActive() ? ::Tactical.Entities.getAllInstancesAsArray().filter(@(_, _entity)(_entity.getFaction() == ::Const.Faction.Player && ::Legends.Perks.has(_entity, ::Legends.Perk.LegendPeaceful))) : 0);
	}

	function onUpdate(_properties) {
		local peaceful = this.countPeaceful();
		_properties.Bravery += (peaceful * 3);
		_properties.XPGainMult *= 1.0 + (peaceful * 0.01);
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		local peaceful = this.countPeaceful();
		return "[color=%positive%]+" + (peaceful * 3) + "[/color] " + ::Legends.S.inlineIcon("bravery") + ", [color=%positive%]+" + peaceful + "%[/color] " + ::Legends.S.inlineIcon("xp_received");
	}
});
