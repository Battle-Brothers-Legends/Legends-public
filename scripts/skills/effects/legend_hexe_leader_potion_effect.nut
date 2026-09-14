this.legend_hexe_leader_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendHexeLeaderPotion);
		this.m.Icon = "skills/status_effect_148.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_148";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "There\'s something different about this character. Physically they seem unchanged, yet somehow a sense of dread precedes them. Any harm that they endure, on or off the battlefield, seems to affect another nearby. Useful in a fight, annoying in camp, and surely isolating in every day society.";
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
				icon = "ui/icons/bravery.png",
				text = "Re-roll every failed morale check for a second chance"
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
		_properties.RerollMoraleChance = 100;
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isHexeLeaderPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isHexeLeaderPotionAcquired", false);
	}

});

