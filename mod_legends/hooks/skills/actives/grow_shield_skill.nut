::mods_hookExactClass("skills/actives/grow_shield_skill", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "Regrow your bark, producing a protective shield";
		this.m.IconDisabled = "skills/active_121_bw.png";
	}

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
				icon = "ui/icons/melee_defense.png", // fix from /ui to ui/ Abyss 6/17/23
				text = "Grants a [color=%positive%]" + "+20" + "[/color] Melee and Ranged Defense shield, with [color=%positive%]" + "32" + "[/color] durability"
			}
		];
	}
});
