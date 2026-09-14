::mods_hookExactClass("entity/tactical/enemies/skeleton_heavy_bodyguard", function(o)
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
		local weapons = [
			"weapons/ancient/ancient_sword",
			"weapons/ancient/crypt_cleaver",
			"weapons/ancient/rhomphaia",
			"weapons/ancient/khopesh",
			"weapons/ancient/warscythe",
			"weapons/ancient/legend_gladius",
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

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

	o.makeMiniboss <- function ()
	{
		
		if (!this.actor.makeMiniboss())
		{
			return false;
		}
		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"named_khopesh",
			"named_crypt_cleaver",
			"named_warscythe",
			"legend_named_gladius"
		];
		this.m.Items.equip(this.new("scripts/items/weapons/named/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Ancient.ancient_heavy_restored_armor]
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Ancient.ancient_heavy_restored_helmet]
		]));

		::Legends.Perks.grant(this, ::Legends.Perk.DevastatingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendTerrifyingVisage);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBackswing);
		::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		return true;
	}
});
