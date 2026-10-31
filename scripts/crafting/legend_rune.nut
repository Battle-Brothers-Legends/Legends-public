this.legend_rune <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		this.blueprint.create();
		this.m.PreviewCraftable.setRuneVariant(this.m.Rune);
		this.m.PreviewCraftable.updateRuneSigilToken();
		this.m.PreviewCraftable.getRuneSigilTooltip = this.getRuneSigilTooltip;
	}

	function isUpgraded() {
		return ::World.Retinue.hasFollower(::Legends.Camp.Upgrades[::Legends.Camp.CampBuildings.Enchanter]);
	}

	function getRuneSigilTooltip() {
		local def = ::Legends.Runes.get(this.m.Rune);
		if (def == null) {
			return "This item is inscribed with a rune sigil, even though it shouldn't have been: please report this bug.";
		}
		return ::Legends.Runes.getRuneTooltip(def, this.isUpgraded());
	}

	function onCraft(_stash) {}

	function onEnchant(_upgraded) {
		local def = ::Legends.Runes.get(this.m.Rune);
		if (def == null) {
			return;
		}
		local rune = ::new(def.Script);
		rune.setRuneVariant(this.m.Rune);
		rune.setRuneBonus(_upgraded, true);
		if (def.ItemType == ::Legends.Runes.Target.Weapon || def.ItemType == ::Legends.Runes.Target.Shield) {
			rune.updateRuneSigilToken();
		}
		::World.Assets.getStash().add(rune);
	}
});
