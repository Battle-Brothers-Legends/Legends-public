::mods_hookExactClass("entity/tactical/enemies/skeleton_lich", function(o)
{
	o.onFactionChanged <- function ()
	{
		this.skeleton.onFactionChanged();
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.addSprite("armor_layer_chain");
		this.addSprite("armor_layer_plate");
		this.addSprite("armor_layer_tabbard");
		this.addSprite("armor_layer_cloak");
		this.addSprite("armor_upgrade_back");
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			this.addSprite(a)
		}
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
	}

	o.assignRandomEquipment = function ()
	{
		local armor = [
			[1, ::Legends.Armor.Ancient.ancient_lich_attire]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);
		local helmet = [
			[1, ::Legends.Helmet.Ancient.ancient_lich_headpiece]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}
});
