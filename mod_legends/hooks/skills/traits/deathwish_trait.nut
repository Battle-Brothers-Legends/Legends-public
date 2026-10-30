::mods_hookExactClass("skills/traits/deathwish_trait", function(o) {
	o.m.Malus <- -5;
	o.m.Bonus <- 0.25;

	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "I\'m not dead yet! This character doesn\'t care about receiving injuries and will even fight with increased vigor despite them.";
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Does not protect from effects that target morale directly, like Fearsome"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]%_malus%[/color] Melee Defense",
				param = [["_malus", this.m.Malus]]
			},
			{
				id = 17,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=%negative%]%_bonus%[/color] increased Damage Dealt from missing Hitpoints",
				param = [["_bonus", this.getBonus()]]
			}
		]);

		return ret;
	}

	o.getBonus <- function () {
		return ::Math.minf(this.m.Bonus, this.m.Bonus * (0.4 + 1.0 -  this.getContainer().getActor().getHitpointsPct()));
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties ) {
		onUpdate(_properties);
		_properties.MeleeDefense -= 5;
		local hpRatio = this.getContainer().getActor().getHitpointsPct();
		_properties.DamageTotalMult *= 1.0 + this.getBonus();
	}
});
