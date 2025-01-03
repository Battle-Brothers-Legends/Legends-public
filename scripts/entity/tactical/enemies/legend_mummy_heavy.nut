this.legend_mummy_heavy <- this.inherit("scripts/entity/tactical/legend_mummy", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendMummyHeavy;
		this.m.XP = this.Const.Tactical.Actor.LegendMummyHeavy.XP;
		this.m.ResurrectionValue = 5.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/legend_mummy_heavy";
		this.legend_mummy.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.legend_mummy.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendMummyHeavy);
		b.Initiative -= 20;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 100)
		{
			b.IsSpecializedInPolearms = true;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_carnage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		}

	}

	function assignRandomEquipment() //pick a weapon
	{
		local r = this.Math.rand(0, 4);

		if (r == 0)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/legend_fan_axe"));
		}
		else if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/crypt_cleaver"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/bladed_pike"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/legend_great_khopesh"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/rhomphaia"));
		}
		// this.m.Items.equip(this.new("scripts/items/weapons/ancient/legend_fan_axe"));

		// if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		// {
		// 	this.m.Items.equip(this.new("scripts/items/shields/ancient/legend_mummy_tower_shield"));
		// }

		local armor = [
			[1, "ancient/legend_mummy_bandages"],
			[4, "ancient/legend_mummy_royal_plate"]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[2, "ancient/ancient_wig"],
			[5, "ancient/legend_mummy_headband"],
			[1, "ancient/legend_mummy_crown_king"]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		local weapons = [
			[1, "legend_named_gladius"],
			[1, "named_crypt_cleaver"],
			[1, "named_khopesh"],
			[1, "legend_named_great_khopesh"],
			[1, "named_warscythe"],
			[1, "named_bladed_pike"]

		]

		local weaponAdd = this.Const.World.Common.pickItem(weapons, "scripts/items/weapons/named/");
		this.m.Items.equip(weaponAdd);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_forceful_swing"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));

	}

});

