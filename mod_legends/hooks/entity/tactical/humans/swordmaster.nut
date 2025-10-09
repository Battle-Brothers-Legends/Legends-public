::mods_hookExactClass("entity/tactical/humans/swordmaster", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_hedge_knight_less_flanking_less_zoc");
		this.m.AIAgent.setActor(this);
		this.m.OnDeathLootTable.extend([
			[1.5, "scripts/items/misc/legend_masterwork_fabric"],
			[1.0, "scripts/items/misc/legend_masterwork_metal"],
			[1.5, "scripts/items/misc/legend_masterwork_tools"]
		]);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Effects.grant(this, ::Legends.Effect.LegendFreedomOfMovement);
			::Legends.Effects.grant(this, ::Legends.Effect.LegendFlourish, function(_skill) {
				_skill.m.IsRemoved = false;
			});
			::Legends.Perks.remove(this, ::Legends.Perk.Dodge); // balancing ig
			::Legends.Perks.grant(this, ::Legends.Perk.LegendFeint);
			::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
			::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendReturnFavor);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
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
				// [1, ::Legends.Armor.Standard.mail_shirt],
				// [1, ::Legends.Armor.Standard.mail_hauberk],
				// [1, ::Legends.Armor.Standard.basic_mail_shirt],
				[1, ::Legends.Armor.Standard.footman_armor],
				[1, ::Legends.Armor.Standard.leather_scale_armor],
				[1, ::Legends.Armor.Standard.light_scale_armor]
			]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head) && this.Math.rand(1, 100) <= 90)
		{

			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[3, ::Legends.Helmet.Standard.nasal_helmet],
				[2, ::Legends.Helmet.Standard.nasal_helmet_with_mail],
				[2, ::Legends.Helmet.Standard.mail_coif],
				[1, ::Legends.Helmet.Standard.feathered_hat],
				[1, ::Legends.Helmet.Standard.headscarf]
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
			"weapons/named/legend_named_estoc",
			"weapons/named/named_sword",
			"weapons/named/named_shamshir"
		];

		local armor = [
			"armor/named/black_leather_armor",
			"armor/named/blue_studded_mail_armor",
			"armor/named/named_noble_mail_armor"
		];

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
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		return true;
	}
});
