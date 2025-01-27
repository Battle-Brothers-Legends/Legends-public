::mods_hookExactClass("ai/tactical/behaviors/ai_defend_knock_back", function ( o )
{
	o.m.PossibleSkills.extend([
		"actives.legend_revolt",
		"actives.legend_push"
	]);
});
