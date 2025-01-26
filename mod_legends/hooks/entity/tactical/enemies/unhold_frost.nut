::mods_hookExactClass("entity/tactical/enemies/unhold_frost", function(o) 
{
	o.onInit = function ()
	{
		this.unhold.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.UnholdFrost);
		b.DamageTotalMult += 0.15;
		b.IsImmuneToDisarm = true;
		b.IsImmuneToRotation = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 90)
		{
			b.DamageTotalMult += 0.1;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_unhold_body_01";
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_unhold_body_01");
		body.varySaturation(0.1);
		body.varyColor(0.04, 0.04, 0.04);
		local injury_body = this.addSprite("injury");
		injury_body.Visible = false;
		injury_body.setBrush("bust_unhold_01_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		if(this.Math.rand(1, 100) < 1)
		{
		head.setBrush("bust_unhold_head_06");
		}
		else
		{
		head.setBrush("bust_unhold_head_01");
		}
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			this.addSprite(a)
		}
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(-10, 16));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
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
			b.MeleeSkill += 10;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));
			this.m.Hitpoints = 2 * b.Hitpoints;
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}

	}

	o.onFactionChanged = function()
	{
		this.unhold.onFactionChanged();
	}
});