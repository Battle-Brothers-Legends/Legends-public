::mods_hookExactClass("skills/actives/break_ally_free_skill", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IsUsingHitchance = false;
	}

	o.getTooltip = function ()
	{
		local tooltip = [
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
				icon = "ui/icons/melee_skill.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getChance() + "%[/color] chance to succeed, based on Melee Skill, or higher if there\'s been attempts to free the ally before."
			}
		];

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInNets)
		{
			tooltip.push({
				id = 5,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Net Mastery makes this signficantly easier",
			});
		}

		return tooltip;
	}

	o.getHitchance <- function ( _targetEntity )
	{
		return getChance();
	}

	o.getChance = function ()
	{
		local actor = this.getContainer().getActor();
		local skill = actor.getCurrentProperties().getMeleeSkill();
		local toHit = this.Math.min(100, skill - 10 + (actor.getSkills().hasSkill("effects.goblin_shaman_potion") ? 100 : 0));
		if (actor.getCurrentProperties().IsSpecializedInNets)
		{
			toHit = this.Math.max(99, toHit);
		}
		return toHit;
	}
});
