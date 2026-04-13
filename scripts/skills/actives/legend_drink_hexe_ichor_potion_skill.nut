this.legend_drink_hexe_ichor_potion_skill <- this.inherit("scripts/skills/actives/base/legend_drink_potion_skill", {
	m = {},

	function create() {
		this.legend_drink_potion_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrinkHexeIchorPotion);
		this.m.Description = "Give to an adjacent ally or drink yourself a dubious hexen brew, granting health and fatigue, but poisoning you. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/ichor_potion_square.png";
		this.m.IconDisabled = "skills/ichor_potion_square_bw.png";
		this.m.Overlay = "active_140";
		this.m.StatusEffect = "status_effect_89";
		this.m.Effects = ["legend_hexe_ichor_potion_effect", "goblin_poison_effect"];
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
				icon = "ui/icons/fatigue.png",
				text = "[color=%positive%]+20[/color] Fatigue Recovery per turn"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "[color=%positive%]+20[/color] Health Recovery per turn"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Become [color=%negative%]poisoned[/color]"
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
		return this.Const.UI.getColorizedEntityName(_user) + " drinks Hexen Ichor Potion";
	}

	function tacticalLogGive(_user, _target) {
		return this.Const.UI.getColorizedEntityName(_user) + " gives Hexen Ichor Potion to " + this.Const.UI.getColorizedEntityName(_target);
	}
});

