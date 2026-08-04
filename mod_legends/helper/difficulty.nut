::Legends.isLegendaryDifficulty <- function() {
	return ("Assets" in ::World) && ::World.Assets != null && ::World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary;
}

::Legends.Difficulty <- {
	DayScaling = [ //used as a divider in Wicht and scaleBaseProperties
		120,
		90,
		60,
		30
	],
	GoblinCity = [ // after which goblin city resource scaling begins (but does it even work?)
		400,
		300,
		200,
		100
	],
	RecruitsMult = [
		2.0,
		1.5,
		1.0,
		0.5
	],
	BroStrengthScaling = function (_broLevel, _count) {
		return [
			3 + ((_broLevel / 4) + (_broLevel - 1)) * 1.5,
			10 + (((3 * _broLevel) / 4) + (_broLevel - 1)) * 2,
			6 + (_count / 2) + ((_broLevel / 2) + (pow(_broLevel, 1.2))),
			_count + (_broLevel + (pow(_broLevel, 1.2)))
		][::World.Assets.getCombatDifficulty()] * ::World.Assets.getOrigin().getBrotherScaling();
	},
	BroItemScaling = function(_items) {
		local itemValue = 0;
		local difficultyDivider = [ // this could use difficulty balancing so gear doesn't affect lower diffs too much
			1000,
			1000,
			1000,
			1000
		][::World.Assets.getCombatDifficulty()];
		foreach (item in _items) {
			if (item != null) {
				itemValue += item.getValue() / difficultyDivider;
			}
		}
		return itemValue;
	},
	DeserterTakesItems = [
		false,
		false,
		true,
		true
	],
	LoneWolfStartingMoney = [
		0,
		-100,
		-100,
		-100
	],
	GladiatorsStartingMoney = [
		0,
		-300,
		-300,
		-300
	],
	DismissCost = [
		false,
		false,
		false,
		true
	],
	RollBonus = [
		5,
		0,
		0,
		0
	]
};
