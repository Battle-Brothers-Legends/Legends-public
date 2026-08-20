::mods_hookExactClass("entity/tactical/enemies/skeleton_lich", function (o) {
	o.onFactionChanged <- function () {
		this.skeleton.onFactionChanged();
	}

	local onInit = o.onInit;
	o.onInit = function () {
		onInit();
		this.addSprite("armor_layer_chain");
		this.addSprite("armor_layer_plate");
		this.addSprite("armor_layer_tabard");
		this.addSprite("armor_layer_cloak");
		this.addSprite("armor_upgrade_back");
		foreach (a in ::Const.CharacterSprites.Helmets) {
			this.addSprite(a);
		}
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
	}

	o.assignRandomEquipment = function () {
		local armor = [
			[1, ::Legends.Armor.Ancient.ancient_lich_attire]
		];
		local item = ::Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);

		local item = ::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Ancient.ancient_lich_headpiece]
		]);
		if (item != null) {
			this.m.Items.equip(item);
		}
		local b = this.m.BaseProperties;	
		b.Armor[::Const.BodyPart.Head] = 80 - item.getArmorMax(); // set head armor of the lorekeeper to vanilla levels while respecting the outfit
		b.ArmorMax[::Const.BodyPart.Head] = 80 - item.getArmorMax();
	}
});
