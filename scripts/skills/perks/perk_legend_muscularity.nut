this.perk_legend_muscularity <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMuscularity);
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
		local damageBonus = actor.getHitpoints() * 0.001;
		damageBonus += (actor.getFatigueMax() - actor.getFatigue()) * 0.0015;
		return this.Math.minf(0.5, damageBonus);
	}

	function getUnactivatedPerkTooltipHints()
	{
		return [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%positive%]" + this.Math.round(this.getBonus() * 100) + "%[/color] Damage based on current Hitpoints and Fatigue"
			}
		];
	}
});
