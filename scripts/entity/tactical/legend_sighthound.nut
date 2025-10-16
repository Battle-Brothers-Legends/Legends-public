this.legend_sighthound <- this.inherit("scripts/entity/tactical/wardog", {

	m = {
		Item = null
		Name = "Sighthound"
	}

	function create() {
		this.wardog.create();
		this.m.Type = this.Const.EntityType.LegendSighthound;
		this.m.XP = this.Const.Tactical.Actor.LegendSighthound.XP;
		this.m.SoundPitch = this.Math.rand(85, 105) * 0.01;
	}

	function setVariant(_variant) {
		this.m.Items.getAppearance().Body = "bust_dawg_01_body_0" + _variant;
		getSprite("body").setBrush("bust_dawg_01_body_0" + _variant);
		getSprite("head").setBrush("bust_dawg_01_head_0" + _variant);
		getSprite("closed_eyes").setBrush("bust_dawg_01_body_0" + _variant + "_eyes_closed");
		setDirty(true);
	}

	function onInit() {
		this.actor.onInit();

		// stats
		local b = m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendSighthound);
		b.TargetAttractionMult = 0.1;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;

		m.ActionPoints = b.ActionPoints;
		m.Hitpoints = b.Hitpoints;
		m.CurrentProperties = clone b;

		m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		m.FatigueCosts = this.Const.DefaultMovementFatigueCost;

		local variant = this.Math.rand(1, 2);

		// inventory
		this.m.Items.getAppearance().Body = "bust_dawg_01_body_0" + variant;

		// appearance
		addSprite("socket").setBrush("bust_base_player");

		local body = addSprite("body");
		body.setBrush("bust_dawg_01_body_0" + variant);

		local armor = addSprite("armor");

		local head = addSprite("head");
		head.setBrush("bust_dawg_01_head_0" + variant);

		local closed_eyes = addSprite("closed_eyes");
		closed_eyes.Visible = false;
		closed_eyes.setBrush("bust_dawg_01_body_0" + variant + "_eyes_closed");

		local injury = addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_dawg_01_injured");

		// add default status sprites
		addDefaultStatusSprites();

		getSprite("status_rooted").Scale = 0.46;
		setSpriteOffset("status_rooted", createVec(8, -15));

		setSpriteOffset("status_stunned", createVec(0, -25));
		setSpriteOffset("arrow", createVec(0, -25));

		// skills
		::Legends.Actives.grant(this, ::Legends.Active.LegendSighthoundBite);
		::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
		::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
	}

})
