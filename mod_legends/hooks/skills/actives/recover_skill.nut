::mods_hookExactClass("skills/actives/recover_skill", function(o)
{
	o.m.CurrentSkillCount <- 0;
	o.m.FatPerAP <- 0.055;
	o.m.UsedAP <- 0;

	o.getTooltip = function ()
	{
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
				text = "Current Fatigue is reduced by [color=" + ::Const.UI.Color.PositiveValue + "]" + getRecoveredFat(getActionPointCost()) + "%[/color] of maximum fatigue"
			}
		];

		if (!isFirstSkillBeUsed())
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Must be this character\'s first skill to be used on their turn[/color]"
			})

		return ret;
	}

	o.isFirstSkillBeUsed <- function()
	{
		return ::Const.SkillCounter == m.CurrentSkillCount;
	}

	o.onTurnStart <- function()
	{
		m.CurrentSkillCount = ::Const.SkillCounter;
	}

	o.isUsable <- function()
	{
		return skill.isUsable() && isFirstSkillBeUsed();
	}

	o.getActionPointCost <- function()
	{
		return getContainer().getActor().getActionPoints();
	}

	o.use <- function( _targetTile, _forFree = false )
	{
		m.UsedAP = getActionPointCost();
		return skill.use(_targetTile, _forFree);
	}

	o.onUse = function ( _user, _targetTile )
	{
		_user.setFatigue(::Math.max(0, _user.getFatigue() - getRecoveredFat(m.UsedAP)));

		if (!_user.isHiddenToPlayer())
			_user.playSound(this.Const.Sound.ActorEvent.Fatigue, this.Const.Sound.Volume.Actor * _user.getSoundVolume(this.Const.Sound.ActorEvent.Fatigue));

		m.UsedAP = 0;
		return true;
	}

	o.getRecoveredFat <- function( _usedAP )
	{
		return _usedAP * m.FatPerAP * getContainer().getActor().getFatigueMax();
	}

});
