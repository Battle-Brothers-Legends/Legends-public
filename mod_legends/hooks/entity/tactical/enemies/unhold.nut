::mods_hookExactClass("entity/tactical/enemies/unhold", function(o) {
	local onFactionChanged = o.onFactionChanged;
	o.onFactionChanged = function()
	{
		onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			if (!this.hasSprite(a))
				continue;

			this.getSprite(a).setHorizontalFlipping(flip);
		}
	}

	o.onInit = function()
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
		if (this.Math.rand(1, 100) < 5)
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
		if (this.Math.rand(1, 100) < 3)
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
		if (::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = 2 * b.Hitpoints;
			b.MeleeSkill += 10;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBattleheart);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function()
	{
	}
});
