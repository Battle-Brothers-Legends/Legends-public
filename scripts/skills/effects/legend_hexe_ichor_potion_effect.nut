this.legend_hexe_ichor_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 8
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendHexeIchorPotion);
		this.m.Icon = "skills/ichor_potion_circle.png";
		this.m.IconMini = "status_effect_89_mini";
		this.m.Overlay = "status_effect_89";
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DrugEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "Thanks to taking a concoction of dubious ingredients, this character feels a second wind for another [color=%negative%]" + this.m.TurnsLeft + "[/color] turn(s).";
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
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%positive%]+20[/color] Fatigue Recovery per turn"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "[color=%positive%]+20[/color] Health Recovery per turn"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRate += 20;
		_properties.HitpointsRecoveryRate += 20;
	}

	function onAdded()
	{
		this.m.TurnsLeft = 4;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

