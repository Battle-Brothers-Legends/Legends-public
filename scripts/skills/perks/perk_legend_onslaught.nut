this.perk_legend_onslaught <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendOnslaught);
		this.m.SoundOnUse = [
			"sounds/combat/bash_01.wav",
			"sounds/combat/bash_02.wav",
			"sounds/combat/bash_03.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/bash_hit_01.wav",
			"sounds/combat/bash_hit_02.wav",
			"sounds/combat/bash_hit_03.wav"
		];
	}

	function getBonus()
	{
		local fat = this.getContainer().getActor().getItems().getStaminaModifier([
			::Const.ItemSlot.Body,
			::Const.ItemSlot.Head,
			::Const.ItemSlot.Bag,
			::Const.ItemSlot.Offhand,
			::Const.ItemSlot.Accessory,
			::Const.ItemSlot.Mainhand
		]);
		fat *= -1;
		return ::Math.min(30, fat * 0.30);
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDamageMult *= 1 + bonus * 0.01;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (::Legends.S.skillEntityAliveCheck(_targetEntity))
			return false;

		if (_targetEntity.getCurrentProperties().IsImmuneToStun)
			return false;

		if (_targetEntity.isNonCombatant())
			return false;

		local user = this.getContainer().getActor();
		local ourInit =  user.getInitiative();
		local targetInit = _targetEntity.getInitiative();


		if (ourInit <= targetInit)
			return false;


		if ( this.Math.rand(1, 100) > 50)
			return false;

		if (!_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendBaffled)) {
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendBaffled);

			if (!user.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) {
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " battered " + this.Const.UI.getColorizedEntityName(_targetEntity) + " leaving them baffled");
			}
		}

		return true;
	}
});
