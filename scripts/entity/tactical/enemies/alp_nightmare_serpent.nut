this.alp_nightmare_serpent <- this.inherit("scripts/entity/tactical/enemies/alp_shadow", {
	m = {},
	function create()
	{
		this.alp_shadow.create();

		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/dlc6/snake_hurt_01.wav",
			"sounds/enemies/dlc6/snake_hurt_02.wav",
			"sounds/enemies/dlc6/snake_hurt_03.wav",
			"sounds/enemies/dlc6/snake_hurt_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/dlc6/snake_idle_01.wav",
			"sounds/enemies/dlc6/snake_idle_02.wav",
			"sounds/enemies/dlc6/snake_idle_03.wav",
			"sounds/enemies/dlc6/snake_idle_04.wav",
			"sounds/enemies/dlc6/snake_idle_05.wav",
			"sounds/enemies/dlc6/snake_idle_06.wav",
			"sounds/enemies/dlc6/snake_idle_07.wav",
			"sounds/enemies/dlc6/snake_idle_08.wav",
			"sounds/enemies/dlc6/snake_idle_09.wav",
			"sounds/enemies/dlc6/snake_idle_10.wav",
			"sounds/enemies/dlc6/snake_idle_11.wav",
			"sounds/enemies/dlc6/snake_idle_12.wav",
			"sounds/enemies/dlc6/snake_idle_13.wav"
		];

		this.m.Flags.set("type", "serpent");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/serpent_agent");
		this.m.AIAgent.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_alp_teleport"));
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.alp_shadow.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Serpent);
		b.Initiative += this.Math.rand(40, 50);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
		{
			b.MeleeDefense += 5;

			if (this.World.getTime().Days >= 50)
				b.DamageDirectMult += 0.15;

			if (this.World.getTime().Days >= 75)
				b.MeleeSkill += 10;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.addSprite("socket").setBrush("bust_base_shadow");
		this.addSprite("fog").setBrush("bust_ghost_fog_02");
		
		local blurAlpha = 110;
		local body_brush = "bust_alp_snake_0" + this.Math.rand(1, 2);
		local body = this.addSprite("body");
		body.setBrush(body_brush);
		body.Alpha = 0;
		body.fadeToAlpha(blurAlpha, 750);
		local head = this.addSprite("head");
		head.setBrush(body_brush);
		head.Alpha = 0;
		head.fadeToAlpha(blurAlpha, 750);
		local blur_1 = this.addSprite("blur_1");
		blur_1.setBrush(body_brush);
		blur_1.Alpha = 0;
		blur_1.fadeToAlpha(blurAlpha, 750);
		local blur_2 = this.addSprite("blur_2");
		blur_2.setBrush(body_brush);
		blur_2.Alpha = 0;
		blur_2.fadeToAlpha(blurAlpha, 750);

		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(-10, 20));
		this.setSpriteOffset("status_stunned", this.createVec(-35, 20));
		this.setSpriteOffset("arrow", this.createVec(0, 20));
		this.m.Skills.add(this.new("scripts/skills/racial/serpent_racial"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/actives/alp_serpent_hook_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/serpent_bite_skill"));
		
		if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}			

		this.applySignatureAbilities();
	}

	function onFactionChanged()
	{
		this.alp_shadow.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("fog").setHorizontalFlipping(flip);
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("blur_1").setHorizontalFlipping(flip);
		this.getSprite("blur_2").setHorizontalFlipping(flip);
	}

});

