this.legend_safeguarded_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSafeguarded);
		this.m.Description = "This character is being safeguarded.";
		this.m.Icon = "ui/perks/safegaurd_circle.png";//incorrect spelling but don't change I can't be arsed to mess with brush files
		this.m.IconMini = "mini_safegaurd_circle";//incorrect spelling but don't change I can't be arsed to mess with brush files
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Ranged Defense"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 15;
		_properties.RangedDefense += 15;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

});
