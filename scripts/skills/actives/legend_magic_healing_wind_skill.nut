this.legend_magic_healing_wind_skill <- this.inherit("scripts/skills/actives/legend_magic_skill", {
	m = {
		BaseHeal = 2
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicHealingWind);
		this.m.Description = "Restore the health of all allies within 4 tiles. Must be holding a magic staff to use.";
		this.m.Icon = "skills/magic_mist_01.png";
		this.m.IconDisabled = "skills/magic_mist_01_bw.png";
		this.m.Overlay = "mage_legend_magic_healing_wind_square";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc4/wardrums_01.wav",
			"sounds/enemies/dlc4/wardrums_02.wav",
			"sounds/enemies/dlc4/wardrums_03.wav"
		];
		this.m.SoundVolume = 1.5;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = true;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 45;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ResolveScaling = 25;
	}

	function getHealAmount()
	{
		return this.m.BaseHeal + this.getResolveScaling();
	}

	function getTooltip()
	{
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
			},
			{
				id = 4,
				type = "text",
				text = "Heals [color=%positive%]" + this.getHealAmount() + "[/color]. Heal amount is based on resolve."
			}
		];
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());
		local healAmount = this.getHealAmount();
		foreach( a in actors )
		{
			if (myTile.getDistanceTo(a.getTile()) > 4)
			{
				continue;
			}

			if (a.getFaction() == _user.getFaction())
			{
				if (a.getHitpoints() < a.getHitpointsMax())
				{
					a.setHitpoints(this.Math.max(0, this.Math.min(a.getHitpointsMax(), a.getHitpoints() + healAmount)));
					this.spawnIcon(this.m.Overlay, a.getTile());
				}
			}
		}
		return true;
	}

});

