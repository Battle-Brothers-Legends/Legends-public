::mods_hookExactClass("skills/actives/knock_back", function(o)
{
	o.m.RegularDamage <- 10;
	o.m.RegularDamageMax <- 25;
	o.m.TilesUsed <- [];

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.FatigueCost = 15;
	}

	o.setDamage <- function (_extraShieldDamageMin, _extraShieldDamageMax)
	{
		this.m.RegularDamage += _extraShieldDamageMin;
		this.m.RegularDamageMax += _extraShieldDamageMax;
	}

	o.getTooltip = function ()
	{
		local ret = this.getContainer().hasPerk(::Legends.Perk.ShieldBash) ? this.getDefaultTooltip() : this.getDefaultUtilityTooltip();
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+40%[/color] chance to hit"
			});
		}
		else
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] chance to hit"
			});
		}

		if (this.getContainer().hasSkill("trait.oath_of_fortification"))
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to stagger on a hit"
			});
		}
		return ret;
	}

	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		this.m.IsAttack = false; // work around to allow targeting on allies
		local result = this.skill.onVerifyTarget(_originTile, _targetTile);
		this.m.IsAttack = true;
		return result;
	}

	o.onTargetHit <- function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.m.TilesUsed = [];
		if (_skill != this)
			return;

		if (!_targetEntity.isAlive() || _targetEntity.isDying())
			return;

		if (_targetEntity.isNonCombatant())
			return;

		local user = _skill.getContainer().getActor();

		if (!_targetEntity.getSkills().hasSkill("effects.legend_break_stance"))
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/legend_break_stance_effect"));

		if (user.getSkills().hasTrait(::Legends.Trait.OathOfFortification) && _targetTile.IsOccupiedByActor && !_targetEntity.isNonCombatant())
		{
			if (!this.getContainer().hasTrait(::Legends.Trait.Teamplayer) || !_targetEntity.isAlliedWith(getContainer().getActor()))
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

				if (!user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " has staggered " + this.Const.UI.getColorizedEntityName(_targetEntity) + " for one turn");
				}
			}
		}

		if (_targetEntity.getCurrentProperties().IsRooted || _targetEntity.getCurrentProperties().IsImmuneToKnockBackAndGrab)
			return;

		local knockToTile = this.findTileToKnockBackTo(user.getTile(), _targetEntity.getTile());

		if (knockToTile == null)
			return;

		this.m.TilesUsed.push(knockToTile.ID);

		if (!user.isHiddenToPlayer() && (_targetEntity.getTile().IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " has knocked back " + this.Const.UI.getColorizedEntityName(_targetEntity));
		}

		_targetEntity.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - _targetEntity.getTile().Level) - 1) * this.Const.Combat.FallingDamage;
		if (damage == 0)
		{
			this.Tactical.getNavigator().teleport(_targetEntity, knockToTile, null, null, true);
		}
		else
		{
			local p = user.getCurrentProperties();
			local tag = {
				Attacker = user,
				Skill = _skill,
				HitInfo = clone this.Const.Tactical.HitInfo
			};
			tag.HitInfo.DamageRegular = damage;
			tag.HitInfo.DamageDirect = 1.0;
			tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
			tag.HitInfo.BodyDamageMult = 1.0;
			tag.HitInfo.FatalityChanceMult = 1.0;
			this.Tactical.getNavigator().teleport(_targetEntity, knockToTile, this.onKnockedDown, tag, true);
		}

		this.m.TilesUsed = [];
		return true;

	}

	o.onKnockedDown <- function ( _entity, _tag )
	{
		if (_tag.Skill.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(_tag.Skill.m.SoundOnHit[this.Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _entity.getPos());
		}

		if (_tag.HitInfo.DamageRegular != 0)
		{
			_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
		}
	}

	o.onUse = function ( _user, _targetTile )
	{
		if (this.m.SoundOnUse.len() != 0)
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());

		if (this.getContainer().hasTrait(::Legends.Trait.Teamplayer) && _targetTile.getEntity().isAlliedWith(getContainer().getActor()))
			return true;
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	o.onAfterUpdate <- function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInShields ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.ShieldBash))
		{
			this.m.FatigueCostMult = this.m.FatigueCostMult *= 0.75;
			this.m.ActionPointCost = 3
		}
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local actor = this.getContainer().getActor();
			if (this.getContainer().hasPerk(::Legends.Perk.ShieldBash))
			{
				local shieldBonus = this.Math.min(10, this.Math.floor(actor.getOffhandItem().m.ConditionMax * 0.05));
				_properties.DamageRegularMin = this.m.RegularDamage + shieldBonus;
				_properties.DamageRegularMax = this.m.RegularDamageMax + shieldBonus;
				_properties.DamageArmorMult = 0.5;
				_properties.FatigueDealtPerHitMult += 1.0;

			}
		}
	}

	o.onTargetSelected <- function ( _targetTile )
	{
		local knockToTile = this.findTileToKnockBackTo(getContainer().getActor().getTile(), _targetTile);

		if (knockToTile == null)
			return;
		// to show where the target may be knocked back
		this.Tactical.getHighlighter().addOverlayIcon("mortar_target_02", knockToTile, knockToTile.Pos.X, knockToTile.Pos.Y);
	}

	o.getHitchance <- function ( _targetEntity )
	{
		if (this.getContainer().hasTrait(::Legends.Trait.Teamplayer) && _targetEntity.isAlliedWith(getContainer().getActor()))
			return 100;

		return this.skill.getHitchance(_targetEntity);
	}
});
