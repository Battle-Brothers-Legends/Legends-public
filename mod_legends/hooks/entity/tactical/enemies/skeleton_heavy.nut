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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
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
				[1, "ancient/ancient_plated_scale_hauberk"],
				[1, "ancient/ancient_scale_coat"],
				[1, "ancient/ancient_plate_harness"],
				[1, "ancient/ancient_plated_mail_hauberk"]
			];
			local item = this.Const.World.Common.pickArmor(armor);
			this.m.Items.equip(item);
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local item = this.Const.World.Common.pickHelmet([
			[66, "ancient/ancient_honorguard_helmet"]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
		}
	}
});
