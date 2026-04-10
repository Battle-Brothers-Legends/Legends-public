this.legend_throw_knife_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 20,
		AdditionalHitChance = -10,
		DistractedChance = 25,
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendThrowKnife);
		this.m.Description = "Throw one of your backup daggers for each free hand. Grants a chance to distract the enemy on head hits. Cannot be used while engaged in melee.";
		this.m.Icon = "skills/active_throw_knife.png";
		this.m.IconDisabled = "skills/active_throw_knife_bw.png";
		this.m.Overlay = "active_throw_knife";
		this.m.SoundOnUse = [
			"sounds/combat/throw_axe_01.wav",
			"sounds/combat/throw_axe_02.wav",
			"sounds/combat/throw_axe_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/throw_axe_hit_01.wav",
			"sounds/combat/throw_axe_hit_02.wav",
			"sounds/combat/throw_axe_hit_03.wav"
		];
		this.m.SoundOnHitDelay = -150;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
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
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 12;
		this.m.MinRange = 2;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 4;
		this.m.DirectDamageMult = 0.2;
		this.m.ProjectileType = this.Const.ProjectileType.Dagger;
		this.m.ProjectileTimeScale = 1.5;
	}

	function getTooltip()
	{
		local tooltip = this.getRangedTooltip(this.getDefaultTooltip());

		local ammo = this.getAmmo();
		if (ammo > 0)
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]%_ammo%[/color] backup knives left",
				param = [["_ammo", ammo]]
			});
		}
		else
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]No backup knives left[/color]",
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	function canDoubleGrip ()
	{
		local missinghand = this.m.Container.getSkillByID("injury.missing_hand");
		local newhand = ::Legends.Traits.get(this, ::Legends.Trait.LegendProstheticHand);
		local main = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return (missinghand == null || newhand != null) && main != null && off == null && main.isDoubleGrippable();
	}

	function isUsable()
	{
		local ammoNeeded = this.canDoubleGrip() ? 2 : 1;
		return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() >= ammoNeeded && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item == null)
		{
			return 0;
		}

		return item.getAmmo();
	}

	function consumeAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item != null)
		{
			item.consumeAmmo();
			if (this.canDoubleGrip());
				item.consumeAmmo();
		}
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local success = this.attackEntity(_user, _targetTile.getEntity());
		this.consumeAmmo();
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);

			if (!this.canDoubleGrip())
				return success;

			if (::Legends.S.isEntityNullOrDead(target))
				return success;

			::Time.scheduleEvent(::TimeUnit.Virtual, 150, function ( _skill )
			{

				success = this.attackEntity(_user, target) || success;
				_skill.m.IsDoingAttackMove = true;
				_skill.getContainer().setBusy(false);
			}.bindenv(this), this);		
		}
		else if (!::Legends.S.isEntityNullOrDead(target))
		{
			return this.attackEntity(_user, target) || success;
		}

		return success;
	}

	function onTargetHit ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill != this)
			return;

		if (::Legends.S.isEntityNullOrDead(_targetEntity))
			return;

		if (!_bodyPart == ::Const.BodyPart.Head)
			return;

		if (this.Math.rand(1, 100) <= this.m.DistractedChance)
		{
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Distracted);
			if (!this.getContainer().getActor().isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " distracted");
		}
	}

	function onAfterUpdate ( _properties )
	{
		if (this.getContainer().hasPerk(::Legends.Perk.LegendPointBlank))
			this.m.MinRange = 1;

		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.AdditionalAccuracy = 20 + this.m.Item.getAdditionalAccuracy();
		this.m.ActionPointCost = this.getContainer().hasPerk(::Legends.Perk.LegendAmbidextrous) ? 3 : 4;
		this.m.DistractedChance = _properties.IsSpecializedInDaggers ? 50 : 25;
	}

	function onAnySkillUsed ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageTotalMult *= 0.7;
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}

});

