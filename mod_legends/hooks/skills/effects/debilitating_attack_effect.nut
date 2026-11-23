::mods_hookExactClass("skills/effects/debilitating_attack_effect", function (o) {

	o.m.SkillCount <- 0;
	o.m.LastTargetID <- 0;

	local create = o.create;
	o.create = function () {
		create();
		this.m.Overlay = "status_effect_01";
	}

	o.getDescription <- function () {
		return "This character has a debilitating attack prepared. Hitting a target will temporarily reduce their ability to inflict damage and increase damage received for two turns. Effect removes itself on turn end or after attacking. Works on Attacks of Opportunity";
	}

	o.getTooltip = function () {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%negative%]-25%[/color] Damage inflicted by target hit for two turns"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%negative%]+15%[/color] Damage taken by target hit for two turns"
			}
		];
	}

	o.onTargetHit = function (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		local actor = _skill.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor, _targetEntity)) {
			return;
		}

		if (_targetEntity.isAlliedWith(actor)) {
			return;
		}

		if (this.m.SkillCount == this.Const.SkillCounter && this.m.LastTargetID == _targetEntity.getID()) {
			return;
		}

		this.m.SkillCount = this.Const.SkillCounter;
		this.m.LastTargetID = _targetEntity.getID();
		local debilitate = ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Debilitated);
		if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer && !_targetEntity.getFlags().has("tail")) {
			this.Tactical.EventLog.log(debilitate.getLogEntryOnAdded(this.Const.UI.getColorizedEntityName(actor), this.Const.UI.getColorizedEntityName(_targetEntity)));
		}
		this.removeEffectAfterAllTargetsHit(_skill);
	}

	o.onTargetMissed = function (_skill, _targetEntity) {
		this.removeEffectAfterAllTargetsHit(_skill);
	}

	o.removeEffectAfterAllTargetsHit <- function (_skill) {
		local actor = _skill.getContainer().getActor();
		if (!_skill.isAOE()) {
			this.removeSelf();
			actor.setDirty(true);
		} else {
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 10, function (_effect) {
				_effect.removeSelf();
				actor.setDirty(true);
			}, this);
		}
	}

});
