::mods_hookExactClass("entity/tactical/humans/assassin", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Effects.remove(this, ::Legends.Effect.Dodge);
		::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/qatal_dagger"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/shamshir"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_katar"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Southern.assassin_robe]
		]));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Southern.assassin_head_wrap],
				[1, ::Legends.Helmet.Southern.assassin_face_mask]
		]));
	}

	o.makeMiniboss <- function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_shamshir",
			"weapons/named/named_dagger",
			"weapons/named/named_qatal_dagger"
		];

		local armor = [
			[1, "armor/named/black_leather_armor"] //will need more in future
		];

		if (this.Math.rand(1, 100) <= 70)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		}

		this.m.BaseProperties.DamageDirectMult *= 1.25;
		::Legends.Perks.grant(this, ::Legends.Perk.LegendEscapeArtist);
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		return true;
	}
});
