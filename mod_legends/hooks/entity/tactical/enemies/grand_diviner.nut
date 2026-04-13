::mods_hookExactClass("entity/tactical/enemies/grand_diviner", function(o) {

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
			::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendPerfectFit);
			::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendDoubleStrike);
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
