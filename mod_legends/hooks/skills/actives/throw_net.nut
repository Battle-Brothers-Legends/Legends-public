::mods_hookExactClass("skills/actives/throw_net", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Throw a net on your target in order to prevent them from moving or defending themself effectively.";
		this.m.IsRanged = true;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local tooltip = getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Some targets can never be caught or ensnared"
		});

		return tooltip;
	}

	o.onAfterUpdate = function ( _properties )
	{
		if (_properties.IsSpecializedInNets)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost = 3;
		}

		if (_properties.IsSpecializedInNetCasting)
		{
			this.m.MaxRange = 5;
		}
	}

	o.onUse = function ( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();

		if (!targetEntity.getCurrentProperties().IsImmuneToRoot)
		{
			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " throws a net and hits " + this.Const.UI.getColorizedEntityName(targetEntity));
			_user.getItems().unequip(_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
			local isSpecialized = _user.getCurrentProperties().IsSpecializedInNetCasting;
			local netted = ::Legends.Effects.new(::Legends.Effect.Net);
			local breakFree = this.new("scripts/skills/actives/break_free_skill");
			breakFree.m.Icon = "skills/active_74.png";
			breakFree.m.IconDisabled = "skills/active_74_sw.png";
			breakFree.m.Overlay = "active_74";
			breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;

			if (this.m.IsReinforced)
			{
				breakFree.setDecal("net_destroyed_02");
				breakFree.setChanceBonus(-15);

				if (isSpecialized)
				{
					netted.m.DropNet = true;
					netted.m.IsReinforced = true;
					breakFree.m.DropNet = true;
					breakFree.m.IsReinforcedNet = true;
				}
				else
				{
					local r = this.Math.rand(1, 2);

					if (r == 1)
					{
						this.World.Assets.getStash().add(this.new("scripts/items/tools/legend_broken_throwing_net"));
					}
					else
					{
						this.World.Assets.getStash().add(this.new("scripts/items/tools/reinforced_throwing_net"));
					}
				}
			}
			else
			{
				breakFree.setDecal("net_destroyed");
				breakFree.setChanceBonus(0);

				if (isSpecialized)
				{
					netted.m.DropNet = true;
					breakFree.m.DropNet = true;
				}
				else
				{
					local chance = this.Math.rand(1, 100);

					if (chance > 25)
					{
						this.World.Assets.getStash().add(this.new("scripts/items/tools/legend_broken_throwing_net"));
					}
				}
			}

			targetEntity.getSkills().add(netted);
			targetEntity.getSkills().add(breakFree);
			local effect = this.Tactical.spawnSpriteEffect(this.m.IsReinforced ? "bust_net_02" : "bust_net", this.createColor("#ffffff"), _targetTile, 0, 10, 1.0, targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
			local flip = !targetEntity.isAlliedWithPlayer();
			effect.setHorizontalFlipping(flip);
			this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), {
				TargetEntity = targetEntity,
				IsReinforced = this.m.IsReinforced
			});
		}
		else
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " throws a net at an immune " + this.Const.UI.getColorizedEntityName(targetEntity) + ", the net falls to the ground ");
			_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).drop();
			return false;
		}
	}
});
