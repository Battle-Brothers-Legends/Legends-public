this.legend_rune <- this.inherit("scripts/crafting/blueprint", {
	m = {
		Rune = 0,
	},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "";
		local token = this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
		token.setRuneVariant(this.m.Rune);
		token.updateRuneSigilToken();
		token.getRuneSigilTooltip = this.getRuneSigilTooltip;
		this.m.PreviewCraftable = token;
		this.m.Cost = 1200;
		this.m.Enchanter = true;
		local ingredients = [
			{
				Script = "scripts/items/trade/uncut_gems_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/backgrounds/legend_vala_background"]
			}
		];
		this.initSkills(skills);
	}

	function isUpgraded()
	{
		return this.Stash.hasItem(::Legends.Camp.Tent.Enchant);
	}

	function getRuneSigilTooltip()
	{
		local def = ::Legends.Runes.get(this.m.Rune);
		if (def == null)
			return "This item is inscribed with a rune sigil, even though it shouldn't have been: please report this bug.";
		return def.getRuneTooltip(this);
	}

	function isQualified()
	{
		return this.blueprint.isQualified();
	}

	function onEnchant( _stash, _bonus )
	{
		local def = ::Legends.Runes.get(this.m.Rune);
		if (def == null)
			return;
		local rune = ::new(def.Script);
		rune.setRuneVariant(this.m.Rune);
		rune.setRuneBonus(_bonus);
		if (def.ItemType == ::Legends.Runes.Target.Weapon || def.ItemType == ::Legends.Runes.Target.Shield) {
			rune.updateRuneSigilToken();
		}
		_stash.add(rune);
	}
});
