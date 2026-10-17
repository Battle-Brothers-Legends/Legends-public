this.legend_skin_ghoul_blood_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 4
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSkinGhoulBlood);
		this.m.Description = "Having consumed the blood of a skin ghoul, %their% flesh is knitting together internally.";
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.DrugEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Heal up to [color=%positive%]" + this.getBonus() + "[/color] every turn"
			}
		]);
		return tooltip;
	}

	function getBonus() {
		return ::Math.floor(this.getContainer().getActor().getHitpointsMax() * 0.1);
	}

	function onTurnStart() {
		local actor = this.getContainer().getActor();
		local healthAdded = ::Math.min((actor.getHitpointsMax() - actor.getHitpoints()), this.getBonus());

		if (healthAdded <= 0) {
			return;
		}

		actor.setHitpoints(actor.getHitpoints() + healthAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer()) {
			this.spawnIcon("status_effect_79", actor.getTile());

			if (this.m.SoundOnUse.len() != 0) {
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			}
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + "'s' Skin Ghoul blood circulates, healing " + healthAdded + " hitpoints");
		}
	}

	function onAdded() {
		this.m.TurnsLeft = 4;
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
			return "[color=%positive%]+" + this.getBonus() + "[/color] " + ::Legends.S.inlineIcon("health_recovery") + " every turn";
	}
});
