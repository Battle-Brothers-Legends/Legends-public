this.perk_legend_muscularity <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendMuscularity);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		local item = _skill.getItem();

		if (item != null && item.isItemType(this.Const.Items.ItemType.Defensive) && !item.isItemType(this.Const.Items.ItemType.Weapon))
			return;

		local isValidRanged = item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && (item.isWeaponType(this.Const.Items.WeaponType.Throwing) || item.isWeaponType(this.Const.Items.WeaponType.Bow));
		if (!_skill.isRanged() || (isValidRanged && item.isItemType(this.Const.Items.ItemType.Weapon)))
		{
			_properties.DamageTotalMult *= 1.0 + this.getBonus();
		}
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();
		local damageBonus = this.Math.maxf(actor.getHitpoints(), actor.getHitpointsMax() / 2.0) * 0.001; // either half of the max hitpoints or hitpoints so there's a lower bound
		damageBonus += this.Math.maxf(actor.getFatigueMax() - actor.getFatigue(), actor.getFatigueMax() / 2.0) * 0.0015;
		return this.Math.minf(0.5, damageBonus);
	}

	function getUnactivatedPerkTooltipHints()
	{
		return [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.Math.round(this.getBonus() * 100) + "%[/color] Damage based on current Hitpoints and Fatigue"
			}
		];
	}
});
