::mods_hookExactClass("entity/tactical/humans/vizier", function(o)
{
	o.assignRandomEquipment = function ()
	{
		local r;
		r = this.Math.rand(1, 8);
		local withDetails = true;
		local alwaysWithDetails = false;
		local withHelmet = true;

		this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Southern.padded_mail_and_lamellar_hauberk],
				[1, ::Legends.Armor.Southern.mail_and_lamellar_plating],
				[1, ::Legends.Armor.Southern.vizier_gear]
		]));

		if (withDetails && (alwaysWithDetails || this.Math.rand(1, 100) <= 50))
		{
			local variants = [
				"03",
				"04"
			];
			this.getSprite("surcoat").setBrush("bust_desert_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
		}

		if (withHelmet && this.Math.rand(1, 100) <= 80)
		{
			local helmet = [
				[5, ::Legends.Helmet.Southern.vizier_headgear],
				[1, ::Legends.Helmet.Standard.legend_noble_southern_crown],
				[1, ::Legends.Helmet.Standard.legend_noble_southern_hat]
			];
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
		}
	}
});
