this.legend_orc_mad_berserker <- this.inherit("scripts/entity/tactical/enemies/orc_berserker", {
	m = {},

	function create() {
		this.orc_berserker.create();
		this.m.Type = this.Const.EntityType.LegendOrcMadBerserker;
		this.m.XP = this.Const.Tactical.Actor.LegendOrcMadBerserker.XP;
		if (this.m.Type != this.Const.EntityType.Player)
		{
			this.m.Name = this.Const.Strings.EntityName[this.m.Type];
		}
		this.actor.create();
	}

	function onInit() {
		this.orc_berserker.onInit();
		local tattooBody = this.getSprite("tattoo_body");
		tattooBody.setBrush("bust_orc_02_body_paint_0" + this.Math.rand(4, 6));
		local tattooHead = this.getSprite("tattoo_head");
		tattooHead.setBrush("bust_orc_02_head_paint_0" + this.Math.rand(4, 6));
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.Brawny);
		::Legends.Perks.grant(this, ::Legends.Perk.Colossus);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendHeightenedReflexes);
		::Legends.Perks.grant(this, ::Legends.Perk.Adrenaline);
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.LegendUberNimble);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendTasteThePain);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendVengeance);
		}
	}

	function assignRandomEquipment() {
		local weapons = [
			"weapons/greenskins/orc_axe",
			"weapons/greenskins/orc_cleaver",
			"weapons/greenskins/orc_flail_2h",
			"weapons/greenskins/orc_axe_2h",
			"weapons/greenskins/legend_limb_lopper",
			"weapons/greenskins/legend_man_mangler",
			"weapons/greenskins/legend_bough",
			"weapons/greenskins/legend_skullbreaker"
		];
		local weapon = weapons[this.Math.rand(0, weapons.len() - 1)];
		this.m.Items.equip(this.new("scripts/items/" + weapon));
		if (!this.m.Items.hasBlockedSlot(::Const.ItemSlot.Offhand)) {
			this.m.Items.equip(this.new("scripts/items/" + weapon));
			this.m.Items.updateDualWield();
		}

	}

	function makeMiniboss() {
		if (!this.actor.makeMiniboss()) {
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss_greenskins");
		local weapons = [
			"weapons/named/named_orc_cleaver",
			"weapons/named/legend_named_orc_axe_2h",
			"weapons/named/legend_named_orc_flail_2h",
			"weapons/named/named_orc_axe"
		];
		local weapon = weapons[this.Math.rand(0, weapons.len() - 1)];
		this.m.Items.equip(this.new("scripts/items/" + weapon));
		if (!this.m.Items.hasBlockedSlot(::Const.ItemSlot.Offhand)) {
			local weapons = [
				"weapons/greenskins/orc_axe",
				"weapons/greenskins/orc_cleaver",
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			this.m.Items.updateDualWield();
		}

		return true;
	}

});
