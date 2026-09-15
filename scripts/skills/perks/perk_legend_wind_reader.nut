this.perk_legend_wind_reader <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendWindReader);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function onBeingAttacked( _attacker, _skill, _properties ) {
		local dist = _attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile());
		_properties.RangedDefense += ::Math.max(10, ::Math.floor(dist * (1 + this.getContainer().getActor().getBaseProperties().getRangedDefense() * 0.1)));
	}

	function onUpdate( _properties ) {
		_properties.HitChanceAdditionalWithEachTile += 2;
	}
});
