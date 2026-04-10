::mods_hookExactClass("skills/effects/debilitating_attack_effect", function(o) {

	o.m.SkillCount <- 0,
	o.m.LastTargetID <- 0
	o.m.TimeAdded <- 0

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Overlay = "status_effect_01";
	}

	o.getDescription <- function () {
		return "This character has a debilitating attack prepared. Hitting a target will temporarily reduce their ability to inflict damage and increase damage recieved for three turns. Effect removes itself on turn end or after attacking. Works on Attacks of Opportunity";
	}

	o.getTooltip = function ()
	{
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
				text = "[color=%negative%]-25%[/color] Damage inflicted by target hit for three turns"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=%negative%]+15%[/color] Damage taken by target hit for three turns"
			}
		];
	}

	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getContainer().getActor().getID())
			return;

		if (::Legends.S.isEntityNullOrDead(this.getContainer().getActor(), _targetEntity))
			return;

		if (_targetEntity.isAlliedWith(this.getContainer().getActor()))
			return;

		if (!_targetEntity.isTurnStarted() && !_targetEntity.isTurnDone())
		{
			if (this.m.SkillCount == this.Const.SkillCounter && this.m.LastTargetID == _targetEntity.getID())
			{
				return;
			}

			this.m.SkillCount = this.Const.SkillCounter;
			this.m.LastTargetID = _targetEntity.getID();
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Debilitated);
		}
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (!_skill.isAttack())
			return;

		if (_targetEntity == null || !_targetEntity.isAttackable())
			return;

		if (!this.m.IsGarbage && this.m.TimeAdded + 0.1 < this.Time.getVirtualTimeF() && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
			this.removeSelf();
	}

});
