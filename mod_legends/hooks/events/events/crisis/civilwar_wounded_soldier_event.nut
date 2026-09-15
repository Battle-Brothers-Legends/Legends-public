::mods_hookExactClass("events/events/crisis/civilwar_wounded_soldier_event", function(o) {
	o.addLoot = function (_list) {
		local item;
		local banner = this.m.NobleHouse.getBanner();
		local r;
		r = ::Math.rand(1, 4);

		if (r == 1)
			item = this.new("scripts/items/weapons/arming_sword");
		else if (r == 2)
			item = this.new("scripts/items/weapons/morning_star");
		else if (r == 3)
			item = this.new("scripts/items/weapons/military_pick");
		else if (r == 4)
			item = this.new("scripts/items/weapons/warbrand");

		::World.Assets.getStash().add(item);
		_list.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + ::Const.Strings.getArticle(item.getName()) + item.getName()
		});
		r = ::Math.rand(1, 4);

		if (r == 1) {
//			item = ::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.faction_helm]]);
//			item.setVariant(banner); // doesn't work, no icons
			item = ::Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_helm]]);
		} else {
			item = ::Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.heraldic_armor, null, banner],
				[1, ::Legends.Armor.Standard.mail_shirt],
				[1, ::Legends.Armor.Standard.mail_hauberk, 28],
			]);
		}

		item.setCondition(44.0);
		::World.Assets.getStash().add(item);
		_list.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			imageOverlayPath = item.getIconOverlay(),
			text = "You gain " + item.makeName()
		});
	}
})
