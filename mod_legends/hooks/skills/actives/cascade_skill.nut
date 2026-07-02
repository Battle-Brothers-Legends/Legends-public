::mods_hookExactClass("skills/actives/cascade_skill", function (o) {
	o.getTooltip = function () {
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will make three separate strikes for one third of the weapon\'s damage each."
			}
		]);
		return ret;
	}

	o.onUse = function (_user, _targetTile) {
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectChop);
		local target = _targetTile.getEntity();
		local ret = this.attackEntity(_user, target);

		if (::Legends.S.isEntityNullOrDead(target)) {
			return ret;
		}

		local tumble = ::Legends.Perks.get(target, ::Legends.Perk.LegendTumble);

		if (::Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)) {
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);
			::Time.scheduleEvent(::TimeUnit.Virtual, 50, function (_skill) {
				if (!::Legends.S.isEntityNullOrDead(target) && _skill.getContainer() != null && (tumble == null || !tumble.m.IsTumbling)) {
					_skill.attackEntity(_user, target);
				}
			}.bindenv(this), this);
			::Time.scheduleEvent(::TimeUnit.Virtual, 100, function (_skill) {
				if (!::Legends.S.isEntityNullOrDead(target) && _skill.getContainer() != null && (tumble == null || !tumble.m.IsTumbling)) {
					_skill.attackEntity(_user, target);
				}

				_skill.m.IsDoingAttackMove = true;
				_skill.getContainer().setBusy(false);
			}.bindenv(this), this);
			return true;
		} else {
			if (!::Legends.S.isEntityNullOrDead(target) && (tumble == null || !tumble.m.IsTumbling)) {
				ret = this.attackEntity(_user, target) || ret;
			}

			if (!::Legends.S.isEntityNullOrDead(target) && (tumble == null || !tumble.m.IsTumbling)) {
				ret = this.attackEntity(_user, target) || ret;
			}

			return ret;
		}
	}
});
