this.legend_legion_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},

	function getTooltip() {
		local ret = this.character_background.getTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "Immune to Bleeding, poison and most fresh injuries"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "Recovers hitpoints at only 20% of the normal rate and requires no food. and has resistance to piercing type attacks"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "Has resistance to piercing type attacks"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Effected by fatigue at 10% normal rate"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Not affected by morale checks or allies fleeing and dying"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Not affected by nighttime penalties"
			}
		]);
		return ret;
	}

	function onAdded() {
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();

		if (::isKindOf(actor, "player")) {
			actor.get().improveMood = function (_change, _text = "") {};
			actor.get().worsenMood = function (_change, _text = "") {};
		}

		this.onApplyAppearance();
		actor.getFlags().add("PlayerSkeleton");
		actor.getFlags().add("skeleton");
		actor.getFlags().add("undead");
		actor.getFlags().add("legion_can_command"); //justifies if this background is subject to the Legion command skill
		::Legends.Traits.grant(this, ::Legends.Trait.RacialSkeleton);
		actor.m.ExcludedInjuries = ::Legends.Legion.ExcludedInjures;
		actor.onFactionChanged();
		actor.onUpdateInjuryLayer();
	}

	function onUpdate(_properties) {
		this.getContainer().getActor().m.MoraleState = ::Const.MoraleState.Ignore;
		_properties.IsImmuneToBleeding = true;
		_properties.IsImmuneToPoison = true;
		_properties.IsAffectedByNight = false;
		_properties.IsAffectedByFleeingAllies = false;
		_properties.IsAffectedByDyingAllies = false;
		_properties.IsAffectedByFreshInjuries = false;
		_properties.MoraleEffectMult = 0.1;
		_properties.FatigueEffectMult = 0.1;
		_properties.HitpointsRecoveryRateMult = 0.2;
		_properties.MovementFatigueCostMult = 0.1;
		_properties.DailyWageMult *= 0;
		_properties.XPGainMult *= 1.0;
		_properties.DailyFood = 0;
	}

	function adjustHiringCostBasedOnEquipment() {
		this.getContainer().getActor().m.HiringCost = 0.0;
	}

	function onApplyAppearance() {
		local actor = this.getContainer().getActor();

		if (::isKindOf(actor, "player")) {
			local hairColor = ::Const.HairColors.Zombie[::Math.rand(0, ::Const.HairColors.Zombie.len() - 1)];
			local body = actor.getSprite("body");
			body.setBrush("bust_skeleton_body_0" + ::Math.rand(1, 2));
			body.Saturation = 0.8;

			actor.getSprite("injury_body").setBrush("bust_skeleton_body_injured");

			local head = actor.getSprite("head");
			head.setBrush("bust_skeleton_head");
			head.Color = body.Color;
			head.Saturation = body.Saturation;

			local beard = actor.getSprite("beard");
			if (beard != null) {
				beard.setBrush("beard_" + hairColor + "_" + ::Const.Beards.ZombieOnly[::Math.rand(0, ::Const.Beards.ZombieOnly.len() - 1)]);
				local beard_top = actor.getSprite("beard_top");
				if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top")) {
					beard_top.setBrush(beard.getBrush().Name + "_top");
					beard_top.Color = beard.Color;
				}
			}

			local face = actor.getSprite("scar_head");
			if (face != null) {
				face.setBrush("bust_skeleton_face_0" + ::Math.rand(1, 6));
			}

			local hair = actor.getSprite("hair");
			if (hair != null) {
				hair.Color = beard.Color;
				hair.setBrush("hair_" + hairColor + "_" + ::Const.Hair.ZombieOnly[::Math.rand(0, ::Const.Hair.ZombieOnly.len() - 1)]);
				actor.setSpriteOffset("hair", this.createVec(0, -3));
			}

			local injury = actor.getSprite("injury");
			if (injury != null) {
				injury.setBrush("bust_skeleton_head_injured");
			}
		}
	}

	function onCombatStarted() {
		local actor = this.getContainer().getActor();
		actor.m.MoraleState = ::Const.MoraleState.Ignore;
		actor.m.BloodType = ::Const.BloodType.Bones;
		actor.m.Sound[::Const.Sound.ActorEvent.NoDamageReceived] = ["sounds/enemies/skeleton_idle_06.wav"];
		actor.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/skeleton_hurt_01.wav",
			"sounds/enemies/skeleton_hurt_02.wav",
			"sounds/enemies/skeleton_hurt_03.wav",
			"sounds/enemies/skeleton_hurt_04.wav",
			"sounds/enemies/skeleton_hurt_06.wav"
		];
		actor.m.Sound[::Const.Sound.ActorEvent.Death] = ::Legends.S.setSounds("sounds/enemies/skeleton_death_01", 6);
		actor.m.Sound[::Const.Sound.ActorEvent.Fatigue] = ["sounds/enemies/skeleton_idle_06.wav"];
		actor.m.Sound[::Const.Sound.ActorEvent.Flee] = ["sounds/enemies/skeleton_idle_06.wav"];
		actor.m.Sound[::Const.Sound.ActorEvent.Idle] = ::Legends.S.setSounds("sounds/enemies/skeleton_idle", 5);
		actor.m.Sound[::Const.Sound.ActorEvent.Move] = ["sounds/enemies/skeleton_idle_06.wav"];
	}
});
