this.legend_bandit_executioner <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.LegendBanditExecutioner;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.LegendBanditExecutioner.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.AllMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_butcher_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit() {
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendBanditExecutioner);
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
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		if(::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.LegendHairSplitter);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendCarnage);
			::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
			::Legends.Traits.grant(this, ::Legends.Trait.IronJaw);
		}
	}

	function assignRandomEquipment() {
		if (this.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) == null) {
			if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= ::Const.World.Scaling.Brigands.LegendsBanditExecutionerSwordDay) {
				this.getItems().equip(this.new("scripts/items/weapons/exesword"));
			}
			else {
				this.getItems().equip(::Legends.Items.pickItem([
					[5, "weapons/butchers_cleaver"],
					[5, "weapons/scramasax"],
					[1, "weapons/legend_militia_glaive"]
				], "scripts/items/"));
			}
		}

		if (this.getItems().getItemAtSlot(::Const.ItemSlot.Body) == null) {
			this.getItems().equip(::Legends.Items.pickArmor([
				[1, ::Legends.Armor.Standard.bandit_executioner_tunic]
			]));
		}

		this.getItems().equip(::Legends.Items.pickHelmet([
			[1, ::Legends.Helmet.Standard.bandit_executioner_hood]
		]));
	}

	function makeMiniboss() {
		if (!this.actor.makeMiniboss()) {
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		this.getItems().equip(this.new("scripts/items/weapons/named/named_exesword"));
		this.getItems().equip(::Legends.Items.pickArmor([
			[1, ::Legends.Armor.Named.bandit_executioner_tunic]
		]));

		::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
		return true;
	}

});

