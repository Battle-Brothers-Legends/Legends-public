::mods_hookExactClass("ai/tactical/agents/hexe_agent", function (o) {
	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function () {
		onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_wither"));
	}

	o.onRoundStarted = function() {
		this.agent.onRoundStarted();

		if (this.Time.getRound() == 1) {
			local allies = this.Tactical.Entities.getInstancesOfFaction(this.getActor().getFaction());

			foreach (a in allies) {
				if (a.getType() != this.Const.EntityType.Hexe && !a.isNonCombatant() && !a.getSkills().hasEffect(::Legends.Effect.FakeCharmed) && !a.getSkills().hasEffect(::Legends.Effect.Charmed) && !a.getSkills().hasEffect(::Legends.Effect.LegendIntenselyCharmed))	{
					::Legends.Effects.grant(a, ::Legends.Effect.FakeCharmed);
				}
			}
		}
	}
});
