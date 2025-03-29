::mods_hookExactClass("contracts/contracts/destroy_goblin_camp_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"A loathsome goblin camp has been reported near %s. Treacherous creatures who fight without honor - something often also said of sellswords.",
			"%s is offering a hefty bounty for some brave souls to go destroy a nearby goblin camp.",
			"Residents of %s live in fear with a goblin camp nearby, its threat looming ever closer.",
			"With a goblin camp nearby, the safety of %s is brought into question. You are being hired to correct that.",
			"Sneaky little bastards, Goblins. You kill one and another pops up to stab you from behind.",
			"Cunning, sneaky and treacherous little creatures, goblins and sellswords apparently have much in common.",
			"Goblin raiders have been terrorising the roads around %s, you are being hired to eradicate them.",
		];
	}

	o.formatDescription <- function ()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = format(r, ::Const.UI.getColorized(this.m.Origin.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));
		
		this.m.Description = r;
	}
});