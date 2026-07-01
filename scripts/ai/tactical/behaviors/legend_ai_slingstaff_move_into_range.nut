this.legend_ai_slingstaff_move_into_range <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			::Legends.Actives.getID(::Legends.Active.LegendSlingstaffBash),
			::Legends.Actives.getID(::Legends.Active.LegendSlingHeavyStone)
		],
		Slingstaffs = [
			"weapon.staff_sling",
			"weapon.nomad_sling",
			"weapon.legend_named_northern_sling",
			"weapon.legend_named_nomad_sling",
			"weapon.legend_northern_sling"
		]
	},

	function create() {
		this.m.ID = this.Const.AI.Behavior.ID.SlingstaffMoveIntoRange;
		this.m.Order = this.Const.AI.Behavior.Order.SlingstaffMoveIntoRange;
		this.behavior.create();
	}

	function onEvaluate(_entity) {
		this.m.TargetTile = null;
		local weapon = _entity.getMainhandItem();

		if (weapon == null || this.m.Slingstaffs.find(weapon.getID()) == null) {
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP || _entity.getMoraleState() == this.Const.MoraleState.Fleeing) {
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (::Legends.S.isEntityMovementDisabled(_entity)) {
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasKnownOpponent()) {
			return this.Const.AI.Behavior.Score.Zero;
		}

		local myTile = _entity.getTile();
		local bestTargetTile = null;

		foreach (t in this.getAgent().getKnownOpponents()) {
			if (::Legends.S.isEntityNullOrDead(t.Actor)) {
				continue;
			}
			local targetTile = t.Actor.getTile();

			/*local dist = myTile.getDistanceTo(targetTile);

            foreach (skillID in this.m.PossibleSkills) {
                local skill = _entity.getSkills().getSkillByID(skillID);
                if (skill != null && skill.isUsable() && dist >= skill.getMinRange() && dist <= skill.getMaxRange() && skill.onVerifyTarget(myTile, targetTile)) {
                    return this.Const.AI.Behavior.Score.Zero;
                }
            }*/

			if (myTile.getDistanceTo(targetTile) == 3 && targetTile.IsVisibleForEntity) {
				bestTargetTile = targetTile;
				break;
			}
		}

		if (bestTargetTile == null) {
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = this.findBestTile(_entity, bestTargetTile);

		if (this.m.TargetTile == null) {
			return this.Const.AI.Behavior.Score.Zero;
		}
		return this.Const.AI.Behavior.Score.SlingstaffMoveIntoRange;
	}

	function onExecute(_entity) {
		local navigator = this.Tactical.getNavigator();
		if (this.m.IsFirstExecuted) {
			local settings = navigator.createSettings();
			settings.ActionPointCosts = _entity.getActionPointCosts();
			settings.FatigueCosts = _entity.getFatigueCosts();
			settings.FatigueCostFactor = 0.0;
			settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
			settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
			settings.AllowZoneOfControlPassing = false;
			settings.ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
			settings.AlliedFactions = _entity.getAlliedFactions();
			settings.Faction = _entity.getFaction();
			navigator.findPath(_entity.getTile(), this.m.TargetTile, settings, 0);

			if (this.Const.AI.PathfindingDebugMode) {
				navigator.buildVisualisation(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
			}

			local movement = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
			this.m.Agent.adjustCameraToDestination(movement.End);

			if (this.Const.AI.VerboseMode) {
				this.logInfo("* " + _entity.getName() + ": Going for slingstaff attack position.");
			}

			this.m.IsFirstExecuted = false;
			return false;
		}

		if (!navigator.travel(_entity, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue())) {
			this.m.TargetTile = null;
			return true;
		}

		return false;
	}

	function findBestTile(_entity, _targetTile) {
		local actorTile = _entity.getTile();
		local bestTile = null;
		local allies = _entity.getAlliedFactions();
		local properties = _entity.getCurrentProperties();

		for (local i = 0; i < 6; i = ++i) {
			if (!actorTile.hasNextTile(i)) {
				continue;
			}
			local nextTile = actorTile.getNextTile(i);

			if (!nextTile.IsEmpty || this.Math.abs(nextTile.Level - actorTile.Level) > 1) {
				continue;
			}

			local apCost = _entity.getActionPointCosts()[nextTile.Type] * properties.MovementAPCostMult;
			local fatCost = _entity.getFatigueCosts()[nextTile.Type] * properties.MovementFatigueCostMult * properties.FatigueEffectMult;
			if (this.Math.abs(nextTile.Level - actorTile.Level) == 1) {
				apCost += _entity.getLevelActionPointCost();
				fatCost += _entity.getLevelFatigueCost();
			}
			
        	if (apCost > _entity.getActionPoints() || fatCost > _entity.getFatigueMax() - _entity.getFatigue()) {
            		continue;
        	}

			if (nextTile.getZoneOfControlCountOtherThan(allies) > 0) {
            	continue;
        	}

			local dist = nextTile.getDistanceTo(_targetTile);
			if (dist == 4) {
				return nextTile;
			}
			if (dist == 2) {
				bestTile = nextTile;
			}
		}
		return bestTile;
	}
});
