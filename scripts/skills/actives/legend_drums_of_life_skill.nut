this.legend_drums_of_life_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrumsOfLife);
		this.m.Description = "Heal allies on with your music, restoring the health of all allies within 8 tiles. Must be holding a musical instrument to use.";
		this.m.Icon = "skills/drums_of_life_square.png";
		this.m.IconDisabled = "skills/drums_of_life_square_bw.png";
		this.m.Overlay = "drums_of_life_square";
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
				text = "Restores [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getBonus() + "[/color] hitpoints to all allied units"
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

	function getBonus()
	{
		local effect = 1;

		// +3 from Music Mastery
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInMusic)
			effect += 3;

		// +3 from Entrancing Song
		if (this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistMusician))
			effect += 3;

		// +3 from Legend Minnesanger
		if (this.getContainer().hasPerk(::Legends.Perk.LegendMinnesanger))
			effect += 3;

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

			if (a.getSkills().hasEffect(::Legends.Effect.LegendDrumsOfLife))
				continue;

			if (a.getTile().getDistanceTo(myTile) > 8)
				continue;

			::Legends.Effects.grant(a, ::Legends.Effect.LegendDrumsOfLife, function(_effect) {
				_effect.setEffect(this.getBonus());
			}.bindenv(this));

			affectedActors.push(a.weakref());
		}

		::Legends.Effects.grant(_user, ::Legends.Effect.LegendDrumsOfLife, function(_effect) {
			_effect.setEffect(this.getBonus());
			_effect.m.Caster = _user.weakref();
			_effect.m.AffectedActors = affectedActors;
		}.bindenv(this));
		return true;
	}
});

