this.legend_prayer_of_faith_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendPrayerOfFaith);
		this.m.Description = "Grant defense to your allies with your chant of holy scripture, granting +20% of your resolve as melee and ranged defense. Adjacent undead and cultists are Baffled.";
		this.m.Icon = "skills/prayer_purple_square.png";
		this.m.IconDisabled = "skills/prayer_purple_square_bw.png";
		this.m.Overlay = "prayer_purple";
		this.m.SoundOnUse = [
			"sounds/ambience/buildings/temple_prayer_00.wav",
			"sounds/ambience/buildings/temple_prayer_01.wav",
			"sounds/ambience/buildings/temple_prayer_02.wav"
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
		this.m.ActionPointCost = 6;
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
			}
		];

		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable();
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getAllInstancesAsArray();

		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}

			if (myTile.getDistanceTo(a.getTile()) > 1)
			{
				continue;
			}

			if ((a.getFlags().has("undead") && !a.getFlags().has("ghoul")) || a.getFlags().has("cultist"))
			{
				::Legends.Effects.grant(a, ::Legends.Effect.LegendBaffled);
			}
			else if (a.getFaction() == _user.getFaction())
			{
				::Legends.Effects.grant(a, ::Legends.Effect.LegendPrayerOfFaith, function(_effect) {
					_effect.m.Resolve = this.getContainer().getActor().getBravery();
				}.bindenv(this));
			}
		}

		return true;
	}

});

