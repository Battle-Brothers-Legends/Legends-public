this.legend_peasant_butcher <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendPeasantButcher;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendPeasantButcher.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_butcher_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantButcher);
		this.m.Hitpoints = b.Hitpoints;
		this.m.ActionPoints = b.ActionPoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_butcher_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_prepare_bleed_skill"));

		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lacerate"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_slaughter"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_butcher_damage"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}

	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
				this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[7, "butcher_apron"],
			[1, "leather_wraps"]
		]));


		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "headscarf"],
					[1, "hood"],
					[1, "headscarf"],
					[1, "feathered_hat"]
				]))
			}
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.m.Items.equip(this.new("scripts/items/weapons/named/legend_named_butchers_cleaver"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lacerate"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_slaughter"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_slaughterer"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_butcher_damage"));
		this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, "legend_champion_butcher_helmet"]
		]))
	}

});

