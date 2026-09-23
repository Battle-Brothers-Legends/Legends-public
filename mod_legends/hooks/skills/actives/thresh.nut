::mods_hookExactClass("skills/actives/thresh", function (o) {
	o.m.IsChain <- false;

	local create = o.create;
	o.create = function () {
		create();
		this.m.HitChanceBonus = -15;
	}

	o.setItem <- function (_item) {
		if (this.m.IsChain) {
			this.m.Name = "Chain Thresh";
			this.m.Description = "Threshing all the targets around you, foe and friend alike, with a reckless round swing. Not hard to evade because it is not aimed at anything. Has a chance to daze targets hit for one turn. Be careful around your own men unless you want to relieve your payroll!";
			this.m.KilledString = "Threshed";
			this.m.ChanceDisembowel = 10;
			this.m.ChanceSmash = 33;
		}
		this.skill.setItem(_item);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();

		if (this.m.IsChain) {
			foreach (tooltip in ret) {
				if (tooltip.id == 8) {
					tooltip.text = "Has a [color=%positive%]" + this.m.StunChance + "%[/color] chance to daze on a hit";
				}
			}
		}
		return ret;
	}

	o.onUse = function (_user, _targetTile) {
		local ret = false;
		local myTile = this.m.Container.getActor().getTile();
		local soundBackup = [];
		local skillToApply = this.m.IsChain ? ::Legends.Effect.Dazed : ::Legends.Effect.Stunned;
		this.spawnAttackEffect(myTile, ::Const.Tactical.AttackEffectThresh);

		for (local i = 0; i < 6; i++) {
			if (myTile.hasNextTile(i)) {
				local nextTile = myTile.getNextTile(i);
				if (!nextTile.IsEmpty) {
					local target = nextTile.getEntity();

					if (target.isAttackable() && ::Math.abs(nextTile.Level - myTile.Level) <= 1) {
						if (ret && soundBackup.len() == 0) {
							soundBackup = this.m.SoundOnHit;
							this.m.SoundOnHit = [];
						}

						local success = this.attackEntity(_user, target);
						ret = success || ret;

						if (!::Legends.S.isEntityNullOrDead(_user) && !::Legends.S.isEntityNullOrDead(_user)) {
							if (success && nextTile.IsOccupiedByActor && ::Math.rand(1, 100) <= this.m.StunChance && !target.getCurrentProperties().IsImmuneToBleeding && !target.getSkills().hasEffect(skillToApply)) {
								if (!_user.isHiddenToPlayer() && nextTile.IsVisibleForPlayer) {
									::Tactical.EventLog.log(::Legends.Effects.grant(target, ::Legends.Effect.Dazed).getLogEntryOnAdded(::Const.UI.getColorizedEntityName(_user), ::Const.UI.getColorizedEntityName(target)));
								}
							}
						}
					}
				}
			}
		}

		if (ret && this.m.SoundOnHit.len() == 0) {
			this.m.SoundOnHit = soundBackup;
		}

		return ret;
	}
});
