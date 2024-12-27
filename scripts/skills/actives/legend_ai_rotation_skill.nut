this.legend_ai_rotation_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_ai_rotation"; //for ai only
		this.m.Name = "Rotation";
		this.m.Description = "For ai use only, if you can see this something has gone wrong.";
		this.m.Icon = "ui/perks/perk_11_active.png";
		this.m.IconDisabled = "ui/perks/perk_11_active_sw.png";
		this.m.Overlay = "perk_11_active";
		this.m.SoundOnUse = [
			"sounds/combat/rotation_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local value = this.Math.round(this.Math.minf(0.5, this.getContainer().getActor().getCurrentProperties().Bravery * 0.005) * 100);
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
		

		// if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		// {
		// 	ret.push({
		// 		id = 9,
		// 		type = "text",
		// 		icon = "ui/tooltips/warning.png",
		// 		text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used while rooted[/color]"
		// 	});
		// }

		// return ret;
	}

	// function getCursorForTile( _tile )
	// {
	// 	return this.Const.UI.Cursor.Rotation;
	// }

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsFleetfooted ? 0.5 : 1.0;

		// if (this.getContainer().getActor().getSkills().hasSkill("effects.goblin_grunt_potion"))
		// {
		// 	this.m.ActionPointCost = 2;
		// }
	}

	function isUsable()
	{	
		return this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (!target.isAlive() && ::MSU.isNull(target))
			return false;

		if (!target.isAlliedWith(this.getContainer().getActor()) && !this.getContainer().hasSkill("perk.legend_twirl"))
			return false;

		return this.skill.onVerifyTarget(_originTile, _targetTile) && !target.getCurrentProperties().IsStunned && !target.getCurrentProperties().IsRooted && target.getCurrentProperties().IsMovable && !target.getCurrentProperties().IsImmuneToRotation;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.Tactical.getNavigator().switchEntities(_user, target, null, null, 1.0);
		return true;
	}

});

