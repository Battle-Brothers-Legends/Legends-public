::mods_hookExactClass("entity/world/settlements/stronghold_player_base", function (o) {
	// Legends puts "legend_" in front of the sprite name of every settlement, also Stronghold never set a base sprite for ports and shit
	o.getSpriteName <- function () {
		return this.m.Sprite;
	}

	local updateLook = o.updateLook;
	o.updateLook = function () {
		updateLook();
		local sprites = ::Stronghold.VisualsMap[this.m.Spriteset];
		this.m.UISprite = "ui/settlement_sprites/" + sprites.Base[this.getSize() - 1][0] + ".png";
	}
});
