::mods_hookExactClass("entity/tactical/humans/councilman", function(o)
{
	o.assignRandomEquipment = function ()
	{
		local r;
		r = this.Math.rand(1, 11);
		local withDetail = true;
		local withHelmet = true;


		if (r <= 7)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.linen_tunic]
			]));

			if (this.Math.rand(1, 100) <= 33)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.feathered_hat]
				]));
				withHelmet = false;
			}
		}
		else if (r <= 9)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.noble_tunic]
			]));
		}
		else if (r == 10)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.monk_robe]
			]));
			withDetail = false;
			withHelmet = false;
		}
		else if (r == 11)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.wizard_robe]
			]));
			withDetail = false;

			if (this.Math.rand(1, 100) <= 50)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.wizard_hat]
				]));
				withHelmet = false;
			}
		}




		if (withDetail && this.Math.rand(1, 100) <= 66)
		{
			local variants = [
				"01",
				"06",
				"07",
				"08",
				"09"
			];
			this.getSprite("surcoat").setBrush("bust_body_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
		}

		if (withHelmet && this.Math.rand(1, 100) <= 25)
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
						[1, ::Legends.Helmet.Standard.feathered_hat]
					]))
			}
			else
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
						[1, ::Legends.Helmet.Standard.noble_headgear]
					]))
			}
		}
	}
});
