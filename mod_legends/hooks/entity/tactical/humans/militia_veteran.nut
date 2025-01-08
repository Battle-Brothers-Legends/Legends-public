::mods_hookExactClass("entity/tactical/humans/militia_veteran", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_militia_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_spear"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_militia_damage"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_spearwall"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_spearthrust"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_skill"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_push"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/hooked_blade",
				"weapons/pike",
				"weapons/woodcutters_axe",
				"weapons/bludgeon",
				"weapons/hand_axe",
				"weapons/militia_spear",
				"weapons/boar_spear",
				"weapons/falchion",
				"weapons/shortsword",
				"weapons/legend_militia_glaive",
				"weapons/legend_glaive",
				"weapons/legend_infantry_axe",
				"weapons/legend_military_goedendag",
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.extend([
					"weapons/goedendag"
				]);
			}

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/warfork"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_tunic"],
			[1, "gambeson"],
			[1, "padded_leather"],
			[1, "padded_surcoat"],
			[1, "leather_lamellar"],
			[1, "thick_tunic"]
		]));

		if (this.Math.rand(1, 100) <= 75)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "hood"],
				[1, "aketon_cap"],
				[1, "full_leather_cap"]
			]))
		}
	}
});
