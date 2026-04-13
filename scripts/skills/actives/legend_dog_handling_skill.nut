this.legend_dog_handling_skill <- this.inherit("scripts/skills/skill", {
	m = {
	Food = 0
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDogHandling);
		this.m.Description = "Use food to convince an enemy dog to flee the battle.";
		this.m.Icon = "skills/skill_dog_handling.png";
		this.m.IconDisabled = "skills/skill_dog_handling_bw.png";
		this.m.Overlay = "dog_circle";
		this.m.SoundOnUse = [
			"sounds/cloth_01.wav"
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
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 0;
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
				text = "Has a range of [color=%positive%]" + this.m.MaxRange + "[/color], can only target dogs and hounds."
			}
		]);
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/asset_food.png",
				text = "This will cost a piece of food out of " + this.World.Assets.getFood() +" total"
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
		local xp = target.getXPValue();
		local food = this.World.Assets.getFood();
		this.m.Food = food;
		if (target.getType() != this.Const.EntityType.Wardog && target.getType() != this.Const.EntityType.Warhound)
		{
			return false;
		}

		if (food < 25 )
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local food = this.World.Assets.getFoodItems();

		for( local i = 0; i < 2; i = ++i )
		{
			local idx = this.Math.rand(0, food.len() - 1);
			local item = food[idx];
			this.World.Assets.getStash().remove(item);
			food.remove(idx);
		}

		this.World.Assets.updateFood();

		target.setMoraleState(this.Const.MoraleState.Fleeing);
		return true;
	}

});
