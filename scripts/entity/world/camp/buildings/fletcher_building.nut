this.fletcher_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		Items = [],
		AmmoAdded = 0,
		NumBros = 0,
		Craft = 0
	},

	function create() {
		this.camp_building.create();
		this.m.ID = ::Legends.Camp.CampBuildings.Fletcher;
		this.m.ModName = "Fletching";
		this.m.ModMod = 10.0;
		this.m.BaseCraft = 1.0;
		this.m.Slot = "fletch";
		this.m.Name = "Fletcher";
		this.m.Description = "Make some ammo";
		this.m.BannerImage = "ui/buttons/banner_fletch.png";
		this.m.CanEnter = false;
		local sounds = this.getCampSounds(5, "fletcher");
		this.m.Sounds = sounds;
		this.m.SoundsAtNight = [];
	}

	function getTitle() {
		return this.m.Name + (this.getUpgraded() ? " *Upgraded*" : " *Not Upgraded*");
	}

	function getDescription() {
		//"The Fletching tent can be upgraded by purchasing a crafting cart from a settlement merchant. An upgraded tent has a 15% increase in production speed. ";
		//"Additionally, there's a chance that ammunition of the disposable throwing kind will be crafted.";
		return "Craft ammunition while encamped.";
	}

	function getModifierTooltip() {
		local mod = this.getModifiers();
		local ret = [
			{
				id = 5,
				type = "text",
				icon = "ui/buttons/asset_ammo_up.png",
				text = "Produces [color=%positive%]" + mod.Craft / 2.0 + "[/color] units of ammo per hour."
			}
		];
		local id = 6;
		foreach (bro in mod.Modifiers) {
			ret.push({
				id = id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]" + bro[0] / 2.0 + "[/color] units/hour " + bro[1] + " (" + bro[2] + ")"
			});
			++id;
		}
		return ret;
	}

	function getUpgraded() {
		return ::Stash.hasItem(::Legends.Camp.Tent.Fletcher);
	}

	function getLevel() {
		return (this.getUpgraded() ? "tent" : "dude") + "_" + (this.getAssignedBros() > 0 ? "full" : "empty");
	}

	function init() {
		this.m.AmmoAdded = 0;
		this.m.Items = [];
		local mod = this.getModifiers();
		this.m.NumBros = mod.Assigned;
		this.m.Craft = mod.Craft;
	}

	function getResults() {
		local res = [];
		local id = 50;
		if (this.m.AmmoAdded > 0) {
			res.push({
				id = id,
				icon = "ui/buttons/asset_ammo_up.png",
				text = "You created " + this.Math.floor(this.m.AmmoAdded) + " units of ammo"
			});
			++id;
		}
		foreach (b in this.m.Items) {
			res.push({
				id = id,
				icon = "ui/items/" + b.getIcon(),
				text = "You gained " + b.getName()
			});
			++id;
		}
		return res;
	}

	function getAssignedBros() {
		return this.getModifiers().Assigned;
	}

	function update() {
		if (this.m.NumBros == 0) {
			return null;
		}

		if (::World.Assets.getAmmo() + this.m.AmmoAdded < ::World.Assets.getMaxAmmo()) {
			this.m.AmmoAdded = ::Math.min(::World.Assets.getMaxAmmo(), (::Math.floor(this.m.Craft * this.m.Camp.getElapsedHours()) / 2.0));
		}

		return "Fletched ... " + ::Math.floor(this.m.AmmoAdded) + " ammo";
	}

	function completed() {
		if (this.m.NumBros == 0) {
			return;
		}

		local item = null;
		if (this.m.AmmoAdded > 0) {
			::World.Assets.addAmmo(::Math.floor(this.m.AmmoAdded));
		}

		if (!this.getUpgraded() || ::Stash.getNumberOfEmptySlots() == 0) {
			return;
		}

		local secondary = [
			"scripts/items/weapons/throwing_spear",
			"scripts/items/weapons/javelin"
		];

		if (::Math.rand(1, 100) <= this.m.Camp.getElapsedHours()) {
			local item = ::new(secondary[::Math.rand(0, secondary.len() - 1)]);
			this.m.Items.push(item);
			::Stash.add(item);
		}
	}
});
