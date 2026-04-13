this.legend_drums_of_war_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrumsOfWar);
		this.m.Description = "Push allies on with your music, lowering the fatigue of all allies within 8 tiles. Must be holding a musical instrument to use. Songs apply once per turn.";
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
				text = "Restores [color=%positive%]" + this.getBonus() + "[/color] fatigue to all allied units within 8 tiles"
			}
		];

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	function getBonus()
	{
		local effect = 1;

		// +2 from Music Mastery
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInMusic)
			effect += 2;

		// +2 from Legend Specialist Musician
		if (this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistMusician))
			effect += 2;

		// +2 from Legend Minnesanger
		if (this.getContainer().hasPerk(::Legends.Perk.LegendMinnesanger))
			effect += 2;

		return effect;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
			return false;

		local mainhand = this.getContainer().getActor().getMainhandItem();
		if (mainhand == null)
			return false;

		if (!this.Tactical.isActive())
			return false;

		local tile = this.getContainer().getActor().getTile();

		return mainhand.isWeaponType(this.Const.Items.WeaponType.Musical) &&
			!tile.hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onUse( _user, _targetTile ) {
		local myTile = _user.getTile();
		local actors = ::Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		local affectedActors = [];
		foreach( a in actors )
		{
			if (_user.getID() == a.getID())
				continue;

			if (a.getSkills().hasEffect(::Legends.Effect.LegendDrumsOfWar))
				continue;

			if (a.getTile().getDistanceTo(myTile) > 8)
				continue;

			::Legends.Effects.grant(a, ::Legends.Effect.LegendDrumsOfWar, function(_effect) {
				_effect.setEffect(this.getBonus());
			}.bindenv(this));

			affectedActors.push(a.weakref());
		}

		::Legends.Effects.grant(_user, ::Legends.Effect.LegendDrumsOfWar, function(_effect) {
			_effect.setEffect(this.getBonus());
			_effect.m.Caster = _user.weakref();
			_effect.m.AffectedActors = affectedActors;
		}.bindenv(this));
		return true;
	}

});

