this.legend_sprint_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_sprint";
		this.m.Name = "Sprint";
		this.m.Description = "For the remainder of this turn, the Action Point cost for movement is reduced by 1 for each tile, but the Fatigue cost is doubled.";
		this.m.Icon = "ui/perks/perk_sprint.png";
		this.m.IconDisabled = "ui/perks/perk_sprint_sw.png";
		this.m.Overlay = "perk_37_active";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OtherTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 10;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
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
				text = "For the remainder of this turn, the Action Point cost for movement is reduced by [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] for each tile, but the Fatigue cost is doubled."
			}
		];
		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.sprint");
	}

	function onUse( _user, _targetTile )
	{
		if (!this.getContainer().hasSkill("effects.sprint"))
		{
			this.m.Container.add(this.new("scripts/skills/effects/sprint_effect"));
			return true;
		}

		return false;
	}

});

