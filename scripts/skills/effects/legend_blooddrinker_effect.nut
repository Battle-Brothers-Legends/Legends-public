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
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Item;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsWeaponSkill = true;
		this.m.IsHidden = true;
	}

	function onTargetKilled( _targetEntity, _skill ) {
		local actor = this.getContainer().getActor();
		if(_skill == null || ::Legends.S.isEntityNullOrDead(actor)){
			return;
		}

		if (_skill.isAttack() && _skill.getItem() != null && _skill.getItem().getID() == "weapon.legend_royal_executioner")
		{
			local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
			local healthAdded = ::Math.min(healthMissing, 0.01 * this.m.HealPct * actor.getHitpointsMax());

			if (healthAdded <= 0)
			{
				return;
			}

			actor.setHitpoints(actor.getHitpoints() + healthAdded);
			actor.setDirty(true);

			if (!actor.isHiddenToPlayer())
			{
				::Tactical.spawnIconEffect("status_effect_79", actor.getTile(), ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
				::Sound.play("sounds/enemies/unhold_regenerate_01.wav", ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
			}
		}
	}
});
