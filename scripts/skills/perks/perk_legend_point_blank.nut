this.perk_legend_point_blank <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPointBlank);
		this.m.Description = "Don't fire until you see the whites of their eyes!";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus(this.getContainer().getActor().getCurrentProperties());
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Allows you to use throwing weapons in melee"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Ranged weapon Damage dealt increased by [color=%positive%]" + bonus + "%[/color] at a range of 4 tiles or less"
			}
		]);
		return tooltip;
	}

	function getBonus(_properties) {
		local actor = this.getContainer().getActor();
		local isWeaponThrowingType = actor.getMainhandItem() != null && actor.getMainhandItem().isWeaponType(::Const.Items.WeaponType.Throwing);
		return (isWeaponThrowingType ? (::Math.floor(0.3 * _properties.getMeleeSkill()) + ::Math.floor(0.5 * _properties.getRangedDefense())) : ::Math.floor(0.3 * _properties.getRangedDefense()));
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_targetEntity == null || !_skill.isRanged() || !_skill.IsWeaponSkill || this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) > 4) {
			return;
		}

		_properties.DamageTotalMult *= 1.0 + this.getBonus(_properties) * 0.01;
	}
});
