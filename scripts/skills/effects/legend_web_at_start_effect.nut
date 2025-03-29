this.legend_web_at_start_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendWebAtStart);
		this.m.Description = "This effect is meant to be used under the hood so that entities can start combat webbed.";
		this.m.Icon = "skills/status_effect_80.png";
		this.m.IconMini = "status_effect_80_mini";
		this.m.Overlay = "status_effect_80";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		]
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		::Legends.Effects.grant(actor, ::Legends.Effect.Web);
		local breakFree = this.new("scripts/skills/actives/break_free_skill");
		breakFree.setDecal("web_destroyed");
		breakFree.m.Icon = "skills/active_113.png";
		breakFree.m.IconDisabled = "skills/active_113_sw.png";
		breakFree.m.Overlay = "active_113";
		breakFree.m.SoundOnUse = [
			"sounds/combat/break_free_net_01.wav",
			"sounds/combat/break_free_net_02.wav",
			"sounds/combat/break_free_net_03.wav"
		];
		actor.getSkills().add(breakFree);
		local effect = this.Tactical.spawnSpriteEffect("bust_web2", this.createColor("#ffffff"), actor.getTile(), 0, 4, 1.0, actor.getSprite("status_rooted").Scale, 100, 100, 0);
		local flip = !actor.isAlliedWithPlayer();
		effect.setHorizontalFlipping(flip);
		local rooted = actor.getSprite("status_rooted");
		rooted.setBrush("bust_web2");
		rooted.Visible = true;
		local rooted_back = actor.getSprite("status_rooted_back");
		rooted_back.setBrush("bust_web2_back");
		rooted_back.Visible = true;
		actor.setDirty(true);
	}
});

