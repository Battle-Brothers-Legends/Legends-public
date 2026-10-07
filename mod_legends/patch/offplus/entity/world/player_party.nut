// Goofy stuff, Legends uses 100+ for its sprites (but not in the files themselves!!!), as does OFF+
::mods_hookExactClass("entity/world/player_party", function(pp) {
	local setBaseImage = ::mods_getMember(pp, "setBaseImage");

	::mods_override(pp, "setBaseImage", function(_version = -1) {
		switch(_version) {
			case 203:
				getSprite("body").setBrush("figure_player_103");
				break;
			case 204:
				getSprite("body").setBrush("figure_player_104");
				break;
			default:
				setBaseImage(_version);
		}
	});
});