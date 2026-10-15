this.legend_demon_hound_aura_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Penalty = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDemonHoundAura);
		this.m.Description = "The Höllenhund's presence has sapped the strength from this character\'s limbs, slowing them down.";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
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
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-" + this.m.Penalty * 100 + "%[/color] Initiative"
			}
		];
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
});
