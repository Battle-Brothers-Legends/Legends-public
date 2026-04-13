this.perk_legend_specialist_butcher <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SoundsA = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		],
		SoundsB = [
			"sounds/combat/chop_hit_01.wav",
			"sounds/combat/chop_hit_02.wav",
			"sounds/combat/chop_hit_03.wav"
		],
		SpecialistWeaponIds = [
			"weapon.butchers_cleaver",
			"weapon.legend_named_butchers_cleaver"
		],
		ExcludedWeaponTypes = [
			this.Const.Items.WeaponType.Whip
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Cleaver
		],
		BonusMelee = 12,
		BonusDamage = 10
	}
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistButcher);
		this.m.IconMini = "perk_spec_butcher_mini";
	}

	function specialistWeaponTooltip (_item, _isRanged)
	{
		return [{
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=%positive%]2[/color] graze bleeding damage per turn, for 5 turns"
		}];
	}

	function onTargetHit ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{

		if (::Legends.S.skillEntityAliveCheck(_targetEntity))
			return;

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			return false;

		if (_targetEntity.isNonCombatant())
			return false;

		local user = _skill.getContainer().getActor();
		local item = user.getMainhandItem();
		if (item == null || item.isWeaponType(this.Const.Items.WeaponType.Whip) || !item.isWeaponType(this.Const.Items.WeaponType.Cleaver))
			return;

		_targetEntity.getSkills().add(this.new("scripts/skills/effects/legend_grazed_effect"));

		if (!user.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " filleted " + this.Const.UI.getColorizedEntityName(_targetEntity) + " leaving them grazed");
		}

		return true;
	}

});
