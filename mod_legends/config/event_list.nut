::Legends.EventList <- {
	StatGain = "%s gains [color=%s]+%d[/color] %s",
	StatLose = "%s loses [color=%s]-%d[/color] %s",
	LightWound = "%s suffers light wounds",
	Injury = "%s suffers %s",
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
	_bro.getBaseProperties().Hitpoints += _value;
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/health.png", "Hitpoints");
}

::Legends.EventList.changeResolve <- function (_bro, _value) {
	_bro.getBaseProperties().Bravery += _value;
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/bravery.png", "Resolve");
}

::Legends.EventList.changeFatigue <- function (_bro, _value) {
	_bro.getBaseProperties().Stamina += _value;
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/fatigue.png", "Max Fatigue");
}

::Legends.EventList.changeMeleeSkill <- function (_bro, _value) {
	_bro.getBaseProperties().MeleeSkill += _value;
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/melee_skill.png", "Melee Skill");
}

::Legends.EventList.changeMeleeDefense <- function (_bro, _value) {
	_bro.getBaseProperties().MeleeDefense += _value;
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/melee_defense.png", "Melee Defense");
}

::Legends.EventList.changeRangedSkill <- function (_bro, _value) {
	_bro.getBaseProperties().RangedSkill += _value;
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/ranged_skill.png", "Ranged Skill");
}

::Legends.EventList.changeRangedDefense <- function (_bro, _value) {
	_bro.getBaseProperties().RangedDefense += _value;
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/ranged_defense.png", "Ranged Defense");
}

::Legends.EventList.changeInitiative <- function (_bro, _value) {
	_bro.getBaseProperties().Initiative += _value;
	return ::Legends.EventList.changeStat(_bro.getName(), _value, "ui/icons/initiative.png", "Initiative");
}

::Legends.EventList.changeMood <- function (_bro, _value = 0, _cause = "") {
	if (_value > 0)
		_bro.improveMood(_value, _cause);
	else if (_value < 0)
		_bro.worsenMood(_value * -1.0, _cause);
	return {
		id = 10,
		icon = ::Const.MoodStateIcon[_bro.getMoodState()],
		text = _bro.getName() + ::Const.MoodStateEvent[_bro.getMoodState()]
	}
}


::Legends.EventList.addInjury <- function (_bro, _injuryConst) {
	local injury = _bro.addInjury(_injuryConst);
	return {
		id = 10,
		icon = injury.getIcon(),
		text = ::format(::Legends.EventList.Injury, _bro.getName(), injury.getNameOnly())
	};
}

::Legends.EventList.addLightInjury <- function (_bro) {
	_bro.addLightInjury();
	return {
		id = 10,
		icon = "ui/icons/days_wounded.png",
		text = ::format(::Legends.EventList.LightWound, _bro.getName())
	};
}

::Legends.EventList.addItems <- function (_itemList, _stash = null,  _prefix = "You gain ") {
	if (_stash != null)
		_stash.makeEmptySlots(_itemList.len());
	local grouped = {};
	foreach (item in _itemList) {
		if (_stash != null)
			_stash.add(item);
		if (item.getID() in grouped) {
			grouped[item.getID()].count++;
			continue;
		}
		grouped[item.getID()] <- {
			item = item,
			count = 1
		};
	}

	local list = [];
	foreach (entry in grouped) {
		list.push({
			id = 1,
			icon = "ui/items/" + entry.item.getIcon(),
			text = _prefix + (entry.count > 1 ? ::format("%dx ", entry.count) : "") + entry.item.getName()
		});
	}
	return list;
}
