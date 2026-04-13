::mods_hookExactClass("skills/actives/root_skill", function(o)
{
	o.m.Cooldown <- 0;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Unleash roots from the ground to ensnare your targets to prevent them from moving or defending themselves effectively. Will always hit if the enemy isn\'t immune. This spell is easier to cast when it\'s raining.";
		this.m.Icon = "skills/roots_square.png";
		this.m.IconDisabled = "skills/roots_square_bw.png"
	}

	o.getTooltip <- function ()
	{
		local tooltip = this.getDefaultUtilityTooltip();
		tooltip.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "All enemies in an area of [color=%damage%]7[/color] tiles will become [color=#731f39]Trapped in Vines[/color]"
		});

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			tooltip.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	o.onAfterUpdate <- function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInPolearms ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 5 : 6;

		if (this.getContainer().hasEffect(::Legends.Effect.LegendRain))
		{
			this.m.FatigueCost -= 10;
			this.m.ActionPointCost -= 1;
		}

	}

	o.isUsable <- function ()
	{
		return this.skill.isUsable() && !this.getContainer().getActor().isEngagedInMelee() && (this.getContainer().getActor().isPlayerControlled() || this.m.Cooldown == 0);
	}

	local onUse = o.onUse;
	o.onUse = function ( _user, _targetTile )
	{
		local item = _user.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local hasStaff = item != null && item.getID() == "legend_named_goblin_staff";
		local hasTraitCombo = ::Legends.Traits.has(this, ::Legends.Trait.RacialGoblinShaman) && ::Legends.Traits.has(this, ::Legends.Trait.RacialSchrat);
		if (!hasStaff && !hasTraitCombo)
		{
			local ret = onUse(_user, _targetTile);
			this.m.Cooldown = 2;
			return ret;
		}

		local targets = [];

		if (_targetTile.IsOccupiedByActor)
		{
			local entity = _targetTile.getEntity();

			if (this.isViableTarget(_user, entity))
			{
				targets.push(entity);
			}
		}

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local adjacent = _targetTile.getNextTile(i);

				if (adjacent.IsOccupiedByActor)
				{
					local entity = adjacent.getEntity();

					if (this.isViableTarget(_user, entity))
					{
						targets.push(entity);
					}
				}
			}
		}

		foreach( target in targets )
		{
			::Legends.Effects.grant(target, ::Legends.Effect.Rooted, function(_effect) {
				_effect.setDamage(10, 20);
			}.bindenv(this));
			if (::Legends.S.skillEntityAliveCheck(target))
				continue;
			::Legends.Actives.grant(target, ::Legends.Active.BreakFree, function (_skill) {
				_skill.setDecal("roots_destroyed");
				_skill.m.Icon = "skills/active_75.png";
				_skill.m.IconDisabled = "skills/active_75_sw.png";
				_skill.m.Overlay = "active_75";
				_skill.m.SoundOnUse = this.m.SoundOnHitHitpoints;
			}.bindenv(this));
			target.raiseRootsFromGround("bust_roots", "bust_roots_back");
		}

		if (targets.len() > 0 && this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, this.targetEntity.getPos());
		}
		this.m.Cooldown = 2;
		return true;
	}

	o.onTurnEnd <- function()
	{
		this.m.Cooldown -= 1;
	}

});
