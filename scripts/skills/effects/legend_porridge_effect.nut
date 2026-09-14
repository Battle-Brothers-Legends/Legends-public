this.legend_porridge_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 15,
		Amount = 100
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPorridgeEffect);
		this.m.Icon = "skills/status_effect_61.png";
		this.m.IconMini = "status_effect_61_mini";
		this.m.Overlay = "status_effect_61";
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DrugEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function setAmount( _a )
	{
		this.m.Amount = _a;
	}

	function addAmount ( _a)
	{
		//Subtract how much we've ate.
		this.m.Amount = this.Math.max(0, this.m.Amount - (15 - this.m.TurnsLeft)) + _a;
	}

	function getTurnsLeft()
	{
		return this.m.TurnsLeft;
	}

	function resetTurns()
	{
		this.m.TurnsLeft = 15;
	}

	function getAmount()
	{
		return this.m.Amount;
	}

	function getDescription()
	{
		return "Thanks to eating a hearty porridge, this character regains health for [color=%negative%]" + this.m.TurnsLeft + "[/color] turn(s).";
	}

	function getTooltip()
	{
		local rate = this.Math.floor(this.m.Amount / 10);
		local turns = this.m.TurnsLeft;
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
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Heals [color=%positive%]+" + rate + "[/color] Hitpoints per turn for " + turns + " turns "
			}
		];
		return ret;
	}


	function onAdded()
	{
		this.m.TurnsLeft = 15;
	}

	function onTurnEnd()
	{
		local rate = this.Math.floor(this.m.Amount / 10);
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + rate));
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

