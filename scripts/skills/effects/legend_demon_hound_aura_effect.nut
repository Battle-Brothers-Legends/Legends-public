this.legend_demon_hound_aura_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Penalty = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDemonHoundAura);
		this.m.Description = "The Höllenhund's presence has sapped the strength from this character\'s limbs, slowing them down.";
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-" + this.m.Penalty * 100 + "%[/color] Initiative"
			}
		]);
		return tooltip;
	}

	function isHidden() {
		return this.m.Penalty == 0;
	}

	function calculatePenalty(_properties) {
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || !::Tactical.isActive()) {
			return 0;
		}

		local myTile = actor.getTile();
		local worstPenalty = 0;
		foreach (t in ::Tactical.Entities.getAllInstancesAsArray().filter(@(_, _hound)(_hound.getType() == ::Const.EntityType.LegendDemonHound && _hound.isPlacedOnMap() && actor.getID() != _hound.getID()))) {
			worstPenalty = ::Math.maxf(worstPenalty, ::Math.maxf(0, 1.0 - (0.25 * (t.getTile().getDistanceTo(myTile) + 1))));
		}

		return worstPenalty;
	}

	function onUpdate(_properties) {
		this.m.Penalty = this.calculatePenalty(_properties);
		_properties.InitiativeMult *= 1.0 - this.m.Penalty;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]-" + (this.m.Penalty * 100) + "%[/color] " + ::Legends.S.inlineIcon("initiative");
	}
});
