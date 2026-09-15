this.perk_legend_muscularity <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMuscularity);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		local item = _skill.getItem();
		local isHandToHand = _skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendChoke) || _skill.getID() == ::Legends.Actives.getID(::Legends.Active.HandToHand);

		if (!isHandToHand && item != null && item.isItemType(::Const.Items.ItemType.Defensive) && !item.isItemType(::Const.Items.ItemType.Weapon)) {
			return;
		}

		local isValidRanged = item != null && item.isItemType(::Const.Items.ItemType.Weapon) && (item.isWeaponType(::Const.Items.WeaponType.Throwing) || item.isWeaponType(::Const.Items.WeaponType.Bow));
		if (!_skill.isRanged() || (isValidRanged && item.isItemType(::Const.Items.ItemType.Weapon)) || isHandToHand) {
			_properties.DamageTotalMult += this.getBonus();
		}
	}

	function getBonus(_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		local damageBonus = actor.getHitpoints() * 0.001;
		damageBonus += (actor.getFatigueMax() - actor.getFatigue()) * 0.001;
		return ::Math.minf(0.5, damageBonus);
	}

	function getUnactivatedPerkTooltipHints(_actor = null) {
		return [{
			id = 3,
			type = "hint",
			icon = "ui/icons/damage_dealt.png",
			text = "[color=%positive%]" + ::Math.round(this.getBonus(_actor) * 100) + "%[/color] Damage based on current Hitpoints and Fatigue"
		}];
	}
});
