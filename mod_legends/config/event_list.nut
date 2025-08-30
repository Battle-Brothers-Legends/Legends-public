::Legends.EventList <- {
	StatGain = "%s gains [color=%s]+%d[/color] %s",
	StatLose = "%s loses [color=%s]-%d[/color] %s"
}

::Legends.EventList.changeStat <- function (_name, _value, _icon, _skill) {
	return {
		id = 17,
		icon = _icon,
		text = (_value > 0) ?
			::format(::Legends.EventList.StatGain, _name, ::Const.UI.Color.PositiveEventValue, ::Math.abs(_value), _skill):
			::format(::Legends.EventList.StatLose, _name, ::Const.UI.Color.NegativeEventValue, ::Math.abs(_value), _skill)
	}
}

::Legends.EventList.changeHitpoints <- function (_bro, _value) {
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/health.png", "Hitpoints");
}

::Legends.EventList.changeResolve <- function (_bro, _value) {
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/bravery.png", "Resolve");
}

::Legends.EventList.changeFatigue <- function (_bro, _value) {
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/fatigue.png", "Max Fatigue");
}

::Legends.EventList.changeMeleeSkill <- function (_bro, _value) {
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/melee_skill.png", "Melee Skill");
}

::Legends.EventList.changeMeleeDefense <- function (_bro, _value) {
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/melee_defense.png", "Melee Defense");
}

::Legends.EventList.changeRangedSkill <- function (_bro, _value) {
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/ranged_skill.png", "Ranged Skill");
}

::Legends.EventList.changeMeleeDefense <- function (_bro, _value) {
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/ranged_defense.png", "Ranged Defense");
}

::Legends.EventList.changeMeleeDefense <- function (_bro, _value) {
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/initiative.png", "Initiative");
}

::Legends.EventList.changeMood <- function (_bro) {
	return {
		id = 10,
		icon = ::Const.MoodStateIcon[_bro.getMoodState()],
		text = _bro.getName() + ::Const.MoodStateEvent[_bro.getMoodState()]
	}
}
