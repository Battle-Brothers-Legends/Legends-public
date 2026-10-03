this.legend_prayer_of_faith_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Resolve = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPrayerOfFaith);
		this.m.Description = "This character is being protected by a stern proclamation of faith.";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getBonus() {
		return ::Math.floor(this.m.Resolve * 0.20);
	}

	function getTooltip() {
		local bonus = this.getBonus();
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
				icon = "ui/icons/health.png",
				text = "Melee and Ranged Defense increased by [color=%positive%]+" + bonus + "[/color]"
			}
		];
	}

	function onTurnEnd() {
		this.removeSelf();
	}

	function onUpdate(_properties) {
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus;
	}
});
