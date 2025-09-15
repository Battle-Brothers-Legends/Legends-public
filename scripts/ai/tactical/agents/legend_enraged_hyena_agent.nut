this.legend_enraged_hyena_agent <- this.inherit("scripts/ai/tactical/agents/hyena_agent", {
	m = {
	},

	function create() {
		this.hyena_agent.create();
		this.m.ID = ::Const.AI.Agent.ID.LegendEnragedHyena;
	}

	function onAddBehaviors() {
		this.hyena_agent.onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_charge"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_disengage"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_rotation"));

		// Needs Charge to properly position, and EngageMelee to consider using bite
		this.addBite(this.Const.AI.Behavior.ID.EngageMelee);
		this.addBite(this.Const.AI.Behavior.ID.Charge);
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

		if (found) {
			// TODO: Not sure that's the best way to do it
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Charge] = 1.25;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 1.25;
		}

		// TODO: should prioritize disengaging then biting if it doesn't have a bite victim
	}

});
