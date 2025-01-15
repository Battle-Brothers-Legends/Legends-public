::mods_hookExactClass("skills/actives/repel", function(o)
{
	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		this.m.IsAttack = false; // work around to allow targeting on allies
		local result = this.skill.onVerifyTarget(_originTile, _targetTile);
		this.m.IsAttack = true;
		return result && !_targetTile.getEntity().getCurrentProperties().IsRooted;
	}

	o.onUse = function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (this.Math.rand(1, 100) > this.getHitchance(_targetTile.getEntity()))
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}

			local overwhelm = this.getContainer().getSkillByID("perk.overwhelm");

			if (overwhelm != null)
			{
				overwhelm.onTargetMissed(this, target);
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

		if (!target.getSkills().hasSkill("effects.legend_break_stance"))
			target.getSkills().add(this.new("scripts/skills/effects/legend_break_stance_effect"));

		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		if (!this.getContainer().hasTrait(::Legends.Trait.Teamplayer) || !_targetEntity.isAlliedWith(getContainer().getActor()))
			target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
		}

		local overwhelm = this.getContainer().getSkillByID("perk.overwhelm");

		if (overwhelm != null)
		{
			overwhelm.onTargetHit(this, target, this.Const.BodyPart.Body, 0, 0);
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
