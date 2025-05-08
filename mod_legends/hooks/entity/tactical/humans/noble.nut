::mods_hookExactClass("entity/tactical/humans/noble", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		this.m.Surcoat = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		local surcoat = "surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat);
		r = this.Math.rand(1, 7);
		local withDetails = true;
		local alwaysWithDetails = false;
		local withHelmet = true;

		if (r == 1)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.noble_tunic]
			]));
			alwaysWithDetails = true;
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.coat_of_plates]
			]));
			withDetails = false;
			withHelmet = false;

			if (this.Math.rand(1, 100) <= 75)
			{
				this.getSprite("surcoat").setBrush(surcoat);
			}

			if (this.Math.rand(1, 100) <= 25)
			{
				local h = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.greatsword_faction_helm, this.World.FactionManager.getFaction(this.getFaction()).getBanner()]
				]);
				this.m.Items.equip(h);
			}

			if (this.Math.rand(1, 100) <= 33)
			{
				local variants = [
					"02",
					"10"
				];
				this.getSprite("surcoat").setBrush("bust_body_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
			}
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.coat_of_scales]
			]));
			withDetails = false;
			withHelmet = false;

			if (this.Math.rand(1, 100) <= 75)
			{
				this.getSprite("surcoat").setBrush(surcoat);
			}

			if (this.Math.rand(1, 100) <= 25)
			{
				local h = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.greatsword_faction_helm, this.World.FactionManager.getFaction(this.getFaction()).getBanner()]
				]);
				this.m.Items.equip(h);
			}

			if (this.Math.rand(1, 100) <= 33)
			{
				local variants = [
					"02",
					"10"
				];
				this.getSprite("surcoat").setBrush("bust_body_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
			}
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.noble_gear]
			]));
		}

		if (withDetails && (alwaysWithDetails || this.Math.rand(1, 100) <= 50))
		{
			local variants = [
				"01",
				"02",
				"03",
				"06",
				"09",
				"10"
			];
			this.getSprite("surcoat").setBrush("bust_body_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
		}

		if (withHelmet && this.Math.rand(1, 100) <= 50)
		{
			this.Const.World.Common.pickHelmet([
					//[1, "legend_helmet_noble_floppy_hat"],
					//[1, "legend_helmet_noble_hat"],
					//[1, "legend_helmet_noble_hood"],
					[1, ""]
			])
		}
	}
});
