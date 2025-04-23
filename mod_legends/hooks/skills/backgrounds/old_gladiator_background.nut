::mods_hookExactClass("skills/backgrounds/old_gladiator_background", function(o)
{
	o.create = function ()
	{
		this.gladiator_background.create();
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Level = 3;
	}

	o.onSetAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");
		local body = actor.getSprite("body");
		tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		tattoo_body.Visible = true;
		tattoo_head.setBrush("scar_02_head");
		tattoo_head.Visible = true;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local a = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.gladiator_harness]
		]);

		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));
		}
		else if (r == 2)
		{
			a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"));
		}
		items.equip(a);
	}
});
