this.legend_rock_unhold_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRockUnholdPotion);
		this.m.Icon = "skills/status_effect_145.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_145";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "This character\'s body has mutated to grow at an unnatural pace. In battle, this causes their wounds to close and heal within moments. Outside of battle, it causes unseemly growths, an unquenchable thirst, and disgustingly long finger nails. You once saw them lacerate both arms with a meat cleaver, screeching maniacally that it was \'the only way to keep it in check\'. Odd.";
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
				icon = "ui/icons/armor_body.png",
				text = "Head and Body armor is increased by [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color]"
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
		_properties.ArmorMult[this.Const.BodyPart.Head] *= 1.15;
		_properties.ArmorMult[this.Const.BodyPart.Body] *= 1.15;
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isRockUnholdPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isRockUnholdPotionAcquired", false);
	}

});

