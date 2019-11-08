this.legend_danger_pay <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_danger_pay";
		this.m.Name = "Danger Pay";
		this.m.Description = "Pay 10 times their daily wage to set a unit to Confident morale";
		this.m.Icon = "skills/coins_square.png";
		this.m.IconDisabled = "skills/coins_square_bw.png";
		this.m.Overlay = "active_41";
		this.m.SoundOnUse = [
			"sounds/coins_01.wav",
			"sounds/coins_02.wav",
			"sounds/coins_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 4;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 4;
	}


		function getTooltip( )
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.MaxRange + "[/color], can only target humans or goblins."
			}
		]);
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = "You have[color=" + this.Const.UI.Color.PositiveValue +"]" + this.World.Assets.getMoney() + "[/color] crowns"
			});

		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();
		local wage = target.getBaseProperties().DailyWage;
		local money = this.World.Assets.getMoney();
		if (!target.getTags().has("human"))
		{
			return false;
		}

		if (money < wage )
		{
			return false;
		}

		return true;
	}
	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local wage = target.getBaseProperties().DailyWage;
		local cost = wage * -10;
		this.World.Assets.addMoney(cost);
		target.setMoraleState(this.Const.MoraleState.Confident);
		return true;
	}

});
