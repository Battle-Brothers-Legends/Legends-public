this.legend_prayer_of_life_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_prayer_of_life";
		this.m.Name = "Prayer of Hope";
		this.m.Description = "Push allies on with your chant of holy scripture, restoring the health of all allies within 1 tile by 20% of your resolve. Does not work on cultists. Inflicts a disintegrating ailment on each adjacent undead.";
		this.m.Icon = "skills/prayer_green_square.png";
		this.m.IconDisabled = "skills/prayer_green_square_bw.png";
		this.m.Overlay = "prayer_green";
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
		local bonus = _user.getCurrentProperties().Bravery * 0.20;
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

			if (a.getFaction() == _user.getFaction())
			{
				if (!a.getFlags().has("cultist") && !a.getSkills().hasSkill("effects.legend_prayer_of_life"))
				{
					local effect = this.new("scripts/skills/effects/legend_prayer_of_life_effect");
					effect.setHeal(bonus);
					a.getSkills().add(effect);
				}
			}

			if (a.getFlags().has("undead") && !a.getFlags().has("ghoul"))
			{
				if (!a.getSkills().hasSkill("effects.disintegrating"))
				{
					a.getSkills().add(this.new("scripts/skills/effects/legend_disintegrating_effect"));
				}
			}
		}

		return true;
	}

});

