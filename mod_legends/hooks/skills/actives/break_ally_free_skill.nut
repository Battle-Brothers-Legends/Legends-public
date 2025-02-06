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

	local onUse = o.onUse;
	o.onUse = function(_user, _targetTile)
	{
		local target = _targetTile.getEntity();

		if (target.getSkills().hasSkill("effects.net"))
		{
			this.spawnIcon("status_effect_99", _targetTile);
		}

		if (target.getSkills().hasSkill("effects.web"))
		{
			this.spawnIcon("status_effect_100", _targetTile);
		}

		if (target.getSkills().hasSkill("effects.rooted"))
		{
			this.spawnIcon("status_effect_101", _targetTile);
		}

		if (target.getSkills().hasSkill("effects.kraken_ensnare"))
		{
			this.spawnIcon("status_effect_96", _targetTile);
		}

		if (target.getSkills().hasSkill("effects.serpent_ensnare"))
		{
			this.spawnIcon("status_effect_114", _targetTile);
		}

		local breakFree = target.getSkills().getSkillByID("actives.break_free");

		if (breakFree != null)
		{
			if (breakFree.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(breakFree.m.SoundOnUse[this.Math.rand(0, breakFree.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill * breakFree.m.SoundVolume, _user.getPos());
			}

			breakFree.onUseByAlly(ally, _targetTile);
		}

		return true;
	}
});
