this.legend_constrained_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},
	
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendConstrained);
		this.m.Icon = "skills/status_effect_78.png";
		this.m.Overlay = "status_effect_78";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}
	
	function getDescription()
	{
		return "This character is Constrained and has trouble moving! Will wear off in [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] turn(s), unless refreshed.";
	}

	function getTooltip()
	{	
		local tooltip = [
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
				id = 3,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Builds up [color=" + this.Const.UI.Color.NegativeValue + "]5[/color] more Fatigue for each tile travelled"
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]2[/color] Additional Action Point per tile moved"
			}
		];
		return tooltip;
	}
	
	function onUpdate( _properties )
	{	
		_properties.MovementFatigueCostAdditional += 5;
		_properties.MovementAPCostAdditional += 2;
	}
	
	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
			this.removeSelf();
	}
});

