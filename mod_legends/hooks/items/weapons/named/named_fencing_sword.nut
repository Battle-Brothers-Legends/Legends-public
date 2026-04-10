::mods_hookExactClass("items/weapons/named/named_fencing_sword", function(o) {

	o.m.PossibleEffects <- ["scripts/skills/effects/legend_named_fencing_sword_effect"];
	o.m.EffectBounds <- [ [4, 12] ];

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.Variants = [1, 2, 3];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.randomizeValues <- function ()
	{
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;

		named_weapon.randomizeValues();
	}

	o.getTooltip <- function ()
	{
		local result = this.named_weapon.getTooltip();
		if (this.m.PossibleEffectIdx == 0)
		{
			result.push({
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%positive%]+" + this.m.EffectChanceOrBonus+ "%[/color] Initiative"
			});
		}
		return result;
	}

	local onEquip = o.onEquip;
	o.onEquip = function()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Riposte);
	}
});
