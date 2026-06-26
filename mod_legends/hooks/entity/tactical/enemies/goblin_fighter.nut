::mods_hookExactClass("entity/tactical/enemies/goblin_fighter", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		::Legends.Perks.grant(this, ::Legends.Perk.LegendTumble);
		if (!this.m.IsLow && this.World.getTime().Days >= ::Const.World.Scaling.Goblins.LegendsFighterMeleeSkillIncreaseDay)
		{
			b.MeleeSkill += 10;
		}
		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Duelist);
			::Legends.Effects.grant(this, ::Legends.Effect.Dodge);
			::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			b.RangedSkill += 10;
		}
	}

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function ()
	{
		local ret = makeMiniboss();
		if (ret)
		{
			local weapons = [
				"weapons/named/named_goblin_falchion",
				"weapons/named/named_goblin_pike",
				"weapons/named/named_goblin_spear",
				"weapons/named/legend_named_goblin_notched_blade"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		return ret;
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/greenskins/goblin_falchion",
				"weapons/greenskins/goblin_spear",
				"weapons/legend_chain",
				"weapons/greenskins/goblin_notched_blade",
				"weapons/greenskins/legend_goblin_infantry_axe",
				"weapons/greenskins/goblin_pike",
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() != "weapon.goblin_spear" && this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() != "weapon.named_goblin_spear")
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
		}

		if (::Legends.isLegendaryDifficulty())
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
			this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
		}


		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
			}
			else
			{
				local shields = [
					"shields/greenskins/goblin_light_shield",
					"shields/greenskins/goblin_heavy_shield"
				];
				this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
			}
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local item = this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Greenskin.goblin_light_armor],
				[1, ::Legends.Armor.Greenskin.goblin_medium_armor],
			]);
			this.m.Items.equip(item);
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local item = this.Const.World.Common.pickHelmet([
				[75, ::Legends.Helmet.Greenskin.goblin_light_helmet],
				[25, ::Legends.Helmet.Greenskin.goblin_heavy_helmet]
			]);
			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}
});
