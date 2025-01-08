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
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CripplingStrikes);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Pathfinder);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.SteelBrow);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.KillingFrenzy);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.BatteringRam);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Stalwart);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.HoldOut);
		this.m.Skills.add(this.new("scripts/skills/racial/unhold_racial"));
		this.m.Skills.add(this.new("scripts/skills/actives/sweep_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/sweep_zoc_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/fling_back_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/unstoppable_charge_skill"));
		if(::Legends.isLegendaryDifficulty())
		{
			b.MeleeSkill += 10;
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBattleheart);
			this.m.Hitpoints = 2 * b.Hitpoints;
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}

	}

	o.onFactionChanged = function()
	{
	}
});
