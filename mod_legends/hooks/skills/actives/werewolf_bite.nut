::mods_hookExactClass("skills/actives/werewolf_bite", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Tear an enemy assunder with your teeth";
		this.m.IconDisabled = "skills/active_71_bw.png";
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
				icon = "ui/icons/health.png", // fix from /ui to ui/, Abyss 6/17/23
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + p.DamageRegularMin + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + p.DamageRegularMax + "[/color] damage"
			}
		];
	}
});
