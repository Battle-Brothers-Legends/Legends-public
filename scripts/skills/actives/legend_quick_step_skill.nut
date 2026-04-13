this.legend_quick_step_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendQuickStep);
		this.m.Description = "Exert yourself to move one tile at an unusually quick speed. Can only be used once per turn while outside of zone of control.";
		this.m.Icon = "skills/unarmed_lunge_square.png";
		this.m.IconDisabled = "skills/unarmed_lunge_square_bw.png";
		this.m.Overlay = "perk_25_active";
		this.m.SoundOnUse = [
			"sounds/combat/footwork_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDisengagement = true;
		this.m.ActionPointCost = 1;
		this.m.FatigueCost = 7;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
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

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can only be used when outside an opponent\'s Zone of Control[/color]"
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used while rooted[/color]"
			});
		}

		if (this.m.IsSpent == true)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can only be used once per turn[/color]"
			});
		}
		return ret;
	}

	function isUsable()
	{
		if (this.skill.isUsable() && !this.m.IsSpent &&  !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && !this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	function onAfterUpdate( _properties )
	{
		// if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendBackflip))
		// {
		// 	this.m.MaxRange = 2;
		// }

		// this.m.FatigueCostMult = _properties.IsFleetfooted ? 0.5 : 1.0;

		// if (this.getContainer().getActor().getSkills().hasEffect(::Legends.Effect.GoblinGruntPotion))
		// {
		// 	this.m.ActionPointCost = 2;
		// }
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (!_targetTile.IsEmpty)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.IsSpent = true;
		this.Tactical.getNavigator().teleport(_user, _targetTile, null, null, false);
		return true;
	}

});

