this.perk_legend_specialist_musician <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistMusician);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IconMini = "perk_spec_bard_mini.png";
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "Taverns have taught you that instruments can be used to make spin tunes, bash heads and block a thrown rotten tomato.";
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

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();

		if (item == null || !item.isWeaponType(this.Const.Items.WeaponType.Musical)) return;

		_properties.MeleeSkill += 10;
		_properties.MeleeDefense += 10;

		if (actor.getCurrentProperties().IsSpecializedInStaves || actor.getCurrentProperties().IsSpecializedInMaces)
		{
			_properties.DamageRegularMin += 10;
			_properties.DamageRegularMax += 10;
		}
	}
});
