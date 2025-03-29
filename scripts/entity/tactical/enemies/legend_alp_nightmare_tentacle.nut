this.legend_alp_nightmare_tentacle <- this.inherit("scripts/entity/tactical/enemies/legend_alp_shadow", {
	m = {},
	function getMode()
	{
		return 1;
	}

	function create()
	{
		this.legend_alp_shadow.create();

		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/dlc2/tentacle_hurt_01.wav",
			"sounds/enemies/dlc2/tentacle_hurt_02.wav",
			"sounds/enemies/dlc2/tentacle_hurt_03.wav",
			"sounds/enemies/dlc2/tentacle_hurt_04.wav",
			"sounds/enemies/dlc2/tentacle_hurt_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Other1] = [
			"sounds/enemies/dlc2/krake_choke_01.wav",
			"sounds/enemies/dlc2/krake_choke_02.wav",
			"sounds/enemies/dlc2/krake_choke_03.wav",
			"sounds/enemies/dlc2/krake_choke_04.wav",
			"sounds/enemies/dlc2/krake_choke_05.wav"
		];

		this.m.Flags.set("type", "tentacle");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/kraken_tentacle_agent");
		this.m.AIAgent.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_alp_teleport"));
		this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Retreat);
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.legend_alp_shadow.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.KrakenTentacle);

		b.IsAffectedByNight = false;
		b.IsMovable = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;
		b.IsAffectedByRain = false;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 100)
		{
			b.MeleeSkill += 5;
			b.RangedSkill += 5;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.addSprite("socket").setBrush("bust_base_shadow");

		local blurAlpha = 110;
		local body_brush = "bust_alp_kraken_tentacle_0" + (this.Math.rand(1, 100) <= 33 ? 1 : 2);
		local body = this.addSprite("body");
		body.setBrush(body_brush);
		//body.Alpha = 0;
		//body.fadeToAlpha(blurAlpha, 750);
		local head = this.addSprite("head");
		head.setBrush(body_brush);
		//head.Alpha = 0;
		//head.fadeToAlpha(blurAlpha, 750);
		local blur_1 = this.addSprite("blur_1");
		blur_1.setBrush(body_brush);
		//blur_1.Alpha = 0;
		//blur_1.fadeToAlpha(blurAlpha, 750);
		local blur_2 = this.addSprite("blur_2");
		blur_2.setBrush("bust_ghost_fog_01");
		//blur_2.Alpha = 0;
		//blur_2.fadeToAlpha(blurAlpha, 750);

		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.68;
		this.setSpriteOffset("status_rooted", this.createVec(5, 25));
		this.setSpriteOffset("arrow", this.createVec(0, 25));
		this.setSpriteOffset("status_stunned", this.createVec(0, 25));
		::Legends.Actives.grant(this, ::Legends.Active.KrakenMove);
		::Legends.Actives.grant(this, ::Legends.Active.KrakenBite);
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);

		this.applySignatureAbilities();
	}

	function onFactionChanged()
	{
		this.legend_alp_shadow.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("blur_1").setHorizontalFlipping(flip);
		this.getSprite("blur_2").setHorizontalFlipping(flip);
	}


});

