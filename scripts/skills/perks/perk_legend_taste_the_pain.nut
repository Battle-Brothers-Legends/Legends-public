this.perk_legend_taste_the_pain <- this.inherit("scripts/skills/skill", {
	m = {
		StackCount = 0
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendTasteThePain);
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByLosingHitpoints = false;
		_properties.Bravery += this.m.StackCount * 4;
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

		++this.m.StackCount;
	}

	function onCombatFinished()
	{
		this.m.StackCount = 0;
	}
});
