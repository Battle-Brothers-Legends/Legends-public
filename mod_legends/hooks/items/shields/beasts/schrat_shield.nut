::mods_hookExactClass("items/shields/beasts/schrat_shield", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "The hardened bark from a schrat";
	}

	// o.updateVariant = function ()
	// {
	// 	this.m.Sprite = "bust_schrat_shield_0" + this.m.Variant;
	// 	this.m.SpriteDamaged = "bust_schrat_shield_0" + this.m.Variant + "_damaged";

	// 	These need to be set only if it's a player that obtained this shield, i.e. through transformation. Currently transformation is removed so this is unneeded (Should maybe be set in create() if its a player anyways?
	// 	this.m.ShieldDecal = "shield_heartwood_destroyed";
	// 	this.m.IconLarge = "shields/inventory_heartwood_shield.png";
	// 	this.m.Icon = "shields/icon_heartwood_shield.png";
	// }
});
