this.legend_nightvision_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendNightvision);
		this.m.Description = "Use your superior vision to pick out enemies in the dark and point them out to your mercenaries.";
		this.m.Icon = "skills/nightvision_square.png";
		this.m.IconDisabled = "skills/nightvision_square_bw.png";
		this.m.Overlay = "nightvision_square";
		this.m.SoundOnUse = [
			"sounds/enemies/shaman_skill_nightvision_01.wav",
			"sounds/enemies/shaman_skill_nightvision_02.wav",
			"sounds/enemies/shaman_skill_nightvision_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.BeforeLast;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		return [
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
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text =  "Removes night penalties from all allies within [color=%positive%]4[/color] tiles"
			}
		];
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());
		foreach( a in actors)
		{

			if (myTile.getDistanceTo(a.getTile()) > 4)
			{
				continue;
			}

			if (a.getFaction() != _user.getFaction())
			{
				continue
			}

			if (a.getSkills().hasEffect(::Legends.Effect.Night))
		 	{
				this.spawnIcon("status_effect_98", a.getTile());
				::Legends.Effects.remove(a, ::Legends.Effect.Night);
		 	}

		}

		return true;
	}
});
