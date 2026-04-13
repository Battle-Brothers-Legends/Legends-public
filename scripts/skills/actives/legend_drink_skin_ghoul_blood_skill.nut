this.legend_drink_skin_ghoul_blood_skill <- this.inherit("scripts/skills/actives/base/legend_drink_potion_skill", {
	m = {},

	function create() {
		this.legend_drink_potion_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrinkSkinGhoulBlood);
		this.m.Description = "Give to an adjacent ally or drink yourself a flask of skin ghoul blood that promises to knit wounds and heal damaged flesh. Can not be used while engaged in melee, and anyone receiving the item needs to have a free bag slot.";
		this.m.Icon = "skills/blooddrop_square.png";
		this.m.IconDisabled = "skills/blooddrop_square_bw.png";
		this.m.Overlay = "active_144";
		this.m.StatusEffect = "status_effect_93";
		this.m.Effects = ["legend_skin_ghoul_blood_effect"];
	}

	function getTooltip()
	{

		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = this.Math.min(healthMissing, this.Math.floor(actor.getHitpointsMax() * 0.10));

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
				text = "[color=%positive%]+ " + healthAdded + "[/color] this turn"
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
		return this.Const.UI.getColorizedEntityName(_user) + " drinks Skin Ghoul Potion";
	}

	function tacticalLogGive(_user, _target) {
		return this.Const.UI.getColorizedEntityName(_user) + " gives Skin Ghoul Potion to " + this.Const.UI.getColorizedEntityName(_target);
	}
});

