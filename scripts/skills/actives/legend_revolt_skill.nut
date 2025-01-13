this.legend_revolt_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_revolt";
		this.m.Name = "Revolt";
		this.m.Description = "Concoct a mixture of smells so fetid and noxious, you force your target to retreat just so they can breathe. Targets hit will receive fatigue and may take damage if they are pushed down several levels of height. Shieldwall, Spearwall and Riposte will be canceled for a target that is successfully knocked back. A rooted target can not be knocked back. Uses Ranged Skill.";
		this.m.Icon = "skills/revolt_square.png";
		this.m.IconDisabled = "skills/revolt_square_bw.png";
		this.m.Overlay = "revolt_square";
		this.m.SoundOnHit = [
			"sounds/combat/knockback_hit_01.wav",
			"sounds/combat/knockback_hit_02.wav",
			"sounds/combat/knockback_hit_03.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/impale_01.wav",
			"sounds/combat/impale_02.wav",
			"sounds/combat/impale_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsTooCloseShown = true;
		this.m.HitChanceBonus = 10;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]6[/color] tiles"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to stagger on a hit"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] chance to hit"
		});

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaves)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] chance to hit targets directly adjacent, unless specialised in staves"
			});
		}

		return ret;
	}

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		local dir = _userTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local knockToTile = _targetTile.getNextTile(dir);

			if (knockToTile.IsEmpty && knockToTile.Level - _userTile.Level <= 1)
			{
				return knockToTile;
			}
		}

		local altdir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _userTile.Level <= 1)
			{
				return knockToTile;
			}
		}

		altdir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _userTile.Level <= 1)
			{
				return knockToTile;
			}
		}

		return null;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInStaves ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInStaves ? 2 : 3;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getCurrentProperties().IsRooted)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (this.Math.rand(1, 100) > this.getHitchance(target))
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}

			target.onMissed(this.getContainer().getActor(), this);
			return false;
		}

		local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);

		if (knockToTile == null)
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}

			return false;
		}

		this.applyFatigueDamage(target, 10);

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}

			return false;
		}

		if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has knocked back " + this.Const.UI.getColorizedEntityName(target));
		}

		local skills = target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");

		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
		}

		target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - _targetTile.Level) - 1) * this.Const.Combat.FallingDamage;

		if (damage == 0)
		{
			this.Tactical.getNavigator().teleport(target, knockToTile, null, null, true);
		}
		else
		{
			local p = this.getContainer().getActor().getCurrentProperties();
			local tag = {
				Attacker = _user,
				Skill = this,
				HitInfo = clone this.Const.Tactical.HitInfo,
				HitInfoBash = null
			};
			tag.HitInfo.DamageRegular = damage;
			tag.HitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit;
			tag.HitInfo.DamageDirect = 1.0;
			tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
			tag.HitInfo.BodyDamageMult = 1.0;
			tag.HitInfo.FatalityChanceMult = 1.0;
			this.Tactical.getNavigator().teleport(target, knockToTile, this.onKnockedDown, tag, true);
		}

		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += 10;

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaves && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.RangedSkill += -15;
				this.m.HitChanceBonus = -5;
			}
			else
			{
				this.m.HitChanceBonus = 10;
			}
		}
	}

	function onKnockedDown( _entity, _tag )
	{
		if (_tag.HitInfo.DamageRegular != 0)
		{
			_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
		}

		if (_tag.HitInfoBash != null)
		{
			_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfoBash);
		}
	}

});
