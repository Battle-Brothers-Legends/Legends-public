this.legend_danger_pay_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Multiplier = 10,	// Daily Wage is multiplied by this to determine cost
		MinCost = 0,	// For Tooltip purposes
		MaxCost = 0,	// For Tooltip purposes
		MaximumMoraleState = this.Const.MoraleState.Confident
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDangerPay);
		this.m.Description = "Pay a unit " + this.m.Multiplier + "x their daily wage to set their morale to Confident and grants them the buff 'Motivated' for three turns. This skill cannot be used on brothers that don\'t have a daily wage.";
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
		this.m.IsAttack = false;
		this.m.IsUsingHitchance = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 4;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip( )
	{
		local ret = this.getDefaultUtilityTooltip();
		this.calculateMinMax();

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]" + this.m.MaxRange + "[/color]."
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = "This will cost between [color=%positive%]" + this.m.MinCost + "[/color] and [color=%positive%]" + this.m.MaxCost + "[/color]"
		});
		ret.push({
			id = 9,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = "You have currently have " + this.World.Assets.getMoney() + " crowns."
		});

		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) return false;

		local target = _targetTile.getEntity();

		if (this.getContainer().getActor().getFaction() != target.getFaction()) return false;
		if (!target.getFlags().has("human")) return false;
		if (("getDailyCost" in target) == false) return false;	// certain human "brothers" may not have dailyCost function and would otherwise crash this function
		if (this.getCrownCost(target) <= 0) return false;		// A Cost of 0 is not accepted to prevent abuse on PlayerCharacter or Indebted
		if (this.World.Assets.getMoney() < this.getCrownCost(target)) return false;
		if (target.getMoraleState() >= this.m.MaximumMoraleState && target.getSkills().hasEffect(::Legends.Effect.LegendMotivatedEffect)) return false;

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		::Legends.Effects.grant(target, ::Legends.Effect.LegendMotivatedEffect);
		target.setMoraleState(this.m.MaximumMoraleState);
		local crownCost = this.getCrownCost(target);
		this.World.Assets.addMoney(crownCost * -1);
		this.Tactical.EventLog.log_newline();
		this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_user) + " uses " + this.getName() + " on " + this.Const.UI.getColorizedEntityName(target) + " and paid " + crownCost + " Crowns for it.");
		return true;
	}

	function getCrownCost( _brother )
	{
		local wage = _brother.getDailyCost();
		wage *= this.m.Multiplier;
		return this.Math.floor(wage);
	}

	function calculateMinMax()
	{
		local roster = this.World.getPlayerRoster().getAll();
		this.m.MinCost = this.getCrownCost(::MSU.Table.randValue( roster ));
		this.m.MaxCost = this.m.MinCost;
		foreach( bro in roster )
		{
			local newCrownCost = this.getCrownCost(bro);
			if(newCrownCost == 0) continue;
			if(newCrownCost > this.m.MaxCost) this.m.MaxCost = newCrownCost;
			if(newCrownCost < this.m.MinCost || this.m.MinCost == 0) this.m.MinCost = newCrownCost;
		}
	}
});
