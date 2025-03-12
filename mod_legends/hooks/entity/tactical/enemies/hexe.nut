::mods_hookExactClass("entity/tactical/enemies/hexe", function(o)
{
	o.m.DroppableRunes <- [
		::Legends.Rune.LegendRshClarity,
		::Legends.Rune.LegendRshBravery,
		::Legends.Rune.LegendRshLuck
	];

	local onDeath = o.onDeath;
	o.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	{
		onDeath( _killer, _skill, _tile, _fatalityType );

		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			if (this.Math.rand(1, 100) <= 1)
			{
				local selected = this.m.DroppableRunes[this.Math.rand(0, this.m.DroppableRunes.len() - 1)];
				local def = ::Legends.Runes.get(selected);
				if (def != null)
				{
					local rune = ::new(def.Script);
					rune.setRuneVariant(selected);
					rune.setRuneBonus(true);
					rune.drop(_tile);
				}
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
