this.legend_steps_guided <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendStepsGuided);
		this.m.Description = "A talented ranger has granted this character the skills of a pathfinder.";
		this.m.Icon = "ui/perks/guided_steps_circle.png";
		this.m.IconMini = "mini_guided_steps_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}



	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.PathfinderMovementAPCost;
		actor.m.FatigueCosts = clone this.Const.PathfinderMovementFatigueCost;
		actor.m.LevelActionPointCost = 0;
	}

});
