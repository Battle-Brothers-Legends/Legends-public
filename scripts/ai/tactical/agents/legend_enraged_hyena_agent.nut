this.legend_enraged_hyena_agent <- this.inherit("scripts/ai/tactical/agents/hyena_agent", {
	m = {
	},

	function create() {
		this.hyena_agent.create();
		this.m.ID = ::Const.AI.Agent.ID.LegendEnragedHyena;
		// Try to help force ranged position for bite
		this.m.Properties.EngageRangeMin = 1;
		this.m.Properties.EngageRangeMax = 3;
		this.m.Properties.EngageRangeIdeal = 2;
		// Reduce flanking behavior (base = 4.0)
		this.m.Properties.EngageFlankingMult = 1.0;
		// this.m.Properties.EngageLockDownTargetMult = 3.0;
		// Make long detours less attractive
		// this.m.Properties.EngageHeatCostMult = 1.0;
	}

	function onAddBehaviors() {
		this.hyena_agent.onAddBehaviors();
		// this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_disengage"));
		// Seems thematic to have hyenas bite, retreat, let others close in, then bite again
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_rotation"));

		this.addBite(this.Const.AI.Behavior.ID.EngageMelee);
	}

	function addBite(_behaviorID) {
		local behavior = this.getBehavior(_behaviorID);
		if (behavior == null) {
			::logError("legend_enraged_hyena_agent: could not find behavior with ID " + _behaviorID);
		} else {
			behavior.m.PossibleSkills.push(::Legends.Actives.getID(::Legends.Active.LegendEnragedHyenaBite));
		}
	}

	function onUpdate() {
		this.hyena_agent.onUpdate();
		this.m.Properties.EngageRangeMin = 1;
		this.m.Properties.EngageRangeMax = 3;
		this.m.Properties.EngageRangeIdeal = 2;

		local actor = this.getActor();
		if (actor == null || !actor.isAlive()) {
			return;
		}

		local bite = ::Legends.Actives.get(actor, ::Legends.Active.LegendEnragedHyenaBite);
		if (bite == null || !bite.isUsable()) {
			return;
		}

		// TODO: Build score for bite targets
		local tile = actor.getTile();
		local found = false;
		foreach (t in this.getKnownOpponents()) {
			if (t.Actor.isNull()) {
				continue;
			}
			local targetTile = t.Actor.getTile();
			if (bite.onVerifyTarget(tile, targetTile)) {
				found = true;
				break;
			}
		}

		local mult = found ? 2.0 : 1.0;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.AttackDefault] = mult;

		// TODO: maybe should prioritize disengaging then biting if it doesn't have a bite victim?
	}

});
