this.legend_bandit_employer <- ::inherit("scripts/entity/tactical/human", {
	m = {},
	function create() {
		this.m.Type = ::Const.EntityType.BanditLeader;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.BanditLeader.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
	}

	function onInit() {
		this.human.onInit();
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = ::Math.rand(150, 255);
		//this.setArmorSaturation(0.85);
		//this.getSprite("shield_icon").setBrightness(0.85);
	}

	function onAppearanceChanged(_appearance, _setDirty = true) {
		this.actor.onAppearanceChanged(_appearance, false);
		//this.setArmorBrightness(0.9);
		this.setDirty(true);
	}

	function assignRandomEquipment() {
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(::Const.ItemSlot.Head)) {
			local armor = [
				[1, "coat_of_plates"],
				[1, "coat_of_scales"],
				[1, "heavy_lamellar_armor"],
				[1, "footman_armor"],
				[1, "brown_hedgeknight_armor"],
				[1, "northern_mercenary_armor_02"],
				[1, "lamellar_harness"],
				[1, "reinforced_mail_hauberk"],
				[1, "leather_scale_armor"],
				[1, "light_scale_armor"]
			];

			local helmet = [
				[1, "closed_mail_coif"],
				[1, "padded_kettle_hat"],
				[1, "kettle_hat_with_closed_mail"],
				[1, "kettle_hat_with_mail"],
				[1, "padded_flat_top_helmet"],
				[1, "nasal_helmet_with_mail"],
				[1, "flat_top_with_mail"],
				[1, "padded_nasal_helmet"],
				[1, "bascinet_with_mail"]
			];

			local outfits = [
				[1, "red_bandit_leader_outfit_00"]
			];
			foreach( item in ::Const.World.Common.pickOutfit(outfits, armor, helmet) ) {
				this.m.Items.equip(item);
			}
			return;
		}

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Body) == null) {
			local armor = [
				[1, "reinforced_mail_hauberk"],
				[2, "heavy_lamellar_armor"],
				[2, "bandit_armor_heavy"],
				[1, "footman_armor"],
				[1, "leather_scale_armor"],
				[1, "light_scale_armor"],
				[1, "red_bandit_leader_armor"]
			];
			this.m.Items.equip(::Const.World.Common.pickArmor(armor))
		}

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Head) == null) {
			local item = ::Const.World.Common.pickHelmet([
				[1, "closed_mail_coif"],
				[1, "padded_kettle_hat"],
				[1, "kettle_hat_with_closed_mail"],
				[1, "kettle_hat_with_mail"],
				[1, "padded_flat_top_helmet"],
				[1, "nasal_helmet_with_mail"],
				[1, "flat_top_with_mail"],
				[1, "padded_nasal_helmet"],
				[1, "bascinet_with_mail"],
				[1, "red_bandit_leader_helmet"]
			]);
			if (item != null) {
				this.m.Items.equip(item);
			}
		}
	}
});
