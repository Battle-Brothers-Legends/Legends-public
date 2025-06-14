this.legend_evasion_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendEvasion);
		this.m.Description = "%name% will move safely through any Zone of Control without incurring any free attacks and the first attack done against you will be automatically evaded. Can only be used if your total armor weight is 30 or less.";
		this.m.Icon = "skills/evasion.png";
		this.m.IconDisabled = "skills/evasion_bw.png";
		this.m.Overlay = "evasion";
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
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
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
	}

	function isHidden()
	{	
		if (this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]) > 30)
			return true;
		return false;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasEffect(::Legends.Effect.LegendEvasion);
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		if (!this.getContainer().hasEffect(::Legends.Effect.LegendEvasion))
		{
			::Legends.Effects.grant(this, ::Legends.Effect.LegendEvasion);
			return true;
		}

		return false;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onRemoved()
	{
		::Legends.Effects.remove(this, ::Legends.Effect.LegendEvasion);
	}

});
