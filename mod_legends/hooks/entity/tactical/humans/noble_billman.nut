::mods_hookExactClass("entity/tactical/humans/noble_billman", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		this.m.Skills.removeByID("actives.rotation");

		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 2;
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendFeint);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendFullForce);
			::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		local banner = 3;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;

		if (this.Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		local weapons = [
			"weapons/billhook",
			"weapons/pike",
			"weapons/legend_battle_glaive",
			"weapons/polehammer"
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "seedmaster_noble_armor"],
			[1, "citreneking_noble_armor"],
		]));

		if (this.Math.rand(1, 100) <= 33)
		{
			local helmet;

			if (banner <= 4)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, "kettle_hat"],
					[1, "rondel_helm"],
					[1, "scale_helm"],
					[1, "padded_kettle_hat"],
					[1, "kettle_hat_with_mail"],
					[1, "mail_coif"],
					[2, "legend_enclave_vanilla_skullcap_01"],
					[5, "heavy_noble_house_helmet_00"]
				])
			}
			else if (banner <= 7)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, "flat_top_helmet"],
					[1, "padded_flat_top_helmet"],
					[1, "rondel_helm"],
					[1, "scale_helm"],
					[1, "flat_top_with_mail"],
					[1, "mail_coif"],
					[1, "legend_enclave_vanilla_skullcap_01"],
					[5, "heavy_noble_house_helmet_00"]
				])
			}
			else
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, "nasal_helmet"],
					[1, "padded_nasal_helmet"],
					[1, "nasal_helmet_with_mail"],
					[1, "rondel_helm"],
					[1, "scale_helm"],
					[1, "mail_coif"],
					[2, "legend_enclave_vanilla_skullcap_01"],
					[5, "heavy_noble_house_helmet_00"]

				])
			}

			if (helmet != null)
			{
				if ("setPlainVariant" in helmet) { helmet.setPlainVariant(); }
				this.m.Items.equip(helmet);
			}
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "full_aketon_cap"],
				[2, "aketon_cap"],
				[1, ""],
				[1, "headscarf"]
			]))
		}
	}
});
