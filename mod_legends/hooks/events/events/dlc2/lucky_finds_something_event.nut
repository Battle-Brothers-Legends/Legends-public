::mods_hookExactClass("events/events/dlc2/lucky_finds_something_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A")
			{
				s.Text = "%terrainImage%{%lucky% the ever lucky sellsword has managed to find something interesting. You ask how %they_lucky% came across the item. %They_lucky% shrugs.%SPEECH_ON%{I was walking, and then I stepped on it. Simple enough. | I looked up and this bird shat and it just missed me. When I looked at where it landed, well, there it was. The bird shit and that thing you got in your hands. | Felt a tingle in my fingers, and then a tingle in my crotch. After that I got to looking around for somethin\' boring to absolve myself and saw it just settin\' there. | Saw a horseshoe just layin\' on the ground there and thought to go and fetch it and, well, that was underneath. | Well, see, I saw this four-leaf clover just setting there and I was gonna add it to my bag, see, I got dozens, anyway when I went to go pick it up I saw that item just settin\' there. Pretty nifty, huh?}%SPEECH_OFF%}";
			}
		}
	}

	o.onPrepare = function () {
		local item;
		local r = this.Math.rand(1, 19);

		if (r == 1)
			item = this.new("scripts/items/weapons/militia_spear");
		else if (r == 2)
			item = this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.patched_mail_shirt],
			]);
		else if (r == 3)
			item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.dented_nasal_helmet]]);
		else if (r == 4)
			item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.mail_coif]]);
		else if (r == 5)
			item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.cultist_hood]]);
		else if (r == 6)
			item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.full_leather_cap]]);
		else if (r == 7)
			item = this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.ragged_surcoat],
			]);
		else if (r == 8)
			item = this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.noble_tunic],
			]);
		else if (r == 9)
			item = this.new("scripts/items/misc/ghoul_horn_item");
		else if (r == 10)
			item = this.new("scripts/items/weapons/knife");
		else if (r == 11)
			item = this.new("scripts/items/misc/wardog_armor_upgrade_item");
		else if (r == 12)
			item = this.new("scripts/items/legend_armor/armor_upgrades/legend_joint_cover_upgrade");
		else if (r == 13)
			item = this.new("scripts/items/tools/throwing_net");
		else if (r == 14)
			item = this.new("scripts/items/weapons/throwing_spear");
		else if (r == 15)
			item = this.new("scripts/items/weapons/hatchet");
		else if (r == 16)
			item = this.new("scripts/items/weapons/lute");
		else if (r == 17)
			item = this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.thick_dark_tunic],
			]);
		else if (r == 18)
			item = this.new("scripts/items/legend_armor/armor_upgrades/legend_mail_patch_upgrade");
		else if (r == 19)
			item = this.new("scripts/items/misc/legend_paint_black_item");

		if (item.getConditionMax() > 1)
			item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 40) * 0.01));

		this.m.FoundItem = item;
	}
});
