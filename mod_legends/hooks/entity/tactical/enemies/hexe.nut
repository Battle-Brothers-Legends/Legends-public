::mods_hookExactClass("entity/tactical/enemies/hexe", function(o)
{
	o.m.DroppableRunes <- [
		::Legends.Rune.LegendRshClarity,
		::Legends.Rune.LegendRshBravery,
		::Legends.Rune.LegendRshLuck
	];

	local create = o.create;
	o.create = function () {
		create();
		this.m.OnDeathLootTable.push([1, function () {
			local selected = this.m.DroppableRunes[::Math.rand(0, this.m.DroppableRunes.len() - 1)];
			local rune = ::new(::Legends.Runes.get(selected).Script);
			rune.setRuneVariant(selected);
			rune.setRuneBonus(true);
			rune.updateRuneSigilToken();
			return rune;
		}.bindenv(this)]);
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++)
			this.m.OnDeathLootTable.push([0.5, "scripts/items/misc/legend_ancient_scroll_item"]);
	}

	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		local b = this.m.BaseProperties;
		::Legends.Actives.grant(this, ::Legends.Active.LegendWither);

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.InspiringPresence);
			::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
			::Legends.Actives.grant(this, ::Legends.Active.LegendMagicMissile);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
			b.Initiative += 50;
			b.RangedSkill += 75;
			b.Stamina += 70;
		}
	}

	o.assignRandomEquipment = function ()
	{
		 if(::Legends.isLegendaryDifficulty())
		 {
		 	this.m.Items.equip(this.new("scripts/items/weapons/legend_staff_gnarled"));
		 }
	}
});
