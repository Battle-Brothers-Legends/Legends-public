this.perk_legend_specialist_poacher <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.wonky_bow",
			"weapon.short_bow"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Bow
		],
		ValidEntities = [
			this.Const.EntityType.Wolf,
			this.Const.EntityType.Hyena
		],
		BonusRanged = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistPoacher);
		this.m.IconMini = "perk_spec_shortbow_mini";
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		];
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (this.onAnySkillUsedSpecialistChecks(_skill))
		{
			local ammo = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
			if (ammo == null)
				return;
			if (::Legends.S.patternIsInText("Piercing", ammo.getName()))
				_properties.DamageDirectAdd += 0.01 * this.calculateSpecialistBonus(25, _skill.getItem());
			else if (::Legends.S.patternIsInText("Broad Head", ammo.getName()))
				_properties.DamageTotalMult += 0.01 * this.calculateSpecialistBonus(10, _skill.getItem());
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (::Legends.S.skillEntityAliveCheck(_targetEntity))
			return;

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			return false;

		if (_targetEntity.isNonCombatant())
			return false;

		if (this.onAnySkillUsedSpecialistChecks(_skill))
		{
			local user = _skill.getContainer().getActor();
			local ammo = user.getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
			if (ammo != null && ::Legends.S.patternIsInText("Broad Head", ammo.getName()))
			{
				::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendGrazedEffect);

				if (!user.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " lacerated " + this.Const.UI.getColorizedEntityName(_targetEntity) + " leaving them grazed");
				}

				return true;
			}
		}
	}
});
