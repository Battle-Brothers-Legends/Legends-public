this.legend_field_treats_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendFieldTreats);
		this.m.Description = "Restore confidence through liberal application of alcohol and food, taking someone from wavering to steady for 20 food.";
		this.m.Icon = "skills/drink_square.png";
		this.m.IconDisabled = "skills/drink_square_bw.png";
		this.m.Overlay = "active_41";
		this.m.SoundOnUse = [
			"sounds/combat/drink_01.wav",
			"sounds/combat/drink_02.wav",
			"sounds/combat/drink_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsUsingHitchance = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 16;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip( )
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = "You have [color=%positive%]" + this.World.Assets.getFood() + "[/color] food."
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = "Spend [color=%negative%]-20[/color] food to raise moral state of adjacent ally from wavering to steady."
		});
		return ret;
	}

	function isUsable()
	{
		return skill.isUsable() && ::World.Assets.getFood() >= 20;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
			return false;

		local target = _targetTile.getEntity();
		return getContainer().getActor().isAlliedWith(target) && target.getMoraleState() < ::Const.MoraleState.Steady;
	}

	function onUse( _user, _targetTile )
	{
		local food = ::World.Assets.getFoodItems();
		_targetTile.getEntity().checkMorale(::Const.MoraleState.Steady - _targetTile.getEntity().getMoraleState(), 9000, ::Const.MoraleCheckType.Default, "status_effect_56");

		for( local i = 0; i < 2; ++i )
		{
			local idx = ::Math.rand(0, food.len() - 1);
			this.World.Assets.getStash().remove(food.remove(idx));
		}

		::World.Assets.updateFood();
		return true;
	}

});
