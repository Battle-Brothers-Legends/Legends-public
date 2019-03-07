local gt = this.getroottable();

if (!("Tactical" in gt.Const))
{
	gt.Const.Tactical <- {};
}

if (!("Actor" in gt.Const.Tactical))
{
	gt.Const.Tactical.Actor <- {};
}

gt.Const.Tactical.Actor.Wardog <- {
	XP = 75,
	ActionPoints = 12,
	Hitpoints = 50,
	Bravery = 40,
	Stamina = 130,
	MeleeSkill = 50,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 25,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.WarWolf <- {
	XP = 150,
	ActionPoints = 12,
	Hitpoints = 70,
	Bravery = 60,
	Stamina = 150,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 25,
	RangedDefense = 25,
	Initiative = 135,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.BanditRabble <- {
	XP = 40,
	ActionPoints = 9,
	Hitpoints = 35,
	Bravery = 30,
	Stamina = 80,
	MeleeSkill = 40,
	RangedSkill = 30,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.BanditThug <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 40,
	Stamina = 95,
	MeleeSkill = 55,
	RangedSkill = 45,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 95,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.BanditPoacher <- {
	XP = 175,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 40,
	Stamina = 95,
	MeleeSkill = 50,
	RangedSkill = 50,
	MeleeDefense = 0,
	RangedDefense = 5,
	Initiative = 95,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.BanditMarksman <- {
	XP = 225,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 45,
	Stamina = 115,
	MeleeSkill = 50,
	RangedSkill = 60,
	MeleeDefense = 5,
	RangedDefense = 10,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.BanditRaider <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 55,
	Stamina = 125,
	MeleeSkill = 65,
	RangedSkill = 55,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.BanditLeader <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 100,
	Bravery = 70,
	Stamina = 130,
	MeleeSkill = 75,
	RangedSkill = 60,
	MeleeDefense = 15,
	RangedDefense = 10,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25
};
gt.Const.Tactical.Actor.Wildman <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 100,
	Bravery = 80,
	Stamina = 150,
	MeleeSkill = 70,
	RangedSkill = 40,
	MeleeDefense = 15,
	RangedDefense = 5,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
