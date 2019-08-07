this.bandit_rabble <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.BanditRabble;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditRabble.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_bandit_rabble_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditRabble);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 10)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_pox_01");
		}
		else if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			b.MeleeDefense += 5;
		}

		this.getSprite("armor").Saturation = 0.8;
		this.getSprite("helmet").Saturation = 0.8;
		this.getSprite("helmet_damage").Saturation = 0.8;
		this.getSprite("shield_icon").Saturation = 0.8;
		this.getSprite("shield_icon").setBrightness(0.9);
		this.m.Skills.add(this.new("scripts/skills/racial/legend_rabble_racial"));
			 if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Easy)
			{
			this.m.Skills.add(this.new("scripts/skills/traits/craven_trait"));
			}

			 if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Hard)
			{
			this.m.Skills.add(this.new("scripts/skills/traits/brave_trait"));
			}

			 if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));
			this.m.Skills.add(this.new("scripts/skills/traits/brave_trait"));
			}

	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		local r = this.Math.rand(1, 11);

		if (r == 1)
		{
		this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_pitchfork"));
		 if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
			}

		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));
			if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_spearwall"));
				}

		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_sickle"));
				if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
				}
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_staff"));
				if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_staff_skill"));
				}
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_shovel"));
				if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
				}
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
				if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
				}
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));
				if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
				}
		}
		else if (r == 8)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_shiv"));
					if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
				}
		}
		else if (r == 9)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/lute"));
				if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
				}
		}
		else if (r == 10)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
				if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
				}
		}
		else if (r == 11)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_hoe"));
				if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
				}
		}

	
		
		if (this.Math.rand(1, 100) <= 90)
		{
			r = this.Math.rand(0, 4);

			if (r <= 0)
			{
				this.m.Items.equip(this.new("scripts/items/armor/leather_wraps"));
			}
			else if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/legend_rabble_tunic"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/monk_robe"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/legend_rabble_fur"));
			}

		}
		if (this.Math.rand(1, 100) <= 50)
		{
			local r = this.Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/mouth_piece"));
			}
			

		}
	}

});
