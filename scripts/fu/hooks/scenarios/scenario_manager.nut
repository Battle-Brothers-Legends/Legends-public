::mods_hookNewObjectOnce("scenarios/scenario_manager", function(o) {
	foreach (scenario in o.m.Scenarios)
	{
		local onUpdateLevel = ::mods_getMember(scenario, "onUpdateLevel");
		scenario.onUpdateLevel <- function( _bro )
		{
			onUpdateLevel(_bro);
			_bro.getSkills().onUpdateLevel();
		}
	}
});
