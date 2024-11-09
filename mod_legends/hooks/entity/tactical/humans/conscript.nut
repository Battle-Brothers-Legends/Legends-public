::mods_hookExactClass("entity/tactical/humans/conscript", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		local banner;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = 13;
		}

		r = this.Math.rand(1, 5);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/saif"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/scimitar"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/firelance"));
		}

		if (this.Math.rand(1, 100) <= 90)
		{
			this.m.Items.equip(this.new("scripts/items/shields/oriental/southern_light_shield"));
		}


		local variant;
		if (banner == 12)
			variant = 9;
		else if (banner == 13)
			variant = 10;
		else
			variant = 8
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[2, "oriental/linothorax", variant],
			[1, "oriental/southern_mail_shirt"]
		]));

		local variant = 7;
		if (banner == 12)
			variant = 12;
		else if (banner == 13)
			variant = 8;
		else if (banner == 14)
			variant = 7;

		local helm =this.Const.World.Common.pickHelmet([
			[1, "oriental/southern_head_wrap", variant],
			[1, "oriental/wrapped_southern_helmet"],
			[1, "oriental/spiked_skull_cap_with_mail"]
		]);

		this.m.Items.equip(helm);

	}
});
