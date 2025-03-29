::mods_hookExactClass("skills/injury/injury", function(o)
{
	o.m.Points <- 0.0;
	o.m.Queue <- 0;

	o.getQueue <- function ()
	{
		return this.m.Queue;
	}

	o.setQueue <- function ( _f )
	{
		this.m.Queue = _f;
	}

	o.getCost <- function ()
	{
		return this.m.HealingTimeMax + this.m.HealingTimeMin;
	}

	o.getPoints <- function ()
	{
		return this.m.Points;
	}

	o.setPoints <- function ( _v)
	{
		this.m.Points = _v;
	}

	o.getTreatedPercentage <- function ()
	{
 		return this.m.Points / this.getCost();
	}

	o.addTooltipHint = function ( _tooltip )
	{
		if (this.m.IsContentWithReserve)
		{
			_tooltip.push({
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is content for now with being in reserve"
			});
		}

		if (this.m.IsFresh && !this.m.IsAlwaysInEffect && !this.getContainer().getActor().getCurrentProperties().IsAffectedByFreshInjuries && this.m.IsHealingMentioned)
		{
			_tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Will take effect only after combat ends due to the Iron Will effect"
			});
		}

		if (!this.m.IsAlwaysInEffect && !this.getContainer().getActor().getCurrentProperties().IsAffectedByInjuries && this.m.IsHealingMentioned)
		{
			if (("State" in this.Tactical) && this.Tactical.State != null)
			{
				_tooltip.push({
					id = 7,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "Will take effect only after combat ends due to the Iron Will effect"
				});
			}
			else
			{
				_tooltip.push({
					id = 7,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "Will take effect again only after the next battle due to the Iron Will effect"
				});
			}
		}

		if (("State" in this.World) && this.World.State != null && this.World.Assets.getMedicine() <= 0 && this.m.IsHealingMentioned)
		{
			_tooltip.push({
				id = 7,
				type = "hint",
				icon = "ui/icons/warning.png",
				text = "Will not heal because you have no medical supplies"
			});
		}
		else if (this.getContainer().getActor().getSkills().hasTrait(::Legends.Trait.OathOfSacrifice) && this.m.IsHealingMentioned)
		{
			_tooltip.push({
				id = 7,
				type = "hint",
				icon = "ui/icons/warning.png",
				text = "Will not heal because this character has taken an oath of sacrifice"
			});
		}
		else
		{
			local ht = this.getHealingTime();
			local d;

			if (this.m.IsHealingMentioned)
			{
				if (ht.Max > 1 && ht.Min == ht.Max)
				{
					d = "Will heal in " + ht.Min + " days";
				}
				else if (ht.Max > 1)
				{
					d = "Will heal in " + ht.Min + " to " + ht.Max + " days";
				}
				else
				{
					d = "Will heal by tomorrow";
				}

				_tooltip.push({
					id = 6,
					type = "hint",
					icon = "ui/icons/days_wounded.png",
					text = d
				});
			}
			else
			{
				if (ht.Max > 1 && ht.Min == ht.Max)
				{
					d = "Will be gone in " + ht.Min + " days";
				}
				else if (ht.Max > 1)
				{
					d = "Will be gone in " + ht.Min + " to " + ht.Max + " days";
				}
				else
				{
					d = "Will be gone by tomorrow";
				}

				_tooltip.push({
					id = 6,
					type = "hint",
					icon = "ui/icons/action_points.png",
					text = d
				});
			}
		}
	}

	o.onNewDay = function ()
	{
		if (!(this.getContainer().getActor().getSkills().hasTrait(::Legends.Trait.OathOfSacrifice) && this.m.IsTreatable) && (this.World.Assets.getMedicine() >= this.Const.World.Assets.MedicinePerInjuryDay || !this.m.IsHealingMentioned))
		{
			if (this.m.IsHealingMentioned)
			{
				this.World.Assets.addMedicine(-this.Const.World.Assets.MedicinePerInjuryDay);
			}

			local time = this.getTime();
			local daysPassed = this.Math.ceil((time - this.m.TimeApplied) / this.World.getTime().SecondsPerDay);
			local minTime = this.m.HealingTimeMin * (this.m.IsTreated ? 0.5 : (1.0 - 0.5 * this.getTreatedPercentage()));
			local maxTime = this.m.HealingTimeMax * (this.m.IsTreated ? 0.5 : (1.0 - 0.5 * this.getTreatedPercentage()));

			if (this.World.Retinue.hasFollower("follower.surgeon"))
			{
				minTime = this.Math.max(1, minTime - 1);
				maxTime = this.Math.max(1, maxTime - 1);
			}

			if (this.getContainer().getActor().getSkills().hasEffect(::Legends.Effect.NachzehrerPotion))
			{
				minTime = this.Math.max(1, minTime - 1);
				maxTime = this.Math.max(1, maxTime - 1);
			}

			if (daysPassed < minTime)
			{
				return;
			}

			local chance = daysPassed / (maxTime * 1.0) * 100.0;

			if (this.Math.rand(1, 100) <= chance)
			{
				this.removeSelf();
				return;
			}
		}
		else
		{
			this.m.TimeApplied = this.Math.minf(this.Time.getVirtualTimeF(), this.m.TimeApplied + this.World.getTime().SecondsPerDay);
		}
	}

	o.onSerialize = function ( _out )
	{
		_out.writeF32(this.m.TimeApplied);
		_out.writeBool(this.m.IsTreated);
		_out.writeU32(this.m.HealingTimeMin);
		_out.writeU32(this.m.HealingTimeMax);
		_out.writeU8(this.m.Queue);
		_out.writeF32(this.m.Points);
		//_out.writeBool(false);
	}

	o.onDeserialize = function ( _in )
	{
		this.m.IsFresh = false;
		this.m.IsShownOutOfCombat = true;
		this.m.TimeApplied = _in.readF32();
		this.m.IsTreated = _in.readBool();
		this.m.HealingTimeMin = _in.readU32();
		this.m.HealingTimeMax = _in.readU32();
		this.m.Queue = _in.readU8();
		this.m.Points = _in.readF32();
		//_in.readBool();
	}
});