this.perk_legend_ironside <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendIronside);
	}


	function getDescription()
	{
		local bonus = this.getBonus() * 100;
		return "This character gains [color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "%[/color] damage reduction because of adjacent opponents.";
	}

	function isOpponent( _actor, _tag )
	{
		if (this.Math.abs(_actor.getTile().Level - _tag.Actor.getTile().Level) > 1)
			return;

		if (!_actor.isAlliedWith) {
			++_tag.Opponents;
		}
	}

	function getBonus()
	{
		local result = {
			Opponents = 0,
			Actor = this.m.Container.getActor()
		};

		if (::Legends.S.isNull(this.getContainer()))
			return 0;

		local actor = this.getContainer().getActor();
		if (::Legends.S.skillEntityAliveCheck(actor))
			return 0;

		if (actor.getTile() == null)
			return 0;

		this.Tactical.queryActorsInRange(actor.getTile(), 0, 1, this.isOpponent, result);

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

