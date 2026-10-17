this.legend_lurking_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsAlone = true
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendLurking);
		this.m.Description = ::Const.Strings.PerkDescription.LegendLurker;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsSerialized = false;
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
				icon = "ui/icons/action_points.png",
				text = "[color=%positive%]+3[/color] Action Points"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+30%[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%positive%]+20[/color] Initiative"
			}
		];
	}

	function isHidden() {
		return !::Tactical.isActive() || !this.getContainer().getActor().isPlacedOnMap() || !this.m.IsAlone;
	}

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap()) {
			return;
		}
		local myTile = actor.getTile();
		this.m.IsAlone = (::Tactical.Entities.getInstancesOfFaction(actor.getFaction()).filter(@(_, _ally)(_ally.getID() != actor.getID() && _ally.isPlacedOnMap() && _ally.getTile().getDistanceTo(myTile) <= 2)).len() == 0) && (::Tactical.Entities.getAllHostilesAsArray().filter(@(_, _enemy)(_enemy.getTile().getDistanceTo(myTile) <= 2)).len() == 0);

		if (this.m.IsAlone) {
			_properties.ActionPoints += 3;
			_properties.RangedDefense *= 1.3;
			_properties.Initiative += 20;
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+3[/color] " + ::Legends.S.inlineIcon("action_points") + ", [color=%positive%]+30%[/color] " + ::Legends.S.inlineIcon("ranged_defense") + ", [color=%positive%]+20[/color] " + ::Legends.S.inlineIcon("initiative");
	}
});
