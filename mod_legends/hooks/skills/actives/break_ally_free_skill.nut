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
		local toHit = this.Math.min(100, skill - 10 + (actor.getSkills().hasEffect(::Legends.Effect.GoblinShamanPotion) ? 100 : 0));
		if (actor.getCurrentProperties().IsSpecializedInNets)
		{
			toHit = this.Math.max(99, toHit);
		}
		return toHit;
	}

	o.isHidden = function ()
	{
		local actor = this.getContainer().getActor();

		if (this.Tactical.isActive() && actor.isPlacedOnMap())
		{
			local myTile = actor.getTile();

			for( local i = 0; i < 6; i = ++i )
			{
				if (!myTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = myTile.getNextTile(i);

					if (this.Math.abs(tile.Level - myTile.Level) <= 1 && tile.IsOccupiedByActor && tile.getEntity().isAlliedWith(actor))
					{
						local entity = tile.getEntity();

						if (entity.getSkills().hasEffect(::Legends.Effect.Net))
						{
							this.m.Icon = "skills/active_157.png";
							this.m.IconDisabled = "skills/active_157_sw.png";
							return false;
						}

						if (entity.getSkills().hasEffect(::Legends.Effect.Web))
						{
							this.m.Icon = "skills/active_158.png";
							this.m.IconDisabled = "skills/active_158_sw.png";
							return false;
						}

						if (entity.getSkills().hasEffect(::Legends.Effect.Rooted))
						{
							this.m.Icon = "skills/active_159.png";
							this.m.IconDisabled = "skills/active_159_sw.png";
							return false;
						}

						if (entity.getSkills().hasEffect(::Legends.Effect.KrakenEnsnare))
						{
							this.m.Icon = "skills/active_151.png";
							this.m.IconDisabled = "skills/active_151_sw.png";
							return false;
						}

						if (entity.getSkills().hasEffect(::Legends.Effect.SerpentEnsnare))
						{
							this.m.Icon = "skills/active_190.png";
							this.m.IconDisabled = "skills/active_190_sw.png";
							return false;
						}
					}
				}
			}
		}

		return this.skill.isHidden();
	}
});
