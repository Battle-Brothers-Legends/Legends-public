this.legend_bribe_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cost = null,
		EntityName = null
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendBribe);
		this.m.Description = "Throw coins at an enemy to bribe them away from battle. Only works on humans, more powerful enemies cost more.";
		this.m.Icon = "skills/coins_square.png";
		this.m.IconDisabled = "skills/coins_square_bw.png";
		this.m.Overlay = "active_41";
		this.m.SoundOnUse = [
			"sounds/coins_01.wav",
			"sounds/coins_02.wav",
			"sounds/coins_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 4;
	}


	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]" + this.m.MaxRange + "[/color], can only target humans."
		});

		if (this.m.Cost != null)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = "Bribing " + this.m.EntityName + " will cost [color=%positive%]" + this.m.Cost + "[/color] crowns out of " + this.World.Assets.getMoney() + " total."
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = "The cost the XP that would be granted by killing the enemy, to the power of 1.3. Hover over an enemy while preparing this skill to update the tooltip."
			});
		}

		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();
		local xp = target.getXPValue();
		if (!target.getFlags().has("human"))
		{
			return false;
		}

		if (this.World.Assets.getMoney() < xp )
		{
			return false;
		}

		this.m.Cost = this.Math.floor(this.Math.pow(xp, 1.3));
		this.m.EntityName = target.getName();

		return true;
	}

	function onCombatFinished()
	{
		this.m.Cost = null;
		this.m.EntityName = null;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local xp = target.getXPValue();
		local cost = this.Math.floor(this.Math.pow(xp, 1.3) * -1);
		this.World.Assets.addMoney(cost);
		target.setMoraleState(this.Const.MoraleState.Fleeing);
		return true;
	}

});
