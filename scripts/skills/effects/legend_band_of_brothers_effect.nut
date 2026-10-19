this.legend_band_of_brothers_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBandOfBrothers);
		this.m.Description = "Trust is a rare weapon on the battlefield. Fighting with trust in those around them allows this character to focus and fight better.";
		this.m.Order = ::Const.SkillOrder.VeryLast;
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
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]" + this.m.Stacks * 2 + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]" + this.m.Stacks * 3 + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]" + this.m.Stacks * 2 + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]" + this.m.Stacks * 2 + "[/color] Ranged Defense"
			}
		];
	}

	function calculateBonus() {
		local actor = this.getContainer().getActor();

		if (actor.isPlacedOnMap()) {
			local myTile = actor.getTile();
			local num = 0;

			for (local i = 0; i < 6; i++) {
				if (myTile.hasNextTile(i)) {
					local tile = myTile.getNextTile(i);

					if (!tile.IsEmpty && tile.IsOccupiedByActor && ::Math.abs(myTile.Level - tile.Level) <= 1) {
						local entity = tile.getEntity();

						if (actor.getFaction() == entity.getFaction() || entity.isAlliedWith(actor)) {
							num++;
						}
					}
				}
			}
			this.m.Stacks = num;
		}
	}

	function onUpdate(_properties) {
		this.calculateBonus();
		if (!this.getContainer().getActor().isPlacedOnMap()) {
			this.m.IsHidden = true;
			return;
		}
		if (this.m.Bonus > 0) {
			this.m.IsHidden = false;
			_properties.MeleeSkill += this.m.Bonus;
			_properties.RangedSkill += (this.m.Bonus * 1.5);
			_properties.MeleeDefense += this.m.Bonus;
			_properties.RangedDefense += this.m.Bonus;
		} else {
			this.m.IsHidden = true;
		}
	}

	function onCombatFinished() {
		this.m.IsHidden = true;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + (this.m.Stacks * 2) + "[/color] " + ::Legends.S.inlineIcon(["melee_skill", "melee_defense", "ranged_defense"]) + ", [color=%positive%]+" + (this.m.Stacks * 3) + "[/color] " + ::Legends.S.inlineIcon("ranged_skill");
	}
});
