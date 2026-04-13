this.legend_parrying_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsFromItem = false // Workaround to be able to remove this effect if it was manually added by equipping legend_parrying_dagger
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendParrying);
		this.m.Description = "This character is prepared to parry any failed melee attacks against them, exposing their attacker to counterattacks.";
		this.m.Icon = "skills/en_garde_circle.png";
		this.m.IconMini = "mini_en_garde_circle";
		this.m.Overlay = "en_garde_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		return [
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
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflict [color=%negative%]Vulnerable[/color] ([color=%damage%]-10[/color] melee and ranged defense) on adjacent attackers who miss a melee attack with a weapon against this character. Enemies who are immune to being disarmed cannot be Parried"
			}
		];
	}


	function onUpdate( _properties )
	{
		_properties.IsParrying = true;
	}

});

