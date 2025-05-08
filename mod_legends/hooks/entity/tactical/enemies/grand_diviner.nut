::mods_hookExactClass("entity/tactical/enemies/grand_diviner", function(o) {
	o.getLootForTile <- function (_killer, _loot) {
		local loot = this.human.getLootForTile(_killer, _loot);
		local newLoot = [];
		foreach(item in loot) {
			if (item.getID() == "weapon.miasma_flail")
				continue;
			newLoot.push(item);
		}
		return newLoot;
	}
});
