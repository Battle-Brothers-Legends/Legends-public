this.legend_bandit_executioner_high <- this.inherit("scripts/entity/tactical/humans/legend_bandit_executioner", {
	m = {},
	function create() {
		this.legend_bandit_executioner.create();
		this.m.Type = this.Const.EntityType.LegendBanditExecutionerHigh;
		this.m.XP = this.Const.Tactical.Actor.LegendBanditExecutionerHigh.XP;
		this.actor.create();
	}

	function onInit() {
		this.legend_bandit_executioner.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendBanditExecutionerHigh);
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		if(::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.Fearless);
		}
	}

	function assignRandomEquipment() {
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= this.Const.World.Scaling.Nomads.LegendsBanditExecutionerSwordDay) {
			this.getItems().equip(this.new("scripts/items/weapons/exesword"));
		}
		else {
			this.getItems().equip(::Const.World.Common.pickItem([
				[10, "weapons/exesword"],
				[1, "weapons/military_cleaver"],
				[1, "weapons/legend_military_warscythe"]
			], "scripts/items/"));
		}

		this.getItems().equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.bandit_executioner_tunic_high]
		]));

		this.getItems().equip(this.Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.Standard.executioner_hood],
			[8, ::Legends.Helmet.Standard.bandit_executioner_hood]
		]))
	}

	function makeMiniboss() {
		if (!this.actor.makeMiniboss()) {
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_exesword",
			"weapons/named/named_exesword",
			"weapons/named/named_exesword",
			"weapons/named/named_exesword",
			"weapons/named/legend_named_military_warscythe"
		];

		local armor = [
			"armor/named/black_leather_armor",
			"armor/named/named_noble_mail_armor",
			"armor/named/blue_studded_mail_armor"
		];

		if (this.Math.rand(1, 100) <= 50)
		{
			this.getItems().equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			// TODO equip a named item
			// this.getItems().equip(this.Const.World.Common.pickArmor(
			// 	this.Const.World.Common.convNameToList(
			// 		armor
			// 	)
			// ));
		}

		::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
		return true;
	}

});

