this.perk_legend_lacerate <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendLacerate);
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		];
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (::Legends.S.skillEntityAliveCheck(_targetEntity))
			return false;

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			return false;

		if (_targetEntity.isNonCombatant())
			return false;

		local user = _skill.getContainer().getActor();
		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendGrazedEffect);

		if (!user.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " lacerated " + this.Const.UI.getColorizedEntityName(_targetEntity) + " leaving them grazed");
		}

		return true;

	}

});
