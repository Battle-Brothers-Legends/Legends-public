this.legend_brothers_in_chains_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBrothersInChains);
		this.m.Description = "Fighting with other escaped slaves drives this character to succeed.";
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
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + this.m.Stacks + "[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+" + this.m.Stacks + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+" + this.m.Stacks + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + this.m.Stacks + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + this.m.Stacks + "[/color] Ranged Defense"
			}
		];
	}

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || actor.getFaction() != ::Const.Faction.Player) {
			this.m.IsHidden = true;
			return;
		}

		local allies = ::Tactical.Entities.getInstancesOfFaction(::Const.Faction.Player);
		local numSlaves = allies.filter(@(_, _ally)(_ally.getID() != actor.getID() && _ally.isPlacedOnMap() && ::Legends.Backgrounds.has(_ally, ::Legends.Background.Slave))).len();

		if (numSlaves > 0) {
			this.m.IsHidden = false;
			this.m.Stacks = numSlaves;
			_properties.MeleeSkill += this.m.Stacks;
			_properties.RangedSkill += this.m.Stacks;
			_properties.MeleeDefense += this.m.Stacks;
			_properties.RangedDefense += this.m.Stacks;
			_properties.Bravery += this.m.Stacks;
		} else {
			this.m.IsHidden = true;
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.m.Stacks + "[/color] " + ::Legends.S.inlineIcon("melee_skill") + ::Legends.S.inlineIcon("ranged_skill") + ::Legends.S.inlineIcon("melee_defense") + ::Legends.S.inlineIcon("ranged_defense") + ::Legends.S.inlineIcon("bravery");
	}
});
