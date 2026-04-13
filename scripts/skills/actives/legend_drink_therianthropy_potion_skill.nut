this.legend_drink_therianthropy_potion_skill <- this.inherit("scripts/skills/actives/base/legend_drink_potion_skill", {
	m = {},

	function create() {
		this.legend_drink_potion_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrinkTherianthropyPotion);
		this.m.Description = "Give to an adjacent ally or drink yourself a horrible concoction of poison taken from the bodies of beasts to destroy your own humanity. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/active_143.png";
		this.m.IconDisabled = "skills/active_143_sw.png";
		this.m.Overlay = "active_143";
		this.m.StatusEffect = "status_effect_92";
		this.m.Effects = [];
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
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will inflict a permanent therianthropic injury on the drinker, allowing them to transform into a beast"
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

	function onUse( _user, _targetTile )
	{
		local user = _targetTile.getEntity();
		user.TherianthropeInfectionRandom();
		return this.legend_drink_potion_skill(_user, _targetTile);
	}

	function tacticalLogDrink(_user) {
		return this.Const.UI.getColorizedEntityName(_user) + " drinks Therianthropic Potion";
	}

	function tacticalLogGive(_user, _target) {
		return this.Const.UI.getColorizedEntityName(_user) + " gives Therianthropic Potion to " + this.Const.UI.getColorizedEntityName(_target);
	}
});

