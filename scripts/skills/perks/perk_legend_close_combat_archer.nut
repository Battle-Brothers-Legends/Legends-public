this.perk_legend_close_combat_archer <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendCloseCombatArcher);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip ()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local bonus = this.getBonus();

		tooltip.extend([
		{
			id = 6,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Reduces your maximum range of throwing weapons to [color=" + this.Const.UI.Color.NegativeValue + "]3[/color]"
		},
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
			text = "Increases your damage done by [color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "%[/color] for ranged weapon attacks at a range of 4 tiles or less"
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
			rdefBonus = this.Math.floor(0.2 * _properties.getRangedDefense());
		}

		return this.Math.max(mskillBonus, rdefBonus);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
			return;

		if (!_skill.isRanged())
			return;

		local bonus = this.getBonus(_properties) / 100;
		local actor = this.getContainer().getActor();

		if (actor == null)
			return;

		if (!actor.getMainhandItem().isWeaponType(this.Const.Items.WeaponType.Throwing) || actor.getTile().getDistanceTo(_targetEntity.getTile()) > 4)
			return;

		_properties.DamageRegularMult *= 1 + bonus;
		_properties.DamageArmorMult *= 1 + bonus;
	}

});

