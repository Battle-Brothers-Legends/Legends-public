this.legend_orc_tyrant <- this.inherit("scripts/entity/tactical/enemies/orc_warlord", {
	m = {},
	function create()
	{
		this.orc_warlord.create();
		this.m.Type = this.Const.EntityType.LegendOrcTyrant;
		this.m.XP = this.Const.Tactical.Actor.LegendOrcTyrant.XP;
		this.actor.create();
	}

	function onInit()
	{
		this.orc_warlord.onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.grant(this, ::Legends.Perk.Brawny);
		::Legends.Perks.grant(this, ::Legends.Perk.InspiringPresence);
		::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		::Legends.Actives.remove(this, ::Legends.Active.Warcry);
		::Legends.Actives.grant(this, ::Legends.Active.Warcry, function (_skill) {
			_skill.m.IsUpgraded = true;
		});
		if (::Legends.isLegendaryDifficulty())
		{
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 100;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 100;		
			this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 350;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 350;
			::Legends.Perks.grant(this, ::Legends.Perk.Steadfast);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendImmovableObject);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBoneBreaker);
		}
	}

	function assignRandomEquipment()
	{
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
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		this.getItems().equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Greenskin.orc_warlord_armor]
		]));

		this.getItems().equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Greenskin.orc_warlord_helmet]
		]));
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss_greenskins");
		local weapons = [
			"weapons/named/named_orc_cleaver",
			"weapons/named/legend_named_orc_axe_2h",
			"weapons/named/legend_named_orc_flail_2h",
			"weapons/named/named_orc_axe"
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		return true;
	}

});

