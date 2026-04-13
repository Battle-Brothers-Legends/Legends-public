this.legend_magic_soothing_wind_skill <- this.inherit("scripts/skills/actives/legend_magic_skill", {
	m = {
		BaseRestore = 3
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicSoothingWind);
		this.m.Description = "Restore the fatigue of all allies within 4 tiles. Must be holding a magic staff to use.";
		this.m.Icon = "skills/soothing_wind_01.png";
		this.m.IconDisabled = "skills/soothing_wind_01_bw.png";
		this.m.Overlay = "mage_legend_magic_soothing_wind_square_bw";
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
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ResolveScaling = 45;
	}

	function getRestoreAmount()
	{
		return this.m.BaseRestore + this.getResolveScaling();
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
				text = "Restores [color=%positive%]" + this.getRestoreAmount() + "[/color] fatigue. Restore amount is based on resolve."
			}
		];
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());
		local restoreAmount = this.getRestoreAmount();
		foreach( a in actors )
		{
			if (myTile.getDistanceTo(a.getTile()) > 4)
			{
				continue;
			}

			if (a.getFaction() == _user.getFaction())
			{
				a.setFatigue(this.Math.max(0, a.getFatigue() - restoreAmount));
				this.spawnIcon(this.m.Overlay, a.getTile());
			}
		}
		return true;
	}

});

