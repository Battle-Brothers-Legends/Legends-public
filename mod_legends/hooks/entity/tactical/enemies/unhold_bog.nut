::mods_hookExactClass("entity/tactical/enemies/unhold_bog", function(o)
{
	o.onInit = function ()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.UnholdBog);
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
		this.m.Items.getAppearance().Body = "bust_unhold_body_03";
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_unhold_body_03");
		body.varySaturation(0.1);
		body.varyColor(0.09, 0.09, 0.09);
		local injury_body = this.addSprite("injury");
		injury_body.Visible = false;
		injury_body.setBrush("bust_unhold_03_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		if(this.Math.rand(1, 100) < 2)
		{
		head.setBrush("bust_unhold_head_05");
		}
		else
		{
		head.setBrush("bust_unhold_head_03");
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
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
		::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		::Legends.Perks.grant(this, ::Legends.Perk.BatteringRam);
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		::Legends.Traits.grant(this, ::Legends.Trait.RacialUnhold);
		::Legends.Actives.grant(this, ::Legends.Active.Sweep);
		::Legends.Actives.grant(this, ::Legends.Active.SweepZoc);
		::Legends.Actives.grant(this, ::Legends.Active.FlingBack);
		::Legends.Actives.grant(this, ::Legends.Active.UnstoppableCharge);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBattleheart);
			::Legends.Traits.grant(this, ::Legends.Trait.RacialLegendBogUnhold);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
			this.m.Hitpoints = 2 * b.Hitpoints;
		}

	}
});
