this.legend_irritable_effect <- this.inherit("scripts/skills/skill", {
	m = {
		HealingTime = 1
	},

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendIrritable);
		this.m.Description = "Repeated attempts to study have made this character more than irritable. The negative effects will disappear by the next day, but this effect is not treatable and prevents the character from reading books and scrolls.";
		this.m.Icon = "skills/status_effect_62.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = false;
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
				id = 6,
				type = "hint",
				icon = "ui/icons/days_wounded.png",
				text = "Will recover in " + this.m.HealingTime + " days"
			}
		];

		return ret;
	}

	function onUpdate(_properties)
	{
		if (this.m.HealingTime == 0)
			this.removeSelf();
	}

	function onNewDay()
	{
		this.m.HealingTime -= 1;
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeU32(this.m.HealingTime);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.HealingTime = _in.readU32();
	}
});

