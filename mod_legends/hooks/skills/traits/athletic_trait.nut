::mods_hookExactClass("skills/traits/athletic_trait", function(o)
{
	o.m.HasMoved <- false;

	o.onUpdate = function ( _properties )
	{
		local actor = this.getContainer().getActor();				
		if (this.m.HasMoved == false && this.getContainer().getActor().m.IsMoving)
		{
			this.m.HasMoved = true;
			local myTile = actor.getTile();			
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + this.Math.max(0, actor.getActionPointCosts()[myTile.Type] * _properties.MovementAPCostMult)));
			actor.setFatigue(this.Math.max(0, actor.getFatigue() - this.Math.max(0, actor.getFatigueCosts()[myTile.Type] * _properties.MovementFatigueCostMult)));			
		}		
	
	}
		
	o.onTurnStart <- function ()
	{
		this.m.HasMoved = false;		
	}
	
	o.onAdded <- function ()
	{
		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
			this.m.HasMoved = false;
		}
	}

	o.onCombatStarted <- function ()
	{
		this.m.HasMoved = false;		
	}

	o.onCombatFinished <- function ()
	{
		this.skill.onCombatFinished();
		this.m.HasMoved = false;	
	}

	o.getTooltip = function ()
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
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The first move each turn costs no Fatigue or Action Points"
			}
		];
	}
});
