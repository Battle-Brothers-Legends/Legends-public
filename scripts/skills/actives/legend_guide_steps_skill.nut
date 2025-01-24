this.legend_guide_steps_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_guide_steps";
		this.m.Name = "Guide steps";
		this.m.Description = "Point out dips and obstacles in the landscape, increasing movement for your troops.";
		this.m.Icon = "skills/guided_steps_square.png";
		this.m.IconDisabled = "skills/guided_steps_square_bw.png";
		this.m.Overlay = "guided_steps_square";
		this.m.SoundOnUse = [
			"sounds/combat/guided_steps_01.wav"
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
		local p = this.getContainer().getActor().getCurrentProperties();
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
				text =  "Grants pathfinder to all allies within [color=" + this.Const.UI.Color.PositiveValue + "]40[/color] tiles"
			}			
		];
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasEffect(::Legends.Effect.LegendStepsGuided);
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

			if (myTile.getDistanceTo(a.getTile()) > 4)
			{
				continue;
			}

			if (a.getFaction() == _user.getFaction() && !a.getSkills().hasEffect(::Legends.Effect.LegendStepsGuided))
			{
				a.getSkills().add(this.new("scripts/skills/effects/legend_steps_guided"));
			}
		}

		this.getContainer().add(this.new("scripts/skills/effects/legend_steps_guided"));
		return true;
	}

});
