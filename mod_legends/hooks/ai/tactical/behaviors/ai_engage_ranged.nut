::mods_hookExactClass("ai/tactical/behaviors/ai_engage_ranged", function(o) 
{
	o.m.PossibleSkills.extend([
		"actives.legend_magic_missile",
		"actives.legend_catapult_boulder",
		"actives.legend_sling_heavy_stone",
		"actives.legend_shoot_dart"
	]);
});