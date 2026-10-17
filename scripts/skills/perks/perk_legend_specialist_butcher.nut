this.perk_legend_specialist_butcher <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SoundsA = ::Legends.S.setSounds("sounds/combat/cleave_hit_hitpoints", 3),
		SoundsB = ::Legends.S.setSounds("sounds/combat/chop_hit", 3),
		SpecialistWeaponIds = [
			"weapon.butchers_cleaver"
		],
		ExcludedWeaponTypes = [
			::Const.Items.WeaponType.Whip
		],
		ApplicableWeaponTypes = [
			::Const.Items.WeaponType.Cleaver
		],
		BonusMelee = 12,
		BonusDamage = 10
	}
	function create() {
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistButcher);
	}

	function specialistWeaponTooltip(_item, _isRanged) {
		return [
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts additional stacking [color=%positive%]2[/color] graze bleeding damage per turn, for 5 turns"
			}
		];
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (::Legends.S.isEntityNullOrDead(_targetEntity) || _targetEntity.isNonCombatant() || _targetEntity.getCurrentProperties().IsImmuneToBleeding) {
			return;
		}

		local user = _skill.getContainer().getActor();
		local item = user.getMainhandItem();
		if (item == null || item.isWeaponType(::Const.Items.WeaponType.Whip) || !item.isWeaponType(::Const.Items.WeaponType.Cleaver)) {
			return;
		}

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendGrazed);

		if (!user.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) {
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(user) + " filleted " + ::Const.UI.getColorizedEntityName(_targetEntity) + " leaving them grazed");
		}

		return true;
	}
});
