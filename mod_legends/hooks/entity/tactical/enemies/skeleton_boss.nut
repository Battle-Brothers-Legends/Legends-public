::mods_hookExactClass("entity/tactical/enemies/skeleton_boss", function(o)
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
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		}
	}

	o.assignRandomEquipment = function ()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/named/named_crypt_cleaver"));

		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
		}

		local item = this.Const.World.Common.pickArmor([
			[1, "legendary/emperors_armor_fake"] //legend_emperors_armor_fake
		]);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[66, "ancient/ancient_laurels"]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
