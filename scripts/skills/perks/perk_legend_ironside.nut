this.perk_legend_ironside <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendIronside);
	}

	function getDescription()
	{
		local bonus = this.getBonus() * 100;
		return "This character gains [color=%positive%]" + bonus + "%[/color] damage reduction because of adjacent opponents.";
	}

	function isOpponent( _actor, _tag )
	{
		if (!::MSU.isKindOf(_actor, "actor"))
			return;

		if (::Legends.S.skillEntityAliveCheck(_actor))
			return;

		if (::Math.abs(_actor.getTile().Level - _tag.Actor.getTile().Level) > 1)
			return;

		if (!_actor.isAlliedWith) {
			++_tag.Opponents;
		}
	}

	function getBonus()
	{
		if (!::Tactical.isActive())
			return 0;

		if ("State" in ::Tactical && ::Tactical.State.isBattleEnded())
			return 0;

		if (!("Entities" in ::Tactical))
			return 0;

		if (::Tactical.Entities == null)
			return 0;

		if (::Legends.S.isNull(this.getContainer()))
			return 0;

		local actor = this.getContainer().getActor();
		if (::Legends.S.skillEntityAliveCheck(actor))
			return 0;

		if (!actor.isPlacedOnMap())
			return 0;

		local result = {
			Opponents = 0,
			Actor = actor
		};

		local myTile = actor.getTile();
		if (myTile == null)
			return 0;

		this.Tactical.queryActorsInRange(myTile, 0, 1, this.isOpponent, result);

		return result.Opponents * 0.05;
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = this.getBonus() == 0;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		_properties.DamageReceivedTotalMult -= this.getBonus();
	}

});

