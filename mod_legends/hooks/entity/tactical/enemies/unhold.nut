::mods_hookExactClass("entity/tactical/enemies/unhold", function(o) 
{
	o.onFactionChanged = function ()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);
		this.getSprite("armor").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).setHorizontalFlipping(flip);
		}
	}

	o.onInit = function ()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Unhold);
		b.IsImmuneToDisarm = true;
		b.IsImmuneToRotation = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 90)
		{
			b.DamageTotalMult += 0.1;
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 190)
		{
			b.DamageTotalMult += 0.2;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_unhold_body_02";
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		if(this.Math.rand(1, 100) < 5)
		{
		body.setBrush("bust_unhold_body_04");
		}
		else
		{
		body.setBrush("bust_unhold_body_02");
		}
		body.varySaturation(0.1);
		body.varyColor(0.09, 0.09, 0.09);
		local injury_body = this.addSprite("injury");
		injury_body.Visible = false;
		injury_body.setBrush("bust_unhold_02_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		if(this.Math.rand(1, 100) < 3)
		{
		head.setBrush("bust_unhold_head_04");
		}
		else
		{
		head.setBrush("bust_unhold_head_02");
		}
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			this.addSprite(a)
		}
		this.addSprite("accessory");
		this.addSprite("accessory_special");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(-10, 16));
		this.setSpriteOffset("status_stunned", this.createVec(0, 10));
		this.setSpriteOffset("arrow", this.createVec(0, 10));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/racial/unhold_racial"));
		this.m.Skills.add(this.new("scripts/skills/actives/sweep_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/sweep_zoc_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/fling_back_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/unstoppable_charge_skill"));
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = 2 * b.Hitpoints;
			b.MeleeSkill += 10;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_last_stand"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function ()
	{
		local armor = [
			[1, "ancient/ancient_lich_attire"]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);
		local helmet = [
			[1, "ancient/ancient_lich_headpiece"]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}
});