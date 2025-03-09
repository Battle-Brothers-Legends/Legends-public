this.perk_legend_specialist_musician <- this.inherit("scripts/skills/skill", {
	m = {
		SpecialistWeaponTypes = [
			this.Const.Items.WeaponType.Musical
		],
		BonusMelee = 10,
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistMusician);
		this.m.IconMini = "perk_spec_bard_mini.png";
	}

	function specialistWeaponTooltip (_item, _isRanged)
	{
		local properties = this.getContainer().getActor().getCurrentProperties();
		local tooltip = [];
		
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(this.m.BonusMelee, _item) + "[/color] chance to hit"
		});

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/direct_damage.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.calculateSpecialistBonus(25, _item) + "%[/color] of any damage ignores armor"
		});

		if (::Legends.S.isCharacterWeaponSpecialized(properties, _item))
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateSpecialistBonus(this.m.BonusDamage, _item) + "%[/color] Damage"
			});
		}
		return tooltip;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;
		if (item == null || !item.isWeaponType(this.Const.Items.WeaponType.Musical))
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "This character is not using the specialist weapon"
			});
			return tooltip;
		}

		tooltip.extend([
		{
			id = 6,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Skill"
		},
		{
			id = 6,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense"
		},
		{
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increases the effect of Drums of War and Drums of Life by [color=" + this.Const.UI.Color.PositiveValue + "]2[/color]" 
		}]);
		if (actor.getCurrentProperties().IsSpecializedInStaves || actor.getCurrentProperties().IsSpecializedInMaces)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Damage"
			});
		}

		return tooltip;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties)
		if (onAnySkillUsedSpecialistChecks(_skill))
		{
			_properties.MeleeDefense += this.calculateSpecialistBonus(10, _skill.getItem());
		}
	}
});
