::mods_hookExactClass("entity/tactical/enemies/grand_diviner", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.OnDeathLootTable.extend([
			[100, function () { return ::Const.World.Common.pickArmor([[1, "grand_diviner_robes"]]) }],
//			[100, function () { return ::Const.World.Common.pickHelmet([[1, "grand_diviner_headdress"]]) }]
		]);
		local rolls = ::Legends.S.extraLootChance(2);
		for(local i = 0; i < rolls; i++) {
			this.m.OnDeathLootTable.push([100, "scripts/items/loot/marble_bust_item"]);
		}
	}

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
