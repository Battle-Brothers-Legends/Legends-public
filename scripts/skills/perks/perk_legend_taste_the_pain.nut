this.perk_legend_taste_the_pain <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendTasteThePain);
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByLosingHitpoints = false;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker == null)
		{
			return;
		}

		if (_attacker.isAlliedWith(this.getContainer().getActor()))
		{
			return;
		}

		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null)
		{
			return;
		}

		if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() != _attacker.getID())
		{
			return;
		}

		this.getContainer().getActor().getCurrentProperties().MoraleCheckBravery[0] += 10;
		this.getContainer().getActor().getCurrentProperties().MoraleCheckBravery[1] += 10;
		this.getContainer().getActor().getCurrentProperties().MoraleCheckBravery[2] += 10;
	}


});
