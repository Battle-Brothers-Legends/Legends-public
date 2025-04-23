::mods_hookExactClass("entity/tactical/humans/standard_bearer", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.FortifiedMind);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendForwardPush);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendHoldTheLine);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		local banner = 4;

		if (("State" in this.Tactical) && this.Tactical.State != null && !this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;
		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		local weapon = this.new("scripts/items/tools/faction_banner");
		weapon.setVariant(banner);
		this.m.Items.equip(weapon);

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.mail_hauberk, 28],
			[1, ::Legends.Armor.Standard.mail_shirt],
			[2, ::Legends.Armor.Standard.basic_mail_shirt]
		]));

		if (this.Math.rand(1, 100) <= 75)
		{
			local helmet;

			if (banner <= 4)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.kettle_hat],
					[1, ::Legends.Helmet.Standard.padded_kettle_hat],
					[1, ::Legends.Helmet.Standard.kettle_hat_with_mail]
				])
			}
			else if (banner <= 7)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.flat_top_helmet],
					[1, ::Legends.Helmet.Standard.padded_flat_top_helmet],
					[1, ::Legends.Helmet.Standard.flat_top_with_mail]
				])
			}
			else
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.nasal_helmet],
					[1, ::Legends.Helmet.Standard.padded_nasal_helmet],
					[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail]
				])
			}

			if (helmet != null)
			{
				if ("setPlainVariant" in helmet) { helmet.setPlainVariant(); }
				this.m.Items.equip(helmet);
			}
		}
	}
});
