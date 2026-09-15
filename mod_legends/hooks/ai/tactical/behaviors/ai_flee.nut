::mods_hookExactClass("ai/tactical/behaviors/ai_flee", function (o) {
	o.onExecute = function (_entity) {
		if (::Legends.S.isEntityNullOrDead(_entity)) {
			this.getAgent().setFinished(true);
			return true;
		}
		if (this.m.TargetTile != null) {
			local navigator = ::Tactical.getNavigator();

			if (this.m.IsFirstExecuted) {
				this.getAgent().getOrders().IsRetreating = true;
				local settings = navigator.createSettings();
				settings.ActionPointCosts = _entity.getActionPointCosts();
				settings.FatigueCosts = _entity.getFatigueCosts();
				settings.FatigueCostFactor = ::Const.Movement.FatigueCostFactor;
				settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
				settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
				settings.AllowZoneOfControlPassing = true;
				settings.ZoneOfControlCost = ::Const.AI.Behavior.ZoneOfControlAPPenalty * 2;
				settings.AlliedFactions = _entity.getAlliedFactions();
				settings.Faction = _entity.getFaction();

				if (::Const.AI.VerboseMode) {
					this.logInfo("* " + this.getAgent().getActor().getName() + ": Fleeing.");
				}

				navigator.findPath(_entity.getTile(), this.m.TargetTile, settings, 0);

				if (::Const.AI.PathfindingDebugMode) {
					navigator.buildVisualisation(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
				}

				local movement = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
				this.m.Agent.adjustCameraToDestination(movement.End);

				if (::Tactical.State.getStrategicProperties() != null
					&& ::Tactical.State.getStrategicProperties().IsArenaMode)
				{
					::Sound.play(::Const.Sound.ArenaFlee[::Math.rand(0, ::Const.Sound.ArenaFlee.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
				}

				this.m.IsFirstExecuted = false;
			}

			if (!navigator.travel(_entity, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue())) {
				if (_entity.isAlive() && !_entity.isNull()) {
					if (_entity.isPlayerControlled()) {
						_entity.setDirty(true);
					}

					if (!_entity.isHiddenToPlayer()) {
						this.getAgent().declareAction();
					}
				}

				this.m.TargetTile = null;
				return true;
			} else {
				return false;
			}
		}

		this.getAgent().setFinished(true);
		return true;
	}
});
