this.legend_trance_abstract_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsInTrance = false,
		IsSameTurn = false,
		BaseFatigueCost = 50,
		BaseAPCost = 5,
		ToggleOnDescription = "",
		ToggleOffDescription = ""
	},
	function create() //this trance abstract is for trances which are wrapped into 1 active, ee read omens or scry trances
	{   
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 5;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsTargetingActor = false;
		this.m.ActionPointCost = this.m.BaseAPCost;
		this.m.FatigueCost = this.m.BaseFatigueCost;
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

	function onCombatFinished()
	{
		this.m.IsInTrance = false;
	}


	function doTranceEndTurn() {} //Put trances that toggle end of turn here
	function doTranceStartTurn() {} //Put trances that toggle start of turn here
	function removeAll() {} //If your trance adds a skill in swapOn() you can override this to remove em all

	function onTurnEnd()
	{
		if (this.m.IsInTrance)
		{
			this.doTranceEndTurn();
		}
	}
	
	function onTurnStart()
	{
		if (this.m.IsInTrance)
		{
			this.doTranceStartTurn();
			this.getContainer().getActor().setActionPoints(0);
		}
	}

	function onUse( _user, _targetTile )
	{
		if (this.m.IsInTrance)
		{
			this.swapOff();
		}
		else
		{
			this.swapOn();
		}
		this.m.IsInTrance = !this.m.IsInTrance;
		return true;
	}

	function onUpdate( _properties )
	{
		if (_properties.IsStunned)
		{
			if (this.m.IsInTrance)
			{
				this.swapOff();
				this.removeAll();
			}
		}
	}

	function swapOn()
	{
		this.m.Description = this.m.ToggleOffDescription;
		this.getContainer().getActor().setActionPoints(0);
		this.m.FatigueCost = 0;
		this.m.ActionPointCost = 0;
	}

	function swapOff()
	{
		this.m.Description = this.m.ToggleOnDescription;
		this.m.FatigueCost = this.m.BaseFatigueCost;
		this.m.ActionPointCost = this.m.BaseAPCost;	
		this.removeAll();
	}

});