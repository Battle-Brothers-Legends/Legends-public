::mods_hookExactClass("events/events/dogs_dig_up_loot_event", function(o) {
	o.onPrepare = function () {
		local item;
		local r = ::Math.rand(1, 2);

		if (r == 1) {
			item = ::Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.thick_dark_tunic],
				[1, ::Legends.Armor.Standard.noble_tunic],
				[1, ::Legends.Armor.Standard.ragged_surcoat],
				[1, ::Legends.Armor.Standard.thick_tunic],
				[1, ::Legends.Armor.Standard.wizard_robe],
			]);
		} else {
			item = ::Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.aketon_cap],
				[1, ::Legends.Helmet.Standard.cultist_hood],
				[1, ::Legends.Helmet.Standard.hood],
				[1, ::Legends.Helmet.Standard.full_leather_cap],
			]);
		}

		item.setCondition(::Math.max(1, item.getConditionMax() * ::Math.rand(10, 40) * 0.01));
		this.m.FoundItem = item;
	}

})
