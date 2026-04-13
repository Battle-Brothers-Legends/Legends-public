this.legend_drink_night_vision_skill <- this.inherit("scripts/skills/actives/base/legend_drink_potion_skill", {
	m = {},

	function create() {
		this.legend_drink_potion_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrinkNightVision);
		this.m.Description = "Give to an adjacent ally or drink yourself an alchemical marvel to brighten up the night like if it were the mid of day. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/active_142.png";
		this.m.IconDisabled = "skills/active_142_sw.png";
		this.m.Overlay = "active_142";
		this.m.StatusEffect = "status_effect_91";
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
				text = "Removes the Nighttime effect"
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

	function onUse( _user, _targetTile ) {
		local user = _targetTile.getEntity();
		::Legends.Effects.remove(user, ::Legends.Effect.Night);
		return this.legend_drink_potion_skill.onUse(_user, _targetTile);
	}

	function tacticalLogDrink(_user) {
		return this.Const.UI.getColorizedEntityName(_user) + " drinks Night Owl Elixir";
	}

	function tacticalLogGive(_user, _target) {
		return this.Const.UI.getColorizedEntityName(_user) + " gives Night Owl Elixir to " + this.Const.UI.getColorizedEntityName(_target);
	}
});

