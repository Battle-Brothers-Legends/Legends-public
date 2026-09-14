::mods_hookExactClass("skills/actives/ghoul_claws", function(o)
{
	o.getTooltip <- function ()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		return [
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
				id = 4,
				type = "text",
				icon = "ui/icons/health.png", // fix from /ui to ui/ ty for pointing this out Necro, Abyss 6/17/23
				text = "Inflicts [color=%damage%]" + p.DamageRegularMin + "[/color] - [color=%damage%]" + p.DamageRegularMax + "[/color] damage"
			}
		];
	}
});
