::Const.XP.MaxLevelWithPerkpoints = 12;

::Const.LevelXP = [
	0,
	200,
	500,
	1000,
	2000,
	3500,
	5000,
	7000,
	9000,
	12000,
	15000,
	20000 // new veterancy
]; // reset for the new max level added

for( local i = 1; i < 88; i = ++i )
{
	::Const.LevelXP.push(this.Const.LevelXP[this.Const.LevelXP.len() - 1] + 4000 + 1000 * i);
}

::Const.Combat.SpawnBloodSameTileChance = 95;
::Const.Combat.SpawnBloodAdjacentTileChance = 80;
::Const.Combat.SpawnBloodAttempts = 4;
::Const.Combat.BloodSplattersAtDeathMult = 2.0;
::Const.Combat.BloodSplattersAtOriginalPosMult = 0.5;
::Const.Combat.DustSplattersAtResurrectionMult = 1.5;
::Const.Combat.BloodPoolsAtDeathMin = 2;
::Const.Combat.BloodiedBustCount = 2;
::Const.Combat.ResurrectAnimationTime = 0.5;

::Const.ShakeCharacterLayers[0].extend([
	"armor_layer_chain",
	"armor_layer_plate",
	"armor_layer_tabbard",
	"armor_layer_cloak_front",
	"armor_layer_cloak",
]);
::Const.ShakeCharacterLayers[1].extend([
	"helmet_vanity_lower",
	"helmet_vanity_lower_2",
	"helmet_helm",
	"helmet_top",
	"helmet_vanity",
	"helmet_vanity_2",
]);
::Const.ShakeCharacterLayers[2].extend([
	"armor_layer_chain",
	"armor_layer_plate",
	"armor_layer_tabbard",
	"armor_layer_cloak_front",
	"armor_layer_cloak",
	"helmet_vanity_lower",
	"helmet_vanity_lower_2",
	"helmet_helm",
	"helmet_top",
	"helmet_vanity",
	"helmet_vanity_2",
]);
::Const.CharacterProperties.DailyWageMult = 1.0; //Is not serialised in vanilla. But I have serialised it today because Scenarios were not keeping their wage multiplier modifiers between save/load cycles - Luft 29/12/22

::Const.CharacterProperties.getMeleeDefense = function ()
{
	if (this.MeleeDefense >= 0)
	{
		return this.Math.floor(this.MeleeDefense * (this.MeleeDefenseMult >= 0 ? this.MeleeDefenseMult : 1.0 / this.MeleeDefenseMult));
	}
	else
	{
		return this.Math.floor(this.MeleeDefense * (this.MeleeDefenseMult < 0 ? this.MeleeDefenseMult : 1.0 / this.MeleeDefenseMult));
	}
};

::Const.CharacterProperties.getRangedDefense = function ()
{
	if (this.RangedDefense >= 0)
	{
		return this.Math.floor(this.RangedDefense * (this.RangedDefenseMult >= 0 ? this.RangedDefenseMult : 1.0 / this.RangedDefenseMult));
	}
	else
	{
		return this.Math.floor(this.RangedDefense * (this.RangedDefenseMult < 0 ? this.RangedDefenseMult : 1.0 / this.RangedDefenseMult));
	}
};

::Const.CharacterProperties.getRangedSkill = function ()
{
	return this.Math.floor(this.RangedSkill * (this.RangedSkillMult >= 0 ? this.RangedSkillMult : 1.0 / this.RangedSkillMult));
};

::Const.CharacterProperties.getBravery = function ()
{
	return this.Math.floor(this.Bravery * (this.BraveryMult >= 0 ? this.BraveryMult : 1.0 / this.BraveryMult));
};

::Const.CharacterProperties.getInitiative = function ()
{
	return this.Math.floor(this.Initiative * (this.InitiativeMult >= 0 ? this.InitiativeMult : 1.0 / this.InitiativeMult));
};

local onSerialize = ::Const.CharacterProperties.onSerialize;
::Const.CharacterProperties.onSerialize = function ( _out )
{
	onSerialize( _out );
	_out.writeF32(this.DailyWageMult);
};

local onDeserialize = ::Const.CharacterProperties.onDeserialize;
::Const.CharacterProperties.onDeserialize = function (_in)
{
	onDeserialize( _in );
	this.DailyWageMult = _in.readF32();
};
