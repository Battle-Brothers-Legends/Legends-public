::mods_hookExactClass("entity/tactical/enemies/unhold_frost_armored", function(o)
{
	o.assignRandomEquipment = function ()
	{
		this.m.Items.equip(this.new("scripts/items/armor/barbarians/unhold_armor_heavy"));
		local item = this.Const.World.Common.pickHelmet([
			[1, "barbarians/unhold_helmet_heavy"]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

	o.onFactionChanged <- function ()
	{
		local flip = !this.isAlliedWithPlayer();
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			if (!this.hasSprite(a))
				continue;
			this.getSprite(a).setHorizontalFlipping(flip);
		}
	}

});
