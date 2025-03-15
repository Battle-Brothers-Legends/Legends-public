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
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistButcher);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.IconMini = "perk_spec_butcher_mini";
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function specialistWeaponTooltip (_item, _isRanged)
	{
		return [{
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] graze bleeding damage per turn, for 5 turns"
		}];
	}

	function onTargetHit ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{

		if (!_targetEntity.isAlive() || _targetEntity.isDying())
		{
			return false;
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding)
		{
			return false;
		}

		if (_targetEntity.isNonCombatant())
		{
			return false;
		}

		local user = _skill.getContainer().getActor();
		local item = user.getMainhandItem();
		if (item == null || item.isWeaponType(this.Const.Items.WeaponType.Whip) || !item.isWeaponType(this.Const.Items.WeaponType.Cleaver))
			return;

		_targetEntity.getSkills().add(this.new("scripts/skills/effects/legend_grazed_effect"));

		if (!user.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " filleted " + this.Const.UI.getColorizedEntityName(_targetEntity) + " leaving them grazed");
		}

		return true;
	}

});
