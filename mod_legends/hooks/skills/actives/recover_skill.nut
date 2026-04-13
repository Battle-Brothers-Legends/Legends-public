::mods_hookExactClass("skills/actives/recover_skill", function (o) {
	o.m.IsFirstSkill <- true;
	o.m.FatPerAP <- 0.08;
	o.m.UsedAP <- 0;

	o.getTooltip = function () {
		local ret = [
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Current Fatigue is reduced by [color=%positive%]" + getRecoveredFat(getActionPointCost()) + "%[/color] of maximum fatigue"
			}
		];

		if (!this.m.IsFirstSkill) {
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "[color=%negative%]Must be the first skill to be used on this character\'s turn[/color]"
			});
		}

		return ret;
	}

	o.onTurnStart <- function () {
		this.m.IsFirstSkill = true;
	}

	o.isUsable <- function () {
		return skill.isUsable() && this.m.IsFirstSkill;
	}

	o.getActionPointCost <- function () {
		return getContainer().getActor().getActionPoints();
	}
	
	o.onAnySkillExecuted <- function(_skill, _targetTile, _targetEntity, _forFree)
	{
		this.m.IsFirstSkill = false;
	}

	o.use <- function (_targetTile, _forFree = false) {
		m.UsedAP = getActionPointCost();
		return skill.use(_targetTile, _forFree);
	}

	o.onUse = function (_user, _targetTile) {
		_user.setFatigue(::Math.max(0, _user.getFatigue() - getRecoveredFat(m.UsedAP)));

		if (!_user.isHiddenToPlayer()) {
			_user.playSound(this.Const.Sound.ActorEvent.Fatigue, this.Const.Sound.Volume.Actor * _user.getSoundVolume(this.Const.Sound.ActorEvent.Fatigue));
		}

		m.UsedAP = 0;
		return true;
	}

	o.getRecoveredFat <- function (_usedAP) {
		return _usedAP * m.FatPerAP * getContainer().getActor().getFatigueMax();
	}
	
	o.onCombatFinished <- function()
	{
		this.m.IsFirstSkill = true;
	}
});
