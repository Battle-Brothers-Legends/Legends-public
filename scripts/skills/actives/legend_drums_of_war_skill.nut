this.legend_drums_of_war_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrumsOfWar);
		this.m.Description = "Push allies on with your music, lowering the fatigue of all allies within 8 tiles. Must be holding a musical instrument to use.";
		this.m.Icon = "skills/drums_of_war_square.png";
		this.m.IconDisabled = "skills/drums_of_war_square_bw.png";
		this.m.Overlay = "drums_of_war_square";
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
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
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
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Restores [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getBonus() + "[/color] fatigue to all allied units within 8 tiles"
			}
		];

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

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = 1.0;
		if (this.getContainer().hasPerk(::Legends.Perk.LegendMinnesanger))
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost -= 1;
		}
	}

	function getBonus()
	{
		local effect = 1;
		if (this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistMusician))
			effect += 2;
		if (this.getContainer().hasPerk(::Legends.Perk.LegendMinnesanger))
			effect += 2;
		return effect;
	}

	function isUsable()
	{
		local mainhand = this.getContainer().getActor().getMainhandItem();
		if (mainhand == null || !this.skill.isUsable())
		{
			return false;
		}
		if (!this.Tactical.isActive())
		{
			return false;
		}

		local tile = this.getContainer().getActor().getTile();
		return mainhand.isWeaponType(this.Const.Items.WeaponType.Musical) && !tile.hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}

			if (myTile.getDistanceTo(a.getTile()) > 8)
			{
				continue;
			}

			if (a.getFaction() == _user.getFaction())
			{
				::Legends.Effects.grant(a, ::Legends.Effect.LegendDrumsOfWar, function(_effect) {
					_effect.setEffect(this.getBonus());
				}.bindenv(this));
			}
		}

		::Legends.Effects.grant(_user, ::Legends.Effect.LegendDrumsOfWar, function(_effect) {
			_effect.setEffect(this.getBonus());
		}.bindenv(this));
		return true;
	}

});

