this.legend_bandit_executioner <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendBanditExecutioner;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendBanditExecutioner.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_butcher_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit() {
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendBanditExecutioner);
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodbath);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPushTheAdvantage);
		::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= this.Const.World.Scaling.Nomads.LegendsBanditExecutionerSwordDay) {
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		}
		if(::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendCarnage);
			::Legends.Traits.grant(this, ::Legends.Trait.IronJaw);
			::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		}
	}

	function assignRandomEquipment() {
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= this.Const.World.Scaling.Nomads.LegendsBanditExecutionerSwordDay) {
			this.getItems().equip(this.new("scripts/items/weapons/exesword"));
		}
		else {
			this.getItems().equip(::Const.World.Common.pickItem([
				[5, "weapons/blunt_cleaver"],
				[5, "weapons/scramasax"],
				[1, "weapons/legend_militia_glaive"]
			], "scripts/items/"));
		}

		this.getItems().equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.bandit_executioner_tunic]
		]));

		this.getItems().equip(this.Const.World.Common.pickHelmet([
			[10, ::Legends.Helmet.Standard.executioner_hood],
			[1, ::Legends.Helmet.Standard.bandit_executioner_hood]
		]))
	}

	function makeMiniboss() {
		if (!this.actor.makeMiniboss()) {
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_exesword"
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

