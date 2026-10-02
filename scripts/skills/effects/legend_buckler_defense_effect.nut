this.legend_buckler_defense_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Bonus = 5
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBucklerDefense);
		this.m.Description = "Fighting with a buckler, this character depends on quick reactions to keep themselves safe of harm.";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = false;
	}

	function isHidden() {
		return this.getBonus() == 0;
	}

	function getBonus() { // this needs to be moved to the shield itself but not rn
		local actor = this.getContainer().getActor();

		if (actor == null || !actor.isPlacedOnMap() || !::Tactical.isActive()) {
			return 0;
		}

		return ::Math.round(actor.getInitiative() * 0.01 * this.m.Bonus);
	}

	function getTooltip() {
		local tooltip = [
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
		];

		local paramBonus = [["_bonus", this.getBonus()], ["_rangedBonus", this.Math.round(this.getBonus() / 2)]]
		if (::Tactical.isActive()) {
			tooltip.extend([{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+%_bonus%[/color] Melee Defense",
				param = paramBonus
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+%_rangedBonus%[/color] Ranged Defense",
				param = paramBonus
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/block.png",
				text = "[color=%positive%]+%_bonus%[/color] Block",
				param = paramBonus
			}]);
		}
		return tooltip;
	}

	function onUpdate(_properties) {
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += this.Math.round(this.getBonus() / 2)
	}
});
