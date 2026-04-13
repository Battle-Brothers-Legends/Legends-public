this.legend_drink_cat_skill <- this.inherit("scripts/skills/actives/base/legend_drink_potion_skill", {
	m = {},

	function create() {
		this.legend_drink_potion_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrinkCat);
		this.m.Description = "Give to an adjacent ally or drink yourself a potion that heightens your senses and sharpens your reflexes, promising to make you as quick to act as a cat. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/active_144.png";
		this.m.IconDisabled = "skills/active_144_sw.png";
		this.m.Overlay = "active_144";
		this.m.StatusEffect = "status_effect_93";
		this.m.Effects = ["cat_potion_effect"];
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
				icon = "ui/icons/initiative.png",
				text = "[color=%positive%]+40[/color] Initiative"
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
		return this.Const.UI.getColorizedEntityName(_user) + " drinks Cat Potion";
	}

	function tacticalLogGive(_user, _target) {
		return this.Const.UI.getColorizedEntityName(_user) + " gives Cat Potion to " + this.Const.UI.getColorizedEntityName(_target);
	}
});

