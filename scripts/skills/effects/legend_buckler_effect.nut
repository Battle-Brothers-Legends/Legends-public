this.legend_buckler_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Bonus = 5
	},
	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBuckler);
		this.m.Icon = "ui/perks/perk_02.png";
		//this.m.IconMini = "perk_02_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = false;
	}

	function getDescription() {
		return "Bucklers favor a quick fighter.";
	}

	function isHidden() {
		return this.getBonus() == 0;
	}

	function getBonus() {
		local actor = this.getContainer().getActor();

		if (actor == null || !actor.isPlacedOnMap() || !::Tactical.isActive()) {
			return 0;
		}

		return ::Math.round(actor.getInitiative() * 0.01 * this.m.Bonus);
	}

	function getTooltip() {
		local bonus = this.getBonus();
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

		if (::Tactical.isActive()) {
			tooltip.extend([{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + bonus + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + bonus + "[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/block.png",
				text = "[color=%positive%]+" + bonus + "[/color] Block"
			}]);
		}
		return tooltip;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus / 2;
	}


});
