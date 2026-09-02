this.legend_volley_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = -4,
		InitiativeAdditionalDamage = 0.05
	},
	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendVolley);
		this.m.Description = "Let loose a cascade of three striking shots on your opponent.";
		this.m.KilledString = "Pin cushioned";
		this.m.SoundOnUse = [
			"sounds/combat/tripleshot_01.wav",
			"sounds/combat/tripleshot_02.wav",
			"sounds/combat/tripleshot_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/tripleshot_hit_01.wav",
			"sounds/combat/tripleshot_hit_02.wav",
			"sounds/combat/tripleshot_hit_03.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/arrow_miss_01.wav",
			"sounds/combat/arrow_miss_02.wav",
			"sounds/combat/arrow_miss_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 250;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsDoingForwardMove = false;
		this.m.IsShowingProjectile = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = this.Const.ProjectileType.Arrow;
	}

	function getTooltip() {
		local ret = this.getRangedTooltip(this.getDefaultTooltip());

		local ammo = this.getAmmo();

		if (ammo > 0) {
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Has [color=%positive%]%_ammo%[/color] arrows left",
				param = [["_ammo", ammo]]
			});
		}
		else {
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Needs a non-empty quiver of arrows equipped[/color]"
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions())) {
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}
		ret.extend([{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will make three separate strikes for one half of the weapon\'s damage each"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Increases damage by [color=%negative%]%_initiativeDamage%[/color] of the Initiative difference between you and the target",
				param = [["_initiativeDamage", this.m.InitiativeAdditionalDamage]]
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "The penalty to hitchance when shooting at a target you have no clear line of fire to is increased by [color=%positive%]50%[/color]",
			}
		]);
		return ret;
	}

	function getAmmo() {
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item == null) {
			return 0;
		}

		if (item.getAmmoType() == this.Const.Items.AmmoType.Arrows) {
			return item.getAmmo();
		}
	}

	function isUsable() {
		if (!this.getContainer().getActor().isArmedWithRangedWeapon()) {
			return false;
		}
		return (!this.Tactical.isActive() || this.skill.isUsable()) && this.getAmmo() > 2 && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}


	function consumeAmmo() {
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
		if (item == null)
		{
			return;
		}
		item.consumeAmmo();
		item.consumeAmmo();
		item.consumeAmmo();
	}

	function onAfterUpdate( _properties ) {
		local bonusRange = (_properties.IsSpecializedInBows ? 1 : 0) + (this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistSharpshooter) ? 1 : 0);
		this.m.MaxRange = this.m.Item.getRangeMax() + bonusRange - 1;
		this.m.AdditionalAccuracy = this.m.Item.getAdditionalAccuracy();
		this.m.FatigueCostMult = _properties.IsSpecializedInBows ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.InitiativeAdditionalDamage = _properties.IsSpecializedInBows ? 0.1 : 0.05;
	}

	function onUse( _user, _targetTile ) {
		this.consumeAmmo();
		local target = _targetTile.getEntity();
		this.attackEntity(_user, target);
		this.m.IsDoingAttackMove = false;
		this.getContainer().setBusy(true);
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 100, function ( _skill ) {
			if (target.isAlive()) {
				_skill.attackEntity(_user, target);
			}
		}.bindenv(this), this);

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, function ( _skill ) {
			if (target.isAlive()) {
				_skill.attackEntity(_user, target);
			}

			_skill.m.IsDoingAttackMove = true;
			_skill.getContainer().setBusy(false);
		}.bindenv(this), this);
		if (!this.getContainer().hasPerk(::Legends.Perk.LegendBarrage)) {
			return;
		}
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 300, function ( _skill ) {
			if (target.isAlive()) {
				_skill.attackEntity(_user, target);
			}

			_skill.m.IsDoingAttackMove = true;
			_skill.getContainer().setBusy(false);
		}.bindenv(this), this);
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
			_properties.DamageTotalMult *= 0.33333334;
			_properties.DamageTooltipMaxMult *= 3.0;
			_properties.RangedAttackBlockedChanceMult *= 1.5;
			if (this.getContainer().hasPerk(::Legends.Perk.LegendBallistics)) {
				_properties.DamageTooltipMaxMult *= 4.0;
			}
			if (_targetEntity != null) {
				local defenderCurrentInitiative = _targetEntity.getInitiative();
				local attackerCurrentInitiative = this.getContainer().getActor().getInitiative();
				local diff = defenderCurrentInitiative - attackerCurrentInitiative;
				if (diff > 0) {
					_properties.DamageRegularMin += this.Math.floor(this.m.InitiativeAdditionalDamage * diff);
					_properties.DamageRegularMax += this.Math.floor(this.m.InitiativeAdditionalDamage * diff); 
				}
			}
		}
	}

});
