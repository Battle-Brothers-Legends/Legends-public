this.legend_throw_knife_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0,
		DistractedChance = 25,
	},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendThrowKnife);
		this.m.Description = "Throw one of your backup daggers for each free hand. Grants a chance to distract the enemy on head hits. Cannot be used while engaged in melee.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/throw_axe", 3);
		this.m.SoundOnHit = ::Legends.S.setSounds("sounds/combat/throw_axe_hit", 3);
		this.m.SoundOnHitDelay = -150;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 750;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsWeaponSkill = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = ::Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = ::Const.Injury.CuttingHead;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 12;
		this.m.MinRange = 2;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 4;
		this.m.DirectDamageMult = 0.2;
		this.m.ProjectileType = ::Const.ProjectileType.Dagger;
		this.m.ProjectileTimeScale = 1.5;
		this.m.HitChanceBonus = 20;
	}

	function getTooltip() {
		local tooltip = this.getDefaultTooltip();

		local ammo = this.getAmmo();
		if (ammo > 0) {
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]%_ammo%[/color] backup knives left",
				param = [
					["_ammo", ammo]
				]
			});
		} else {
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]No backup knives left[/color]",
			});
		}

		if (this.getContainer().getActor().isEngagedInMelee()) {
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	function canDoubleThrow() {
		local actor = this.getContainer().getActor();
		local hasBothHands = this.getContainer().getSkillByID("injury.missing_hand") == null || ::Legends.Traits.get(this, ::Legends.Trait.LegendProstheticHand) != null;
		local main = actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
		local off = actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		return hasBothHands && off == null && main != null && main.isDoubleGrippable() && this.isUsable();
	}

	function isUsable() {
		local actor = this.getContainer().getActor();
		return this.skill.isUsable() && !actor.isEngagedInMelee() && this.getAmmo() >= 1;
	}

	function getAmmo() {
		local item = this.getItem();
		return (item != null ? item.getAmmo() : 0);
	}

	function onUse(_user, _targetTile) {
		local target = _targetTile.getEntity();
		local success = this.attackEntity(_user, target);
		local dagger = this.getItem();
		dagger.consumeAmmo();
		if (!this.canDoubleThrow()) {
			return success;
		}
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer) {
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);

			::Time.scheduleEvent(::TimeUnit.Virtual, 150, function (_skill) {
				if (!::Legends.S.isEntityNullOrDead(target)) {
					success = _skill.attackEntity(_user, target) || success;
					dagger.consumeAmmo();
					_skill.m.IsDoingAttackMove = true;
					_skill.getContainer().setBusy(false);
				}
			}.bindenv(this), this);
		} else if (!::Legends.S.isEntityNullOrDead(target)) {
			dagger.consumeAmmo();
			return this.attackEntity(_user, target) || success;
		}

		return success;
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_skill != this || ::Legends.S.isEntityNullOrDead(_targetEntity) || _bodyPart != ::Const.BodyPart.Head) {
			return;
		}

		if (::Math.rand(1, 100) <= this.m.DistractedChance) {
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Distracted);
			if (!this.getContainer().getActor().isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) {
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " struck a hit that leaves " + ::Const.UI.getColorizedEntityName(_targetEntity) + " distracted");
			}
		}
	}

	function onAfterUpdate(_properties) {
		if (this.getContainer().hasPerk(::Legends.Perk.LegendPointBlank)) {
			this.m.MinRange = 1;
		}

		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.DistractedChance = _properties.IsSpecializedInDaggers ? 50 : 25;
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_skill == this) {
			_properties.DamageTotalMult *= 0.7;
			local bonus = this.m.Item.getAdditionalAccuracy();
			_properties.RangedSkill += this.addHitChanceBonus(bonus);
			_properties.HitChanceAdditionalWithEachTile -= 10;
		}
	}
});
