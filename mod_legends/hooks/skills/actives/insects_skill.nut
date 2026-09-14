::mods_hookExactClass("skills/actives/insects_skill", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Icon = "skills/insects_square.png";
		this.m.IconDisabled = "skills/insects_square_bw.png";
		this.m.MaxLevelDifference = 8;
	}

	o.getDescription <- function () {
		return "Conjure a cloud of a thousand black flies to swarm an enemy. The insects seek to crawl into every crack in the armor and every bodily orifice, almost completely overwhelming the target's ability to fight for [color=" + this.Const.UI.Color.NegativeValue + "]" + 3 + "[/color] turns.";
	}

	o.getTooltip <- function () {
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
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-50%[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-50%[/color] Ranged Skill"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-50%[/color] Melee Defense"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-50%[/color] Ranged Defense"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-50%[/color] Initiative"
			}
		];
		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))	{
			ret.push({
				id = 15,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Cannot be used because this character is engaged in melee[/color]"
			});
		}
		return ret;
	}

	o.isUsable <- function () {
		return this.skill.isUsable() && !this.getContainer().getActor().isEngagedInMelee();
	}
});
