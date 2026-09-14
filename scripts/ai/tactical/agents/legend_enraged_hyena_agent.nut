this.legend_enraged_hyena_agent <- this.inherit("scripts/ai/tactical/agents/hyena_agent", {
	m = {
	},

	function create() {
		this.hyena_agent.create();
		this.m.ID = ::Const.AI.Agent.ID.LegendEnragedHyena;
		// Try to help force ranged position for bite
		this.m.Properties.EngageRangeMin = 2;
		this.m.Properties.EngageRangeMax = 3;
		this.m.Properties.EngageRangeIdeal = 3;
		//
		this.m.Properties.TargetPriorityDamageMult = 0.20; // (base = 0.0)
		// Reduce flanking behavior (base = 4.0)
		this.m.Properties.EngageFlankingMult = 1.0;
		// Prefer engaging with bite
		this.m.Properties.EngageLockDownTargetMult = 0.0;
		// this.m.Properties.TargetPriorityFinishOpponentMult = 4.0; // (base = 3.0)
		// this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.5; // (base = 0.5)
	}

	function onAddBehaviors() {
		this.hyena_agent.onAddBehaviors();
		// this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_disengage"));
		// this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_rotation"));

		this.addBite(this.Const.AI.Behavior.ID.EngageMelee);
		this.addBite(this.Const.AI.Behavior.ID.AttackDefault);
	}

	function addBite(_behaviorID) {
		local behavior = this.getBehavior(_behaviorID);
		if (behavior == null) {
			::logError("legend_enraged_hyena_agent: could not find behavior with ID " + _behaviorID);
		} else {
			// ::logDebug("legend_enraged_hyena_agent: adding bite to behavior " + _behaviorID);
			behavior.m.PossibleSkills.push(::Legends.Actives.getID(::Legends.Active.LegendEnragedHyenaBite));
		}
	}

	function onUpdate() {
		local actor = this.getActor();
		local tile = actor != null ? actor.getTile() : null;
		local preferBite = false;
		// Prefer ranged bite positioning only if we can actually bite someone
		if (actor != null && tile != null && !actor.getFlags().has("LegendEnragedHyenaBiteVictim")) {
			local bite = ::Legends.Actives.get(actor, ::Legends.Active.LegendEnragedHyenaBite);
			if (bite != null && bite.isUsable()) {
				foreach (t in this.getKnownOpponents()) {
					if (t.Actor.isNull()) {
						continue;
					}
					local targetTile = t.Actor.getTile();
					if (targetTile == null) {
						continue;
					}
					if (bite.onVerifyTarget(tile, targetTile)) {
						preferBite = true;
						break;
					}
				}
			}
		}

		if (preferBite) {
			// Encourage standing at 2-3 tiles to set up a bite
			this.m.Properties.EngageRangeMin = 2;
			this.m.Properties.EngageRangeMax = 3;
			this.m.Properties.EngageRangeIdeal = 3;
		} else {
			// Default to standard melee range so Idle doesn't win
			this.m.Properties.EngageRangeMin = 1;
			this.m.Properties.EngageRangeMax = 1;
			this.m.Properties.EngageRangeIdeal = 1;
		}

		this.hyena_agent.onUpdate();

		if (actor.getFlags().has("LegendEnragedHyenaBiteVictim")) {
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.AttackDefault] = 5.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.5;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Roam] = 0.5;
		} else {
			// // TODO Should prioritize engaging targets that are already bitten by other hyenas
			// local tile = this.getActor().getTile();
			// local bite = ::Legends.Actives.get(this.getActor(), ::Legends.Active.LegendEnragedHyenaBite);
			// if (bite == null || !bite.isUsable()) {
			// 	return;
			// }
			// foreach (t in this.getKnownOpponents()) {
			// 	if (t.Actor.isNull()) {
			// 		continue;
			// 	}
			// 	local targetTile = t.Actor.getTile();
			// 	if (bite.onVerifyTarget(tile, targetTile)) {
			// 		break;
			// 	}
			// }

			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.AttackDefault] = 1.25;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Roam] = 1.0;
		}

	}


});
