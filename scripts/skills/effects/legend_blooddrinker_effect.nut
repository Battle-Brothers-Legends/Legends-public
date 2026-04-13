this.legend_blooddrinker_effect <- this.inherit("scripts/skills/skill", {
	m = {
		HealPct = 10
	},
	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBlooddrinker);
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "skills/placeholder_circle.png";
		this.m.IconMini = "mini_placeholder_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Item;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsWeaponSkill = true;
		this.m.IsHidden = true;
	}

	function onTargetKilled( _targetEntity, _skill ) {
		if (_skill.isAttack() && _skill.getItem() != null && _skill.getItem().getID() == "legend.legend_royal_executioner")
		{
			local actor = this.getContainer().getActor();
			local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
			local healthAdded = this.Math.min(healthMissing, 0.01 * HealPct * actor.getHitpointsMax());

			if (healthAdded <= 0)
			{
				return;
			}

			actor.setHitpoints(actor.getHitpoints() + healthAdded);
			actor.setDirty(true);

			if (!actor.isHiddenToPlayer())
			{
				this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
				this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
			}
		}
	}
});
