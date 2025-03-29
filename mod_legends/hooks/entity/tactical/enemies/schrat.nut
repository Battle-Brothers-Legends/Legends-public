::mods_hookExactClass("entity/tactical/enemies/schrat", function(o)
{
	o.m.DroppableRunes <- [
		::Legends.Rune.LegendRsaEndurance,
		::Legends.Rune.LegendRsaSafety
	];

	local create = o.create;
	o.create = function () {
		create();
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++)
		{
			this.m.OnDeathLootTable.push([1, function () {
				local token = this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
				token.setRuneVariant(this.m.DroppableRunes[this.Math.rand(0, this.m.DroppableRunes.len() - 1)]);
				token.setRuneBonus(true);
				token.updateRuneSigilToken();
				return token;
			}.bindenv(this)]);
		}
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldBash);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLacerate);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistShieldSkill);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}
});
