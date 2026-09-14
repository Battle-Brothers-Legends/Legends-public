this.legend_flowing_slash_skill <- this.inherit("scripts/skills/actives/slash", {
	m = {}
	function create() {
		this.slash.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendFlowingSlash);
		this.m.Description = "A skillful slash that easily flows into another attack.";
	}

	function getTooltip () {
		local ret = this.slash.getTooltip();
		local chance = ::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties(), this.getItem()) ? 20 : 10;
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%positive%]%chance%%[/color] chance to reroll a missed attack",
			param = [["_chance", chance]]
		});
		return ret;
	}

	function onAnySkillUsed ( _skill, _targetEntity, _properties ) {
		this.slash.onAnySkillUsed( _skill, _targetEntity, _properties );
		if (_skill == this) {
			_properties.RerollAttackChance += 10;
			if (::Legends.S.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties(), this.getItem())) {
				_properties.RerollAttackChance += 10;
			}
		}
	}
});
