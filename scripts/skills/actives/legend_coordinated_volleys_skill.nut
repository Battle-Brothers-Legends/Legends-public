this.legend_coordinated_volleys_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_coordinated_volleys";
		this.m.Name = "Coordinated Volleys";
		this.m.Description = "Time and call the shots for archers, increasing their chance to hit";
		this.m.Icon = "skills/coordinated_volleys_square.png";
		this.m.IconDisabled = "skills/coordinated_volleys_square_bw.png";
		this.m.Overlay = "coordinated_volleys_square";
		this.m.SoundOnUse = [
			"sounds/combat/coordinated_volleys.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.BeforeLast;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 5;
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
				icon = "ui/icons/ranged_skill.png",
				text =  "[color=" + this.Const.UI.Color.PositiveValue + "]10[/color] ranged attack to all allies within [color=" + this.Const.UI.Color.PositiveValue + "]4[/color] tiles for one turn"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text =  "[color=" + this.Const.UI.Color.PositiveValue + "]5%[/color] damage bonus to all allies within [color=" + this.Const.UI.Color.PositiveValue + "]4[/color] tiles for one turn"
			}		
		];
	}

function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.legend_coordinating_volleys");
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

			if (a.getFaction() == _user.getFaction() && !a.getSkills().hasSkill("effects.legend_coordinating_volleys"))
			{
				local effect = this.new("scripts/skills/effects/legend_coordinating_volleys")
				effect.setCommander(this.getContainer().getActor());
				a.getSkills().add(effect);
			}
		}

		local effect = this.new("scripts/skills/effects/legend_coordinating_volleys")
		effect.setCommander(this.getContainer().getActor());
		this.getContainer().add(effect);
		return true;
	}

});
