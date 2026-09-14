this.legend_mummy_curse_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 1
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendMummyCurse);
		this.m.Description = "This character has been cursed by the death of a mummy.";
		this.m.Icon = "skills/icon_mummy_curse.png";
		this.m.IconMini = "mini_icon_mummy_curse";
		this.m.Overlay = "mummy_curse";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getName()
	{
		return this.m.Stacks > 1 ? this.m.Name + " (x" + this.m.Stacks + ")" : this.m.Name;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Receive [color=%negative%]+" + this.getBonus() + "[/color] damage from any source"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Enemies are more likely to target this character"
			}
		]);

		return tooltip;
	}

	function getBonus()
	{
		return 25 * this.m.Stacks;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus() * 0.01;
		_properties.DamageReceivedTotalMult *= 1.0 + bonus;
		_properties.TargetAttractionMult *= 1.0 + bonus;
	}

	function onRefresh()
	{
		this.m.Stacks++;
		this.spawnIcon("mummy_curse", this.getContainer().getActor().getTile());
	}
});

