this.legend_drink_heartwood_sap_skill <- this.inherit("scripts/skills/actives/base/legend_drink_potion_skill", {
	m = {},

	function create() {
		this.legend_drink_potion_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrinkHeartwoodSap);
		this.m.Description = "Give to an adjacent ally or drink yourself a flask of heartwood sap that promises to render someone indomitable for three turns. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/heartwood_sap_potion_square.png";
		this.m.IconDisabled = "skills/blood_potion_square_bw.png";
		this.m.Overlay = "active_144";
		this.m.StatusEffect = "status_effect_93";
		this.m.Effects = ["legend_greenwood_sap_effect"];
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
				icon = "ui/icons/days_wounded.png",
				text = "Grants perfect focus, halving the action point costs of all skills for three turns."
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
		return this.Const.UI.getColorizedEntityName(_user) + " drinks Heartwood Sap";
	}

	function tacticalLogGive(_user, _target) {
		return this.Const.UI.getColorizedEntityName(_user) + " gives Heartwood Sap to " + this.Const.UI.getColorizedEntityName(_target);
	}
});

