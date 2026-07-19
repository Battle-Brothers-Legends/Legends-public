::mods_hookBaseClass("arena/arena", function(o) {
	o.getFightsPerDay = @() ::World.Assets.m.IsArenaTooled ? 3 : 1;
});
