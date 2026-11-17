::mods_hookExactClass("root_state", function (o) {
	local onInit = o.onInit;
	o.onInit = function () {
		onInit();
		// the combat speed that was last used, so a new session starts with it
		if (::Legends.Mod.PersistentData.hasFile("CombatSpeed")) {
			local speed = ::Legends.Mod.PersistentData.readFile("CombatSpeed");
			if ((typeof speed == "integer" || typeof speed == "float") && speed >= 1 && speed <= 4) {
				::Const.Tactical.Settings.AnimationSpeed = speed.tofloat();
			}
		}
	}
});
