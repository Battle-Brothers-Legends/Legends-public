this.legend_manhunter_veteran_ranged <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendManhunterVeteran;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendManhunterVeteranRanged.XP;
		this.human.create();
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.SouthernUntidy;
		this.m.BeardChance = 80;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_manhunter_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendManhunterVeteranRanged);
		b.TargetAttractionMult = 1.1;
		b.Vision = 8;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");

		if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInBows = true;
		b.IsSpecializedInCrossbows = true;
		b.IsSpecializedInDaggers = true;

		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.QuickHands);
		::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
	}

	function onOtherActorDeath( _killer, _victim, _skill )
	{
		if (_victim.getType() == this.Const.EntityType.Slave && _victim.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorDeath(_killer, _victim, _skill);
	}

	function onOtherActorFleeing( _actor )
	{
		if (_actor.getType() == this.Const.EntityType.Slave && _actor.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorFleeing(_actor);
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local r = this.Math.rand(1, 3);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/oriental/handgonne"));
				this.m.Items.equip(this.new("scripts/items/ammo/powder_bag"));
			}
			else
			{
				local weapons = [
					"weapons/throwing_axe",
					"weapons/throwing_axe",
					"weapons/javelin"
				];

				if (this.World.getTime().Days < 80)
				{
					weapons.extend([
						"weapons/greenskins/goblin_spiked_balls"
					]);
				}

				weapons.extend([
					"weapons/greenskins/goblin_spiked_balls"
				]);

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}
		}

		local mainhandWeaponID = this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID();
		if (mainhandWeaponID == "weapon.handgonne" || mainhandWeaponID == "weapon.named_handgonne") {
			this.getItems().addToBag(::Const.World.Common.pickItem([
				[1, "weapons/oriental/qatal_dagger"],
			], "scripts/items/"));
		} else {
			this.getItems().addToBag(::Const.World.Common.pickItem([
				[1, "weapons/hooked_blade"],
				[1, "weapons/warbrand"],
				[1, "weapons/oriental/two_handed_saif"],
				[1, "weapons/warfork"],
			], "scripts/items/"));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armors = [
				[1, ::Legends.Armor.Southern.mail_and_lamellar_plating],
				[1, ::Legends.Armor.Southern.southern_long_mail_with_padding],
				[1, ::Legends.Armor.Standard.mail_hauberk],
				[1, ::Legends.Armor.Standard.reinforced_mail_hauberk],
				[1, ::Legends.Armor.Standard.lamellar_harness]
			];

			if (this.Const.DLC.Unhold)
			{
				armors.extend([
					[1, ::Legends.Armor.Standard.leather_scale_armor],
					[1, ::Legends.Armor.Standard.footman_armor]
				]);
			}

			this.m.Items.equip(this.Const.World.Common.pickArmor(armors));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helmets = [
				[1, ::Legends.Helmet.Southern.wrapped_southern_helmet],
				[1, ::Legends.Helmet.Southern.spiked_skull_cap_with_mail],
				[1, ::Legends.Helmet.Southern.southern_helmet_with_coif]
			];

			if (this.World.getTime().Days > 50) {
				helmets.extend([
					[1, ::Legends.Helmet.Southern.heavy_lamellar_helmet]
				]);

				if (this.Const.DLC.Wildmen)
				{
					helmets.extend([
						[1, ::Legends.Helmet.Standard.conic_helmet_with_closed_mail]
					]);
				}
			}

			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmets));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			[
				"weapons/named/named_javelin"
			],
			[
				"weapons/named/named_throwing_axe"
			],
			[
				"weapons/named/named_handgonne",
				"ammo/powder_bag"
			]
		];
		local armors = clone this.Const.Items.NamedSouthernArmors;

		armors.push("armor/named/golden_scale_armor");
		if (this.Const.DLC.Wildmen)
		{
			armors.push("armor/named/named_golden_lamellar_armor");
		}

		local helmets = clone this.Const.Items.NamedSouthernHelmets;

		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			local r = this.Math.rand(0, weapons.len() - 1);

			foreach( w in weapons[r] )
			{
				this.m.Items.equip(this.new("scripts/items/" + w));
			}
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor(
				this.Const.World.Common.convNameToList(armors)
			));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet(
				this.Const.World.Common.convNameToList(helmets)
			));
		}

		::Legends.Perks.grant(this, ::Legends.Perk.Duelist);
		::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
		return true;
	}
});

