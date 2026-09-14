::mods_hookExactClass("entity/tactical/humans/conscript_polearm", function(o)
{
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
			banner = 13;
		}

		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/polemace"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/swordlance"));
		}

		local variant;
		if (banner == 12)
			variant = 9;
		else if (banner == 13)
			variant = 10;
		else
			variant = 8;
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Southern.linothorax, variant],
			[1, ::Legends.Armor.Southern.southern_mail_shirt]
		]));

		local variant = 7;
		if (banner == 12)
			variant = 12;
		else if (banner == 13)
			variant = 8;
		else if (banner == 14)
			variant = 7;

		local helm =this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.southern_head_wrap, variant]
		]);

		this.m.Items.equip(helm);
	}
});
