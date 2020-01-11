this.legend_rations_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 10,
		Amount = 0
	},

	function setAmount( _a )
	{
	this.m.Amount = _a;
	}

	function create()
	{
		this.m.ID = "effects.legend_rations_effect";
		this.m.Name = "Satiated";
		this.m.Icon = "skills/status_effect_61.png";
		this.m.IconMini = "status_effect_61_mini";
		this.m.Overlay = "status_effect_61";
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DrugEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "Thanks to eating food, this character regains Health and loses Fatigue for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] turn(s). ";
	}

	function getTooltip()
	{
		local rate = this.Math.floor(this.m.Amount / 10);
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "] +" + rate + "[/color] Healing per turn"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "] -" + rate + "[/color] Fatigue Recovery per turn"
			}
		];
		return ret;
	}


	function onUpdate( _properties )
	{
		local rate = this.Math.floor(this.m.Amount / 10);
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + rate));
		_properties.FatigueRecoveryRate -= rate;
	}

	function onAdded()
	{
		this.m.TurnsLeft = 10;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

