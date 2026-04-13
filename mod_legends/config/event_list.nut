::Legends.EventList <- {
	StatGain = "%s gains [color=%s]+%d[/color] %s",
	StatLose = "%s loses [color=%s]-%d[/color] %s",
	LightWound = "%s suffers light wounds",
	HeavyWound = "%s suffers heavy wounds",
	Injury = "%s suffers %s",
	RenownGain = "You gain [color=%s]%s[/color] of Renown",
	RenownLose = "You lose [color=%s]%s[/color] of Renown",
	GoldGain = "You gain [color=%s]%d[/color] Crowns",
	GoldLose = "You lose [color=%s]%d[/color] Crowns",
	Amount = [
		"a small amount",
		"a decent amount",
		"a large amount",
		"a considerable amount"
	]
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
::Legends.EventList.changeBroExperience <- function (_bro, _value) {
	_bro.addXP(_value);
	_bro.updateLevel();
	return {
		id = 10,
		icon = "ui/icons/xp_received.png",
		text = _bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]" + _value + "[/color] Experience"
	};
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
::Legends.EventList.addHeavyInjury <- function (_bro) {
	_bro.addHeavyInjury();
	return {
		id = 10,
		icon = "ui/icons/days_wounded.png",
		text = ::format(::Legends.EventList.HeavyWound, _bro.getName())
	};
}

::Legends.EventList.changeRenown <- function (_renown) {
	::World.Assets.addBusinessReputation(_renown);
	return {
		id = 10,
		icon = "ui/icons/special.png",
		text = (_renown > 0) ?
			::format(::Legends.EventList.RenownGain, this.Const.UI.Color.PositiveEventValue, function(_amount) {
				if (_amount <= 50)
					return ::Legends.EventList.Amount[0];
				if (_amount <= 75)
					return ::Legends.EventList.Amount[1];
				if (_amount <= 100)
					return ::Legends.EventList.Amount[2];
				return ::Legends.EventList.Amount[3];
			} (_renown))
			:
			::format(::Legends.EventList.RenownLose, this.Const.UI.Color.NegativeEventValue, function(_amount) {
				if (_amount <= 50)
					return ::Legends.EventList.Amount[0];
				if (_amount <= 75)
					return ::Legends.EventList.Amount[1];
				if (_amount <= 100)
					return ::Legends.EventList.Amount[2];
				return ::Legends.EventList.Amount[3];
			} (::Math.abs(_renown)))
	};
}

::Legends.EventList.changeMoney <- function (_amount) {
	::World.Assets.addMoney(_amount);
	return {
		id = 10,
		icon = "ui/icons/asset_money.png",
		text = (_amount > 0) ?
			::format(::Legends.EventList.GoldGain, ::Const.UI.Color.PositiveEventValue, ::Math.abs(_amount)):
			::format(::Legends.EventList.GoldLose, ::Const.UI.Color.NegativeEventValue, ::Math.abs(_amount))
	}
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
