this.legend_drink_lionheart_skill <- this.inherit("scripts/skills/actives/base/legend_drink_potion_skill", {
	m = {},

	function create() {
		this.legend_drink_potion_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrinkLionheart);
		this.m.Description = "Give to an adjacent ally or drink yourself a potion that inhibits fear and promotes courage, up to and including the gross overestimation of one\'s own abilities. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/active_141.png";
		this.m.IconDisabled = "skills/active_141_sw.png";
		this.m.Overlay = "active_141";
		this.m.StatusEffect = "status_effect_90";
		this.m.Effects = ["lionheart_potion_effect"];
	}

	function getTooltip()
	{
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+40[/color] Resolve"
			}
		];

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	function tacticalLogDrink(_user) {
		return this.Const.UI.getColorizedEntityName(_user) + " drinks Lionheart Potion";
	}

	function tacticalLogGive(_user, _target) {
		return this.Const.UI.getColorizedEntityName(_user) + " gives Lionheart Potion to " + this.Const.UI.getColorizedEntityName(_target);
	}
});

