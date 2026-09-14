this.legend_skinghoul_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSkinghoulPotion);
		this.m.Icon = "skills/status_effect_149.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_149";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "This character\'s body has mutated to regrow skin and muscle tissue much more quickly than normal. Deep injuries heal much faster than normal as a result. They also seem to have developed a strong taste for red meat, but that\'s probably unrelated.";
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
				icon = "ui/icons/days_wounded.png",
				text = "Lowers the threshold to inflict injuries by [color=" + this.Const.UI.Color.NegativeValue + "]40%[/color] for both melee and ranged attacks"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		];
		return ret;
	}
	
	function onUpdate( _properties )
	{
		_properties.ThresholdToInflictInjuryMult *= 0.6;
	}	

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isSkinghoulPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isSkinghoulPotionAcquired", false);
	}

});

