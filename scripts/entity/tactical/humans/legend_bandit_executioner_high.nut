this.legend_bandit_executioner_high <- this.inherit("scripts/entity/tactical/humans/legend_bandit_executioner", {
	m = {},
	function create() {
		this.legend_bandit_executioner.create();
		this.m.Type = ::Const.EntityType.LegendBanditExecutionerHigh;
		this.m.XP = ::Const.Tactical.Actor.LegendBanditExecutionerHigh.XP;
		this.actor.create();
	}

	function onInit() {
		this.legend_bandit_executioner.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendBanditExecutionerHigh);
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		::Legends.Traits.grant(this, ::Legends.Trait.Brute);
		if(::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.Fearless);
		}
	}

	function assignRandomEquipment() {
		if (this.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) == null) {
			if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= ::Const.World.Scaling.Brigands.LegendsBanditExecutionerSwordDay) {
				this.getItems().equip(this.new("scripts/items/weapons/exesword"));
			}
			else {
				this.getItems().equip(::Legends.Items.pickItem([
					[10, "weapons/exesword"],
					[1, "weapons/military_cleaver"],
					[1, "weapons/legend_military_warscythe"]
				], "scripts/items/"));
			}
		}

		if (this.getItems().getItemAtSlot(::Const.ItemSlot.Body) == null) {
			this.getItems().equip(::Legends.Items.pickArmor([
				[1, ::Legends.Armor.Standard.bandit_executioner_tunic_high]
			]));
		}

		this.getItems().equip(::Legends.Items.pickHelmet([
			[1, ::Legends.Helmet.Standard.bandit_executioner_hood_high]
		]));
	}

	function makeMiniboss() {
		if (!this.actor.makeMiniboss()) {
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		this.getItems().equip(::Legends.Items.pickItem([
			[4, "weapons/named/named_exesword"],
			[1, "weapons/named/legend_named_military_warscythe"]
		], "scripts/items/"));
		this.getItems().equip(::Legends.Items.pickArmor([
			[1, ::Legends.Armor.Named.bandit_executioner_tunic]
		]));

		::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
		return true;
	}

});

