this.perk_legend_point_blank <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPointBlank);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function getDescription()
	{
		return "Don't fire until you see the whites of their eyes!";
	}

	function getTooltip ()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local bonus = this.getBonus(actor.getCurrentProperties());

		tooltip.extend([
		{
			id = 6,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "Allows you to use throwing weapons in melee"
		},
		{
			id = 6,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "Increases your damage done by [color=%positive%]" + bonus + "%[/color] for ranged weapon attacks at a range of 4 tiles or less"
		}]);

		return tooltip;
	}

	function getBonus(_properties)
	{
		local actor = this.getContainer().getActor();
		local mskillBonus = 0;
		local rdefBonus = 0;

		if (actor.getMainhandItem() != null && actor.getMainhandItem().isWeaponType(this.Const.Items.WeaponType.Throwing))
		{
			mskillBonus = this.Math.floor(0.3 * _properties.getMeleeSkill());
			rdefBonus = this.Math.floor(0.5 * _properties.getRangedDefense());
		}
		else
		{
			mskillBonus = 0;
			rdefBonus = this.Math.floor(0.3 * _properties.getRangedDefense());
		}

		return mskillBonus + rdefBonus;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
			return;

		if (!_skill.isRanged())
			return;

		local bonus = this.getBonus(_properties) * 0.01;

		if (this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) > 4)
			return;

		_properties.DamageTotalMult *= 1.0 + bonus;
	}
});
