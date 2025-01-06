::mods_hookExactClass("skills/actives/hook", function(o)
{
	o.m.IsChain <- false;

	local create = o.create;
	o.create = function ()
	{
		create();
		if (this.m.IsChain)
		{
			this.m.Description = "A target up to 3 tiles away is hooked and pulled close if there is space. Anyone hit will be staggered and lose initiative. A target can not be pulled up a level of height, but may take damage if it is pulled down several levels of height at once. Shieldwall, Spearwall and Riposte will be canceled for a successfully hooked-in target. A rooted target can not be hooked.";
			this.m.MaxRange = 3;
			this.m.FatigueCost = 30;
		}
	}

	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		this.m.IsAttack = false; // work around to allow targeting on allies
		local result = this.skill.onVerifyTarget(_originTile, _targetTile);
		this.m.IsAttack = true;

		if (!result || _targetTile.getEntity().getCurrentProperties().IsRooted)
			return false;

		return this.getPulledToTile(_originTile, _targetTile) != null;
	}

	o.onUse = function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (this.Math.rand(1, 100) > this.getHitchance(target))
		{
			return false;
		}

		local pullToTile = this.getPulledToTile(_user.getTile(), _targetTile);

		if (pullToTile == null)
		{
			return false;
		}

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			return false;
		}

		if (!_user.isHiddenToPlayer() && pullToTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " hooks in " + this.Const.UI.getColorizedEntityName(target));
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

		local overwhelm = this.getContainer().getSkillByID("perk.overwhelm");

		if (overwhelm != null)
		{
			overwhelm.onTargetHit(this, target, this.Const.BodyPart.Body, 0, 0);
		}

		target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		local damage = this.Math.max(0, this.Math.abs(pullToTile.Level - _targetTile.Level) - 1) * this.Const.Combat.FallingDamage;
		local tag = {
			Attacker = _user,
			Skill = this,
			HitInfo = clone this.Const.Tactical.HitInfo
		};

		if (damage == 0)
		{
			this.Tactical.getNavigator().teleport(_targetTile.getEntity(), pullToTile, this.onHookingComplete, tag, true);
		}
		else
		{
			tag.HitInfo.DamageRegular = damage;
			tag.HitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit;
			tag.HitInfo.DamageDirect = 1.0;
			tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
			this.Tactical.getNavigator().teleport(target, pullToTile, this.onPulledDown, tag, true);
		}

		return true;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		if (this.m.IsChain)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInFlails ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
			this.m.ActionPointCost = _properties.IsSpecializedInFlails ? 5 : 6;
		}
		else
		{
			onAfterUpdate( _properties );
		}
	}

	o.onTargetSelected <- function ( _targetTile )
	{
		local knockToTile = this.getPulledToTile(getContainer().getActor().getTile(), _targetTile);

		if (knockToTile == null)
			return;
		// to show where the target may be knocked back
		this.Tactical.getHighlighter().addOverlayIcon("mortar_target_02", knockToTile, knockToTile.Pos.X, knockToTile.Pos.Y);
	}

	o.getHitchance <- function ( _targetEntity )
	{
		if (this.getContainer().hasSkill("trait.teamplayer") && _targetEntity.isAlliedWith(getContainer().getActor()))
			return 100;

		return this.skill.getHitchance(_targetEntity);
	}
});
