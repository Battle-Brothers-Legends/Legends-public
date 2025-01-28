this.legend_animated_player_properties <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendAnimatedPlayerProperties);
		this.m.Icon = "";
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = true;
	}


	function isHidden()
	{
		return true;
	}


	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		actor.m.MoraleState = this.Const.MoraleState.Ignore;

		if (actor.getFlags().has("PlayerZombie"))
		{
			actor.m.BloodType = this.Const.BloodType.Dark;
			actor.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = [
				"sounds/enemies/zombie_idle_14.wav",
				"sounds/enemies/zombie_idle_15.wav",
				"sounds/enemies/zombie_idle_16.wav"
			];
			actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
				"sounds/enemies/zombie_hurt_01.wav",
				"sounds/enemies/zombie_hurt_02.wav",
				"sounds/enemies/zombie_hurt_03.wav",
				"sounds/enemies/zombie_hurt_04.wav",
				"sounds/enemies/zombie_hurt_05.wav",
				"sounds/enemies/zombie_hurt_06.wav",
				"sounds/enemies/zombie_hurt_07.wav"
			];
			actor.m.Sound[this.Const.Sound.ActorEvent.Death] = [
				"sounds/enemies/zombie_death_01.wav",
				"sounds/enemies/zombie_death_02.wav",
				"sounds/enemies/zombie_death_03.wav",
				"sounds/enemies/zombie_death_04.wav",
				"sounds/enemies/zombie_death_05.wav",
				"sounds/enemies/zombie_death_06.wav"
			];
			actor.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = [
				"sounds/enemies/zombie_bite_01.wav",
				"sounds/enemies/zombie_bite_02.wav",
				"sounds/enemies/zombie_bite_03.wav"
			];
			actor.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
				"sounds/enemies/zombie_bite_01.wav",
				"sounds/enemies/zombie_bite_02.wav",
				"sounds/enemies/zombie_bite_03.wav"
			];
			actor.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
				"sounds/enemies/zombie_idle_01.wav",
				"sounds/enemies/zombie_idle_02.wav",
				"sounds/enemies/zombie_idle_03.wav",
				"sounds/enemies/zombie_idle_04.wav",
				"sounds/enemies/zombie_idle_05.wav",
				"sounds/enemies/zombie_idle_06.wav",
				"sounds/enemies/zombie_idle_07.wav",
				"sounds/enemies/zombie_idle_08.wav",
				"sounds/enemies/zombie_idle_09.wav",
				"sounds/enemies/zombie_idle_10.wav",
				"sounds/enemies/zombie_idle_11.wav",
				"sounds/enemies/zombie_idle_12.wav",
				"sounds/enemies/zombie_idle_13.wav"
			];
			actor.m.Sound[this.Const.Sound.ActorEvent.Move] = [
				"sounds/enemies/zombie_bite_01.wav",
				"sounds/enemies/zombie_bite_02.wav",
				"sounds/enemies/zombie_bite_03.wav"
			];
		}
		else if (actor.getFlags().has("PlayerSkeleton"))
		{
			actor.m.BloodType = this.Const.BloodType.Bones;
			actor.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = [
				"sounds/enemies/skeleton_idle_06.wav"
			];
			actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
				"sounds/enemies/skeleton_hurt_01.wav",
				"sounds/enemies/skeleton_hurt_02.wav",
				"sounds/enemies/skeleton_hurt_03.wav",
				"sounds/enemies/skeleton_hurt_04.wav",
				"sounds/enemies/skeleton_hurt_06.wav"
			];
			actor.m.Sound[this.Const.Sound.ActorEvent.Death] = [
				"sounds/enemies/skeleton_death_01.wav",
				"sounds/enemies/skeleton_death_02.wav",
				"sounds/enemies/skeleton_death_03.wav",
				"sounds/enemies/skeleton_death_04.wav",
				"sounds/enemies/skeleton_death_05.wav",
				"sounds/enemies/skeleton_death_06.wav"
			];
			actor.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = [
				"sounds/enemies/skeleton_idle_06.wav"
			];
			actor.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
				"sounds/enemies/skeleton_idle_06.wav"
			];
			actor.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
				"sounds/enemies/skeleton_idle_01.wav",
				"sounds/enemies/skeleton_idle_02.wav",
				"sounds/enemies/skeleton_idle_03.wav",
				"sounds/enemies/skeleton_idle_04.wav",
				"sounds/enemies/skeleton_idle_05.wav"
			];
			actor.m.Sound[this.Const.Sound.ActorEvent.Move] = [
				"sounds/enemies/skeleton_idle_06.wav"
			];
		}
	}


	function onUpdate (_properties)
	{
		local actor = this.getContainer().getActor();
		actor.m.MoraleState = this.Const.MoraleState.Ignore;

		_properties.IsImmuneToBleeding = true;
		_properties.IsImmuneToPoison = true;
		_properties.IsAffectedByNight = false;
		_properties.IsAffectedByFleeingAllies = false;
		_properties.IsAffectedByDyingAllies = false;
		_properties.IsAffectedByFreshInjuries = false;
		_properties.MoraleEffectMult = 0.1;
		_properties.FatigueEffectMult = 0.1;
		_properties.HitpointsRecoveryRateMult = 0.1;
		_properties.MovementFatigueCostMult = 0.1;
		_properties.DailyWageMult = 0;
		_properties.DailyFood = 0;
	}
});
