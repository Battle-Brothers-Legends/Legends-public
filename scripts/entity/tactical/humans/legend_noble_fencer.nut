this.legend_noble_fencer <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendFencer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendFencer.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_fencer_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendFencer);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_feint"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		if(::Legends.isLegendaryDifficulty())
			{
			this.m.Hitpoints = b.Hitpoints * 2;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			}
	}

	function assignRandomEquipment()
	{
		local r;
		local banner = 3;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;

		if (this.Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}


		r = this.Math.rand(0, 2);

		if (r <= 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_estoc"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/fencing_sword"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "seedmaster_noble_armor"],
			[1, "citreneking_noble_armor"],
		]));

		if (this.Math.rand(1, 100) <= 33)
		{
			local helmet;

			if (banner <= 4)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, "kettle_hat"],
					[1, "padded_kettle_hat"],
					[1, "kettle_hat_with_mail"],
					[1, "mail_coif"]
				])
			}
			else if (banner <= 7)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, "flat_top_helmet"],
					[1, "padded_flat_top_helmet"],
					[1, "flat_top_with_mail"],
					[1, "mail_coif"]
				])
			}
			else
			{
				helmet = this.Const.World.Common.pickHelmet([
					[1, "nasal_helmet"],
					[1, "padded_nasal_helmet"],
					[1, "nasal_helmet_with_mail"],
					[1, "mail_coif"]
				])
			}

			if (helmet != null)
			{
				if ("setPlainVariant" in helmet) { helmet.setPlainVariant(); }
				this.m.Items.equip(helmet);
			}
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "aketon_cap"],
				[1, "full_aketon_cap"],
				[1, "headscarf"],
				[1, ""]
			]))
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_fencing_sword",
			"weapons/named/legend_named_estoc"
		];

		local armor = [
			"armor/named/black_leather_armor",
			"armor/named/named_noble_mail_armor",
			"armor/named/blue_studded_mail_armor"
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		return true;
	}

});

