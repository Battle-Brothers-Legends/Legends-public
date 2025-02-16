this.legend_reload_ally_skill <- this.inherit("scripts/skills/skill", {
	m = {
		ApplicableSkill = "",
		IsUsingOwnAmmo = false,
		ReloadBuddy = null
	},
	function create()
	{
		this.m.ID = "actives.legend_reload_ally";
		this.m.Name = "Reload";
		this.m.Description = "Make yourself helpful and reload an ally\'s crossbow or handgonne. You\'ll need to use your own ammunition.";
		this.m.Icon = "";
		this.m.IconDisabled = "";
		this.m.Overlay = "";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.IsHidden = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		local ret = [
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
			}
		];
		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] bolts left"
			});
		}
		else
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Needs a non-empty quiver of bolts equipped[/color]"
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	function getAmmo()
	{
		local ammoType = this.m.ApplicableSkill == "actives.reload_bolt" ? this.Const.Items.AmmoType.Bolts : this.Const.Items.AmmoType.Powder;
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
		if (item != null && item.getAmmoType() == ammoType)
		{
			this.m.isUsingOwnAmmo = true;
			return item.getAmmo()
		}
		item = this.m.ReloadBuddy.getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
		if (item == null)
		{
			return 0;
		}

		if (item.getAmmoType() == ammoType)
		{
			return item.getAmmo();
		}
	}

	function isHidden()
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

						if (entity.getSkills().hasSkill(this.m.ApplicableSkill))
						{
							this.m.ReloadBuddy = entity;
							return false;
						}
					}
				}
			}
		}

		return this.skill.isHidden();
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = 1.0;
		if (_properties.IsSpecializedInCrossbows)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.ActionPointCost -= 1;	
		}
		if (_entity.getSkills().hasTrait(::Legends.Trait.Teamplayer))
		{
			this.ActionPointCost -= 1;
		}
		if (_entity.getSkills().hasTrait(::Legends.Trait.QuickHands))
		{
			this.ActionPointCost -= 1;
		}
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0 && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (!this.m.Container.getActor().isAlliedWith(target))
		{
			return false;
		}

		if (target.getSkills().hasSkill(this.m.applicableSkill))
		{
			return true;
		}

		return false;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		local reload = target.getSkills().getSkillByID(this.m.applicableSkill);

		if (reload != null)
		{
			if (reload.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(reload.m.SoundOnUse[this.Math.rand(0, reload.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill * reload.m.SoundVolume, _user.getPos());
			}

			reload.onUseByAlly(target, _targetTile);
		}

		return true;
	}

});

