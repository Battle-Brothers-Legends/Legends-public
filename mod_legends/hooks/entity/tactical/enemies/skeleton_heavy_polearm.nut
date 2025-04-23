::mods_hookExactClass("entity/tactical/enemies/skeleton_heavy_polearm", function(o)
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
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/bladed_pike"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/warscythe"));
		}

		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
		}

		local armor = [
			[1, ::Legends.Armor.Ancient.ancient_plated_scale_hauberk],
			[1, ::Legends.Armor.Ancient.ancient_scale_coat],
			[1, ::Legends.Armor.Ancient.ancient_plate_harness],
			[1, ::Legends.Armor.Ancient.ancient_plated_mail_hauberk]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[66, ::Legends.Helmet.Ancient.ancient_honorguard_helmet]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
