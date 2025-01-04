this.legend_alp_nightmare_human <- this.inherit("scripts/entity/tactical/enemies/legend_alp_shadow", {
	m = {},
	function create()
	{
		this.legend_alp_shadow.create();

		local voice = this.Math.rand(0, this.Const.HumanSounds.len() - 1);
		this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.Const.HumanSounds[voice].NoDamageReceived;
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = this.Const.HumanSounds[voice].DamageReceived;
		this.m.SoundPitch = this.Math.rand(125, 135) * 0.01;

		// volumn
		this.m.SoundVolume[this.Const.Sound.ActorEvent.NoDamageReceived] = 1.2;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 1.15;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 1.25;

		this.m.Flags.set("type", "human");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_alp_teleport"));
		this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Retreat);
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.legend_alp_shadow.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.World.getTime().Days >= 100
			? this.Const.Tactical.Actor.BanditVeteran
			: this.Const.Tactical.Actor.BanditRaider);

		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 50)
		{
			b.MeleeSkill += 5;
			b.RangedSkill += 5;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.addSprite("socket").setBrush("bust_base_shadow");

		local blurAlpha = 110;
		local body_brush = "bust_alp_human_body_0" + this.Math.rand(1, 2);
		local head_brush = "bust_alp_human_head_0" + this.Math.rand(1, 3);
		local body = this.addSprite("body");
		body.setBrush(body_brush);
		//body.Alpha = 0;
		//body.fadeToAlpha(blurAlpha, 750);
		local head = this.addSprite("head");
		head.setBrush(head_brush);
		//head.Alpha = 0;
		//head.fadeToAlpha(blurAlpha, 750);
		local blur_1 = this.addSprite("blur_1");
		blur_1.setBrush(body_brush);
		//blur_1.Alpha = 0;
		//blur_1.fadeToAlpha(blurAlpha, 750);
		local blur_2 = this.addSprite("blur_2");
		blur_2.setBrush(head_brush);
		//blur_2.Alpha = 0;
		//blur_2.fadeToAlpha(blurAlpha, 750);

		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(0, 5));
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		}

		this.applySignatureAbilities();
	}

	function onFactionChanged()
	{
		this.legend_alp_shadow.onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("blur_1").setHorizontalFlipping(flip);
		this.getSprite("blur_2").setHorizontalFlipping(flip);
	}

	function assignRandomEquipment()
	{
		local r;

		if (this.Math.rand(1, 100) <= 20)
		{
			if (this.Const.DLC.Unhold)
			{
				r = this.Math.rand(0, 10);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));

					if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));

					if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/pike"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));

					if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloody_harvest"));

					if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_forceful_swing"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/longaxe"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));

					if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));

					if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
				}
				else if (r == 6)
				{
					local weapons = [
						"weapons/two_handed_wooden_flail",
						"weapons/legend_reinforced_flail",
					];

					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));

					if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
				}
				else if (r == 7)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/two_handed_mace"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));

					if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
				}
				else if (r == 8)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_vengeance"));

					if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_feint"));
				}
				else if (r == 9)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/legend_longsword"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_forceful_swing"));

					if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloody_harvest"));
				}
				else if (r == 10)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/legend_two_handed_club"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));

					if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
				}
			}
			else
			{
				r = this.Math.rand(0, 4);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/pike"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/longaxe"));
				}
			}
		}
		else
		{
			r = this.Math.rand(2, 11);

			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_feint"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
					this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_spearthrust"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
					this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
					this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_feint"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
					this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/flail"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
					this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
			}
			else if (r == 9)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
					this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
			}
			else if (r == 10)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
			}
			else if (r == 11)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_glaive"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
					this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
			}

			if (this.Math.rand(1, 100) <= 75)
			{
				if (this.Math.rand(1, 100) <= 75)
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				else
					this.m.Items.equip(this.new("scripts/items/shields/legend_tower_shield"));
			}
		}

		// stop the items from dropping
		foreach (item in this.getItems().getAllItems())
		{
			item.m.IsDroppedAsLoot = false;
		}
	}

});

