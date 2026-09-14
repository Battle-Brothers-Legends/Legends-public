::mods_hookExactClass("entity/tactical/enemies/lesser_flesh_golem", function(o) {
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBoneBreaker);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.LegendPummelIntoSubmission);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAmbidextrous);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendTerrifyingVisage);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLacerate);
			b.Hitpoints *= 1.5;
		}
		::Legends.S.scaleBaseProperties(b);
	}

	o.onDeath = function ( _killer, _skill, _tile, _fatalityType ) {
		this.legend_flesh_golem.onDeath( _killer, _skill, _tile, _fatalityType );
	}

	o.getLootForTile = function( _killer, _loot ) {
		return _loot;
	}

	o.assignRandomEquipment = function ()
	{
		this.m.Items.equip(this.new("scripts/items/helmets/golems/flesh_golem_facewrap"));
		this.m.Items.equip(this.new("scripts/items/armor/golems/flesh_golem_robes"));
		local weapons = [
			"weapons/butchers_cleaver",
			"weapons/pickaxe",
			"weapons/bludgeon",
			"weapons/reinforced_wooden_flail",
			"weapons/militia_spear",
			"weapons/shortsword",
			"weapons/hatchet"
		];
		local weapon = weapons[this.Math.rand(0, weapons.len() - 1)];
		this.m.Items.equip(this.new("scripts/items/" + weapon));
		if (!this.m.Items.hasBlockedSlot(::Const.ItemSlot.Offhand)) {
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			this.m.Items.updateDualWield();
		}
	}
});
