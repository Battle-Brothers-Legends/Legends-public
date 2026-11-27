this.legend_buckler_defense_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Bonus = 5
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBucklerDefense);
		this.m.Description = "Fighting with a buckler, this character depends on quick reactions to keep themselves safe of harm.";
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsSerialized = false;
	}

	function getBonus() {
		// this needs to be moved to the shield itself but not rn
		return ::Math.round(this.getContainer().getActor().getInitiative() * 0.01 * this.m.Bonus);
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

		local paramBonus = [
			["_bonus", this.getBonus()],
			["_rangedBonus", ::Math.round(this.getBonus() / 2)]
		];
		tooltip.extend([
			{
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
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += ::Math.round(this.getBonus() / 2);
		_properties.Block += this.getBonus();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.getBonus() + "[/color] " + ::Legends.Text.inlineIcons(["melee_defense", "block"]) + ", [color=%positive%]+" + ::Math.round(this.getBonus() / 2) + "[/color] " + ::Legends.Text.inlineIcons("ranged_defense");
	}
});
