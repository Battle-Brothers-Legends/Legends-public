::mods_hookExactClass("entity/tactical/enemies/hexe", function(o)
{
	local onDeath = o.onDeath;
	o.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	{
		onDeath( _killer, _skill, _tile, _fatalityType );

		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			if (this.Math.rand(1, 100) <= 1)
			{
				local rune;
				local selected = this.Math.rand(11,13);
				switch(selected)
				{
					case 11:
						rune = this.new("scripts/items/legend_helmets/runes/legend_rune_clarity");
						break;

					case 12:
						rune = this.new("scripts/items/legend_helmets/runes/legend_rune_bravery");
						break;

					case 13:
						rune = this.new("scripts/items/legend_helmets/runes/legend_rune_luck");
						break;
				}
				rune.setRuneVariant(selected);
				rune.setRuneBonus(true);
				// rune.setRuneVariant(0);
				rune.drop(_tile);


				// @Enduriel did the following, but it doesn't have a declaration for the `selected` variable
				// Hence reverting back to mercury's implementation for now (above).

				// local options = this.new("scripts/mods/script_container");
				// options.extend([
				// 	"scripts/items/legend_helmets/runes/legend_rune_clarity",
				// 	"scripts/items/legend_helmets/runes/legend_rune_bravery",
				// 	"scripts/items/legend_helmets/runes/legend_rune_luck"
				// ]);
				// local rune = this.new(options.roll());
				// rune.setRuneVariant(selected);
				// rune.setRuneBonus(true);
				// // rune.setRuneVariant(0);
				// rune.drop(_tile);

			}
		}
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
