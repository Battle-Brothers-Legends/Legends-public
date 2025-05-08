::mods_hookExactClass("entity/tactical/enemies/skeleton_heavy", function(o)
{
	// o.onFactionChanged <- function ()
	// {
	// 	this.actor.onFactionChanged();
	// 	local flip = this.isAlliedWithPlayer()
	// 	flip = !flip
	// 	foreach (a in this.Const.CharacterSprites.Helmets)
	// 	{
	// 		if (!this.hasSprite(a))
	// 		{
	// 			continue;
	// 		}
	// 		this.getSprite(a).setHorizontalFlipping(flip);
	// 	}
	// }

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		}
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/ancient/ancient_sword",
				"weapons/ancient/legend_gladius",
				"weapons/ancient/khopesh"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/ancient/warscythe",
					"weapons/ancient/crypt_cleaver",
					"weapons/ancient/rhomphaia"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
		}


		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armor = [
				[1, ::Legends.Armor.Ancient.ancient_plated_scale_hauberk],
				[1, ::Legends.Armor.Ancient.ancient_scale_coat],
				[1, ::Legends.Armor.Ancient.ancient_plate_harness],
				[1, ::Legends.Armor.Ancient.ancient_plated_mail_hauberk]
			];
			local item = this.Const.World.Common.pickArmor(armor);
			this.m.Items.equip(item);
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local item = this.Const.World.Common.pickHelmet([
				[66, ::Legends.Helmet.Ancient.ancient_honorguard_helmet]
			]);
			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}
});
