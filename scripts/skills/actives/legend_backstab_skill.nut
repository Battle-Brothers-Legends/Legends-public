this.legend_backstab_skill <- this.inherit("scripts/skills/actives/stab", {
	m = {}
	function create() {
		this.stab.onCreate();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendBackstab);
		this.m.Name = "Backstab";
		this.m.Description = "A quick and fast stab that takes advantage of a distracted target.";
	}

	function getTooltip () {
		local ret = this.stab.getTooltip();
		if (::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties(), this.getItem())) {
			ret.extend([{
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal an additional [color=%positive%]5%[/color] Damage per target surrounding the target up to a maximum of [color=%positive%]25%[/color]"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "An additional [color=%positive%]3%[/color] of any damage ignores armor per target surrounding the target up to a maximum of [color=%positive%]15%[/color]"
			}]);
		}
		return ret;
	}

	function onAnySkillUsed ( _skill, _targetEntity, _properties ) {
		if (_skill != this)
			return;

		if (_targetEntity == null)
			return;

		local surroundedCount = _targetEntity.getSurroundedCount();
		if (surroundedCount > 0) {
			_properties.DamageRegularMult *= 1.0 + surroundedCount * 0.05;
			_properties.DamageDirectMult *= 1.0 + surroundedCount * 0.03;
		}

	}
});