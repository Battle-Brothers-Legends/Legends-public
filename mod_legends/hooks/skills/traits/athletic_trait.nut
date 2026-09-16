::mods_hookExactClass("skills/traits/athletic_trait", function (o) {
	o.m.HasMoved <- false;

	o.onUpdate = function ( _properties )
	{
		/*local actor = this.getContainer().getActor();				
		if (this.m.HasMoved == false && this.getContainer().getActor().m.IsMoving)
		{
			this.m.HasMoved = true;
			local myTile = actor.getTile();			
			actor.setActionPoints(::Math.min(actor.getActionPointsMax(), actor.getActionPoints() + ::Math.max(0, actor.getActionPointCosts()[myTile.Type] * _properties.MovementAPCostMult)));
			actor.setFatigue(::Math.max(0, actor.getFatigue() - ::Math.max(0, actor.getFatigueCosts()[myTile.Type] * _properties.MovementFatigueCostMult)));			
		}*/		
	}
		
	o.onTurnStart <- function ()
	{
		this.m.HasMoved = false;		
	}

	o.onAdded <- function () {
		if (("State" in ::Tactical) && ::Tactical.State != null) {
			this.m.HasMoved = false;
		}
	}

	o.onCombatStarted <- function () {
		this.m.HasMoved = false;
	}

	o.onCombatFinished <- function () {
		this.skill.onCombatFinished();
		this.m.HasMoved = false;
	}

	o.getTooltip = function () {
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
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The first tile of movement each turn costs no Action Points and refunds used Fatigue (capped at your current Fatigue)"
			}
		];
	}
});
