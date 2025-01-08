::mods_hookExactClass("entity/tactical/humans/swordmaster", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_hedge_knight_less_flanking_less_zoc");
		this.m.AIAgent.setActor(this);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));

		if (::Legends.isLegendaryDifficulty())
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_feint"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_return_favor"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/noble_sword",
				"weapons/arming_sword",
				"weapons/legend_estoc"
			];

			if (this.Const.DLC.Wildmen || this.Const.DLC.Desert)
			{
				weapons.extend([
					"weapons/shamshir"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				// [1, "mail_shirt"],
				// [1, "mail_hauberk"],
				// [1, "basic_mail_shirt"],
				[1, "footman_armor"],
				[1, "leather_scale_armor"],
				[1, "light_scale_armor"]
			]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head) && this.Math.rand(1, 100) <= 90)
		{

			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[3, "nasal_helmet"],
				[2, "nasal_helmet_with_mail"],
				[2, "mail_coif"],
				[1, "feathered_hat"],
				[1, "headscarf"]
			]))

		}
	}

	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_sword",
			"weapons/named/legend_named_estoc"
		];

		if (this.Const.DLC.Wildmen || this.Const.DLC.Desert)
		{
			weapons.extend([
				"weapons/named/named_sword",
				"weapons/named/named_shamshir"
			]);
		}

		local armor = [
			"armor/named/black_leather_armor",
			"armor/named/blue_studded_mail_armor"
		];

		if (this.Const.DLC.Wildmen)
		{
			armor.extend([
				"armor/named/named_noble_mail_armor"
			]);
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor(
				this.Const.World.Common.convNameToList(
					armor
				)
			));
		}

		this.m.BaseProperties.DamageDirectMult *= 1.25;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		return true;
	}
});
