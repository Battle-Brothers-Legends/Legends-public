::mods_hookExactClass("entity/tactical/enemies/necromancer", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r = this.Math.rand(0, 4);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
		}

		local item = this.Const.World.Common.pickArmor([
			[1, "ragged_dark_surcoat"],
			[1, "thick_dark_tunic"]
		]);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[1, "witchhunter_hat"],
			[1, "dark_cowl"],
			[1, "hood", 63]
		]);
		this.m.Items.equip(item);
	}

	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_dagger"
		];

		local item = this.Const.World.Common.pickHelmet([
			[1, "named/witchhunter_helm"],
		]);
		this.m.Items.equip(item);

		if (this.Const.DLC.Desert)
		{
			weapons.extend([
				"weapons/named/named_dagger",
				"weapons/named/named_qatal_dagger"
			]);
		}

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		this.m.ActionPoints = 9;
		this.m.BaseProperties.ActionPoints = 9;
		this.m.Skills.update();
		return true;
	}
});
