this.legend_evasion_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "actives.legend_evasion";
		this.m.Name = "Evasion";
		this.m.Description = "Prepares the character to move safely through any Zone of Control next turn without incurring any free attacks.";
		this.m.Icon = "skills/evasion.png";
		this.m.IconDisabled = "skills/evasion_bw.png";
		this.m.Overlay = "evasion";
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 30;
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
			}
		];
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.legend_evasion");
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		if (!this.getContainer().hasSkill("effects.legend_evasion"))
		{
			this.m.Container.add(this.new("scripts/skills/effects/legend_evasion_effect"));
			return true;
		}

		return false;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onRemoved()
	{
		this.m.Container.removeByID("effects.legend_evasion");
	}

});
