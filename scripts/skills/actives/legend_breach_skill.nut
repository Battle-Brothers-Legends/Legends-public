this.legend_breach_skill <- this.inherit("scripts/skills/actives/slash", {
	m = {
		IsGreatBreachSlash = false
	}

	function setItem (_item) {
		if (this.m.IsGreatBreachSlash) {
			this.m.DirectDamageMult = 0.25;
			this.m.FatigueCost = 13;
		}
		this.skill.setItem(_item);
	}

	function create() {
		this.slash.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendBreach);
		this.m.Description = "A swift slashing attack making good use of the light blade of the weapon to maneuver around longer weapons.";
	}

	function onUse( _user, _targetTile ) {
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function getTooltip () {
		local ret = this.slash.getTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "[color=%positive%]15%[/color] extra damage done against enemies armed with polearms or melee weapons that can strike over a distance"
		});
		return ret;
	}

	function onAnySkillUsed ( _skill, _targetEntity, _properties ) {
		this.slash.onAnySkillUsed( _skill, _targetEntity, _properties );
		if (_skill == this && _targetEntity != null && _targetEntity.isArmedWithPoleWeapon()) {
			_properties.DamageTotalMult *= 1.15;
		}
	}
});
