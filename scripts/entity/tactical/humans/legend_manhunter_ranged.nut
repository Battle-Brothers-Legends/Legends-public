this.legend_manhunter_ranged <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendManhunterRanged;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendManhunterRanged.XP;
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
		b.setValues(this.Const.Tactical.Actor.LegendManhunterRanged);
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

		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.QuickHands);
		::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
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
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/nomad_sling"));
			this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
			this.m.Items.addToBag(this.new("scripts/items/weapons/militia_spear"));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
		}

		local armor = [
			[1, ::Legends.Armor.Southern.linothorax],
			[1, ::Legends.Armor.Southern.stitched_nomad_armor],
			[1, ::Legends.Armor.Standard.leather_lamellar]
		];
		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));

		local helmet = [
			[1, ::Legends.Helmet.Southern.southern_head_wrap],
			[1, ::Legends.Helmet.Southern.nomad_leather_cap],
			[1, ::Legends.Helmet.Southern.nomad_light_helmet]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}

});

