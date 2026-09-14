if (!("Tactical" in ::Const))
{
	::Const.Tactical <- {};
}

if (!("Actor" in ::Const.Tactical))
{
	::Const.Tactical.Actor <- {};
}

::Const.Tactical.Actor.LegendZombieLight <- {
	XP = 100,
	ActionPoints = 8,
	Hitpoints = 100,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 5,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 45,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::Const.Tactical.Actor.LegendZombieLightXbow <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 100,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 5,
	RangedSkill = 55,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 45,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::Const.Tactical.Actor.LegendZombieMedium <- {
	XP = 150,
	ActionPoints = 10,
	Hitpoints = 130,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 65,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::Const.Tactical.Actor.LegendZombieMediumXbow <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 130,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 5,
	RangedSkill = 65,
	MeleeDefense = 5,
	RangedDefense = 10,
	Initiative = 65,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::Const.Tactical.Actor.LegendZombieHeavy <- {
	XP = 250,
	ActionPoints = 11,
	Hitpoints = 180,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 15,
	Initiative = 60,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::Const.Tactical.Actor.LegendZombieHeavyXbow <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 180,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 0,
	RangedSkill = 75,
	MeleeDefense = 5,
	RangedDefense = 20,
	Initiative = 60,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};