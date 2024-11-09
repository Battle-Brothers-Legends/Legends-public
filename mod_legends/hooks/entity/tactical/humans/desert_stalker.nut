::mods_hookExactClass("entity/tactical/humans/desert_stalker", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}

		local weapons = [
			"weapons/dagger",
			"weapons/oriental/nomad_mace",
			"weapons/oriental/qatal_dagger"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "oriental/plated_nomad_mail"]
		]));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head) && this.Math.rand(1, 100) <= 75)
		{
			local helm =this.Const.World.Common.pickHelmet([
				[1, "oriental/desert_stalker_head_wrap"]
			]);
			this.m.Items.equip(helm);
		}
	}

	o.makeMiniboss = function ()
	{
		this.actor.makeMiniboss();
		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			[
				"weapons/named/named_warbow",
				"ammo/quiver_of_arrows"
			]
		];
		local armor = [
			"armor/named/black_leather_armor"
		];

		if (this.Math.rand(1, 100) <= 70)
		{
			local r = this.Math.rand(0, weapons.len() - 1);

			foreach( w in weapons[r] )
			{
				this.m.Items.equip(this.new("scripts/items/" + w));
			}
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "named/black_leather_armor"]
			]));
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
	}
});
