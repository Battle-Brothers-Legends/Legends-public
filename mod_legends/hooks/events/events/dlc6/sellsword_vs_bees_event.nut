::mods_hookExactClass("events/events/dlc6/sellsword_vs_bees_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Good") {
				s.Text = "%terrainImage%{%chosen% confidently walks up toward the tree and the bees seem shunted away by %their_chosen% very presence. The noise of their fluttering thickens with angry vibrations, but otherwise they take no further offense. %They_chosen% carefully scoops some of the honey into a jar and then eases back and steps away. %They_chosen% returns to the company.%SPEECH_ON%Easy peasy beehive squeezy, lads.%SPEECH_OFF%}";
			}
			if (s.ID == "Fail") {
				s.Text = "%terrainImage%{%chosen% laces %their_chosen% fingers and cracks the knuckles with a long stretch.%SPEECH_ON%Like stealing candy from a baby.%SPEECH_OFF%%They_chosen% walks up to the tree and stands beneath the hive. %They_chosen% poses and points up at it, laughs, then turns %their_chosen% hands up and - much to the shock of everyone - just grabs the entire beehive. The bees instantly swarm the sellsword and %they_chosen% drops the hive and sprints away, a cloud of angry buzzing chasing %them_chosen% down a sand dune. %They_chosen% rolls and rolls, %their_chosen% screams issuing out whenever %they_chosen% flies out of the sand, and then %they_chosen% lands at the bottom and a wash of sand covers %them_chosen% and spares %them_chosen% from further bee stings. You wait a while before retrieving %them_chosen%, lest the bees know your hand in this attempted thievery.}";
			}
			if (s.ID == "Wildman") {
				s.Text = "%terrainImage%{You\'re sure %wildman% the Wildman has seen a hive or two in %their_wildman% time estranged to the forests. %They_wildman% grunts and points at the beehive and then at %themselves_wildman%. You nod. %They_wildman% grunts again and goes up the sand dune to the tree while you watch from a safe distance. When %they_wildman% stands beneath the hive, %they_wildman% hoots again, cupping %their_wildman% hand over %their_wildman% mouth to make sure you hear %them_wildman%. %They_wildman% points at the beehive. You nod again and point aggressively at the hive. It\'s the only beehive for miles, what could possibly be so confusing about this? \n\n The Wildman turns toward the beehive. %They_wildman% cocks an arm back. That... that is not what you wanted to see. %They_wildman% sizes up the beehive, tongue out, eyes slimmed. You rush forward, yelling at %them_wildman%, but %they_wildman%\'s already honed in. %They_wildman% launches a fist and absolutely obliterates the bees. Honeycombs stickily flail around %their_wildman% wrist as though %their_wildman% hairy arm were an impromptu maypole. The Wildman casually walks back down the sand dune. As %they_wildman% nears, you see bees crawling all over %their_wildman% face and stinging away like the pissed off savages that they are, but %they_wildman% doesn\'t seem to even sense their presence. %They_wildman% holds out the crunchy remains of %their_wildman% honeyed demolition as though %they_wildman% held the heart of a ferocious beast.}";
			}
		}
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars )
	{
		onPrepareVariables(_vars);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Dude.getGender(), "chosen");
		if (this.m.Wildman != null)
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Wildman.getGender(), "wildman");
	}
})
