::mods_hookExactClass("skills/actives/charm_skill", function(o)
{
	local isViableTarget = o.isViableTarget;
	o.isViableTarget = function  ( _user, _target )
	{
		local ret = isViableTarget( _user, _target );

		if (_target.getSkills().hasEffect(::Legends.Effect.LegendIntenselyCharmed))
		{
			return false;
		}

		return ret;
	}

	o.onDelayedEffect = function ( _tag )
	{
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;
		local target = _targetTile.getEntity();
		local time = this.Tactical.spawnProjectileEffect("effect_heart_01", _user.getTile(), _targetTile, 0.33, 2.0, false, false);
		local self = this;
		this.Time.scheduleEvent(this.TimeUnit.Virtual, time, function ( _e )
		{
			local bonus = _targetTile.getDistanceTo(_user.getTile()) == 1 ? -5 : 0;

			if (target.getSkills().hasSkill("background.eunuch") || target.getSkills().hasTrait(::Legends.Trait.Player) || target.getSkills().hasTrait(::Legends.Trait.Loyal))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " can not be charmed");
				}

				return false;
			}


			if (target.checkMorale(0, -35 + bonus, this.Const.MoraleCheckType.MentalAttack))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being charmed thanks to his resolve");
				}

				return false;
			}

			if (target.checkMorale(0, -35 + bonus, this.Const.MoraleCheckType.MentalAttack))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being charmed thanks to his resolve");
				}

				return false;
			}

			if (target.getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50)
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being charmed thanks to his unnatural physiology");
				}

				return false;
			}

			this.m.Slaves.push(target.getID());

			::Legends.Effects.grant(target, ::Legends.Effect.Charmed, function(_effect) {
				_effect.setMasterFaction(_user.getFaction() == this.Const.Faction.Player ? this.Const.Faction.PlayerAnimals : _user.getFaction());
				_effect.setMaster(self);
			}.bindenv(this));

			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " is charmed");
			}

			_user.setCharming(true);
		}.bindenv(this), this);
	}
});
