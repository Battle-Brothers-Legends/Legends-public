::mods_hookExactClass("events/events/dogs_dig_up_loot_event", function(o) {
	o.onPrepare = function () {
		local item;
		local r = this.Math.rand(1, 2);

		if (r == 1) {
			item = this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.thick_dark_tunic],
				[1, ::Legends.Armor.Standard.noble_tunic],
				[1, ::Legends.Armor.Standard.ragged_surcoat],
				[1, ::Legends.Armor.Standard.thick_tunic],
				[1, ::Legends.Armor.Standard.wizard_robe],
			]);
		} else {
			item = this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.aketon_cap],
				[1, ::Legends.Helmet.Standard.cultist_hood],
				[1, ::Legends.Helmet.Standard.hood],
				[1, ::Legends.Helmet.Standard.full_leather_cap],
			]);
		}

		item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 40) * 0.01));
		this.m.FoundItem = item;
	}

})
