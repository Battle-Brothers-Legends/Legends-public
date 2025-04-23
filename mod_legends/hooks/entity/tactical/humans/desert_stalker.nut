::mods_hookExactClass("entity/tactical/humans/desert_stalker", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
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
			[1, ::Legends.Armor.Southern.plated_nomad_mail]
		]));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head) && this.Math.rand(1, 100) <= 75)
		{
			local helm =this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Southern.desert_stalker_head_wrap]
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
				[1, ::Legends.Armor.Named.black_leather_armor]
			]));
		}

		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
	}
});
