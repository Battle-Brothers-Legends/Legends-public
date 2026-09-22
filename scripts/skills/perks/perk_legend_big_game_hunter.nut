this.perk_legend_big_game_hunter <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBigGameHunter);
		this.m.Icon = "ui/perks/BigGameHunterPerk.png";
		this.m.IconMini = "mini_big_game_hunter";
		this.m.Type = this.Const.SkillType.StatusEffect;
	}

	function onUpdate( _properties ) {
		this.m.Type = !this.getContainer().getActor().isPlacedOnMap() ? ::Const.SkillType.Trait : ::Const.SkillType.StatusEffect
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_targetEntity == null) {
			return;
		}
		local actor = this.getContainer().getActor()
		if (!actor.isArmedWithRangedWeapon()) {
			return;
		}

		if (!this.Const.EntityType.getDefaultFaction(_targetEntity.getType()) == this.Const.FactionType.Beasts &&
			_targetEntity.getType() == this.Const.EntityType.BarbarianUnhold &&
		 	_targetEntity.getType() == this.Const.EntityType.BarbarianUnholdFrost) {
			_properties.RangedDamageMult *= 1.10;
		}
		else {
			_properties.DamageRegularMult += 1.0 - _targetEntity.getHitpoints() / (_targetEntity.getHitpointsMax() * 1.0);
		}
	}
});
