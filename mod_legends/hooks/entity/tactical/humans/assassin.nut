::mods_hookExactClass("entity/tactical/humans/assassin", function(o) 
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.removeByID("effects.dodge");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
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
				[1, "oriental/assassin_robe"]
		]));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "oriental/assassin_head_wrap"],
				[1, "oriental/assassin_face_mask"]
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_escape_artist"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		return true;
	}
});