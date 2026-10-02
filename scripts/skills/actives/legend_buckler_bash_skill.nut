this.legend_buckler_bash_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendBucklerBash);
		this.m.Description = "A quick punch forward with a solid buckler. Anyone hit with a blow like this will be dazed and gasping for air, unable to put full force behind their blows for two turns.";
		this.m.KilledString = "Bashed to death";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/cudgel", 3);
		this.m.SoundOnHit = ::Legends.S.setSounds("sounds/combat/cudgel_hit", 4);
		this.m.SoundVolume = 1.25;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = false;
		this.m.InjuriesOnBody = ::Const.Injury.BluntBody;
		this.m.InjuriesOnHead = ::Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.2;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 33;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local fatPerHit = (this.getContainer().getActor().getCurrentProperties().FatigueDealtPerHitMult + 1) * ::Const.Combat.FatigueReceivedPerHit;
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=%damage%]" + fatPerHit + "[/color] extra fatigue"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%positive%]100%[/color] chance to baffle on a hit"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInShields ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (this.getContainer().hasPerk(::Legends.Perk.ShieldBash))
		{
			this.m.FatigueCostMult = this.m.FatigueCostMult *= 0.75;
			this.m.ActionPointCost = 3;
		}
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, target);

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && target.isAlive())
		{
			::Legends.Effects.grant(target, ::Legends.Effect.LegendBaffled);

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " struck a blow that leaves " + ::Const.UI.getColorizedEntityName(target) + " baffled");
			}
		}

		return success;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			_properties.DamageRegularMin = this.getItem().m.RegularDamage;
			_properties.DamageRegularMax = this.getItem().m.RegularDamageMax;
			_properties.DamageArmorMult = 0.5;
			_properties.FatigueDealtPerHitMult += 1.0;
			if (this.getContainer().hasPerk(::Legends.Perk.ShieldBash)) {
				_properties.DamageRegularMin += 3;
				_properties.DamageRegularMax += 5;
			}
		}
	}

	function onAnySkillExecuted(_skill, _targetTile, _targetEntity, _forFree) {
		local actor = this.getContainer().getActor();

		if (actor.getCurrentProperties().IsSpecializedInShields) {
			return;
		}

		if (_skill == this) {
			return;
		}

		if (!_skill.m.IsAttack) {
			return;
		}

		if (_forFree) {
			return;
		}

		if (::Legends.S.isEntityNullOrDead(actor, _targetEntity)) {
			return;
		}

		if (actor.getTile().getDistanceTo(_targetEntity.getTile()) > 1) {
			return;
		}

		if (_targetEntity != null) {
			::Time.scheduleEvent(::TimeUnit.Virtual, ::Const.Combat.RiposteDelay, function (_skill) {
				if (::Legends.S.isEntityNullOrDead(_targetEntity) || !_targetEntity.isPlacedOnMap() || _targetEntity.getTile() == null) {
					return;
				}
				::Const.SkillCounter++;
				_skill.executeFollowUpAttack({
					TargetTile = _targetEntity.getTile(),
					Skill = this
				});
			}.bindenv(this), this);
		}
	}

	function executeFollowUpAttack(_info) {
		local actor = this.getContainer().getActor();
		local entity = _info.TargetTile.getEntity();
		if (::Legends.S.isEntityNullOrDead(entity) || ::Legends.S.isEntityNullOrDead(actor)) {
			return;
		}
		if (::MSU.isNull(_info.Skill)) {
			::logWarning("buckler bash is null for follow up attack for some reason");
			return;
		}
		
		_info.Skill.m.IsExecutingOffhand = true;
		_info.Skill.useForFree(_info.TargetTile);
	}

});

