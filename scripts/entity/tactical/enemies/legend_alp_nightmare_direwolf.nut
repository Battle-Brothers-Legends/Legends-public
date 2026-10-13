this.legend_alp_nightmare_direwolf <- this.inherit("scripts/entity/tactical/enemies/legend_alp_shadow", {
	m = {},

	function create() {
		this.legend_alp_shadow.create();

		this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = ::Legends.S.setSounds("sounds/enemies/werewolf_hurt", 4);
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = ::Legends.S.setSounds("sounds/enemies/werewolf_idle", 21);
		this.m.Sound[::Const.Sound.ActorEvent.Attack] = [
			"sounds/enemies/werewolf_idle_01.wav",
			"sounds/enemies/werewolf_idle_02.wav",
			"sounds/enemies/werewolf_idle_03.wav",
			"sounds/enemies/werewolf_idle_05.wav",
			"sounds/enemies/werewolf_idle_06.wav",
			"sounds/enemies/werewolf_idle_07.wav",
			"sounds/enemies/werewolf_idle_08.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Move] = ::Legends.S.setSounds("sounds/enemies/werewolf_fatigue", 7);

		this.m.Flags.set("type", "direwolf");
		this.m.SoundVolume[::Const.Sound.ActorEvent.Attack] = 0.8;
		this.m.SoundVolume[::Const.Sound.ActorEvent.Move] = 0.7;
		this.m.SoundPitch = ::Math.rand(95, 105) * 0.01;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/direwolf_agent");
		this.m.AIAgent.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_alp_teleport"));
		this.m.AIAgent.removeBehavior(::Const.AI.Behavior.ID.Retreat);
		this.m.AIAgent.setActor(this);
	}

	function playAttackSound() {
		if (::Math.rand(1, 100) <= 50) {
			this.playSound(::Const.Sound.ActorEvent.Attack, ::Const.Sound.Volume.Actor * this.m.SoundVolume[::Const.Sound.ActorEvent.Attack] * (::Math.rand(75, 100) * 0.01), this.m.SoundPitch * 1.15);
		}
	}

	function onInit() {
		this.legend_alp_shadow.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.FrenziedDirewolf);

		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.DamageTotalMult = 1.25;

		if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= ::Const.World.Scaling.Beasts.LegendsAlpNightmareScaleDay2) {
			b.MeleeSkill += 5;
			b.MeleeDefense += 5;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.addSprite("socket").setBrush("bust_base_shadow");

		local blurAlpha = 110;
		local body_brush = "bust_alp_direwolf_0" + ::Math.rand(1, 3) + "_body";
		local head_brush = "bust_alp_direwolf_0" + ::Math.rand(1, 3) + "_head";
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
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));
		::Legends.Actives.grant(this, ::Legends.Active.WerewolfBite);
		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);

		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		}

		this.applySignatureAbilities();
	}

	function onFactionChanged() {
		this.legend_alp_shadow.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("blur_1").setHorizontalFlipping(flip);
		this.getSprite("blur_2").setHorizontalFlipping(flip);
	}

});
