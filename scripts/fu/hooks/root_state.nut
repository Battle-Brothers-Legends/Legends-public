::mods_hookExactClass("root_state", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		foreach (script in ::IO.enumerateFiles("scripts/ai/tactical/behaviors"))
		{
			try
			{
				::FU.AI.BehaviorIDToScriptMap[::new(script).getID()] <- script;
			}
			catch (error)
			{
				::logError("Could not instantiate or get ID of behavior: " + script);
			}
		}

		return onInit();
	}
});
