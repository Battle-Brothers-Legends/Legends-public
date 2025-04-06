/**
 * This file contains definitions and helper function for perks used in Legends.
 *
 * To add new perk, add definition to perkDefObjects:
 * perkDefObjects.push({
 *		ID = "perk.legend_ballistics", 									<- by convention, use legend_ prefix for your perk name or use your own if that's submod
 *		Script = "scripts/skills/perks/perk_legend_ballistics", 		<- same here
 *		Name = ::Const.Strings.PerkName.LegendBallistics,   			<- Name and Tooltip should be defined in perk_strings.nut
 *		Tooltip = ::Const.Strings.PerkDescription.LegendBallistics,
 *		Icon = "ui/perks/ballistics56_circle.png",						<- provide both icons, that will be used on perk screen, here's perk granted version
 *		IconDisabled = "ui/perks/ballistics56_circle_bw.png",			<- perk not granted version
 *		Const = "LegendBallistics" 										<- constant name this definition will be available at ::Const.Perks.PerkDefs, by convention, use Legend prefix for your perk or use your own if that's submod
 *	});
 *
 *	In perk implementation create() method it's encouraged to use helper function to set defined fields automatically by using
 *  ::Const.Perks.setup(this.m, ::Legends.Perk.LegendBallistics);
 *  Use your name, this will ensure there's not mismatch or typos in ID, Icons etc.
 *  If your perk is an effect or requires to show different icons when used as a skill or whatever other reason, you can still set values you need regardless what helper sets.
 *
 * 	If you need to reference perk in other place, it's best to use reference to the ID instead of raw string literal.
 *  For example, instead of using:
 *  	bro.getSkills().hasSkill("perk.legend_ballistics")
 *  Use:
 *  	bro.getSkills().hasPerk(::Legends.Perk.LegendBallistics)
 */

if (!("Perks" in ::Const))
	::Const.Perks <- {};

if (!("Perk" in ::Legends))
	::Legends.Perk <- {};

::Const.Perks.PerkDefObjects <- [];
::Const.Perks.PerkDefs <- {};

::Const.Perks.addPerkDefObjects <- function( _perkDefObjects )
{
	local size = ::Const.Perks.PerkDefObjects.len();
	::Const.Perks.PerkDefObjects.extend(_perkDefObjects);
	foreach (i, perkDefObject in _perkDefObjects)
	{
		if (perkDefObject.Const in ::Legends.Perk)
			::Legends.Perk[perkDefObject.Const] = size + i;
		else
			::Legends.Perk[perkDefObject.Const] <- size + i;
		::Const.Perks.PerkDefs[perkDefObject.Const] <- size + i;
		::Const.Perks.LookupMap[perkDefObject.ID] <- perkDefObject;
	}
}

::Const.Perks.updatePerkGroupTooltips <- function( _perkDef = null, _groups = [] )
{
	local map = {};

	foreach (group in ::Const.Perks)
	{
		if (!("Name" in group))
		{
			continue;
		}

		foreach (row in group.Tree)
		{
			foreach (perkDef in row)
			{
				if (_perkDef != null && perkDef != _perkDef)
				{
					continue;
				}

				if (!(perkDef in map))
				{
					map[perkDef] <- { Groups = [], Const = perkDef };
				}
				map[perkDef].Groups.push(group.Name);
			}
		}
	}

	foreach (perk, table in map)
	{
		local desc = ::Const.Strings.PerkDescription[::Const.Perks.PerkDefObjects[perk].Const];

		local pre = "[color=#0b0084]From the ";
		local mid = "";
		local ap = "perk group[/color]";
		local array = _groups.len() == 0 ? table.Groups : _groups;
		if (array.len() == 1)
		{
			mid += array[0] + " ";
		}
		else
		{
			for (local i = 0; i < array.len() - 2; i++)
			{
				 mid += array[i] + ", ";
			}
			mid += array[array.len()-2] + " or ";
			mid += array[array.len()-1] + " ";
			ap = "perk groups[/color]";
		}

		if (desc.find(pre) == null)
		{
			local text = "\n\n" + pre + mid + ap;
			::Const.Strings.PerkDescription[::Const.Perks.PerkDefObjects[perk].Const] += text;
			::Const.Perks.PerkDefObjects[table.Const].Tooltip += text;
		}
		else
		{
			local strArray = split(desc, "[");

			strArray.pop();
			strArray.apply(@(a) a += "[" );

			strArray[strArray.len()-1] = "color=#0b0084]From the " + mid + ap;

			if (strArray[0].find("color=") != null)
			{
				strArray[0] = "[" + strArray[0];
			}

			local ret = "";
			foreach (s in strArray)
			{
				ret += s;
			}

			if (ret.find("\n\n" + pre) == null)
			{
				local prefix = ret.find("\n" + pre) == null ? "\n\n" : "\n";
				ret = this.MSU.String.replace(ret, pre, prefix + pre);
			}

			::Const.Strings.PerkDescription[::Const.Perks.PerkDefObjects[perk].Const] = ret;
			::Const.Perks.PerkDefObjects[table.Const].Tooltip = ret;
		}
	}
}

::Const.Perks.setup <- function (_m, _perkDef) {
	local def = ::Const.Perks.PerkDefObjects[_perkDef];
	_m.ID = def.ID;
	_m.Name = ::Const.Strings.PerkName[def.Const];
	_m.Description = ::Const.Strings.PerkDescription[def.Const];
	_m.Icon = def.Icon;
	_m.IconDisabled = def.IconDisabled;
}

local perkDefObjects = [];

// Vanilla defined perks
::Legends.Perk.Relentless <- null;
perkDefObjects.push({
	ID = "perk.relentless",
	Script = "scripts/skills/perks/perk_relentless",
	Name = ::Const.Strings.PerkName.Relentless,
	Tooltip = ::Const.Strings.PerkDescription.Relentless,
	Icon = "ui/perks/perk_26.png",
	IconDisabled = "ui/perks/perk_26_sw.png",
	Const = "Relentless"
});

::Legends.Perk.DevastatingStrikes <- null;
perkDefObjects.push({
	ID = "perk.devastating_strikes",
	Script = "scripts/skills/perks/perk_devastating_strikes",
	Name = ::Const.Strings.PerkName.DevastatingStrikes,
	Tooltip = ::Const.Strings.PerkDescription.DevastatingStrikes,
	Icon = "ui/perks/devastating_strikes.png",
	IconDisabled = "ui/perks/devastating_strikes_bw.png",
	Const = "DevastatingStrikes"
});

::Legends.Perk.ShieldBash <- null;
perkDefObjects.push({
	ID = "perk.shield_bash_legend",
	Script = "scripts/skills/perks/perk_shield_bash",
	Name = ::Const.Strings.PerkName.ShieldBash,
	Tooltip = ::Const.Strings.PerkDescription.ShieldBash,
	Icon = "ui/perks/perk_22.png",
	IconDisabled = "ui/perks/perk_22_sw.png",
	Const = "ShieldBash"
});

::Legends.Perk.FastAdaption <- null;
perkDefObjects.push({
	ID = "perk.fast_adaption",
	Script = "scripts/skills/perks/perk_fast_adaption",
	Name = ::Const.Strings.PerkName.FastAdaption,
	Tooltip = ::Const.Strings.PerkDescription.FastAdaption,
	Icon = "ui/perks/perk_33.png",
	IconDisabled = "ui/perks/perk_33_sw.png",
	Const = "FastAdaption"
});

::Legends.Perk.CripplingStrikes <- null;
perkDefObjects.push({
	ID = "perk.crippling_strikes",
	Script = "scripts/skills/perks/perk_crippling_strikes",
	Name = ::Const.Strings.PerkName.CripplingStrikes,
	Tooltip = ::Const.Strings.PerkDescription.CripplingStrikes,
	Icon = "ui/perks/perk_57.png",
	IconDisabled = "ui/perks/perk_57_sw.png",
	Const = "CripplingStrikes"
});

::Legends.Perk.Colossus <- null;
perkDefObjects.push({
	ID = "perk.colossus",
	Script = "scripts/skills/perks/perk_colossus",
	Name = ::Const.Strings.PerkName.Colossus,
	Tooltip = ::Const.Strings.PerkDescription.Colossus,
	Icon = "ui/perks/perk_06.png",
	IconDisabled = "ui/perks/perk_06_sw.png",
	Const = "Colossus"
});

::Legends.Perk.NineLives <- null;
perkDefObjects.push({
	ID = "perk.nine_lives",
	Script = "scripts/skills/perks/perk_nine_lives",
	Name = ::Const.Strings.PerkName.NineLives,
	Tooltip = ::Const.Strings.PerkDescription.NineLives,
	Icon = "ui/perks/perk_07.png",
	IconDisabled = "ui/perks/perk_07_sw.png",
	Const = "NineLives"
});

::Legends.Perk.BagsAndBelts <- null;
perkDefObjects.push({
	ID = "perk.bags_and_belts",
	Script = "scripts/skills/perks/perk_bags_and_belts",
	Name = ::Const.Strings.PerkName.BagsAndBelts,
	Tooltip = ::Const.Strings.PerkDescription.BagsAndBelts,
	Icon = "ui/perks/perk_20.png",
	IconDisabled = "ui/perks/perk_20_sw.png",
	Const = "BagsAndBelts"
});

::Legends.Perk.Pathfinder <- null;
perkDefObjects.push({
	ID = "perk.pathfinder",
	Script = "scripts/skills/perks/perk_pathfinder",
	Name = ::Const.Strings.PerkName.Pathfinder,
	Tooltip = ::Const.Strings.PerkDescription.Pathfinder,
	Icon = "ui/perks/perk_23.png",
	IconDisabled = "ui/perks/perk_23_sw.png",
	Const = "Pathfinder"
});

::Legends.Perk.Adrenaline <- null;
perkDefObjects.push({
	ID = "perk.adrenaline",
	Script = "scripts/skills/perks/perk_adrenalin",
	Name = ::Const.Strings.PerkName.Adrenaline,
	Tooltip = ::Const.Strings.PerkDescription.Adrenaline,
	Icon = "ui/perks/perk_37.png",
	IconDisabled = "ui/perks/perk_37_sw.png",
	Const = "Adrenaline"
});

::Legends.Perk.Recover <- null;
perkDefObjects.push({
	ID = "perk.recover",
	Script = "scripts/skills/perks/perk_recover",
	Name = ::Const.Strings.PerkName.Recover,
	Tooltip = ::Const.Strings.PerkDescription.Recover,
	Icon = "ui/perks/perk_54.png",
	IconDisabled = "ui/perks/perk_54_sw.png",
	Const = "Recover"
});

::Legends.Perk.Student <- null;
perkDefObjects.push({
	ID = "perk.student",
	Script = "scripts/skills/perks/perk_student",
	Name = ::Const.Strings.PerkName.Student,
	Tooltip = ::Const.Strings.PerkDescription.Student,
	Icon = "ui/perks/perk_21.png",
	IconDisabled = "ui/perks/perk_21_sw.png",
	Const = "Student"
});

::Legends.Perk.CoupDeGrace <- null;
perkDefObjects.push({
	ID = "perk.coup_de_grace",
	Script = "scripts/skills/perks/perk_coup_de_grace",
	Name = ::Const.Strings.PerkName.CoupDeGrace,
	Tooltip = ::Const.Strings.PerkDescription.CoupDeGrace,
	Icon = "ui/perks/perk_16.png",
	IconDisabled = "ui/perks/perk_16_sw.png",
	Const = "CoupDeGrace"
});

::Legends.Perk.Bullseye <- null;
perkDefObjects.push({
	ID = "perk.bullseye",
	Script = "scripts/skills/perks/perk_bullseye",
	Name = ::Const.Strings.PerkName.Bullseye,
	Tooltip = ::Const.Strings.PerkDescription.Bullseye,
	Icon = "ui/perks/perk_17.png",
	IconDisabled = "ui/perks/perk_17_sw.png",
	Const = "Bullseye"
});

::Legends.Perk.Dodge <- null;
perkDefObjects.push({
	ID = "perk.dodge",
	Script = "scripts/skills/perks/perk_dodge",
	Name = ::Const.Strings.PerkName.Dodge,
	Tooltip = ::Const.Strings.PerkDescription.Dodge,
	Icon = "ui/perks/perk_01.png",
	IconDisabled = "ui/perks/perk_01_sw.png",
	Const = "Dodge"
});

::Legends.Perk.FortifiedMind <- null;
perkDefObjects.push({
	ID = "perk.fortified_mind",
	Script = "scripts/skills/perks/perk_fortified_mind",
	Name = ::Const.Strings.PerkName.FortifiedMind,
	Tooltip = ::Const.Strings.PerkDescription.FortifiedMind,
	Icon = "ui/perks/perk_08.png",
	IconDisabled = "ui/perks/perk_08_sw.png",
	Const = "FortifiedMind"
});

::Legends.Perk.HoldOut <- null;
perkDefObjects.push({
	ID = "perk.hold_out",
	Script = "scripts/skills/perks/perk_hold_out",
	Name = ::Const.Strings.PerkName.HoldOut,
	Tooltip = ::Const.Strings.PerkDescription.HoldOut,
	Icon = "ui/perks/perk_04.png",
	IconDisabled = "ui/perks/perk_04_sw.png",
	Const = "HoldOut"
});

::Legends.Perk.SteelBrow <- null;
perkDefObjects.push({
	ID = "perk.steel_brow",
	Script = "scripts/skills/perks/perk_steel_brow",
	Name = ::Const.Strings.PerkName.SteelBrow,
	Tooltip = ::Const.Strings.PerkDescription.SteelBrow,
	Icon = "ui/perks/perk_09.png",
	IconDisabled = "ui/perks/perk_09_sw.png",
	Const = "SteelBrow"
});

::Legends.Perk.QuickHands <- null;
perkDefObjects.push({
	ID = "perk.quick_hands",
	Script = "scripts/skills/perks/perk_quick_hands",
	Name = ::Const.Strings.PerkName.QuickHands,
	Tooltip = ::Const.Strings.PerkDescription.QuickHands,
	Icon = "ui/perks/perk_39.png",
	IconDisabled = "ui/perks/perk_39_sw.png",
	Const = "QuickHands"
});

::Legends.Perk.Gifted <- null;
perkDefObjects.push({
	ID = "perk.gifted",
	Script = "scripts/skills/perks/perk_gifted",
	Name = ::Const.Strings.PerkName.Gifted,
	Tooltip = ::Const.Strings.PerkDescription.Gifted,
	Icon = "ui/perks/perk_56.png",
	IconDisabled = "ui/perks/perk_56_sw.png",
	Const = "Gifted"
});

::Legends.Perk.Backstabber <- null;
perkDefObjects.push({
	ID = "perk.backstabber",
	Script = "scripts/skills/perks/perk_backstabber",
	Name = ::Const.Strings.PerkName.Backstabber,
	Tooltip = ::Const.Strings.PerkDescription.Backstabber,
	Icon = "ui/perks/perk_59.png",
	IconDisabled = "ui/perks/perk_59_sw.png",
	Const = "Backstabber"
});

::Legends.Perk.Anticipation <- null;
perkDefObjects.push({
	ID = "perk.anticipation",
	Script = "scripts/skills/perks/perk_anticipation",
	Name = ::Const.Strings.PerkName.Anticipation,
	Tooltip = ::Const.Strings.PerkDescription.Anticipation,
	Icon = "ui/perks/perk_10.png",
	IconDisabled = "ui/perks/perk_10_sw.png",
	Const = "Anticipation"
});

::Legends.Perk.ShieldExpert <- null;
perkDefObjects.push({
	ID = "perk.shield_expert",
	Script = "scripts/skills/perks/perk_shield_expert",
	Name = ::Const.Strings.PerkName.ShieldExpert,
	Tooltip = ::Const.Strings.PerkDescription.ShieldExpert,
	Icon = "ui/perks/perk_05.png",
	IconDisabled = "ui/perks/perk_05_sw.png",
	Const = "ShieldExpert"
});

::Legends.Perk.Brawny <- null;
perkDefObjects.push({
	ID = "perk.brawny",
	Script = "scripts/skills/perks/perk_brawny",
	Name = ::Const.Strings.PerkName.Brawny,
	Tooltip = ::Const.Strings.PerkDescription.Brawny,
	Icon = "ui/perks/perk_40.png",
	IconDisabled = "ui/perks/perk_40_sw.png",
	Const = "Brawny"
});

::Legends.Perk.Rotation <- null;
perkDefObjects.push({
	ID = "perk.rotation",
	Script = "scripts/skills/perks/perk_rotation",
	Name = ::Const.Strings.PerkName.Rotation,
	Tooltip = ::Const.Strings.PerkDescription.Rotation,
	Icon = "ui/perks/perk_11.png",
	IconDisabled = "ui/perks/perk_11_sw.png",
	Const = "Rotation"
});

::Legends.Perk.RallyTheTroops <- null;
perkDefObjects.push({
	ID = "perk.rally_the_troops",
	Script = "scripts/skills/perks/perk_rally_the_troops",
	Name = ::Const.Strings.PerkName.RallyTheTroops,
	Tooltip = ::Const.Strings.PerkDescription.RallyTheTroops,
	Icon = "ui/perks/perk_42.png",
	IconDisabled = "ui/perks/perk_42_sw.png",
	Const = "RallyTheTroops"
});

::Legends.Perk.Taunt <- null;
perkDefObjects.push({
	ID = "perk.taunt",
	Script = "scripts/skills/perks/perk_taunt",
	Name = ::Const.Strings.PerkName.Taunt,
	Tooltip = ::Const.Strings.PerkDescription.Taunt,
	Icon = "ui/perks/perk_38.png",
	IconDisabled = "ui/perks/perk_38_sw.png",
	Const = "Taunt"
});

::Legends.Perk.SpecMace <- null;
perkDefObjects.push({
	ID = "perk.mastery.mace",
	Script = "scripts/skills/perks/perk_mastery_mace",
	Name = ::Const.Strings.PerkName.SpecMace,
	Tooltip = ::Const.Strings.PerkDescription.SpecMace,
	Icon = "ui/perks/perk_43.png",
	IconDisabled = "ui/perks/perk_43_sw.png",
	Const = "SpecMace"
});

::Legends.Perk.SpecFlail <- null;
perkDefObjects.push({
	ID = "perk.mastery.flail",
	Script = "scripts/skills/perks/perk_mastery_flail",
	Name = ::Const.Strings.PerkName.SpecFlail,
	Tooltip = ::Const.Strings.PerkDescription.SpecFlail,
	Icon = "ui/perks/perk_47.png",
	IconDisabled = "ui/perks/perk_47_sw.png",
	Const = "SpecFlail"
});

::Legends.Perk.SpecHammer <- null;
perkDefObjects.push({
	ID = "perk.mastery.hammer",
	Script = "scripts/skills/perks/perk_mastery_hammer",
	Name = ::Const.Strings.PerkName.SpecHammer,
	Tooltip = ::Const.Strings.PerkDescription.SpecHammer,
	Icon = "ui/perks/perk_53.png",
	IconDisabled = "ui/perks/perk_53_sw.png",
	Const = "SpecHammer"
});

::Legends.Perk.SpecAxe <- null;
perkDefObjects.push({
	ID = "perk.mastery.axe",
	Script = "scripts/skills/perks/perk_mastery_axe",
	Name = ::Const.Strings.PerkName.SpecAxe,
	Tooltip = ::Const.Strings.PerkDescription.SpecAxe,
	Icon = "ui/perks/perk_44.png",
	IconDisabled = "ui/perks/perk_44_sw.png",
	Const = "SpecAxe"
});

::Legends.Perk.SpecCleaver <- null;
perkDefObjects.push({
	ID = "perk.mastery.cleaver",
	Script = "scripts/skills/perks/perk_mastery_cleaver",
	Name = ::Const.Strings.PerkName.SpecCleaver,
	Tooltip = ::Const.Strings.PerkDescription.SpecCleaver,
	Icon = "ui/perks/perk_52.png",
	IconDisabled = "ui/perks/perk_52_sw.png",
	Const = "SpecCleaver"
});

::Legends.Perk.SpecSword <- null;
perkDefObjects.push({
	ID = "perk.mastery.sword",
	Script = "scripts/skills/perks/perk_mastery_sword",
	Name = ::Const.Strings.PerkName.SpecSword,
	Tooltip = ::Const.Strings.PerkDescription.SpecSword,
	Icon = "ui/perks/perk_46.png",
	IconDisabled = "ui/perks/perk_46_sw.png",
	Const = "SpecSword"
});

::Legends.Perk.SpecDagger <- null;
perkDefObjects.push({
	ID = "perk.mastery.dagger",
	Script = "scripts/skills/perks/perk_mastery_dagger",
	Name = ::Const.Strings.PerkName.SpecDagger,
	Tooltip = ::Const.Strings.PerkDescription.SpecDagger,
	Icon = "ui/perks/perk_51.png",
	IconDisabled = "ui/perks/perk_51_sw.png",
	Const = "SpecDagger"
});

::Legends.Perk.SpecPolearm <- null;
perkDefObjects.push({
	ID = "perk.mastery.polearm",
	Script = "scripts/skills/perks/perk_mastery_polearm",
	Name = ::Const.Strings.PerkName.SpecPolearm,
	Tooltip = ::Const.Strings.PerkDescription.SpecPolearm,
	Icon = "ui/perks/perk_58.png",
	IconDisabled = "ui/perks/perk_58_sw.png",
	Const = "SpecPolearm"
});

::Legends.Perk.SpecSpear <- null;
perkDefObjects.push({
	ID = "perk.mastery.spear",
	Script = "scripts/skills/perks/perk_mastery_spear",
	Name = ::Const.Strings.PerkName.SpecSpear,
	Tooltip = ::Const.Strings.PerkDescription.SpecSpear,
	Icon = "ui/perks/perk_45.png",
	IconDisabled = "ui/perks/perk_45_sw.png",
	Const = "SpecSpear"
});

::Legends.Perk.SpecCrossbow <- null;
perkDefObjects.push({
	ID = "perk.mastery.crossbow",
	Script = "scripts/skills/perks/perk_mastery_crossbow",
	Name = ::Const.Strings.PerkName.SpecCrossbow,
	Tooltip = ::Const.Strings.PerkDescription.SpecCrossbow,
	Icon = "ui/perks/perk_48.png",
	IconDisabled = "ui/perks/perk_48_sw.png",
	Const = "SpecCrossbow"
});

::Legends.Perk.SpecBow <- null;
perkDefObjects.push({
	ID = "perk.mastery.bow",
	Script = "scripts/skills/perks/perk_mastery_bow",
	Name = ::Const.Strings.PerkName.SpecBow,
	Tooltip = ::Const.Strings.PerkDescription.SpecBow,
	Icon = "ui/perks/perk_49.png",
	IconDisabled = "ui/perks/perk_49_sw.png",
	Const = "SpecBow"
});

::Legends.Perk.SpecThrowing <- null;
perkDefObjects.push({
	ID = "perk.mastery.throwing",
	Script = "scripts/skills/perks/perk_mastery_throwing",
	Name = ::Const.Strings.PerkName.SpecThrowing,
	Tooltip = ::Const.Strings.PerkDescription.SpecThrowing,
	Icon = "ui/perks/perk_50.png",
	IconDisabled = "ui/perks/perk_50_sw.png",
	Const = "SpecThrowing"
});

::Legends.Perk.ReachAdvantage <- null;
perkDefObjects.push({
	ID = "perk.reach_advantage",
	Script = "scripts/skills/perks/perk_reach_advantage",
	Name = ::Const.Strings.PerkName.ReachAdvantage,
	Tooltip = ::Const.Strings.PerkDescription.ReachAdvantage,
	Icon = "ui/perks/perk_19.png",
	IconDisabled = "ui/perks/perk_19_sw.png",
	Const = "ReachAdvantage"
});

::Legends.Perk.Overwhelm <- null;
perkDefObjects.push({
	ID = "perk.overwhelm",
	Script = "scripts/skills/perks/perk_overwhelm",
	Name = ::Const.Strings.PerkName.Overwhelm,
	Tooltip = ::Const.Strings.PerkDescription.Overwhelm,
	Icon = "ui/perks/perk_62.png",
	IconDisabled = "ui/perks/perk_62_sw.png",
	Const = "Overwhelm"
});

::Legends.Perk.LoneWolf <- null;
perkDefObjects.push({
	ID = "perk.lone_wolf",
	Script = "scripts/skills/perks/perk_lone_wolf",
	Name = ::Const.Strings.PerkName.LoneWolf,
	Tooltip = ::Const.Strings.PerkDescription.LoneWolf,
	Icon = "ui/perks/perk_61.png",
	IconDisabled = "ui/perks/perk_61_sw.png",
	Const = "LoneWolf"
});

::Legends.Perk.Underdog <- null;
perkDefObjects.push({
	ID = "perk.underdog",
	Script = "scripts/skills/perks/perk_underdog",
	Name = ::Const.Strings.PerkName.Underdog,
	Tooltip = ::Const.Strings.PerkDescription.Underdog,
	Icon = "ui/perks/perk_60.png",
	IconDisabled = "ui/perks/perk_60_sw.png",
	Const = "Underdog"
});

::Legends.Perk.Footwork <- null;
perkDefObjects.push({
	ID = "perk.footwork",
	Script = "scripts/skills/perks/perk_footwork",
	Name = ::Const.Strings.PerkName.Footwork,
	Tooltip = ::Const.Strings.PerkDescription.Footwork,
	Icon = "ui/perks/perk_25.png",
	IconDisabled = "ui/perks/perk_25_sw.png",
	Const = "Footwork"
});

::Legends.Perk.Berserk <- null;
perkDefObjects.push({
	ID = "perk.berserk",
	Script = "scripts/skills/perks/perk_berserk",
	Name = ::Const.Strings.PerkName.Berserk,
	Tooltip = ::Const.Strings.PerkDescription.Berserk,
	Icon = "ui/perks/perk_35.png",
	IconDisabled = "ui/perks/perk_35_sw.png",
	Const = "Berserk"
});

::Legends.Perk.HeadHunter <- null;
perkDefObjects.push({
	ID = "perk.head_hunter",
	Script = "scripts/skills/perks/perk_head_hunter",
	Name = ::Const.Strings.PerkName.HeadHunter,
	Tooltip = ::Const.Strings.PerkDescription.HeadHunter,
	Icon = "ui/perks/perk_15.png",
	IconDisabled = "ui/perks/perk_15_sw.png",
	Const = "HeadHunter"
});

::Legends.Perk.Nimble <- null;
perkDefObjects.push({
	ID = "perk.nimble",
	Script = "scripts/skills/perks/perk_nimble",
	Name = ::Const.Strings.PerkName.Nimble,
	Tooltip = ::Const.Strings.PerkDescription.Nimble,
	Icon = "ui/perks/perk_29.png",
	IconDisabled = "ui/perks/perk_29_sw.png",
	Const = "Nimble"
});

::Legends.Perk.BattleForged <- null;
perkDefObjects.push({
	ID = "perk.battle_forged",
	Script = "scripts/skills/perks/perk_battle_forged",
	Name = ::Const.Strings.PerkName.BattleForged,
	Tooltip = ::Const.Strings.PerkDescription.BattleForged,
	Icon = "ui/perks/perk_03.png",
	IconDisabled = "ui/perks/perk_03_sw.png",
	Const = "BattleForged"
});

::Legends.Perk.Fearsome <- null;
perkDefObjects.push({
	ID = "perk.fearsome",
	Script = "scripts/skills/perks/perk_fearsome",
	Name = ::Const.Strings.PerkName.Fearsome,
	Tooltip = ::Const.Strings.PerkDescription.Fearsome,
	Icon = "ui/perks/perk_27.png",
	IconDisabled = "ui/perks/perk_27_sw.png",
	Const = "Fearsome"
});

::Legends.Perk.Duelist <- null;
perkDefObjects.push({
	ID = "perk.duelist",
	Script = "scripts/skills/perks/perk_duelist",
	Name = ::Const.Strings.PerkName.Duelist,
	Tooltip = ::Const.Strings.PerkDescription.Duelist,
	Icon = "ui/perks/perk_41.png",
	IconDisabled = "ui/perks/perk_41_sw.png",
	Const = "Duelist"
});

::Legends.Perk.KillingFrenzy <- null;
perkDefObjects.push({
	ID = "perk.killing_frenzy",
	Script = "scripts/skills/perks/perk_killing_frenzy",
	Name = ::Const.Strings.PerkName.KillingFrenzy,
	Tooltip = ::Const.Strings.PerkDescription.KillingFrenzy,
	Icon = "ui/perks/perk_36.png",
	IconDisabled = "ui/perks/perk_36_sw.png",
	Const = "KillingFrenzy"
});

::Legends.Perk.Indomitable <- null;
perkDefObjects.push({
	ID = "perk.indomitable",
	Script = "scripts/skills/perks/perk_indomitable",
	Name = ::Const.Strings.PerkName.Indomitable,
	Tooltip = ::Const.Strings.PerkDescription.Indomitable,
	Icon = "ui/perks/perk_30.png",
	IconDisabled = "ui/perks/perk_30_sw.png",
	Const = "Indomitable"
});

::Legends.Perk.Steadfast <- null;
perkDefObjects.push({
	ID = "perk.steadfast",
	Script = "scripts/skills/perks/perk_steadfast",
	Name = ::Const.Strings.PerkName.Steadfast,
	Tooltip = ::Const.Strings.PerkDescription.Steadfast,
	Icon = "ui/perks/steadfast_circle.png",
	IconDisabled = "ui/perks/steadfast_circle_bw.png",
	Const = "Steadfast"
});

::Legends.Perk.SunderingStrikes <- null;
perkDefObjects.push({
	ID = "perk.sundering_strikes",
	Script = "scripts/skills/perks/perk_sundering_strikes",
	Name = ::Const.Strings.PerkName.SunderingStrikes,
	Tooltip = ::Const.Strings.PerkDescription.SunderingStrikes,
	Icon = "ui/perks/sunderingstrikes_circle.png",
	IconDisabled = "ui/perks/sunderingstrikes_circle_bw.png",
	Const = "SunderingStrikes"
});

::Legends.Perk.Stalwart <- null;
perkDefObjects.push({
	ID = "perk.stalwart",
	Script = "scripts/skills/perks/perk_stalwart",
	Name = ::Const.Strings.PerkName.Stalwart,
	Tooltip = ::Const.Strings.PerkDescription.Stalwart,
	Icon = "ui/perks/stalwart.png",
	IconDisabled = "ui/perks/stalwart_bw.png",
	Const = "Stalwart"
});

::Legends.Perk.BattleFlow <- null;
perkDefObjects.push({
	ID = "perk.battle_flow",
	Script = "scripts/skills/perks/perk_battle_flow",
	Name = ::Const.Strings.PerkName.BattleFlow,
	Tooltip = ::Const.Strings.PerkDescription.BattleFlow,
	Icon = "ui/perks/battle_flow56_circle.png",
	IconDisabled = "ui/perks/battle_flow56_circle_bw.png",
	Const = "BattleFlow"
});

::Legends.Perk.InspiringPresence <- null;
perkDefObjects.push({
	ID = "perk.inspiring_presence",
	Script = "scripts/skills/perks/perk_inspiring_presence",
	Name = ::Const.Strings.PerkName.InspiringPresence,
	Tooltip = ::Const.Strings.PerkDescription.InspiringPresence,
	Icon = "ui/perks/perk_28.png",
	IconDisabled = "ui/perks/perk_28_sw.png",
	Const = "InspiringPresence"
});

::Legends.Perk.LegendBallistics <- null;
perkDefObjects.push({
	ID = "perk.legend_ballistics",
	Script = "scripts/skills/perks/perk_legend_ballistics",
	Name = ::Const.Strings.PerkName.LegendBallistics,
	Tooltip = ::Const.Strings.PerkDescription.LegendBallistics,
	Icon = "ui/perks/ballistics56_circle.png",
	IconDisabled = "ui/perks/ballistics56_circle_bw.png",
	Const = "LegendBallistics"
});

::Legends.Perk.LegendDebilitate <- null;
perkDefObjects.push({
	ID = "perk.legend_debilitate",
	Script = "scripts/skills/perks/perk_legend_debilitate",
	Name = ::Const.Strings.PerkName.LegendDebilitate,
	Tooltip = ::Const.Strings.PerkDescription.LegendDebilitate,
	Icon = "ui/perks/debilitate_circle_56.png",
	IconDisabled = "ui/perks/debilitate_circle_56_bw.png",
	Const = "LegendDebilitate"
});

::Legends.Perk.LegendReturnFavor <- null;
perkDefObjects.push({
	ID = "perk.legend_return_favor",
	Script = "scripts/skills/perks/perk_legend_return_favor",
	Name = ::Const.Strings.PerkName.LegendReturnFavor,
	Tooltip = ::Const.Strings.PerkDescription.LegendReturnFavor,
	Icon = "ui/perks/return_favor_circle.png",
	IconDisabled = "ui/perks/return_favor_circle_bw.png",
	Const = "LegendReturnFavor"
});

::Legends.Perk.LegendDaze <- null;
perkDefObjects.push({
	ID = "perk.legend_daze",
	Script = "scripts/skills/perks/perk_legend_daze",
	Name = ::Const.Strings.PerkName.LegendDaze,
	Tooltip = ::Const.Strings.PerkDescription.LegendDaze,
	Icon = "ui/perks/daze56_circle.png",
	IconDisabled = "ui/perks/daze56_circle_bw.png",
	Const = "LegendDaze"
});

::Legends.Perk.LegendRoster1 <- null;
perkDefObjects.push({
	ID = "perk.legend_roster_1",
	Script = "scripts/skills/perks/perk_legend_roster_1",
	Name = ::Const.Strings.PerkName.LegendRoster1,
	Tooltip = ::Const.Strings.PerkDescription.LegendRoster1,
	Icon = "ui/perks/recruit1.png",
	IconDisabled = "ui/perks/recruit1_bw.png",
	Const = "LegendRoster1"
});

::Legends.Perk.LegendRoster2 <- null;
perkDefObjects.push({
	ID = "perk.legend_roster_2",
	Script = "scripts/skills/perks/perk_legend_roster_2",
	Name = ::Const.Strings.PerkName.LegendRoster2,
	Tooltip = ::Const.Strings.PerkDescription.LegendRoster2,
	Icon = "ui/perks/recruit2.png",
	IconDisabled = "ui/perks/recruit2_bw.png",
	Const = "LegendRoster2"
});

::Legends.Perk.LegendRoster3 <- null;
perkDefObjects.push({
	ID = "perk.legend_roster_3",
	Script = "scripts/skills/perks/perk_legend_roster_3",
	Name = ::Const.Strings.PerkName.LegendRoster3,
	Tooltip = ::Const.Strings.PerkDescription.LegendRoster3,
	Icon = "ui/perks/recruit3.png",
	IconDisabled = "ui/perks/recruit3_bw.png",
	Const = "LegendRoster3"
});

::Legends.Perk.LegendRoster4 <- null;
perkDefObjects.push({
	ID = "perk.legend_roster_4",
	Script = "scripts/skills/perks/perk_legend_roster_4",
	Name = ::Const.Strings.PerkName.LegendRoster4,
	Tooltip = ::Const.Strings.PerkDescription.LegendRoster4,
	Icon = "ui/perks/recruit4.png",
	IconDisabled = "ui/perks/recruit4_bw.png",
	Const = "LegendRoster4"
});

::Legends.Perk.LegendRoster5 <- null;
perkDefObjects.push({
	ID = "perk.legend_roster_5",
	Script = "scripts/skills/perks/perk_legend_roster_5",
	Name = ::Const.Strings.PerkName.LegendRoster5,
	Tooltip = ::Const.Strings.PerkDescription.LegendRoster5,
	Icon = "ui/perks/recruit5.png",
	IconDisabled = "ui/perks/recruit5_bw.png",
	Const = "LegendRoster5"
});

::Legends.Perk.LegendRoster6 <- null;
perkDefObjects.push({
	ID = "perk.legend_roster_6",
	Script = "scripts/skills/perks/perk_legend_roster_6",
	Name = ::Const.Strings.PerkName.LegendRoster6,
	Tooltip = ::Const.Strings.PerkDescription.LegendRoster6,
	Icon = "ui/perks/recruit6.png",
	IconDisabled = "ui/perks/recruit6_bw.png",
	Const = "LegendRoster6"
});

::Legends.Perk.LegendRoster7 <- null;
perkDefObjects.push({
	ID = "perk.legend_roster_7",
	Script = "scripts/skills/perks/perk_legend_roster_7",
	Name = ::Const.Strings.PerkName.LegendRoster7,
	Tooltip = ::Const.Strings.PerkDescription.LegendRoster7,
	Icon = "ui/perks/recruit7.png",
	IconDisabled = "ui/perks/recruit7_bw.png",
	Const = "LegendRoster7"
});

::Legends.Perk.LegendStun <- null;
perkDefObjects.push({
	ID = "perk.legend_stun",
	Script = "scripts/skills/perks/perk_legend_stun",
	Name = ::Const.Strings.PerkName.LegendStun,
	Tooltip = ::Const.Strings.PerkDescription.LegendStun,
	Icon = "ui/perks/stun56_circle.png",
	IconDisabled = "ui/perks/stun56_circle_bw.png",
	Const = "LegendStun"
});

::Legends.Perk.LegendHorrify <- null;
perkDefObjects.push({
	ID = "perk.legend_horrify",
	Script = "scripts/skills/perks/perk_legend_horrify",
	Name = ::Const.Strings.PerkName.LegendHorrify,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorrify,
	Icon = "ui/perks/horrify56_circle.png",
	IconDisabled = "ui/perks/horrify56_circle_bw.png",
	Const = "LegendHorrify"
});

::Legends.Perk.LegendEntice <- null;
perkDefObjects.push({
	ID = "perk.legend_entice",
	Script = "scripts/skills/perks/perk_legend_entice",
	Name = ::Const.Strings.PerkName.LegendEntice,
	Tooltip = ::Const.Strings.PerkDescription.LegendEntice,
	Icon = "ui/perks/entice_circle_56.png",
	IconDisabled = "ui/perks/entice_circle_56_bw.png",
	Const = "LegendEntice"
});

::Legends.Perk.LegendPush <- null;
perkDefObjects.push({
	ID = "perk.legend_push",
	Script = "scripts/skills/perks/perk_legend_push",
	Name = ::Const.Strings.PerkName.LegendPush,
	Tooltip = ::Const.Strings.PerkDescription.LegendPush,
	Icon = "ui/perks/revolt56_circle.png", // todo wtf is that icon
	IconDisabled = "ui/perks/revolt56_circle_bw.png",
	Const = "LegendPush"
});

::Legends.Perk.LegendPerfectFocus <- null;
perkDefObjects.push({
	ID = "perk.legend_perfect_focus",
	Script = "scripts/skills/perks/perk_legend_perfect_focus",
	Name = ::Const.Strings.PerkName.LegendPerfectFocus,
	Tooltip = ::Const.Strings.PerkDescription.LegendPerfectFocus,
	Icon = "ui/perks/perfectfocus_circle.png",
	IconDisabled = "ui/perks/perfectfocus_circle_bw.png",
	Const = "LegendPerfectFocus"
});

::Legends.Perk.LegendFirefield <- null;
perkDefObjects.push({
	ID = "perk.legend_firefield",
	Script = "scripts/skills/perks/perk_legend_firefield",
	Name = ::Const.Strings.PerkName.LegendFirefield,
	Tooltip = ::Const.Strings.PerkDescription.LegendFirefield,
	Icon = "ui/perks/fire_circle.png",
	IconDisabled = "ui/perks/fire_circle_bw.png",
	Const = "LegendFirefield"
});

::Legends.Perk.LegendSleep <- null;
perkDefObjects.push({
	ID = "perk.legend_sleep",
	Script = "scripts/skills/perks/perk_legend_sleep",
	Name = ::Const.Strings.PerkName.LegendSleep,
	Tooltip = ::Const.Strings.PerkDescription.LegendSleep,
	Icon = "ui/perks/sleep_56.png",
	IconDisabled = "ui/perks/sleep_56_bw.png",
	Const = "LegendSleep"
});

::Legends.Perk.LegendFullForce <- null;
perkDefObjects.push({
	ID = "perk.legend_full_force",
	Script = "scripts/skills/perks/perk_legend_full_force",
	Name = ::Const.Strings.PerkName.LegendFullForce,
	Tooltip = ::Const.Strings.PerkDescription.LegendFullForce,
	Icon = "ui/perks/fullforce_circle.png",
	IconDisabled = "ui/perks/fullforce_circle_bw.png",
	Const = "LegendFullForce"
});

::Legends.Perk.LegendLookout <- null;
perkDefObjects.push({
	ID = "perk.legend_lookout",
	Script = "scripts/skills/perks/perk_legend_lookout",
	Name = ::Const.Strings.PerkName.LegendLookout,
	Tooltip = ::Const.Strings.PerkDescription.LegendLookout,
	Icon = "ui/perks/lookout_circle.png",
	IconDisabled = "ui/perks/lookout_circle_bw.png",
	Const = "LegendLookout"
});

::Legends.Perk.LegendSprint <- null;
perkDefObjects.push({
	ID = "perk.legend_sprint",
	Script = "scripts/skills/perks/perk_legend_sprint",
	Name = ::Const.Strings.PerkName.LegendSprint,
	Tooltip = ::Const.Strings.PerkDescription.LegendSprint,
	Icon = "ui/perks/perk_sprint.png",
	IconDisabled = "ui/perks/perk_sprint_sw.png",
	Const = "LegendSprint"
});

::Legends.Perk.LegendQuickStep <- null;
perkDefObjects.push({
	ID = "perk.legend_quick_step",
	Script = "scripts/skills/perks/perk_legend_quick_step",
	Name = ::Const.Strings.PerkName.LegendQuickStep,
	Tooltip = ::Const.Strings.PerkDescription.LegendQuickStep,
	Icon = "ui/perks/unarmed_lunge.png",
	IconDisabled = "ui/perks/unarmed_lunge_bw.png",
	Const = "LegendQuickStep"
});

::Legends.Perk.LegendAthlete <- null;
perkDefObjects.push({
	ID = "perk.legend_athlete",
	Script = "scripts/skills/perks/perk_legend_athlete",
	Name = ::Const.Strings.PerkName.LegendAthlete,
	Tooltip = ::Const.Strings.PerkDescription.LegendAthlete,
	Icon = "ui/perks/climb_circle.png",
	IconDisabled = "ui/perks/climb_circle_bw.png",
	Const = "LegendAthlete"
});

::Legends.Perk.LegendDoubleStrike <- null;
perkDefObjects.push({
	ID = "perk.legend_double_strike",
	Script = "scripts/skills/perks/perk_legend_double_strike",
	Name = ::Const.Strings.PerkName.LegendDoubleStrike,
	Tooltip = ::Const.Strings.PerkDescription.LegendDoubleStrike,
	Icon = "ui/perks/doublestrike_circle.png",
	IconDisabled = "ui/perks/doublestrike_circle_bw.png",
	Const = "LegendDoubleStrike"
});

::Legends.Perk.LegendSpecPoison <- null;
perkDefObjects.push({
	ID = "perk.legend_mastery_poison",
	Script = "scripts/skills/perks/perk_legend_mastery_poison",
	Name = ::Const.Strings.PerkName.LegendSpecPoison,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecPoison,
	Icon = "ui/perks/mastery_poison.png",
	IconDisabled = "ui/perks/mastery_poison_bw.png",
	Const = "LegendSpecPoison"
});

::Legends.Perk.LegendCloseCombatArcher <- null;
perkDefObjects.push({
	ID = "perk.legend_close_combat_archer",
	Script = "scripts/skills/perks/perk_legend_close_combat_archer",
	Name = ::Const.Strings.PerkName.LegendCloseCombatArcher,
	Tooltip = ::Const.Strings.PerkDescription.LegendCloseCombatArcher,
	Icon = "ui/perks/closecombat56.png",
	IconDisabled = "ui/perks/closecombat56_bw.png",
	Const = "LegendCloseCombatArcher"
});

::Legends.Perk.LegendCascade <- null;
perkDefObjects.push({
	ID = "perk.legend_cascade",
	Script = "scripts/skills/perks/perk_legend_cascade",
	Name = ::Const.Strings.PerkName.LegendCascade,
	Tooltip = ::Const.Strings.PerkDescription.LegendCascade,
	Icon = "ui/perks/triplestrike56.png",
	IconDisabled = "ui/perks/triplestrike56_bw.png",
	Const = "LegendCascade"
});

::Legends.Perk.LegendEvasion <- null;
perkDefObjects.push({
	ID = "perk.legend_evasion",
	Script = "scripts/skills/perks/perk_legend_evasion",
	Name = ::Const.Strings.PerkName.LegendEvasion,
	Tooltip = ::Const.Strings.PerkDescription.LegendEvasion,
	Icon = "ui/perks/evasion_circle.png",
	IconDisabled = "ui/perks/evasion_circle_bw.png",
	Const = "LegendEvasion"
});

::Legends.Perk.LegendRust <- null;
perkDefObjects.push({
	ID = "perk.legend_rust",
	Script = "scripts/skills/perks/perk_legend_rust",
	Name = ::Const.Strings.PerkName.LegendRust,
	Tooltip = ::Const.Strings.PerkDescription.LegendRust,
	Icon = "ui/perks/rust56_circle.png",
	IconDisabled = "ui/perks/rust56_circle_bw.png",
	Const = "LegendRust"
});

::Legends.Perk.LegendDeathtouch <- null;
perkDefObjects.push({
	ID = "perk.legend_deathtouch",
	Script = "scripts/skills/perks/perk_legend_deathtouch",
	Name = ::Const.Strings.PerkName.LegendDeathtouch,
	Tooltip = ::Const.Strings.PerkDescription.LegendDeathtouch,
	Icon = "ui/perks/deathtouch_circle.png",
	IconDisabled = "ui/perks/deathtouch_circle_bw.png",
	Const = "LegendDeathtouch"
});

::Legends.Perk.LegendPossessUndead <- null;
perkDefObjects.push({
	ID = "perk.legend_possess_undead",
	Script = "scripts/skills/perks/perk_legend_possess_undead",
	Name = ::Const.Strings.PerkName.LegendPossessUndead,
	Tooltip = ::Const.Strings.PerkDescription.LegendPossessUndead,
	Icon = "ui/perks/possess56.png",
	IconDisabled = "ui/perks/possess56_bw.png",
	Const = "LegendPossessUndead"
});

::Legends.Perk.LegendMiasma <- null;
perkDefObjects.push({
	ID = "perk.legend_miasma",
	Script = "scripts/skills/perks/perk_legend_miasma",
	Name = ::Const.Strings.PerkName.LegendMiasma,
	Tooltip = ::Const.Strings.PerkDescription.LegendMiasma,
	Icon = "ui/perks/miasma_circle.png",
	IconDisabled = "ui/perks/miasma_circle_bw.png",
	Const = "LegendMiasma"
});

::Legends.Perk.LegendHex <- null;
perkDefObjects.push({
	ID = "perk.legend_hex",
	Script = "scripts/skills/perks/perk_legend_hex",
	Name = ::Const.Strings.PerkName.LegendHex,
	Tooltip = ::Const.Strings.PerkDescription.LegendHex,
	Icon = "ui/perks/hex_circle.png",
	IconDisabled = "ui/perks/hex_circle_bw.png",
	Const = "LegendHex"
});

::Legends.Perk.LegendDarkflight <- null;
perkDefObjects.push({
	ID = "perk.legend_darkflight",
	Script = "scripts/skills/perks/perk_legend_darkflight",
	Name = ::Const.Strings.PerkName.LegendDarkflight,
	Tooltip = ::Const.Strings.PerkDescription.LegendDarkflight,
	Icon = "ui/perks/darkflight_circle.png",
	IconDisabled = "ui/perks/darkflight_circle_bw.png",
	Const = "LegendDarkflight"
});

::Legends.Perk.LegendSpecBandage <- null;
perkDefObjects.push({
	ID = "perk.legend_mastery_bandage",
	Script = "scripts/skills/perks/perk_legend_mastery_bandage",
	Name = ::Const.Strings.PerkName.LegendSpecBandage,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecBandage,
	Icon = "ui/perks/bandage_circle.png",
	IconDisabled = "ui/perks/bandage_circle_bw.png",
	Const = "LegendSpecBandage"
});

::Legends.Perk.LegendHoldTheLine <- null;
perkDefObjects.push({
	ID = "perk.legend_hold_the_line",
	Script = "scripts/skills/perks/perk_legend_hold_the_line",
	Name = ::Const.Strings.PerkName.LegendHoldTheLine,
	Tooltip = ::Const.Strings.PerkDescription.LegendHoldTheLine,
	Icon = "ui/perks/holdtheline_circle.png",
	IconDisabled = "ui/perks/holdtheline_circle_bw.png",
	Const = "LegendHoldTheLine"
});

::Legends.Perk.LegendInspire <- null;
perkDefObjects.push({
	ID = "perk.legend_inspire",
	Script = "scripts/skills/perks/perk_legend_inspire",
	Name = ::Const.Strings.PerkName.LegendInspire,
	Tooltip = ::Const.Strings.PerkDescription.LegendInspire,
	Icon = "ui/perks/inspire_circle.png",
	IconDisabled = "ui/perks/inspire_circle_bw.png",
	Const = "LegendInspire"
});

::Legends.Perk.LegendBloodyHarvest <- null;
perkDefObjects.push({
	ID = "perk.legend_bloody_harvest",
	Script = "scripts/skills/perks/perk_legend_bloody_harvest",
	Name = ::Const.Strings.PerkName.LegendBloodyHarvest,
	Tooltip = ::Const.Strings.PerkDescription.LegendBloodyHarvest,
	Icon = "ui/perks/bloody_harvest.png",
	IconDisabled = "ui/perks/bloody_harvest_bw.png",
	Const = "LegendBloodyHarvest"
});

::Legends.Perk.LegendSlaughterer <- null;
perkDefObjects.push({
	ID = "perk.legend_slaughterer",
	Script = "scripts/skills/perks/perk_legend_slaughterer",
	Name = ::Const.Strings.PerkName.LegendSlaughterer,
	Tooltip = ::Const.Strings.PerkDescription.LegendSlaughterer,
	Icon = "ui/perks/slaughterer_circle.png",
	IconDisabled = "ui/perks/slaughterer_circle_bw.png",
	Const = "LegendSlaughterer"
});

::Legends.Perk.LegendVengeance <- null;
perkDefObjects.push({
	ID = "perk.legend_vengeance",
	Script = "scripts/skills/perks/perk_legend_vengeance",
	Name = ::Const.Strings.PerkName.LegendVengeance,
	Tooltip = ::Const.Strings.PerkDescription.LegendVengeance,
	Icon = "ui/perks/vengeance_circle.png",
	IconDisabled = "ui/perks/vengeance_circle_bw.png",
	Const = "LegendVengeance"
});

::Legends.Perk.LegendIronside <- null;
perkDefObjects.push({
	ID = "perk.legend_ironside",
	Script = "scripts/skills/perks/perk_legend_ironside",
	Name = ::Const.Strings.PerkName.LegendIronside,
	Tooltip = ::Const.Strings.PerkDescription.LegendIronside,
	Icon = "ui/perks/perk_101.png",
	IconDisabled = "ui/perks/perk_101_sw.png",
	Const = "LegendIronside"
});

::Legends.Perk.LegendLastStand <- null;
perkDefObjects.push({
	ID = "perk.legend_last_stand",
	Script = "scripts/skills/perks/perk_legend_last_stand",
	Name = ::Const.Strings.PerkName.LegendLastStand,
	Tooltip = ::Const.Strings.PerkDescription.LegendLastStand,
	Icon = "ui/perks/laststand_circle.png",
	IconDisabled = "ui/perks/laststand_circle_bw.png",
	Const = "LegendLastStand"
});

::Legends.Perk.LegendRaiseUndead <- null;
perkDefObjects.push({
	ID = "perk.legend_raise_undead",
	Script = "scripts/skills/perks/perk_legend_raise_undead",
	Name = ::Const.Strings.PerkName.LegendRaiseUndead,
	Tooltip = ::Const.Strings.PerkDescription.LegendRaiseUndead,
	Icon = "ui/perks/raisedead2_circle.png",
	IconDisabled = "ui/perks/raisedead2_circle_bw.png",
	Const = "LegendRaiseUndead"
});

::Legends.Perk.LegendWither <- null;
perkDefObjects.push({
	ID = "perk.legend_wither",
	Script = "scripts/skills/perks/perk_legend_wither",
	Name = ::Const.Strings.PerkName.LegendWither,
	Tooltip = ::Const.Strings.PerkDescription.LegendWither,
	Icon = "ui/perks/wither56.png",
	IconDisabled = "ui/perks/wither56_bw.png",
	Const = "LegendWither"
});

::Legends.Perk.LegendRebound <- null;
perkDefObjects.push({
	ID = "perk.legend_rebound",
	Script = "scripts/skills/perks/perk_legend_rebound",
	Name = ::Const.Strings.PerkName.LegendRebound,
	Tooltip = ::Const.Strings.PerkDescription.LegendRebound,
	Icon = "ui/perks/rebound_circle.png",
	IconDisabled = "ui/perks/rebound_circle_bw.png",
	Const = "LegendRebound"
});

::Legends.Perk.LegendCoordinatedVolleys <- null;
perkDefObjects.push({
	ID = "perk.legend_coordinated_volleys",
	Script = "scripts/skills/perks/perk_legend_coordinated_volleys",
	Name = ::Const.Strings.PerkName.LegendCoordinatedVolleys,
	Tooltip = ::Const.Strings.PerkDescription.LegendCoordinatedVolleys,
	Icon = "ui/perks/coordinated_volleys_circle.png",
	IconDisabled = "ui/perks/coordinated_volleys_circle_bw.png",
	Const = "LegendCoordinatedVolleys"
});

::Legends.Perk.LegendForwardPush <- null;
perkDefObjects.push({
	ID = "perk.legend_push_forward",
	Script = "scripts/skills/perks/perk_legend_push_forward",
	Name = ::Const.Strings.PerkName.LegendForwardPush,
	Tooltip = ::Const.Strings.PerkDescription.LegendForwardPush,
	Icon = "ui/perks/spears_circle.png",
	IconDisabled = "ui/perks/spears_circle_bw.png",
	Const = "LegendForwardPush"
});

::Legends.Perk.LegendInsects <- null;
perkDefObjects.push({
	ID = "perk.legend_insects",
	Script = "scripts/skills/perks/perk_legend_insects",
	Name = ::Const.Strings.PerkName.LegendInsects,
	Tooltip = ::Const.Strings.PerkDescription.LegendInsects,
	Icon = "ui/perks/insects_circle.png",
	IconDisabled = "ui/perks/insects_circle_bw.png",
	Const = "LegendInsects"
});

::Legends.Perk.LegendChainLightning <- null;
perkDefObjects.push({
	ID = "perk.legend_chain_lightning",
	Script = "scripts/skills/perks/perk_legend_chain_lightning",
	Name = ::Const.Strings.PerkName.LegendChainLightning,
	Tooltip = ::Const.Strings.PerkDescription.LegendChainLightning,
	Icon = "ui/perks/lightning_circle.png",
	IconDisabled = "ui/perks/lightning_circle_bw.png",
	Const = "LegendChainLightning"
});

::Legends.Perk.LegendComposure <- null;
perkDefObjects.push({
	ID = "perk.legend_composure",
	Script = "scripts/skills/perks/perk_legend_composure",
	Name = ::Const.Strings.PerkName.LegendComposure,
	Tooltip = ::Const.Strings.PerkDescription.LegendComposure,
	Icon = "ui/perks/composed_circle.png",
	IconDisabled = "ui/perks/composed_circle_bw.png",
	Const = "LegendComposure"
});

::Legends.Perk.LegendNightvision <- null;
perkDefObjects.push({
	ID = "perk.legend_nightvision",
	Script = "scripts/skills/perks/perk_legend_nightvision",
	Name = ::Const.Strings.PerkName.LegendNightvision,
	Tooltip = ::Const.Strings.PerkDescription.LegendNightvision,
	Icon = "ui/perks/nightvision_circle.png",
	IconDisabled = "ui/perks/nightvision_circle_bw.png",
	Const = "LegendNightvision"
});

::Legends.Perk.LegendMasteryStaves <- null;
perkDefObjects.push({
	ID = "perk.legend_mastery_staves",
	Script = "scripts/skills/perks/perk_legend_mastery_staves",
	Name = ::Const.Strings.PerkName.LegendMasteryStaves,
	Tooltip = ::Const.Strings.PerkDescription.LegendMasteryStaves,
	Icon = "ui/perks/staffmastery.png",
	IconDisabled = "ui/perks/staffmastery_bw.png",
	Const = "LegendMasteryStaves"
});

::Legends.Perk.LegendRelax <- null;
perkDefObjects.push({
	ID = "perk.legend_relax",
	Script = "scripts/skills/perks/perk_legend_relax",
	Name = ::Const.Strings.PerkName.LegendRelax,
	Tooltip = ::Const.Strings.PerkDescription.LegendRelax,
	Icon = "ui/perks/relax_circle.png",
	IconDisabled = "ui/perks/relax_circle_bw.png",
	Const = "LegendRelax"
});

::Legends.Perk.LegendGruesomeFeast <- null;
perkDefObjects.push({
	ID = "perk.legend_gruesome_feast",
	Script = "scripts/skills/perks/perk_legend_gruesome_feast",
	Name = ::Const.Strings.PerkName.LegendGruesomeFeast,
	Tooltip = ::Const.Strings.PerkDescription.LegendGruesomeFeast,
	Icon = "ui/perks/gruesome_circle.png",
	IconDisabled = "ui/perks/gruesome_circle_bw.png",
	Const = "LegendGruesomeFeast"
});

::Legends.Perk.LegendUberNimble <- null;
perkDefObjects.push({
	ID = "perk.legend_ubernimble",
	Script = "scripts/skills/perks/perk_legend_ubernimble",
	Name = ::Const.Strings.PerkName.LegendUberNimble,
	Tooltip = ::Const.Strings.PerkDescription.LegendUberNimble,
	Icon = "ui/perks/ubernimble_circle.png",
	IconDisabled = "ui/perks/ubernimble_circle_bw.png",
	Const = "LegendUberNimble"
});

::Legends.Perk.LegendMuscularity <- null;
perkDefObjects.push({
	ID = "perk.legend_muscularity",
	Script = "scripts/skills/perks/perk_legend_muscularity",
	Name = ::Const.Strings.PerkName.LegendMuscularity,
	Tooltip = ::Const.Strings.PerkDescription.LegendMuscularity,
	Icon = "ui/perks/muscularity_circle.png",
	IconDisabled = "ui/perks/muscularity_circle_bw.png",
	Const = "LegendMuscularity",
	HasUnactivatedPerkTooltipHints = true
});

::Legends.Perk.LegendBattleheart <- null;
perkDefObjects.push({
	ID = "perk.legend_battleheart",
	Script = "scripts/skills/perks/perk_legend_battleheart",
	Name = ::Const.Strings.PerkName.LegendBattleheart,
	Tooltip = ::Const.Strings.PerkDescription.LegendBattleheart,
	Icon = "ui/perks/battleheart_circle.png",
	IconDisabled = "ui/perks/battleheart_circle_bw.png",
	Const = "LegendBattleheart"
});

::Legends.Perk.LegendTrueBeliever <- null;
perkDefObjects.push({
	ID = "perk.legend_true_believer",
	Script = "scripts/skills/perks/perk_legend_true_believer",
	Name = ::Const.Strings.PerkName.LegendTrueBeliever,
	Tooltip = ::Const.Strings.PerkDescription.LegendTrueBeliever,
	Icon = "ui/perks/true_believer_circle.png",
	IconDisabled = "ui/perks/true_believer_circle_bw.png",
	Const = "LegendTrueBeliever"
});

::Legends.Perk.LegendPoisonImmunity <- null;
perkDefObjects.push({
	ID = "perk.legend_poison_immunity",
	Script = "scripts/skills/perks/perk_legend_poison_immunity",
	Name = ::Const.Strings.PerkName.LegendPoisonImmunity,
	Tooltip = ::Const.Strings.PerkDescription.LegendPoisonImmunity,
	Icon = "ui/perks/poison_immunity.png",
	IconDisabled = "ui/perks/poison_immunity_bw.png",
	Const = "LegendPoisonImmunity"
});

::Legends.Perk.LegendSummonCat <- null;
perkDefObjects.push({
	ID = "perk.legend_summon_cat",
	Script = "scripts/skills/perks/perk_legend_summon_cat",
	Name = ::Const.Strings.PerkName.LegendSummonCat,
	Tooltip = ::Const.Strings.PerkDescription.LegendSummonCat,
	Icon = "ui/perks/cat_circle.png",
	IconDisabled = "ui/perks/cat_circle_bw.png",
	Const = "LegendSummonCat"
});

::Legends.Perk.LegendSpawnZombieLow <- null;
perkDefObjects.push({
	ID = "perk.legend_spawn_zombie_low",
	Script = "scripts/skills/perks/perk_legend_spawn_zombie_low",
	Name = ::Const.Strings.PerkName.LegendSpawnZombieLow,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpawnZombieLow,
	Icon = "ui/perks/mold_carrion_circle.png",
	IconDisabled = "ui/perks/mold_carrion_circle_bw.png",
	Const = "LegendSpawnZombieLow"
});

::Legends.Perk.LegendSpawnZombieMed <- null;
perkDefObjects.push({
	ID = "perk.legend_spawn_zombie_med",
	Script = "scripts/skills/perks/perk_legend_spawn_zombie_med",
	Name = ::Const.Strings.PerkName.LegendSpawnZombieMed,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpawnZombieMed,
	Icon = "ui/perks/fashion_body_circle.png",
	IconDisabled = "ui/perks/fashion_body_circle_bw.png",
	Const = "LegendSpawnZombieMed"
});

::Legends.Perk.LegendSpawnZombieHigh <- null;
perkDefObjects.push({
	ID = "perk.legend_spawn_zombie_high",
	Script = "scripts/skills/perks/perk_legend_spawn_zombie_high",
	Name = ::Const.Strings.PerkName.LegendSpawnZombieHigh,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpawnZombieHigh,
	Icon = "ui/perks/remake_man_circle.png",
	IconDisabled = "ui/perks/remake_man_circle_bw.png",
	Const = "LegendSpawnZombieHigh"
});

::Legends.Perk.LegendSpawnSkeletonLow <- null;
perkDefObjects.push({
	ID = "perk.legend_spawn_skeleton_low",
	Script = "scripts/skills/perks/perk_legend_spawn_skeleton_low",
	Name = ::Const.Strings.PerkName.LegendSpawnSkeletonLow,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpawnSkeletonLow,
	Icon = "ui/perks/arrange_bones_circle.png",
	IconDisabled = "ui/perks/arrange_bones_circle_bw.png",
	Const = "LegendSpawnSkeletonLow"
});

::Legends.Perk.LegendSpawnSkeletonMed <- null;
perkDefObjects.push({
	ID = "perk.legend_spawn_skeleton_med",
	Script = "scripts/skills/perks/perk_legend_spawn_skeleton_med",
	Name = ::Const.Strings.PerkName.LegendSpawnSkeletonMed,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpawnSkeletonMed,
	Icon = "ui/perks/align_joints_circle.png",
	IconDisabled = "ui/perks/align_joints_circle_bw.png",
	Const = "LegendSpawnSkeletonMed"
});

::Legends.Perk.LegendSpawnSkeletonHigh <- null;
perkDefObjects.push({
	ID = "perk.legend_spawn_skeleton_high",
	Script = "scripts/skills/perks/perk_legend_spawn_skeleton_high",
	Name = ::Const.Strings.PerkName.LegendSpawnSkeletonHigh,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpawnSkeletonHigh,
	Icon = "ui/perks/rebuild_skeleton_circle.png",
	IconDisabled = "ui/perks/rebuild_skeleton_circle_bw.png",
	Const = "LegendSpawnSkeletonHigh"
});

::Legends.Perk.LegendExtendendAura <- null;
perkDefObjects.push({
	ID = "perk.legend_extended_aura",
	Script = "scripts/skills/perks/perk_legend_extended_aura",
	Name = ::Const.Strings.PerkName.LegendExtendendAura,
	Tooltip = ::Const.Strings.PerkDescription.LegendExtendendAura,
	Icon = "ui/perks/extended_aura_circle.png",
	IconDisabled = "ui/perks/extended_aura_circle_bw.png",
	Const = "LegendExtendendAura"
});

::Legends.Perk.LegendChanneledPower <- null;
perkDefObjects.push({
	ID = "perk.legend_channeled_power",
	Script = "scripts/skills/perks/perk_legend_channeled_power",
	Name = ::Const.Strings.PerkName.LegendChanneledPower,
	Tooltip = ::Const.Strings.PerkDescription.LegendChanneledPower,
	Icon = "ui/perks/channeled_power_circle.png",
	IconDisabled = "ui/perks/channeled_power_circle_bw.png",
	Const = "LegendChanneledPower"
});

::Legends.Perk.LegendReclamation <- null;
perkDefObjects.push({
	ID = "perk.legend_reclamation",
	Script = "scripts/skills/perks/perk_legend_reclamation",
	Name = ::Const.Strings.PerkName.LegendReclamation,
	Tooltip = ::Const.Strings.PerkDescription.LegendReclamation,
	Icon = "ui/perks/reclamation_circle.png",
	IconDisabled = "ui/perks/reclamation_circle_bw.png",
	Const = "LegendReclamation"
});

::Legends.Perk.LegendConservation <- null;
perkDefObjects.push({
	ID = "perk.legend_conservation",
	Script = "scripts/skills/perks/perk_legend_conservation",
	Name = ::Const.Strings.PerkName.LegendConservation,
	Tooltip = ::Const.Strings.PerkDescription.LegendConservation,
	Icon = "ui/perks/conservation_circle.png",
	IconDisabled = "ui/perks/conservation_circle_bw.png",
	Const = "LegendConservation"
});

::Legends.Perk.LegendEnthrall <- null;
perkDefObjects.push({
	ID = "perk.legend_enthrall",
	Script = "scripts/skills/perks/perk_legend_enthrall",
	Name = ::Const.Strings.PerkName.LegendEnthrall,
	Tooltip = ::Const.Strings.PerkDescription.LegendEnthrall,
	Icon = "ui/perks/enthrall_circle.png",
	IconDisabled = "ui/perks/enthrall_circle_bw.png",
	Const = "LegendEnthrall"
});

::Legends.Perk.LegendViolentDecomposition <- null;
perkDefObjects.push({
	ID = "perk.legend_violent_decomposition",
	Script = "scripts/skills/perks/perk_legend_violent_decomposition",
	Name = ::Const.Strings.PerkName.LegendViolentDecomposition,
	Tooltip = ::Const.Strings.PerkDescription.LegendViolentDecomposition,
	Icon = "ui/perks/violent_decomposition_circle.png",
	IconDisabled = "ui/perks/violent_decomposition_circle_bw.png",
	Const = "LegendViolentDecomposition"
});

::Legends.Perk.LegendPossession <- null;
perkDefObjects.push({
	ID = "perk.legend_possession",
	Script = "scripts/skills/perks/perk_legend_possession",
	Name = ::Const.Strings.PerkName.LegendPossession,
	Tooltip = ::Const.Strings.PerkDescription.LegendPossession,
	Icon = "ui/perks/possession_circle_56.png",
	IconDisabled = "ui/perks/possession_circle_56_bw.png",
	Const = "LegendPossession"
});

::Legends.Perk.LegendSiphon <- null;
perkDefObjects.push({
	ID = "perk.legend_siphon",
	Script = "scripts/skills/perks/perk_legend_siphon",
	Name = ::Const.Strings.PerkName.LegendSiphon,
	Tooltip = ::Const.Strings.PerkDescription.LegendSiphon,
	Icon = "ui/perks/siphon_circle.png",
	IconDisabled = "ui/perks/siphon_circle_bw.png",
	Const = "LegendSiphon"
});

::Legends.Perk.LegendGuideSteps <- null;
perkDefObjects.push({
	ID = "perk.legend_guide_steps",
	Script = "scripts/skills/perks/perk_legend_guide_steps",
	Name = ::Const.Strings.PerkName.LegendGuideSteps,
	Tooltip = ::Const.Strings.PerkDescription.LegendGuideSteps,
	Icon = "ui/perks/guided_steps_circle.png",
	IconDisabled = "ui/perks/guided_steps_circle_bw.png",
	Const = "LegendGuideSteps"
});

::Legends.Perk.LegendBerserkerRage <- null;
perkDefObjects.push({
	ID = "perk.legend_berserker_rage",
	Script = "scripts/skills/perks/perk_legend_berserker_rage",
	Name = ::Const.Strings.PerkName.LegendBerserkerRage,
	Tooltip = ::Const.Strings.PerkDescription.LegendBerserkerRage,
	Icon = "ui/perks/berserker_rage_circle.png",
	IconDisabled = "ui/perks/berserker_rage_circle_bw.png",
	Const = "LegendBerserkerRage"
});

::Legends.Perk.LegendBecomeBerserker <- null;
perkDefObjects.push({
	ID = "perk.legend_become_berserker",
	Script = "scripts/skills/perks/perk_legend_become_berserker",
	Name = ::Const.Strings.PerkName.LegendBecomeBerserker,
	Tooltip = ::Const.Strings.PerkDescription.LegendBecomeBerserker,
	Icon = "ui/perks/berserker_rage_circle.png",
	IconDisabled = "ui/perks/berserker_rage_circle_bw.png",
	Const = "LegendBecomeBerserker"
});

::Legends.Perk.LegendSkillfulStacking <- null;
perkDefObjects.push({
	ID = "perk.legend_skillful_stacking",
	Script = "scripts/skills/perks/perk_legend_skillful_stacking",
	Name = ::Const.Strings.PerkName.LegendSkillfulStacking,
	Tooltip = ::Const.Strings.PerkDescription.LegendSkillfulStacking,
	Icon = "ui/perks/MaxStashT2.png",
	IconDisabled = "ui/perks/MaxStashT2_bw.png",
	Const = "LegendSkillfulStacking"
});

::Legends.Perk.LegendEfficientPacking <- null;
perkDefObjects.push({
	ID = "perk.legend_efficient_packing",
	Script = "scripts/skills/perks/perk_legend_efficient_packing",
	Name = ::Const.Strings.PerkName.LegendEfficientPacking,
	Tooltip = ::Const.Strings.PerkDescription.LegendEfficientPacking,
	Icon = "ui/perks/MaxStashT1.png",
	IconDisabled = "ui/perks/MaxStashT1_bw.png",
	Const = "LegendEfficientPacking"
});

::Legends.Perk.LegendAmmoBinding <- null;
perkDefObjects.push({
	ID = "perk.legend_ammo_binding",
	Script = "scripts/skills/perks/perk_legend_ammo_binding",
	Name = ::Const.Strings.PerkName.LegendAmmoBinding,
	Tooltip = ::Const.Strings.PerkDescription.LegendAmmoBinding,
	Icon = "ui/perks/MaxAmmoT1.png",
	IconDisabled = "ui/perks/MaxAmmoT1_bw.png",
	Const = "LegendAmmoBinding"
});

::Legends.Perk.LegendAmmoBundles <- null;
perkDefObjects.push({
	ID = "perk.legend_ammo_bundles",
	Script = "scripts/skills/perks/perk_legend_ammo_bundles",
	Name = ::Const.Strings.PerkName.LegendAmmoBundles,
	Tooltip = ::Const.Strings.PerkDescription.LegendAmmoBundles,
	Icon = "ui/perks/MaxAmmoT2.png",
	IconDisabled = "ui/perks/MaxAmmoT2_bw.png",
	Const = "LegendAmmoBundles"
});

::Legends.Perk.LegendMedPackages <- null;
perkDefObjects.push({
	ID = "perk.legend_med_packages",
	Script = "scripts/skills/perks/perk_legend_med_packages",
	Name = ::Const.Strings.PerkName.LegendMedPackages,
	Tooltip = ::Const.Strings.PerkDescription.LegendMedPackages,
	Icon = "ui/perks/MaxMedsT1.png",
	IconDisabled = "ui/perks/MaxMedsT1_bw.png",
	Const = "LegendMedPackages"
});

::Legends.Perk.LegendMedIngredients <- null;
perkDefObjects.push({
	ID = "perk.legend_med_ingredients",
	Script = "scripts/skills/perks/perk_legend_med_ingredients",
	Name = ::Const.Strings.PerkName.LegendMedIngredients,
	Tooltip = ::Const.Strings.PerkDescription.LegendMedIngredients,
	Icon = "ui/perks/MaxMedsT2.png",
	IconDisabled = "ui/perks/MaxMedsT2_bw.png",
	Const = "LegendMedIngredients"
});

::Legends.Perk.LegendToolsDrawers <- null;
perkDefObjects.push({
	ID = "perk.legend_tools_drawers",
	Script = "scripts/skills/perks/perk_legend_tools_drawers",
	Name = ::Const.Strings.PerkName.LegendToolsDrawers,
	Tooltip = ::Const.Strings.PerkDescription.LegendToolsDrawers,
	Icon = "ui/perks/MaxToolsT1.png",
	IconDisabled = "ui/perks/MaxToolsT1_bw.png",
	Const = "LegendToolsDrawers"
});

::Legends.Perk.LegendToolsSpares <- null;
perkDefObjects.push({
	ID = "perk.legend_tools_spares",
	Script = "scripts/skills/perks/perk_legend_tools_spares",
	Name = ::Const.Strings.PerkName.LegendToolsSpares,
	Tooltip = ::Const.Strings.PerkDescription.LegendToolsSpares,
	Icon = "ui/perks/MaxToolsT2.png",
	IconDisabled = "ui/perks/MaxToolsT2_bw.png",
	Const = "LegendToolsSpares"
});

::Legends.Perk.LegendBarterConvincing <- null;
perkDefObjects.push({
	ID = "perk.legend_barter_convincing",
	Script = "scripts/skills/perks/perk_legend_barter_convincing",
	Name = ::Const.Strings.PerkName.LegendBarterConvincing,
	Tooltip = ::Const.Strings.PerkDescription.LegendBarterConvincing,
	Icon = "ui/perks/BarterT1.png",
	IconDisabled = "ui/perks/BarterT1_bw.png",
	Const = "LegendBarterConvincing"
});

::Legends.Perk.LegendBarterTrustworthy <- null;
perkDefObjects.push({
	ID = "perk.legend_barter_trustworthy",
	Script = "scripts/skills/perks/perk_legend_barter_trustworthy",
	Name = ::Const.Strings.PerkName.LegendBarterTrustworthy,
	Tooltip = ::Const.Strings.PerkDescription.LegendBarterTrustworthy,
	Icon = "ui/perks/BarterT2.png",
	IconDisabled = "ui/perks/BarterT2_bw.png",
	Const = "LegendBarterTrustworthy"
});

::Legends.Perk.LegendBribe <- null;
perkDefObjects.push({
	ID = "perk.legend_bribe",
	Script = "scripts/skills/perks/perk_legend_bribe",
	Name = ::Const.Strings.PerkName.LegendBribe,
	Tooltip = ::Const.Strings.PerkDescription.LegendBribe,
	Icon = "ui/perks/coins_circle.png",
	IconDisabled = "ui/perks/coins_circle_bw.png",
	Const = "LegendBribe"
});

::Legends.Perk.LegendOffBookDeal <- null;
perkDefObjects.push({
	ID = "perk.legend_off_book_deal",
	Script = "scripts/skills/perks/perk_legend_off_book_deal",
	Name = ::Const.Strings.PerkName.LegendOffBookDeal,
	Tooltip = ::Const.Strings.PerkDescription.LegendOffBookDeal,
	Icon = "ui/perks/coins_circle.png",
	IconDisabled = "ui/perks/coins_circle_bw.png",
	Const = "LegendOffBookDeal"
});

::Legends.Perk.LegendSpecialistCultist <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_cultist",
	Script = "scripts/skills/perks/perk_legend_specialist_cultist",
	Name = ::Const.Strings.PerkName.LegendSpecialistCultist,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistCultist,
	Icon = "ui/perks/perk_spec_cultist.png",
	IconDisabled = "ui/perks/perk_spec_cultist_bw.png",
	Const = "LegendSpecialistCultist"
});

::Legends.Perk.LegendSpecialistButcher <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_butcher",
	Script = "scripts/skills/perks/perk_legend_specialist_butcher",
	Name = ::Const.Strings.PerkName.LegendSpecialistButcher,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistButcher,
	Icon = "ui/perks/perk_spec_butcher.png",
	IconDisabled = "ui/perks/perk_spec_butcher_bw.png",
	Const = "LegendSpecialistButcher"
});

::Legends.Perk.LegendSpecialistBlacksmith <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_blacksmith",
	Script = "scripts/skills/perks/perk_legend_specialist_blacksmith",
	Name = ::Const.Strings.PerkName.LegendSpecialistBlacksmith,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistBlacksmith,
	Icon = "ui/perks/perk_spec_smith.png",
	IconDisabled = "ui/perks/perk_spec_smith_bw.png",
	Const = "LegendSpecialistBlacksmith"
});

::Legends.Perk.LegendSpecialistPrisoner <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_knife_prisoner",
	Script = "scripts/skills/perks/perk_legend_specialist_prisoner",
	Name = ::Const.Strings.PerkName.LegendSpecialistPrisoner,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistPrisoner,
	Icon = "ui/perks/perk_spec_dagger.png",
	IconDisabled = "ui/perks/perk_spec_dagger_bw.png",
	Const = "LegendSpecialistPrisoner"
});

::Legends.Perk.LegendSpecialistMusician <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_musician",
	Script = "scripts/skills/perks/perk_legend_specialist_musician",
	Name = ::Const.Strings.PerkName.LegendSpecialistMusician,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistMusician,
	Icon = "ui/perks/perk_spec_bard.png",
	IconDisabled = "ui/perks/perk_spec_bard_bw.png",
	Const = "LegendSpecialistMusician"
});

::Legends.Perk.LegendSpecialistMilitia <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_militia",
	Script = "scripts/skills/perks/perk_legend_specialist_militia",
	Name = ::Const.Strings.PerkName.LegendSpecialistMilitia,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistMilitia,
	Icon = "ui/perks/perk_spec_militia.png",
	IconDisabled = "ui/perks/perk_spec_militia_bw.png",
	Const = "LegendSpecialistMilitia"
});

::Legends.Perk.LegendSpecialistMiner <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_miner",
	Script = "scripts/skills/perks/perk_legend_specialist_miner",
	Name = ::Const.Strings.PerkName.LegendSpecialistMiner,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistMiner,
	Icon = "ui/perks/perk_spec_pickaxe.png",
	IconDisabled = "ui/perks/perk_spec_pickaxe_bw.png",
	Const = "LegendSpecialistMiner"
});

::Legends.Perk.LegendSpecialistFarmhand <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_farmhand",
	Script = "scripts/skills/perks/perk_legend_specialist_farmhand",
	Name = ::Const.Strings.PerkName.LegendSpecialistFarmhand,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistFarmhand,
	Icon = "ui/perks/perk_spec_bitchfork.png",
	IconDisabled = "ui/perks/perk_spec_bitchfork_bw.png",
	Const = "LegendSpecialistFarmhand"
});

::Legends.Perk.LegendSpecialistReaper <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_reaper",
	Script = "scripts/skills/perks/perk_legend_specialist_reaper",
	Name = ::Const.Strings.PerkName.LegendSpecialistReaper,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistReaper,
	Icon = "ui/perks/perk_spec_scythe.png",
	IconDisabled = "ui/perks/perk_spec_scythe_bw.png",
	Const = "LegendSpecialistReaper"
});

::Legends.Perk.LegendSpecialistPoacher <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_poacher",
	Script = "scripts/skills/perks/perk_legend_specialist_poacher",
	Name = ::Const.Strings.PerkName.LegendSpecialistPoacher,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistPoacher,
	Icon = "ui/perks/perk_spec_shortbow.png",
	IconDisabled = "ui/perks/perk_spec_shortbow_bw.png",
	Const = "LegendSpecialistPoacher"
});

::Legends.Perk.LegendSpecialistGravedigger <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_gravedigger",
	Script = "scripts/skills/perks/perk_legend_specialist_gravedigger",
	Name = ::Const.Strings.PerkName.LegendSpecialistGravedigger,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistGravedigger,
	Icon = "ui/perks/perk_spec_shovel.png",
	IconDisabled = "ui/perks/perk_spec_shovel_bw.png",
	Const = "LegendSpecialistGravedigger"
});

::Legends.Perk.LegendSpecialistWoodsman <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_woodsman",
	Script = "scripts/skills/perks/perk_legend_specialist_woodsman",
	Name = ::Const.Strings.PerkName.LegendSpecialistWoodsman,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistWoodsman,
	Icon = "ui/perks/perk_spec_woodsman.png",
	IconDisabled = "ui/perks/perk_spec_woodsman_bw.png",
	Const = "LegendSpecialistWoodsman"
});

::Legends.Perk.LegendSpecialistSelfdefense <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_selfdefense",
	Script = "scripts/skills/perks/perk_legend_specialist_selfdefense",
	Name = ::Const.Strings.PerkName.LegendSpecialistSelfdefense,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistSelfdefense,
	Icon = "ui/perks/perk_spec_staff.png",
	IconDisabled = "ui/perks/perk_spec_staff_bw.png",
	Const = "LegendSpecialistSelfdefense"
});

::Legends.Perk.LegendSpecialistHerbalist <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_herbalist",
	Script = "scripts/skills/perks/perk_legend_specialist_herbalist",
	Name = ::Const.Strings.PerkName.LegendSpecialistHerbalist,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistHerbalist,
	Icon = "ui/perks/perk_spec_sickle.png",
	IconDisabled = "ui/perks/perk_spec_sickle_bw.png",
	Const = "LegendSpecialistHerbalist"
});

::Legends.Perk.LegendSpecialistShepherd <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_shepherd",
	Script = "scripts/skills/perks/perk_legend_specialist_shepherd",
	Name = ::Const.Strings.PerkName.LegendSpecialistShepherd,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistShepherd,
	Icon = "ui/perks/perk_spec_sling.png",
	IconDisabled = "ui/perks/perk_spec_sling_bw.png",
	Const = "LegendSpecialistShepherd"
});

::Legends.Perk.LegendSpecialistInventor <- null;
perkDefObjects.push({
		ID = "perk.legend_specialist_inventor",
		Script = "scripts/skills/perks/perk_legend_specialist_inventor",
		Name = this.Const.Strings.PerkName.LegendSpecialistInventor,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistInventor,
		Icon = "ui/perks/perk_spec_firearm.png",
		IconDisabled = "ui/perks/perk_spec_firearm_bw.png",
		Const = "LegendSpecialistInventor"
});

::Legends.Perk.LegendSpecialistBodyguard <- null;
perkDefObjects.push({
		ID = "perk.legend_specialist_bodyguard",
		Script = "scripts/skills/perks/perk_legend_specialist_bodyguard",
		Name = this.Const.Strings.PerkName.LegendSpecialistBodyguard,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistBodyguard,
		Icon = "ui/perks/perk_spec_2hsword.png",
		IconDisabled = "ui/perks/perk_spec_2hsword_bw.png",
		Const = "LegendSpecialistBodyguard"
});

::Legends.Perk.LegendSpecialistInquisition <- null;
perkDefObjects.push({
		ID = "perk.legend_specialist_inquisition",
		Script = "scripts/skills/perks/perk_legend_specialist_inquisition",
		Name = this.Const.Strings.PerkName.LegendSpecialistInquisition,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistInquisition,
		Icon = "ui/perks/perk_spec_xbow.png",
		IconDisabled = "ui/perks/perk_spec_xbow_bw.png",
		Const = "LegendSpecialistInquisition"
});

::Legends.Perk.LegendSpecialistClub <- null;
perkDefObjects.push({
		ID = "perk.legend_specialist_club",
		Script = "scripts/skills/perks/perk_legend_specialist_club",
		Name = this.Const.Strings.PerkName.LegendSpecialistClub,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistClub,
		Icon = "ui/perks/perk_spec_mace.png",
		IconDisabled = "ui/perks/perk_spec_mace_bw.png",
		Const = "LegendSpecialistClub"
});

::Legends.Perk.LegendBigGameHunter <- null;
perkDefObjects.push({
	ID = "perk.legend_big_game_hunter",
	Script = "scripts/skills/perks/perk_legend_big_game_hunter",
	Name = ::Const.Strings.PerkName.LegendBigGameHunter,
	Tooltip = ::Const.Strings.PerkDescription.LegendBigGameHunter,
	Icon = "ui/perks/BigGameHunterPerk.png",
	IconDisabled = "ui/perks/BigGameHunterPerk_bw.png",
	Const = "LegendBigGameHunter"
});

::Legends.Perk.LegendSecondWind <- null;
perkDefObjects.push({
	ID = "perk.legend_second_wind",
	Script = "scripts/skills/perks/perk_legend_second_wind",
	Name = ::Const.Strings.PerkName.LegendSecondWind,
	Tooltip = ::Const.Strings.PerkDescription.LegendSecondWind,
	Icon = "ui/perks/SecondWindPerk.png",
	IconDisabled = "ui/perks/SecondWindPerk_bw.png",
	Const = "LegendSecondWind"
});

::Legends.Perk.LegendMarkTarget <- null;
perkDefObjects.push({
	ID = "perk.legend_mark_target",
	Script = "scripts/skills/perks/perk_legend_mark_target",
	Name = ::Const.Strings.PerkName.LegendMarkTarget,
	Tooltip = ::Const.Strings.PerkDescription.LegendMarkTarget,
	Icon = "ui/perks/MarkTargetPerk.png",
	IconDisabled = "ui/perks/MarkTargetPerk_bw.png",
	Const = "LegendMarkTarget"
});

::Legends.Perk.LegendFieldTriage <- null;
perkDefObjects.push({
	ID = "perk.legend_field_triage",
	Script = "scripts/skills/perks/perk_legend_field_triage",
	Name = ::Const.Strings.PerkName.LegendFieldTriage,
	Tooltip = ::Const.Strings.PerkDescription.LegendFieldTriage,
	Icon = "ui/perks/MaxMedsT2.png",
	IconDisabled = "ui/perks/MaxMedsT2_bw.png",
	Const = "LegendFieldTriage"
});

::Legends.Perk.LegendFieldRepairs <- null;
perkDefObjects.push({
	ID = "perk.legend_field_repairs",
	Script = "scripts/skills/perks/perk_legend_field_repairs",
	Name = ::Const.Strings.PerkName.LegendFieldRepairs,
	Tooltip = ::Const.Strings.PerkDescription.LegendFieldRepairs,
	Icon = "ui/perks/MaxToolsT2.png",
	IconDisabled = "ui/perks/MaxToolsT2_bw.png",
	Const = "LegendFieldRepairs"
});

::Legends.Perk.LegendDangerPay <- null;
perkDefObjects.push({
	ID = "perk.legend_danger_pay",
	Script = "scripts/skills/perks/perk_legend_danger_pay",
	Name = ::Const.Strings.PerkName.LegendDangerPay,
	Tooltip = ::Const.Strings.PerkDescription.LegendDangerPay,
	Icon = "ui/perks/coins_circle.png",
	IconDisabled = "ui/perks/coins_circle_bw.png",
	Const = "LegendDangerPay"
});

::Legends.Perk.LegendValaWarden <- null;
perkDefObjects.push({
	ID = "perk.legend_vala_warden",
	Script = "scripts/skills/perks/perk_legend_vala_warden",
	Name = ::Const.Strings.PerkName.LegendValaWarden,
	Tooltip = ::Const.Strings.PerkDescription.LegendValaWarden,
	Icon = "ui/perks/legend_vala_warden.png",
	IconDisabled = "ui/perks/legend_vala_warden_sw.png",
	Const = "LegendValaWarden"
});

::Legends.Perk.LegendValaThreads <- null;
perkDefObjects.push({
	ID = "perk.legend_vala_threads",
	Script = "scripts/skills/perks/perk_legend_vala_threads",
	Name = ::Const.Strings.PerkName.LegendValaThreads,
	Tooltip = ::Const.Strings.PerkDescription.LegendValaThreads,
	Icon = "ui/perks/legend_vala_threads.png",
	IconDisabled = "ui/perks/legend_vala_threads_sw.png",
	Const = "LegendValaThreads"
});

::Legends.Perk.LegendValaPremonition <- null;
perkDefObjects.push({
	ID = "perk.legend_vala_premonition",
	Script = "scripts/skills/perks/perk_legend_vala_premonition",
	Name = ::Const.Strings.PerkName.LegendValaPremonition,
	Tooltip = ::Const.Strings.PerkDescription.LegendValaPremonition,
	Icon = "ui/perks/legend_vala_premonition.png",
	IconDisabled = "ui/perks/legend_vala_premonition_sw.png",
	Const = "LegendValaPremonition"
});

::Legends.Perk.LegendValaChantMastery <- null;
perkDefObjects.push({
	ID = "perk.legend_vala_chanting_mastery",
	Script = "scripts/skills/perks/perk_legend_vala_chanting_mastery",
	Name = ::Const.Strings.PerkName.LegendValaChantMastery,
	Tooltip = ::Const.Strings.PerkDescription.LegendValaChantMastery,
	Icon = "ui/perks/legend_vala_chanting_mastery.png",
	IconDisabled = "ui/perks/legend_vala_chanting_mastery_sw.png",
	Const = "LegendValaChantMastery"
});

::Legends.Perk.LegendValaTranceMastery <- null;
perkDefObjects.push({
	ID = "perk.legend_vala_trance_mastery",
	Script = "scripts/skills/perks/perk_legend_vala_trance_mastery",
	Name = ::Const.Strings.PerkName.LegendValaTranceMastery,
	Tooltip = ::Const.Strings.PerkDescription.LegendValaTranceMastery,
	Icon = "ui/perks/legend_vala_trance_mastery.png",
	IconDisabled = "ui/perks/legend_vala_trance_mastery_sw.png",
	Const = "LegendValaTranceMastery"
});

::Legends.Perk.LegendValaChantDisharmony <- null;
perkDefObjects.push({
	ID = "perk.legend_vala_chant_disharmony",
	Script = "scripts/skills/perks/perk_legend_vala_chant_disharmony",
	Name = ::Const.Strings.PerkName.LegendValaChantDisharmony,
	Tooltip = ::Const.Strings.PerkDescription.LegendValaChantDisharmony,
	Icon = "ui/perks/legend_vala_chant_disharmony.png",
	IconDisabled = "ui/perks/legend_vala_chant_disharmony_sw.png",
	Const = "LegendValaChantDisharmony"
});

::Legends.Perk.LegendValaSpiritualBond <- null;
perkDefObjects.push({
	ID = "perk.legend_vala_spiritual_bond",
	Script = "scripts/skills/perks/perk_legend_vala_spiritual_bond",
	Name = ::Const.Strings.PerkName.LegendValaSpiritualBond,
	Tooltip = ::Const.Strings.PerkDescription.LegendValaSpiritualBond,
	Icon = "ui/perks/legend_vala_spiritual_bond.png",
	IconDisabled = "ui/perks/legend_vala_spiritual_bond_sw.png",
	Const = "LegendValaSpiritualBond"
});

::Legends.Perk.LegendValaTrancePerspective <- null;
perkDefObjects.push({
	ID = "perk.legend_vala_trance_perspective",
	Script = "scripts/skills/perks/perk_legend_vala_trance_perspective",
	Name = ::Const.Strings.PerkName.LegendValaTrancePerspective,
	Tooltip = ::Const.Strings.PerkDescription.LegendValaTrancePerspective,
	Icon = "ui/perks/legend_vala_trance_perspective.png",
	IconDisabled = "ui/perks/legend_vala_trance_perspective_sw.png",
	Const = "LegendValaTrancePerspective"
});

::Legends.Perk.LegendValaTranceMalevolent <- null;
perkDefObjects.push({
	ID = "perk.legend_vala_trance_malevolent",
	Script = "scripts/skills/perks/perk_legend_vala_trance_malevolent",
	Name = ::Const.Strings.PerkName.LegendValaTranceMalevolent,
	Tooltip = ::Const.Strings.PerkDescription.LegendValaTranceMalevolent,
	Icon = "ui/perks/legend_vala_trance_malevolent.png",
	IconDisabled = "ui/perks/legend_vala_trance_malevolent_sw.png",
	Const = "LegendValaTranceMalevolent"
});

::Legends.Perk.LegendPreparedForAnything <- null;
perkDefObjects.push({
	ID = "perk.legend_prepared_for_anything",
	Script = "scripts/skills/perks/perk_legend_prepared_for_anything",
	Name = ::Const.Strings.PerkName.LegendPreparedForAnything,
	Tooltip = ::Const.Strings.PerkDescription.LegendPreparedForAnything,
	Icon = "ui/perks/perk_20.png",
	IconDisabled = "ui/perks/perk_20_sw.png",
	Const = "LegendPreparedForAnything"
});

::Legends.Perk.LegendBrinkOfDeath <- null;
perkDefObjects.push({
	ID = "perk.legend_brink_of_death",
	Script = "scripts/skills/perks/perk_legend_brink_of_death",
	Name = ::Const.Strings.PerkName.LegendBrinkOfDeath,
	Tooltip = ::Const.Strings.PerkDescription.LegendBrinkOfDeath,
	Icon = "ui/perks/perk_bod.png",
	IconDisabled = "ui/perks/perk_bod_sw.png",
	Const = "LegendBrinkOfDeath"
});

::Legends.Perk.LegendStrictSermons <- null;
perkDefObjects.push({
	ID = "perk.legend_strict_sermons",
	Script = "scripts/skills/perks/perk_legend_strict_sermons",
	Name = ::Const.Strings.PerkName.LegendStrictSermons,
	Tooltip = ::Const.Strings.PerkDescription.LegendStrictSermons,
	Icon = "ui/perks/perk_08.png",
	IconDisabled = "ui/perks/perk_08_sw.png",
	Const = "LegendStrictSermons"
});

::Legends.Perk.LegendInfectiousRage <- null;
perkDefObjects.push({
	ID = "perk.legend_infectious_rage",
	Script = "scripts/skills/perks/perk_legend_infectious_rage",
	Name = ::Const.Strings.PerkName.LegendInfectiousRage,
	Tooltip = ::Const.Strings.PerkDescription.LegendInfectiousRage,
	Icon = "ui/perks/perk_35.png",
	IconDisabled = "ui/perks/perk_35_sw.png",
	Const = "LegendInfectiousRage"
});

::Legends.Perk.LegendTeacher <- null;
perkDefObjects.push({
	ID = "perk.legend_teacher",
	Script = "scripts/skills/perks/perk_legend_teacher",
	Name = ::Const.Strings.PerkName.LegendTeacher,
	Tooltip = ::Const.Strings.PerkDescription.LegendTeacher,
	Icon = "ui/perks/perk_21.png",
	IconDisabled = "ui/perks/perk_21_sw.png",
	Const = "LegendTeacher"
});

::Legends.Perk.LegendResurrectionist <- null;
perkDefObjects.push({
	ID = "perk.legend_resurrectionist",
	Script = "scripts/skills/perks/perk_legend_resurrectionist",
	Name = ::Const.Strings.PerkName.LegendResurrectionist,
	Tooltip = ::Const.Strings.PerkDescription.LegendResurrectionist,
	Icon = "ui/perks/reclamation_circle.png",
	IconDisabled = "ui/perks/reclamation_circle_bw.png",
	Const = "LegendResurrectionist"
});

::Legends.Perk.LegendScry <- null;
perkDefObjects.push({
	ID = "perk.legend_scry",
	Script = "scripts/skills/perks/perk_legend_scry",
	Name = ::Const.Strings.PerkName.LegendScry,
	Tooltip = ::Const.Strings.PerkDescription.LegendScry,
	Icon = "ui/perks/scry_perk.png",
	IconDisabled = "ui/perks/scry_perk_bw.png",
	Const = "LegendScry"
});

::Legends.Perk.LegendPiercingShot <- null;
perkDefObjects.push({
	ID = "perk.legend_piercing_shot",
	Script = "scripts/skills/perks/perk_legend_piercing_shot",
	Name = ::Const.Strings.PerkName.LegendPiercingShot,
	Tooltip = ::Const.Strings.PerkDescription.LegendPiercingShot,
	Icon = "ui/perks/PiercingBoltPerk.png",
	IconDisabled = "ui/perks/PiercingBoltPerk_bw.png",
	Const = "LegendPiercingShot"
});

::Legends.Perk.LegendLevitate <- null;
perkDefObjects.push({
	ID = "perk.legend_levitation",
	Script = "scripts/skills/perks/perk_legend_levitation",
	Name = ::Const.Strings.PerkName.LegendLevitate,
	Tooltip = ::Const.Strings.PerkDescription.LegendLevitate,
	Icon = "ui/perks/levitate.png",
	IconDisabled = "ui/perks/levitate_bw.png",
	Const = "LegendLevitate"
});

::Legends.Perk.LegendTeleport <- null;
perkDefObjects.push({
	ID = "perk.legend_teleport",
	Script = "scripts/skills/perks/perk_legend_teleport",
	Name = ::Const.Strings.PerkName.LegendTeleport,
	Tooltip = ::Const.Strings.PerkDescription.LegendTeleport,
	Icon = "ui/perks/teleport_perk.png",
	IconDisabled = "ui/perks/teleport_perk_bw.png",
	Const = "LegendTeleport"
});

::Legends.Perk.LegendSpecialistShieldSkill <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_shield_skill",
	Script = "scripts/skills/perks/perk_legend_specialist_shield_skill",
	Name = ::Const.Strings.PerkName.LegendSpecialistShieldSkill,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistShieldSkill,
	Icon = "ui/perks/perk_05.png",
	IconDisabled = "ui/perks/perk_05_sw.png",
	Const = "LegendSpecialistShieldSkill"
});

::Legends.Perk.LegendSpecialistShieldPush <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_shield_push",
	Script = "scripts/skills/perks/perk_legend_specialist_shield_push",
	Name = ::Const.Strings.PerkName.LegendSpecialistShieldPush,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistShieldPush,
	Icon = "ui/perks/perk_22.png",
	IconDisabled = "ui/perks/perk_22_sw.png",
	Const = "LegendSpecialistShieldPush"
});

::Legends.Perk.LegendMasteryNets <- null;
perkDefObjects.push({
	ID = "perk.legend_mastery_nets",
	Script = "scripts/skills/perks/perk_legend_mastery_nets",
	Name = ::Const.Strings.PerkName.LegendMasteryNets,
	Tooltip = ::Const.Strings.PerkDescription.LegendMasteryNets,
	Icon = "ui/perks/net_perk.png",
	IconDisabled = "ui/perks/net_perk_bw.png",
	Const = "LegendMasteryNets"
});

::Legends.Perk.LegendValaChantFury <- null;
perkDefObjects.push({
	ID = "perk.legend_vala_chant_fury",
	Script = "scripts/skills/perks/perk_legend_vala_chant_fury",
	Name = ::Const.Strings.PerkName.LegendValaChantFury,
	Tooltip = ::Const.Strings.PerkDescription.LegendValaChantFury,
	Icon = "ui/perks/legend_vala_chant_fury.png",
	IconDisabled = "ui/perks/legend_vala_chant_fury_sw.png",
	Const = "LegendValaChantFury"
});

::Legends.Perk.LegendValaChantSenses <- null;
perkDefObjects.push({
	ID = "perk.legend_vala_chant_senses",
	Script = "scripts/skills/perks/perk_legend_vala_chant_senses",
	Name = ::Const.Strings.PerkName.LegendValaChantSenses,
	Tooltip = ::Const.Strings.PerkDescription.LegendValaChantSenses,
	Icon = "ui/perks/legend_vala_chant_senses.png",
	IconDisabled = "ui/perks/legend_vala_chant_senses_sw.png",
	Const = "LegendValaChantSenses"
});

::Legends.Perk.LegendInventorAnatomy <- null;
perkDefObjects.push({
	ID = "perk.legend_inventor_anatomy",
	Script = "scripts/skills/perks/perk_legend_inventor_anatomy",
	Name = ::Const.Strings.PerkName.LegendInventorAnatomy,
	Tooltip = ::Const.Strings.PerkDescription.LegendInventorAnatomy,
	Icon = "ui/perks/legend_inventor_anatomy.png",
	IconDisabled = "ui/perks/legend_inventor_anatomy_sw.png",
	Const = "LegendInventorAnatomy"
});

::Legends.Perk.LegendMasterySlings <- null;
perkDefObjects.push({
	ID = "perk.legend_mastery_slings",
	Script = "scripts/skills/perks/perk_legend_mastery_slings",
	Name = ::Const.Strings.PerkName.LegendMasterySlings,
	Tooltip = ::Const.Strings.PerkDescription.LegendMasterySlings,
	Icon = "ui/perks/perk_sling_mastery.png",
	IconDisabled = "ui/perks/perk_sling_mastery_bw.png",
	Const = "LegendMasterySlings"
});

::Legends.Perk.LegendSlingerSpins <- null;
perkDefObjects.push({
		ID = "perk.legend_slinger_spins",
		Script = "scripts/skills/perks/perk_legend_slinger_spins",
		Name = this.Const.Strings.PerkName.LegendSlingerSpins,
		Tooltip = this.Const.Strings.PerkDescription.LegendSlingerSpins,
		Icon = "ui/perks/perk_slinger_spins.png",
		IconDisabled = "ui/perks/perk_slinger_spins_bw.png",
		Const = "LegendSlingerSpins"
});

::Legends.Perk.LegendBarrage <- null;
perkDefObjects.push({
		ID = "perk.legend_barrage",
		Script = "scripts/skills/perks/perk_legend_barrage",
		Name = this.Const.Strings.PerkName.LegendBarrage,
		Tooltip = this.Const.Strings.PerkDescription.LegendBarrage,
		Icon = "ui/perks/perk_barrage.png",
		IconDisabled = "ui/perks/perk_barrage_bw.png",
		Const = "LegendBarrage"
});

::Legends.Perk.LegendStaffBlock <- null;
perkDefObjects.push({
		ID = "perk.legend_staff_block",
		Script = "scripts/skills/perks/perk_legend_staff_block",
		Name = this.Const.Strings.PerkName.LegendStaffBlock,
		Tooltip = this.Const.Strings.PerkDescription.LegendStaffBlock,
		Icon = "ui/perks/staff_skill_circle.png",
		IconDisabled = "ui/perks/staff_skill_circle_bw.png",
		Const = "LegendStaffBlock"
});

::Legends.Perk.LegendFavouredEnemyGhoul <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_ghoul",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_ghoul",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyGhoul,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyGhoul,
	Icon = "ui/perks/favoured_ghoul_01.png",
	IconDisabled = "ui/perks/favoured_ghoul_bw.png",
	Const = "LegendFavouredEnemyGhoul",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyHexen <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_hexen",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_hexen",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyHexen,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyHexen,
	Icon = "ui/perks/favoured_hexen_01.png",
	IconDisabled = "ui/perks/favoured_hexen_bw.png",
	Const = "LegendFavouredEnemyHexen",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyAlps <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_alps",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_alps",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyAlps,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyAlps,
	Icon = "ui/perks/favoured_alps_01.png",
	IconDisabled = "ui/perks/favoured_alps_bw.png",
	Const = "LegendFavouredEnemyAlps",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyUnhold <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_unhold",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_unhold",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyUnhold,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyUnhold,
	Icon = "ui/perks/favoured_unhold_01.png",
	IconDisabled = "ui/perks/favoured_unhold_bw.png",
	Const = "LegendFavouredEnemyUnhold",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyLindwurm <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_lindwurm",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_lindwurm",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyLindwurm,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyLindwurm,
	Icon = "ui/perks/favoured_lindwurm_01.png",
	IconDisabled = "ui/perks/favoured_lindwurm_bw.png",
	Const = "LegendFavouredEnemyLindwurm",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyDirewolf <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_direwolf",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_direwolf",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyDirewolf,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyDirewolf,
	Icon = "ui/perks/favoured_direwolf_01.png",
	IconDisabled = "ui/perks/favoured_direwolf_bw.png",
	Const = "LegendFavouredEnemyDirewolf",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemySpider <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_spider",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_spider",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemySpider,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySpider,
	Icon = "ui/perks/favoured_spider_01.png",
	IconDisabled = "ui/perks/favoured_spider_bw.png",
	Const = "LegendFavouredEnemySpider",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemySchrat <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_schrat",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_schrat",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemySchrat,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySchrat,
	Icon = "ui/perks/favoured_schrat_01.png",
	IconDisabled = "ui/perks/favoured_schrat_bw.png",
	Const = "LegendFavouredEnemySchrat",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyOrk <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_ork",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_ork",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyOrk,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyOrk,
	Icon = "ui/perks/favoured_ork_01.png",
	IconDisabled = "ui/perks/favoured_ork_bw.png",
	Const = "LegendFavouredEnemyOrk",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyGoblin <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_goblin",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_goblin",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyGoblin,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyGoblin,
	Icon = "ui/perks/favoured_goblin_01.png",
	IconDisabled = "ui/perks/favoured_goblin_bw.png",
	Const = "LegendFavouredEnemyGoblin",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyVampire <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_vampire",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_vampire",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyVampire,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyVampire,
	Icon = "ui/perks/favoured_vampire_01.png",
	IconDisabled = "ui/perks/favoured_vampire_bw.png",
	Const = "LegendFavouredEnemyVampire",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemySkeleton <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_skeleton",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_skeleton",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemySkeleton,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySkeleton,
	Icon = "ui/perks/favoured_skeleton_01.png",
	IconDisabled = "ui/perks/favoured_skeleton_bw.png",
	Const = "LegendFavouredEnemySkeleton",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyZombie <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_zombie",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_zombie",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyZombie,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyZombie,
	Icon = "ui/perks/favoured_zombie_01.png",
	IconDisabled = "ui/perks/favoured_zombie_bw.png",
	Const = "LegendFavouredEnemyZombie",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyNoble <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_noble",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_noble",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyNoble,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyNoble,
	Icon = "ui/perks/favoured_noble_01.png",
	IconDisabled = "ui/perks/favoured_noble_bw.png",
	Const = "LegendFavouredEnemyNoble",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyBarbarian <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_barbarian",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_barbarian",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyBarbarian,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyBarbarian,
	Icon = "ui/perks/favoured_barbarian_01.png",
	IconDisabled = "ui/perks/favoured_barbarian_bw.png",
	Const = "LegendFavouredEnemyBarbarian",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyBandit <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_bandit",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_bandit",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyBandit,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyBandit,
	Icon = "ui/perks/favoured_bandit_01.png",
	IconDisabled = "ui/perks/favoured_bandit_bw.png",
	Const = "LegendFavouredEnemyBandit",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyArcher <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_master_archer",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_master_archer",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyArcher,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyArcher,
	Icon = "ui/perks/favoured_archer_01.png",
	IconDisabled = "ui/perks/favoured_archer_bw.png",
	Const = "LegendFavouredEnemyArcher",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemySwordmaster <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_swordmaster",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_swordmaster",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemySwordmaster,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySwordmaster,
	Icon = "ui/perks/favoured_swordmaster_01.png",
	IconDisabled = "ui/perks/favoured_swordmaster_bw.png",
	Const = "LegendFavouredEnemySwordmaster",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyMercenary <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_mercenary",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_mercenary",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyMercenary,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyMercenary,
	Icon = "ui/perks/favoured_mercenary_01.png",
	IconDisabled = "ui/perks/favoured_mercenary_bw.png",
	Const = "LegendFavouredEnemyMercenary",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyCaravan <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_caravan",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_caravan",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyCaravan,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyCaravan,
	Icon = "ui/perks/favoured_caravan_01.png",
	IconDisabled = "ui/perks/favoured_caravan_bw.png",
	Const = "LegendFavouredEnemyCaravan",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemySoutherner <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_southerner",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_southerner",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemySoutherner,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySoutherner,
	Icon = "ui/perks/favoured_southerner_01.png",
	IconDisabled = "ui/perks/favoured_southerner_bw.png",
	Const = "LegendFavouredEnemySoutherner",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendFavouredEnemyNomad <- null;
perkDefObjects.push({
	ID = "perk.legend_favoured_enemy_nomad",
	Script = "scripts/skills/perks/perk_legend_favoured_enemy_nomad",
	Name = ::Const.Strings.PerkName.LegendFavouredEnemyNomad,
	Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyNomad,
	Icon = "ui/perks/favoured_nomad_01.png",
	IconDisabled = "ui/perks/favoured_nomad_bw.png",
	Const = "LegendFavouredEnemyNomad",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendForcefulSwing <- null;
perkDefObjects.push({
	ID = "perk.legend_forceful_swing",
	Script = "scripts/skills/perks/perk_legend_forceful_swing",
	Name = ::Const.Strings.PerkName.LegendForcefulSwing,
	Tooltip = ::Const.Strings.PerkDescription.LegendForcefulSwing,
	Icon = "ui/perks/forceful_swings.png",
	IconDisabled = "ui/perks/forceful_swings_bw.png",
	Const = "LegendForcefulSwing"
});

::Legends.Perk.LegendBalance <- null;
perkDefObjects.push({
	ID = "perk.legend_balance",
	Script = "scripts/skills/perks/perk_legend_balance",
	Name = ::Const.Strings.PerkName.LegendBalance,
	Tooltip = ::Const.Strings.PerkDescription.LegendBalance,
	Icon = "ui/perks/balance.png",
	IconDisabled = "ui/perks/balance_bw.png",
	Const = "LegendBalance"
});

::Legends.Perk.LegendPerfectFit <- null;
perkDefObjects.push({
	ID = "perk.legend_perfect_fit",
	Script = "scripts/skills/perks/perk_legend_perfect_fit",
	Name = ::Const.Strings.PerkName.LegendPerfectFit,
	Tooltip = ::Const.Strings.PerkDescription.LegendPerfectFit,
	Icon = "ui/perks/perfect_fit.png",
	IconDisabled = "ui/perks/perfect_fit_bw.png",
	Const = "LegendPerfectFit",
	HasUnactivatedPerkTooltipHints = true
});

::Legends.Perk.LegendLithe <- null;
perkDefObjects.push({
	ID = "perk.legend_lithe",
	Script = "scripts/skills/perks/perk_legend_lithe",
	Name = ::Const.Strings.PerkName.LegendLithe,
	Tooltip = ::Const.Strings.PerkDescription.LegendLithe,
	Icon = "ui/perks/lithe.png",
	IconDisabled = "ui/perks/lithe_bw.png",
	Const = "LegendLithe"
});

::Legends.Perk.LegendInTheZone <- null;
perkDefObjects.push({
	ID = "perk.legend_in_the_zone",
	Script = "scripts/skills/perks/perk_legend_in_the_zone",
	Name = ::Const.Strings.PerkName.LegendInTheZone,
	Tooltip = ::Const.Strings.PerkDescription.LegendInTheZone,
	Icon = "ui/perks/in_the_zone.png",
	IconDisabled = "ui/perks/in_the_zone_bw.png",
	Const = "LegendInTheZone"
});

::Legends.Perk.LegendHidden <- null;
perkDefObjects.push({
	ID = "perk.legend_hidden",
	Script = "scripts/skills/perks/perk_legend_hidden",
	Name = ::Const.Strings.PerkName.LegendHidden,
	Tooltip = ::Const.Strings.PerkDescription.LegendHidden,
	Icon = "ui/perks/hidden.png",
	IconDisabled = "ui/perks/hidden_bw.png",
	Const = "LegendHidden"
});

::Legends.Perk.LegendSpecSpearWall <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_spearwall",
	Script = "scripts/skills/perks/perk_legend_specialist_spearwall",
	Name = ::Const.Strings.PerkName.LegendSpecSpearWall,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecSpearWall,
	Icon = "ui/perks/spearwall_mastery.png",
	IconDisabled = "ui/perks/spearwall_mastery_bw.png",
	Const = "LegendSpecSpearWall"
});

::Legends.Perk.LegendThrustMaster <- null;
perkDefObjects.push({
	ID = "perk.legend_thrust_master",
	Script = "scripts/skills/perks/perk_legend_thrust_master",
	Name = ::Const.Strings.PerkName.LegendThrustMaster,
	Tooltip = ::Const.Strings.PerkDescription.LegendThrustMaster,
	Icon = "ui/perks/spearthrust_mastery.png",
	IconDisabled = "ui/perks/spearthrust_mastery_bw.png",
	Const = "LegendThrustMaster"
});

::Legends.Perk.LegendAssuredConquest <- null;
perkDefObjects.push({
	ID = "perk.legend_assured_conquest",
	Script = "scripts/skills/perks/perk_legend_assured_conquest",
	Name = ::Const.Strings.PerkName.LegendAssuredConquest,
	Tooltip = ::Const.Strings.PerkDescription.LegendAssuredConquest,
	Icon = "ui/perks/assured_conquest_circle.png",
	IconDisabled = "ui/perks/assured_conquest_circle_bw.png",
	Const = "LegendAssuredConquest"
});

::Legends.Perk.LegendBlendIn <- null;
perkDefObjects.push({
	ID = "perk.legend_blend_in",
	Script = "scripts/skills/perks/perk_legend_blend_in",
	Name = ::Const.Strings.PerkName.LegendBlendIn,
	Tooltip = ::Const.Strings.PerkDescription.LegendBlendIn,
	Icon = "ui/perks/blend_in_circle.png",
	IconDisabled = "ui/perks/blend_in_circle_bw.png",
	Const = "LegendBlendIn"
});

::Legends.Perk.LegendSpecStaffStun <- null;
perkDefObjects.push({
	ID = "perk.legend_mastery_staff_stun",
	Script = "scripts/skills/perks/perk_legend_mastery_staff_stun",
	Name = ::Const.Strings.PerkName.LegendSpecStaffStun,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecStaffStun,
	Icon = "ui/perks/staff_circle.png",
	IconDisabled = "ui/perks/staff_circle_bw.png",
	Const = "LegendSpecStaffStun"
});

::Legends.Perk.LegendMinnesanger <- null;
perkDefObjects.push({
	ID = "perk.legend_minnesanger",
	Script = "scripts/skills/perks/perk_legend_minnesanger",
	Name = ::Const.Strings.PerkName.LegendMinnesanger,
	Tooltip = ::Const.Strings.PerkDescription.LegendMinnesanger,
	Icon = "ui/perks/minnesanger.png",
	IconDisabled = "ui/perks/minnesanger_bw.png",
	Const = "LegendMinnesanger"
});

::Legends.Perk.LegendSpecUnarmed <- null;
perkDefObjects.push({
	ID = "perk.legend_mastery_unarmed",
	Script = "scripts/skills/perks/perk_legend_mastery_unarmed",
	Name = ::Const.Strings.PerkName.LegendSpecUnarmed,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecUnarmed,
	Icon = "ui/perks/unarmed_mastery_circle.png",
	IconDisabled = "ui/perks/unarmed_mastery_circle_bw.png",
	Const = "LegendSpecUnarmed"
});

::Legends.Perk.LegendKick <- null;
perkDefObjects.push({
	ID = "perk.legend_kick",
	Script = "scripts/skills/perks/perk_legend_kick",
	Name = ::Const.Strings.PerkName.LegendKick,
	Tooltip = ::Const.Strings.PerkDescription.LegendKick,
	Icon = "ui/perks/kick_circle.png",
	IconDisabled = "ui/perks/kick_circle_bw.png",
	Const = "LegendKick"
});

::Legends.Perk.LegendGrapple <- null;
perkDefObjects.push({
	ID = "perk.legend_grapple",
	Script = "scripts/skills/perks/perk_legend_grapple",
	Name = ::Const.Strings.PerkName.LegendGrapple,
	Tooltip = ::Const.Strings.PerkDescription.LegendGrapple,
	Icon = "ui/perks/grapple_circle.png",
	IconDisabled = "ui/perks/grapple_circle_bw.png",
	Const = "LegendGrapple"
});

::Legends.Perk.LegendAmbidextrous <- null;
perkDefObjects.push({
	ID = "perk.legend_ambidextrous",
	Script = "scripts/skills/perks/perk_legend_ambidextrous",
	Name = ::Const.Strings.PerkName.LegendAmbidextrous,
	Tooltip = ::Const.Strings.PerkDescription.LegendAmbidextrous,
	Icon = "ui/perks/ambidexterity_circle.png", // Just borrowed duelist, change later w/ Olve's art
	IconDisabled = "ui/perks/ambidexterity_circle_bw.png",
	Const = "LegendAmbidextrous"
});

::Legends.Perk.LegendTackle <- null;
perkDefObjects.push({
	ID = "perk.legend_tackle",
	Script = "scripts/skills/perks/perk_legend_tackle",
	Name = ::Const.Strings.PerkName.LegendTackle,
	Tooltip = ::Const.Strings.PerkDescription.LegendTackle,
	Icon = "ui/perks/tackle_circle.png", // Just borrowed duelist, change later w/ Olve's art
	IconDisabled = "ui/perks/tackle_circle_bw.png",
	Const = "LegendTackle"
});

::Legends.Perk.LegendFieldTreats <- null;
perkDefObjects.push({
	ID = "perk.legend_field_treats",
	Script = "scripts/skills/perks/perk_legend_field_treats",
	Name = ::Const.Strings.PerkName.LegendFieldTreats,
	Tooltip = ::Const.Strings.PerkDescription.LegendFieldTreats,
	Icon = "ui/perks/drink_circle.png",
	IconDisabled = "ui/perks/drink_circle_bw.png",
	Const = "LegendFieldTreats"
});

::Legends.Perk.LegendSmashingShields <- null;
perkDefObjects.push({
	ID = "perk.legend_smashing_shields",
	Script = "scripts/skills/perks/perk_legend_smashing_shields",
	Name = ::Const.Strings.PerkName.LegendSmashingShields,
	Tooltip = ::Const.Strings.PerkDescription.LegendSmashingShields,
	Icon = "ui/perks/smashing_shields_circle.png",
	IconDisabled = "ui/perks/smashing_shields_circle_bw.png",
	Const = "LegendSmashingShields"
});

::Legends.Perk.LegendSmackdown <- null;
perkDefObjects.push({
	ID = "perk.legend_smackdown",
	Script = "scripts/skills/perks/perk_legend_smackdown",
	Name = ::Const.Strings.PerkName.LegendSmackdown,
	Tooltip = ::Const.Strings.PerkDescription.LegendSmackdown,
	Icon = "ui/perks/smackdown_circle.png",
	IconDisabled = "ui/perks/smackdown_circle_bw.png",
	Const = "LegendSmackdown"
});

::Legends.Perk.LegendBoneBreaker <- null;
perkDefObjects.push({
	ID = "perk.legend_bone_breaker",
	Script = "scripts/skills/perks/perk_legend_bone_breaker",
	Name = ::Const.Strings.PerkName.LegendBoneBreaker,
	Tooltip = ::Const.Strings.PerkDescription.LegendBoneBreaker,
	Icon = "ui/perks/bone_breaker.png",
	IconDisabled = "ui/perks/bone_breaker_bw.png",
	Const = "LegendBoneBreaker"
});

::Legends.Perk.LegendFeint <- null;
perkDefObjects.push({
	ID = "perk.legend_feint",
	Script = "scripts/skills/perks/perk_legend_feint",
	Name = ::Const.Strings.PerkName.LegendFeint,
	Tooltip = ::Const.Strings.PerkDescription.LegendFeint,
	Icon = "ui/perks/feint_circle.png",
	IconDisabled = "ui/perks/feint_circle_bw.png",
	Const = "LegendFeint"
});

::Legends.Perk.LegendClarity <- null;
perkDefObjects.push({
	ID = "perk.legend_clarity",
	Script = "scripts/skills/perks/perk_legend_clarity",
	Name = ::Const.Strings.PerkName.LegendClarity,
	Tooltip = ::Const.Strings.PerkDescription.LegendClarity,
	Icon = "ui/perks/clarity_circle.png",
	IconDisabled = "ui/perks/clarity_circle_bw.png",
	Const = "LegendClarity"
});

::Legends.Perk.LegendAlert <- null;
perkDefObjects.push({
	ID = "perk.legend_alert",
	Script = "scripts/skills/perks/perk_legend_alert",
	Name = ::Const.Strings.PerkName.LegendAlert,
	Tooltip = ::Const.Strings.PerkDescription.LegendAlert,
	Icon = "ui/perks/alert_circle.png",
	IconDisabled = "ui/perks/alert_circle_bw.png",
	Const = "LegendAlert"
});

::Legends.Perk.LegendBloodbath <- null;
perkDefObjects.push({
	ID = "perk.legend_bloodbath",
	Script = "scripts/skills/perks/perk_legend_bloodbath",
	Name = ::Const.Strings.PerkName.LegendBloodbath,
	Tooltip = ::Const.Strings.PerkDescription.LegendBloodbath,
	Icon = "ui/perks/bloodbath_circle.png",
	IconDisabled = "ui/perks/bloodbath_circle_bw.png",
	Const = "LegendBloodbath"
});

::Legends.Perk.LegendTerrifyingVisage <- null;
perkDefObjects.push({
	ID = "perk.legend_terrifying_visage",
	Script = "scripts/skills/perks/perk_legend_terrifying_visage",
	Name = ::Const.Strings.PerkName.LegendTerrifyingVisage,
	Tooltip = ::Const.Strings.PerkDescription.LegendTerrifyingVisage,
	Icon = "ui/perks/perk_21.png",
	IconDisabled = "ui/perks/perk_21_sw.png",
	Const = "LegendTerrifyingVisage"
});

::Legends.Perk.LegendFreedomOfMovement <- null;
perkDefObjects.push({
	ID = "perk.legend_freedom_of_movement",
	Script = "scripts/skills/perks/perk_legend_freedom_of_movement",
	Name = ::Const.Strings.PerkName.LegendFreedomOfMovement,
	Tooltip = ::Const.Strings.PerkDescription.LegendFreedomOfMovement,
	Icon = "ui/perks/freedom_of_movement_circle.png",
	IconDisabled = "ui/perks/freedom_of_movement_circle_bw.png",
	Const = "LegendFreedomOfMovement"
});

::Legends.Perk.LegendOnslaught <- null;
perkDefObjects.push({
	ID = "perk.legend_onslaught",
	Script = "scripts/skills/perks/perk_legend_onslaught",
	Name = ::Const.Strings.PerkName.LegendOnslaught,
	Tooltip = ::Const.Strings.PerkDescription.LegendOnslaught,
	Icon = "ui/perks/perk_26.png",
	IconDisabled = "ui/perks/perk_26_sw.png",
	Const = "LegendOnslaught"
});

::Legends.Perk.LegendBackToBasics <- null;
perkDefObjects.push({
	ID = "perk.legend_back_to_basics",
	Script = "scripts/skills/perks/perk_legend_back_to_basics",
	Name = ::Const.Strings.PerkName.LegendBackToBasics,
	Tooltip = ::Const.Strings.PerkDescription.LegendBackToBasics,
	Icon = "ui/perks/back_to_basics_circle.png",
	IconDisabled = "ui/perks/back_to_basics_circle_bw.png",
	Const = "LegendBackToBasics"
});

::Legends.Perk.LegendPushTheAdvantage <- null;
perkDefObjects.push({
	ID = "perk.legend_push_the_advantage",
	Script = "scripts/skills/perks/perk_legend_push_the_advantage",
	Name = ::Const.Strings.PerkName.LegendPushTheAdvantage,
	Tooltip = ::Const.Strings.PerkDescription.LegendPushTheAdvantage,
	Icon = "ui/perks/perk_32.png", // todo is that correct icon?
	IconDisabled = "ui/perks/perk_32_sw.png",
	Const = "LegendPushTheAdvantage"
});

::Legends.Perk.LegendTrophyHunter <- null;
perkDefObjects.push({
	ID = "perk.legend_trophy_hunter",
	Script = "scripts/skills/perks/perk_legend_trophy_hunter",
	Name = ::Const.Strings.PerkName.LegendTrophyHunter,
	Tooltip = ::Const.Strings.PerkDescription.LegendTrophyHunter,
	Icon = "ui/perks/slaughterer_circle.png",
	IconDisabled = "ui/perks/slaughterer_circle_bw.png",
	Const = "LegendTrophyHunter"
});

::Legends.Perk.LegendBruiser <- null;
perkDefObjects.push({
	ID = "perk.legend_bruiser",
	Script = "scripts/skills/perks/perk_legend_bruiser",
	Name = ::Const.Strings.PerkName.LegendBruiser,
	Tooltip = ::Const.Strings.PerkDescription.LegendBruiser,
	Icon = "ui/perks/perk_40.png",
	IconDisabled = "ui/perks/perk_40_sw.png",
	Const = "LegendBruiser"
});

::Legends.Perk.LegendMindOverBody <- null;
perkDefObjects.push({
	ID = "perk.legend_mind_over_body",
	Script = "scripts/skills/perks/perk_legend_mind_over_body",
	Name = ::Const.Strings.PerkName.LegendMindOverBody,
	Tooltip = ::Const.Strings.PerkDescription.LegendMindOverBody,
	Icon = "ui/perks/relax_circle.png",
	IconDisabled = "ui/perks/relax_circle_bw.png",
	Const = "LegendMindOverBody",
	HasUnactivatedPerkTooltipHints = true
});

::Legends.Perk.LegendEscapeArtist <- null;
perkDefObjects.push({
	ID = "perk.legend_escape_artist",
	Script = "scripts/skills/perks/perk_legend_escape_artist",
	Name = ::Const.Strings.PerkName.LegendEscapeArtist,
	Tooltip = ::Const.Strings.PerkDescription.LegendEscapeArtist,
	Icon = "ui/perks/net_escape.png",
	IconDisabled = "ui/perks/net_escape_bw.png",
	Const = "LegendEscapeArtist"
});

::Legends.Perk.LegendGatherer <- null;
perkDefObjects.push({
	ID = "perk.legend_gatherer",
	Script = "scripts/skills/perks/perk_legend_gatherer",
	Name = ::Const.Strings.PerkName.LegendGatherer,
	Tooltip = ::Const.Strings.PerkDescription.LegendGatherer,
	Icon = "ui/perks/herbs_circle.png",
	IconDisabled = "ui/perks/herbs_circle_bw.png",
	Const = "LegendGatherer"
});

::Legends.Perk.LegendPotionBrewer <- null;
perkDefObjects.push({
	ID = "perk.legend_potion_brewer",
	Script = "scripts/skills/perks/perk_legend_potion_brewer",
	Name = ::Const.Strings.PerkName.LegendPotionBrewer,
	Tooltip = ::Const.Strings.PerkDescription.LegendPotionBrewer,
	Icon = "ui/perks/potion_circle.png",
	IconDisabled = "ui/perks/potion_circle_bw.png",
	Const = "LegendPotionBrewer"
});

::Legends.Perk.LegendSpecCultHood <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_cult_hood",
	Script = "scripts/skills/perks/perk_legend_specialist_cult_hood",
	Name = ::Const.Strings.PerkName.LegendSpecCultHood,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecCultHood,
	Icon = "ui/perks/dedication_circle.png",
	IconDisabled = "ui/perks/dedication_circle_bw.png",
	Const = "LegendSpecCultHood"
});

::Legends.Perk.LegendSpecCultArmor <- null;
perkDefObjects.push({
	ID = "perk.legend_specialist_cult_armor",
	Script = "scripts/skills/perks/perk_legend_specialist_cult_armor",
	Name = ::Const.Strings.PerkName.LegendSpecCultArmor,
	Tooltip = ::Const.Strings.PerkDescription.LegendSpecCultArmor,
	Icon = "ui/perks/penance_circle.png",
	IconDisabled = "ui/perks/penance_circle_bw.png",
	Const = "LegendSpecCultArmor"
});

::Legends.Perk.LegendPrepareBleed <- null;
perkDefObjects.push({
	ID = "perk.legend_prepare_bleed",
	Script = "scripts/skills/perks/perk_legend_prepare_bleed",
	Name = ::Const.Strings.PerkName.LegendPrepareBleed,
	Tooltip = ::Const.Strings.PerkDescription.LegendPrepareBleed,
	Icon = "ui/perks/bleed_circle.png",
	IconDisabled = "ui/perks/bleed_circle_bw.png",
	Const = "LegendPrepareBleed"
});

::Legends.Perk.LegendPrepareGraze <- null;
perkDefObjects.push({
	ID = "perk.legend_prepare_graze",
	Script = "scripts/skills/perks/perk_legend_prepare_graze",
	Name = ::Const.Strings.PerkName.LegendPrepareGraze,
	Tooltip = ::Const.Strings.PerkDescription.LegendPrepareGraze,
	Icon = "ui/perks/graze_circle.png",
	IconDisabled = "ui/perks/graze_circle_bw.png",
	Const = "LegendPrepareGraze"
});

::Legends.Perk.LegendCarnage <- null;
perkDefObjects.push({
	ID = "perk.legend_carnage",
	Script = "scripts/skills/perks/perk_legend_carnage",
	Name = ::Const.Strings.PerkName.LegendCarnage,
	Tooltip = ::Const.Strings.PerkDescription.LegendCarnage,
	Icon = "ui/perks/slaughter_circle.png",
	IconDisabled = "ui/perks/slaughter_circle_bw.png",
	Const = "LegendCarnage"
});

::Legends.Perk.LegendUntouchable <- null;
perkDefObjects.push({
	ID = "perk.legend_untouchable",
	Script = "scripts/skills/perks/perk_legend_untouchable",
	Name = ::Const.Strings.PerkName.LegendUntouchable,
	Tooltip = ::Const.Strings.PerkDescription.LegendUntouchable,
	Icon = "ui/perks/untouchable_circle.png",
	IconDisabled = "ui/perks/untouchable_circle_bw.png",
	Const = "LegendUntouchable"
});

::Legends.Perk.LegendKnifeplay <- null;
perkDefObjects.push({
	ID = "perk.legend_knifeplay",
	Script = "scripts/skills/perks/perk_legend_knifeplay",
	Name = ::Const.Strings.PerkName.LegendKnifeplay,
	Tooltip = ::Const.Strings.PerkDescription.LegendKnifeplay,
	Icon = "ui/perks/knifeplay.png",
	IconDisabled = "ui/perks/knifeplay_bw.png",
	Const = "LegendKnifeplay"
});

::Legends.Perk.LegendOpportunist <- null;
perkDefObjects.push({
	ID = "perk.legend_opportunist",
	Script = "scripts/skills/perks/perk_legend_opportunist",
	Name = ::Const.Strings.PerkName.LegendOpportunist,
	Tooltip = ::Const.Strings.PerkDescription.LegendOpportunist,
	Icon = "ui/perks/opportunist.png",
	IconDisabled = "ui/perks/opportunist_bw.png",
	Const = "LegendOpportunist"
});

::Legends.Perk.LegendPrepared <- null;
perkDefObjects.push({
	ID = "perk.legend_prepared",
	Script = "scripts/skills/perks/perk_legend_prepared",
	Name = ::Const.Strings.PerkName.LegendPrepared,
	Tooltip = ::Const.Strings.PerkDescription.LegendPrepared,
	Icon = "ui/perks/prepared.png",
	IconDisabled = "ui/perks/prepared_bw.png",
	Const = "LegendPrepared"
});

::Legends.Perk.LegendLurker <- null;
perkDefObjects.push({
	ID = "perk.legend_lurker",
	Script = "scripts/skills/perks/perk_legend_lurker",
	Name = ::Const.Strings.PerkName.LegendLurker,
	Tooltip = ::Const.Strings.PerkDescription.LegendLurker,
	Icon = "ui/perks/lurker.png",
	IconDisabled = "ui/perks/lurker_bw.png",
	Const = "LegendLurker"
});

::Legends.Perk.LegendNightRaider <- null;
perkDefObjects.push({
	ID = "perk.legend_night_raider",
	Script = "scripts/skills/perks/perk_legend_night_raider",
	Name = ::Const.Strings.PerkName.LegendNightRaider,
	Tooltip = ::Const.Strings.PerkDescription.LegendNightRaider,
	Icon = "ui/perks/night_raider.png",
	IconDisabled = "ui/perks/night_raider_bw.png",
	Const = "LegendNightRaider"
});

::Legends.Perk.LegendAdaptive <- null;
perkDefObjects.push({
	ID = "perk.legend_adaptive",
	Script = "scripts/skills/perks/perk_legend_adaptive",
	Name = ::Const.Strings.PerkName.LegendAdaptive,
	Tooltip = ::Const.Strings.PerkDescription.LegendAdaptive,
	Icon = "ui/perks/adaptive_circle.png",
	IconDisabled = "ui/perks/adaptive_circle_bw.png",
	Const = "LegendAdaptive",
	HasUnactivatedPerkTooltipHints = true // Inform general_queryUIPerkTooltipData() in tooltip_events.nut that the Perk has additional hints from getUnactivatedPerkTooltipHints()
});

::Legends.Perk.LegendRecuperation <- null;
perkDefObjects.push({
	ID = "perk.legend_recuperation",
	Script = "scripts/skills/perks/perk_legend_recuperation",
	Name = ::Const.Strings.PerkName.LegendRecuperation,
	Tooltip = ::Const.Strings.PerkDescription.LegendRecuperation,
	Icon = "ui/perks/recuperation_circle.png",
	IconDisabled = "ui/perks/recuperation_circle_bw.png",
	Const = "LegendRecuperation"
});

::Legends.Perk.LegendClimb <- null;
perkDefObjects.push({
	ID = "perk.legend_climb",
	Script = "scripts/skills/perks/perk_legend_climb",
	Name = ::Const.Strings.PerkName.LegendClimb,
	Tooltip = ::Const.Strings.PerkDescription.LegendClimb,
	Icon = "ui/perks/climb_circle.png",
	IconDisabled = "ui/perks/climb_circle_bw.png",
	Const = "LegendClimb"
});

::Legends.Perk.LegendSmallTarget <- null;
perkDefObjects.push({
	ID = "perk.legend_small_target",
	Script = "scripts/skills/perks/perk_legend_small_target",
	Name = ::Const.Strings.PerkName.LegendSmallTarget,
	Tooltip = ::Const.Strings.PerkDescription.LegendSmallTarget,
	Icon = "ui/perks/small_target.png",
	IconDisabled = "ui/perks/small_target_bw.png",
	Const = "LegendSmallTarget"
});

::Legends.Perk.LegendFashionable <- null;
perkDefObjects.push({
	ID = "perk.legend_fashionable",
	Script = "scripts/skills/perks/perk_legend_fashionable",
	Name = ::Const.Strings.PerkName.LegendFashionable,
	Tooltip = ::Const.Strings.PerkDescription.LegendFashionable,
	Icon = "ui/perks/fashionable.png",
	IconDisabled = "ui/perks/fashionable_bw.png",
	Const = "LegendFashionable"
});

::Legends.Perk.LegendUnburdened <- null;
perkDefObjects.push({
	ID = "perk.legend_unburdened",
	Script = "scripts/skills/perks/perk_legend_unburdened",
	Name = ::Const.Strings.PerkName.LegendUnburdened,
	Tooltip = ::Const.Strings.PerkDescription.LegendUnburdened,
	Icon = "ui/perks/meek.png",
	IconDisabled = "ui/perks/meek_bw.png",
	Const = "LegendUnburdened"
});

::Legends.Perk.LegendHelpful <- null;
perkDefObjects.push({
	ID = "perk.legend_helpful",
	Script = "scripts/skills/perks/perk_legend_helpful",
	Name = ::Const.Strings.PerkName.LegendHelpful,
	Tooltip = ::Const.Strings.PerkDescription.LegendHelpful,
	Icon = "ui/perks/helpful.png",
	IconDisabled = "ui/perks/helpful_bw.png",
	Const = "LegendHelpful"
});

::Legends.Perk.LegendAssassinate <- null;
perkDefObjects.push({
	ID = "perk.legend_assassinate",
	Script = "scripts/skills/perks/perk_legend_assassinate",
	Name = ::Const.Strings.PerkName.LegendAssassinate,
	Tooltip = ::Const.Strings.PerkDescription.LegendAssassinate,
	Icon = "ui/perks/assassinate_circle.png",
	IconDisabled = "ui/perks/assassinate_circle_bw.png",
	Const = "LegendAssassinate"
});

::Legends.Perk.LegendMealPreperation <- null;
perkDefObjects.push({
	ID = "perk.legend_meal_preperation",
	Script = "scripts/skills/perks/perk_legend_meal_preperation",
	Name = ::Const.Strings.PerkName.LegendMealPreperation,
	Tooltip = ::Const.Strings.PerkDescription.LegendMealPreperation,
	Icon = "ui/perks/meal_prep_circle.png",
	IconDisabled = "ui/perks/meal_prep_circle_bw.png",
	Const = "LegendMealPreperation"
});

::Legends.Perk.LegendAlcoholBrewing <- null;
perkDefObjects.push({
	ID = "perk.legend_alcohol_brewing",
	Script = "scripts/skills/perks/perk_legend_alcohol_brewing",
	Name = ::Const.Strings.PerkName.LegendAlcoholBrewing,
	Tooltip = ::Const.Strings.PerkDescription.LegendAlcoholBrewing,
	Icon = "ui/perks/alcohol_circle.png",
	IconDisabled = "ui/perks/alcohol_circle_bw.png",
	Const = "LegendAlcoholBrewing"
});

::Legends.Perk.LegendHorseCharge <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_charge",
	Script = "scripts/skills/perks/perk_legend_horse_charge",
	Name = ::Const.Strings.PerkName.LegendHorseCharge,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseCharge,
	Icon = "ui/perks/charge_perk.png",
	IconDisabled = "ui/perks/charge_perk_bw.png",
	Const = "LegendHorseCharge"
});

::Legends.Perk.LegendHorsePirouette <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_pirouette",
	Script = "scripts/skills/perks/perk_legend_horse_pirouette",
	Name = ::Const.Strings.PerkName.LegendHorsePirouette,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorsePirouette,
	Icon = "ui/perks/pirouette_perk.png",
	IconDisabled = "ui/perks/pirouette_perk_bw.png",
	Const = "LegendHorsePirouette"
});

::Legends.Perk.LegendHorseBitting <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_bitting",
	Script = "scripts/skills/perks/perk_legend_horse_bitting",
	Name = ::Const.Strings.PerkName.LegendHorseBitting,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseBitting,
	Icon = "ui/perks/bitting_perk.png",
	IconDisabled = "ui/perks/bitting_perk_bw.png",
	Const = "LegendHorseBitting"
});

::Legends.Perk.LegendHorseDesensitization <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_desensitization",
	Script = "scripts/skills/perks/perk_legend_horse_desensitization",
	Name = ::Const.Strings.PerkName.LegendHorseDesensitization,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseDesensitization,
	Icon = "ui/perks/desensitization_perk.png",
	IconDisabled = "ui/perks/desensitization_perk_bw.png",
	Const = "LegendHorseDesensitization"
});

::Legends.Perk.LegendHorseHippology <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_hippology",
	Script = "scripts/skills/perks/perk_legend_horse_hippology",
	Name = ::Const.Strings.PerkName.LegendHorseHippology,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseHippology,
	Icon = "ui/perks/hippology_perk.png",
	IconDisabled = "ui/perks/hippology_perk_bw.png",
	Const = "LegendHorseHippology"
});

::Legends.Perk.LegendHorseImpulsion <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_impulsion",
	Script = "scripts/skills/perks/perk_legend_horse_impulsion",
	Name = ::Const.Strings.PerkName.LegendHorseImpulsion,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseImpulsion,
	Icon = "ui/perks/impulse_perk.png",
	IconDisabled = "ui/perks/impulse_perk_bw.png",
	Const = "LegendHorseImpulsion"
});

::Legends.Perk.LegendHorseLeadChange <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_lead_change",
	Script = "scripts/skills/perks/perk_legend_horse_lead_change",
	Name = ::Const.Strings.PerkName.LegendHorseLeadChange,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseLeadChange,
	Icon = "ui/perks/perk_23.png",
	IconDisabled = "ui/perks/perk_23_sw.png",
	Const = "LegendHorseLeadChange"
});

::Legends.Perk.LegendHorseLegControl <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_leg_control",
	Script = "scripts/skills/perks/perk_legend_horse_leg_control",
	Name = ::Const.Strings.PerkName.LegendHorseLegControl,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseLegControl,
	Icon = "ui/perks/legcontrol_perk.png",
	IconDisabled = "ui/perks/legcontrol_perk_bw.png",
	Const = "LegendHorseLegControl"
});

::Legends.Perk.LegendHorseLiberty <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_liberty",
	Script = "scripts/skills/perks/perk_legend_horse_liberty",
	Name = ::Const.Strings.PerkName.LegendHorseLiberty,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseLiberty,
	Icon = "ui/perks/liberty_perk.png",
	IconDisabled = "ui/perks/liberty_perk_bw.png",
	Const = "LegendHorseLiberty"
});

::Legends.Perk.LegendHorseLongeing <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_longeing",
	Script = "scripts/skills/perks/perk_legend_horse_longeing",
	Name = ::Const.Strings.PerkName.LegendHorseLongeing,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseLongeing,
	Icon = "ui/perks/longeing_perk.png",
	IconDisabled = "ui/perks/longeing_perk_bw.png",
	Const = "LegendHorseLongeing"
});

::Legends.Perk.LegendHorseParthianShot <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_parthian_shot",
	Script = "scripts/skills/perks/perk_legend_horse_parthian_shot",
	Name = ::Const.Strings.PerkName.LegendHorseParthianShot,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseParthianShot,
	Icon = "ui/perks/partian_shot_perk.png",
	IconDisabled = "ui/perks/partian_shot_perk_bw.png",
	Const = "LegendHorseParthianShot"
});

::Legends.Perk.LegendHorsePiaffe <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_piaffe",
	Script = "scripts/skills/perks/perk_legend_horse_piaffe",
	Name = ::Const.Strings.PerkName.LegendHorsePiaffe,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorsePiaffe,
	Icon = "ui/perks/Piaffe_perk.png",
	IconDisabled = "ui/perks/Piaffe_perk_bw.png",
	Const = "LegendHorsePiaffe"
});

::Legends.Perk.LegendHorseTempiChange <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_tempi_change",
	Script = "scripts/skills/perks/perk_legend_horse_tempi_change",
	Name = ::Const.Strings.PerkName.LegendHorseTempiChange,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseTempiChange,
	Icon = "ui/perks/perk_23.png",
	IconDisabled = "ui/perks/perk_23_sw.png",
	Const = "LegendHorseTempiChange"
});

::Legends.Perk.LegendHorseCollection <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_collection",
	Script = "scripts/skills/perks/perk_legend_horse_collection",
	Name = ::Const.Strings.PerkName.LegendHorseCollection,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseCollection,
	Icon = "ui/perks/collection_perk.png",
	IconDisabled = "ui/perks/collection_perk_bw.png",
	Const = "LegendHorseCollection"
});

::Legends.Perk.LegendHorseFlyingChange <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_flying_change",
	Script = "scripts/skills/perks/perk_legend_horse_flying_change",
	Name = ::Const.Strings.PerkName.LegendHorseFlyingChange,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseFlyingChange,
	Icon = "ui/perks/perk_23.png",
	IconDisabled = "ui/perks/perk_23_sw.png",
	Const = "LegendHorseFlyingChange"
});

::Legends.Perk.LegendHorsePassage <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_passage",
	Script = "scripts/skills/perks/perk_legend_horse_passage",
	Name = ::Const.Strings.PerkName.LegendHorsePassage,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorsePassage,
	Icon = "ui/perks/passage_perk.png",
	IconDisabled = "ui/perks/passage_perk_bw.png",
	Const = "LegendHorsePassage"
});

::Legends.Perk.LegendMeistersanger <- null;
perkDefObjects.push({
	ID = "perk.legend_meistersanger",
	Script = "scripts/skills/perks/perk_legend_meistersanger",
	Name = ::Const.Strings.PerkName.LegendMeistersanger,
	Tooltip = ::Const.Strings.PerkDescription.LegendMeistersanger,
	Icon = "ui/perks/meistersanger.png",
	IconDisabled = "ui/perks/meistersanger_bw.png",
	Const = "LegendMeistersanger"
});

::Legends.Perk.LegendLacerate <- null;
perkDefObjects.push({
	ID = "perk.legend_lacerate",
	Script = "scripts/skills/perks/perk_legend_lacerate",
	Name = ::Const.Strings.PerkName.LegendLacerate,
	Tooltip = ::Const.Strings.PerkDescription.LegendLacerate,
	Icon = "ui/perks/bleed_circle.png",
	IconDisabled = "ui/perks/bleed_circle_bw.png",
	Const = "LegendLacerate"
});

::Legends.Perk.LegendPeaceful <- null;
perkDefObjects.push({
	ID = "perk.legend_peaceful",
	Script = "scripts/skills/perks/perk_legend_peaceful",
	Name = ::Const.Strings.PerkName.LegendPeaceful,
	Tooltip = ::Const.Strings.PerkDescription.LegendPeaceful,
	Icon = "ui/perks/peaceful_circle.png",
	IconDisabled = "ui/perks/peaceful_circle_bw.png",
	Const = "LegendPeaceful"
});

::Legends.Perk.LegendSummonHound <- null;
perkDefObjects.push({
	ID = "perk.legend_summon_hound",
	Script = "scripts/skills/perks/perk_legend_summon_hound",
	Name = ::Const.Strings.PerkName.LegendSummonHound,
	Tooltip = ::Const.Strings.PerkDescription.LegendSummonHound,
	Icon = "ui/perks/dog_circle.png",
	IconDisabled = "ui/perks/dog_circle_bw.png",
	Const = "LegendSummonHound"
});

::Legends.Perk.LegendSummonWolf <- null;
perkDefObjects.push({
	ID = "perk.legend_summon_wolf",
	Script = "scripts/skills/perks/perk_legend_summon_wolf",
	Name = ::Const.Strings.PerkName.LegendSummonWolf,
	Tooltip = ::Const.Strings.PerkDescription.LegendSummonWolf,
	Icon = "ui/perks/wolf_circle.png",
	IconDisabled = "ui/perks/wolf_circle_bw.png",
	Const = "LegendSummonWolf"
});

::Legends.Perk.LegendSummonFalcon <- null;
perkDefObjects.push({
	ID = "perk.legend_summon_falcon",
	Script = "scripts/skills/perks/perk_legend_summon_falcon",
	Name = ::Const.Strings.PerkName.LegendSummonFalcon,
	Tooltip = ::Const.Strings.PerkDescription.LegendSummonFalcon,
	Icon = "ui/perks/falcon_circle.png",
	IconDisabled = "ui/perks/falcon_circle_bw.png",
	Const = "LegendSummonFalcon"
});

::Legends.Perk.LegendSummonBear <- null;
perkDefObjects.push({
	ID = "perk.legend_summon_bear",
	Script = "scripts/skills/perks/perk_legend_summon_bear",
	Name = ::Const.Strings.PerkName.LegendSummonBear,
	Tooltip = ::Const.Strings.PerkDescription.LegendSummonBear,
	Icon = "ui/perks/bear_circle.png",
	IconDisabled = "ui/perks/bear_circle_bw.png",
	Const = "LegendSummonBear"
});

::Legends.Perk.LegendSummonCatapult <- null;
perkDefObjects.push({
	ID = "perk.legend_summon_catapult",
	Script = "scripts/skills/perks/perk_legend_summon_catapult",
	Name = ::Const.Strings.PerkName.LegendSummonCatapult,
	Tooltip = ::Const.Strings.PerkDescription.LegendSummonCatapult,
	Icon = "ui/perks/catapult_circle.png",
	IconDisabled = "ui/perks/catapult_circle_bw.png",
	Const = "LegendSummonCatapult"
});

::Legends.Perk.LegendNetRepair <- null;
perkDefObjects.push({
	ID = "perk.legend_net_repair",
	Script = "scripts/skills/perks/perk_legend_net_repair",
	Name = ::Const.Strings.PerkName.LegendNetRepair,
	Tooltip = ::Const.Strings.PerkDescription.LegendNetRepair,
	Icon = "ui/perks/net_repair.png",
	IconDisabled = "ui/perks/net_repair_bw.png",
	Const = "LegendNetRepair"
});

::Legends.Perk.LegendNetCasting <- null;
perkDefObjects.push({
	ID = "perk.legend_net_casting",
	Script = "scripts/skills/perks/perk_legend_net_casting",
	Name = ::Const.Strings.PerkName.LegendNetCasting,
	Tooltip = ::Const.Strings.PerkDescription.LegendNetCasting,
	Icon = "ui/perks/net_casting.png",
	IconDisabled = "ui/perks/net_casting_bw.png",
	Const = "LegendNetCasting"
});

::Legends.Perk.LegendPacifist <- null;
perkDefObjects.push({
	ID = "perk.legend_pacifist",
	Script = "scripts/skills/perks/perk_legend_pacifist",
	Name = ::Const.Strings.PerkName.LegendPacifist,
	Tooltip = ::Const.Strings.PerkDescription.LegendPacifist,
	Icon = "ui/perks/pacifist_circle.png",
	IconDisabled = "ui/perks/pacifist_circle_bw.png",
	Const = "LegendPacifist"
});

::Legends.Perk.LegendHorseMovement <- null;
perkDefObjects.push({
	ID = "perk.legend_horse_movement",
	Script = "scripts/skills/perks/perk_legend_horse_movement",
	Name = ::Const.Strings.PerkName.LegendHorseMovement,
	Tooltip = ::Const.Strings.PerkDescription.LegendHorseMovement,
	Icon = "ui/perks/charge_perk.png",
	IconDisabled = "ui/perks/charge_perk_bw.png",
	Const = "LegendHorseMovement"
});

::Legends.Perk.LegendCampCook <- null;
perkDefObjects.push({
	ID = "perk.legend_camp_cook",
	Script = "scripts/skills/perks/perk_legend_camp_cook",
	Name = ::Const.Strings.PerkName.LegendCampCook,
	Tooltip = ::Const.Strings.PerkDescription.LegendCampCook,
	Icon = "ui/perks/cooking_circle.png",
	IconDisabled = "ui/perks/cooking_circle_bw.png",
	Const = "LegendCampCook"
});

::Legends.Perk.LegendPackleader <- null;
perkDefObjects.push({
	ID = "perk.legend_packleader",
	Script = "scripts/skills/perks/perk_legend_packleader",
	Name = ::Const.Strings.PerkName.LegendPackleader,
	Tooltip = ::Const.Strings.PerkDescription.LegendPackleader,
	Icon = "ui/perks/perk_dog.png",
	IconDisabled = "ui/perks/perk_dog_bw.png",
	Const = "LegendPackleader"
});

::Legends.Perk.LegendDogWhisperer <- null;
perkDefObjects.push({
	ID = "perk.legend_dogwhisperer",
	Script = "scripts/skills/perks/perk_legend_dogwhisperer",
	Name = ::Const.Strings.PerkName.LegendDogWhisperer,
	Tooltip = ::Const.Strings.PerkDescription.LegendDogWhisperer,
	Icon = "ui/perks/perk_hound.png",
	IconDisabled = "ui/perks/perk_hound_bw.png",
	Const = "LegendDogWhisperer"
});

::Legends.Perk.LegendDogBreeder <- null;
perkDefObjects.push({
	ID = "perk.legend_dogbreeder",
	Script = "scripts/skills/perks/perk_legend_dogbreeder",
	Name = ::Const.Strings.PerkName.LegendDogBreeder,
	Tooltip = ::Const.Strings.PerkDescription.LegendDogBreeder,
	Icon = "ui/perks/perk_dogs.png",
	IconDisabled = "ui/perks/perk_dogs_bw.png",
	Const = "LegendDogBreeder"
});

::Legends.Perk.LegendDogHandling <- null;
perkDefObjects.push({
	ID = "perk.legend_doghandling",
	Script = "scripts/skills/perks/perk_legend_doghandling",
	Name = ::Const.Strings.PerkName.LegendDogHandling,
	Tooltip = ::Const.Strings.PerkDescription.LegendDogHandling,
	Icon = "ui/perks/dog_handling.png",
	IconDisabled = "ui/perks/dog_handling_bw.png",
	Const = "LegendDogHandling"
});

::Legends.Perk.LegendDogMaster <- null;
perkDefObjects.push({
	ID = "perk.legend_dogmaster",
	Script = "scripts/skills/perks/perk_legend_dogmaster",
	Name = ::Const.Strings.PerkName.LegendDogMaster,
	Tooltip = ::Const.Strings.PerkDescription.LegendDogMaster,
	Icon = "ui/perks/dog_handling.png",
	IconDisabled = "ui/perks/dog_handling_bw.png",
	Const = "LegendDogMaster"
});

::Legends.Perk.LegendHeightenedReflexes <- null;
perkDefObjects.push({
	ID = "perk.legend_heightened_reflexes",
	Script = "scripts/skills/perks/perk_legend_heightened_reflexes",
	Name = ::Const.Strings.PerkName.LegendHeightenedReflexes,
	Tooltip = ::Const.Strings.PerkDescription.LegendHeightenedReflexes,
	Icon = "ui/perks/heightened_reflexes.png",
	IconDisabled = "ui/perks/heightened_reflexes_bw.png",
	Const = "LegendHeightenedReflexes"
});

::Legends.Perk.LegendWindReader <- null;
perkDefObjects.push({
	ID = "perk.legend_wind_reader",
	Script = "scripts/skills/perks/perk_legend_wind_reader",
	Name = ::Const.Strings.PerkName.LegendWindReader,
	Tooltip = ::Const.Strings.PerkDescription.LegendWindReader,
	Icon = "ui/perks/wind_reader.png",
	IconDisabled = "ui/perks/wind_reader_bw.png",
	Const = "LegendWindReader"
});

::Legends.Perk.LegendChoke <- null;
perkDefObjects.push({
	ID = "perk.legend_choke",
	Script = "scripts/skills/perks/perk_legend_choke",
	Name = ::Const.Strings.PerkName.LegendChoke,
	Tooltip = ::Const.Strings.PerkDescription.LegendChoke,
	Icon = "ui/perks/choke_circle.png",
	IconDisabled = "ui/perks/choke_circle_bw.png",
	Const = "LegendChoke"
});

::Legends.Perk.LegendPaymaster <- null;
perkDefObjects.push({
	ID = "perk.legend_barter_paymaster",
	Script = "scripts/skills/perks/perk_legend_barter_paymaster",
	Name = ::Const.Strings.PerkName.LegendPaymaster,
	Tooltip = ::Const.Strings.PerkDescription.LegendPaymaster,
	Icon = "ui/perks/paymaster.png",
	IconDisabled = "ui/perks/paymaster_bw.png",
	Const = "LegendPaymaster"
});

::Legends.Perk.LegendQuartermaster <- null;
perkDefObjects.push({
	ID = "perk.legend_quartermaster",
	Script = "scripts/skills/perks/perk_legend_quartermaster",
	Name = ::Const.Strings.PerkName.LegendQuartermaster,
	Tooltip = ::Const.Strings.PerkDescription.LegendQuartermaster,
	Icon = "ui/perks/food56.png",
	IconDisabled = "ui/perks/food56_bw.png",
	Const = "LegendQuartermaster"
});

::Legends.Perk.LegendBarterGreed <- null;
perkDefObjects.push({
	ID = "perk.legend_barter_greed",
	Script = "scripts/skills/perks/perk_legend_barter_greed",
	Name = ::Const.Strings.PerkName.LegendBarterGreed,
	Tooltip = ::Const.Strings.PerkDescription.LegendBarterGreed,
	Icon = "ui/perks/gold56.png",
	IconDisabled = "ui/perks/gold56_bw.png",
	Const = "LegendBarterGreed"
});

::Legends.Perk.LegendPrayerOfLife <- null;
perkDefObjects.push({
	ID = "perk.legend_prayer_of_life",
	Script = "scripts/skills/perks/perk_legend_prayer_of_life",
	Name = ::Const.Strings.PerkName.LegendPrayerOfLife,
	Tooltip = ::Const.Strings.PerkDescription.LegendPrayerOfLife,
	Icon = "ui/perks/prayer_green.png",
	IconDisabled = "ui/perks/prayer_green_bw.png",
	Const = "LegendPrayerOfLife"
});

::Legends.Perk.LegendPrayerOfFaith <- null;
perkDefObjects.push({
	ID = "perk.legend_prayer_of_faith",
	Script = "scripts/skills/perks/perk_legend_prayer_of_faith",
	Name = ::Const.Strings.PerkName.LegendPrayerOfFaith,
	Tooltip = ::Const.Strings.PerkDescription.LegendPrayerOfFaith,
	Icon = "ui/perks/prayer_purple.png",
	IconDisabled = "ui/perks/prayer_purple_bw.png",
	Const = "LegendPrayerOfFaith"
});

::Legends.Perk.LegendHolyFlame <- null;
perkDefObjects.push({
	ID = "perk.legend_holyflame",
	Script = "scripts/skills/perks/perk_legend_holyflame",
	Name = ::Const.Strings.PerkName.LegendHolyFlame,
	Tooltip = ::Const.Strings.PerkDescription.LegendHolyFlame,
	Icon = "ui/perks/holybluefire_circle.png",
	IconDisabled = "ui/perks/holyfire_circle_bw.png",
	Const = "LegendHolyFlame"
});

::Legends.Perk.LegendShieldsUp <- null;
perkDefObjects.push({
	ID = "perk.legend_shields_up",
	Script = "scripts/skills/perks/perk_legend_shields_up",
	Name = ::Const.Strings.PerkName.LegendShieldsUp,
	Tooltip = ::Const.Strings.PerkDescription.LegendShieldsUp,
	Icon = "ui/perks/shields_up.png",
	IconDisabled = "ui/perks/shields_up_bw.png",
	Const = "LegendShieldsUp"
});

::Legends.Perk.LegendIncoming <- null;
perkDefObjects.push({
	ID = "perk.legend_incoming",
	Script = "scripts/skills/perks/perk_legend_incoming",
	Name = ::Const.Strings.PerkName.LegendIncoming,
	Tooltip = ::Const.Strings.PerkDescription.LegendIncoming,
	Icon = "ui/perks/incoming_circle.png",
	IconDisabled = "ui/perks/incoming_circle_bw.png",
	Const = "LegendIncoming"
});

::Legends.Perk.LegendZombieBite <- null;
perkDefObjects.push({
	ID = "perk.perk_legend_zombie_bite",
	Script = "scripts/skills/perks/perk_legend_zombie_bite",
	Name = ::Const.Strings.PerkName.LegendZombieBite,
	Tooltip = ::Const.Strings.PerkDescription.LegendZombieBite,
	Icon = "ui/perks/mold_carrion_circle.png",
	IconDisabled = "ui/perks/mold_carrion_circle_bw.png",
	Const = "LegendZombieBite"
});

::Legends.Perk.LegendCheerOn <- null;
perkDefObjects.push({
	ID = "perk.legend_cheer_on",
	Script = "scripts/skills/perks/perk_legend_cheer_on",
	Name = ::Const.Strings.PerkName.LegendCheerOn,
	Tooltip = ::Const.Strings.PerkDescription.LegendCheerOn,
	Icon = "ui/perks/cheered_on_circle.png",
	IconDisabled = "ui/perks/cheered_on_circle_bw.png",
	Const = "LegendCheerOn"
});

::Legends.Perk.LegendLeap <- null;
perkDefObjects.push({
	ID = "perk.legend_leap",
	Script = "scripts/skills/perks/perk_legend_leap",
	Name = ::Const.Strings.PerkName.LegendLeap,
	Tooltip = ::Const.Strings.PerkDescription.LegendLeap,
	Icon = "ui/perks/leap_circle.png",
	IconDisabled = "ui/perks/leap_circle_bw.png",
	Const = "LegendLeap"
});

::Legends.Perk.LegendTumble <- null;
perkDefObjects.push({
	ID = "perk.legend_tumble",
	Script = "scripts/skills/perks/perk_legend_tumble",
	Name = ::Const.Strings.PerkName.LegendTumble,
	Tooltip = ::Const.Strings.PerkDescription.LegendTumble,
	Icon = "ui/perks/tumble_circle.png",
	IconDisabled = "ui/perks/tumble_circle_bw.png",
	Const = "LegendTumble"
});

::Legends.Perk.LegendHairSplitter <- null;
perkDefObjects.push({
	ID = "perk.legend_hair_splitter",
	Script = "scripts/skills/perks/perk_legend_hair_splitter",
	Name = ::Const.Strings.PerkName.LegendHairSplitter,
	Tooltip = ::Const.Strings.PerkDescription.LegendHairSplitter,
	Icon = "ui/perks/hairsplit_circle.png",
	IconDisabled = "ui/perks/hairsplit_circle_bw.png",
	Const = "LegendHairSplitter"
});

::Legends.Perk.LegendBearform <- null;
perkDefObjects.push({
	ID = "perk.legend_bearform",
	Script = "scripts/skills/perks/perk_legend_bearform",
	Name = ::Const.Strings.PerkName.LegendBearform,
	Tooltip = ::Const.Strings.PerkDescription.LegendBearform,
	Icon = "ui/perks/bear2_circle.png",
	IconDisabled = "ui/perks/bear2_circle_bw.png",
	Const = "LegendBearform"
});

::Legends.Perk.LegendRoots <- null;
perkDefObjects.push({
	ID = "perk.legend_roots",
	Script = "scripts/skills/perks/perk_legend_roots",
	Name = ::Const.Strings.PerkName.LegendRoots,
	Tooltip = ::Const.Strings.PerkDescription.LegendRoots,
	Icon = "ui/perks/roots_circle.png",
	IconDisabled = "ui/perks/roots_circle_bw.png",
	Const = "LegendRoots"
});

::Legends.Perk.LegendWolfform <- null;
perkDefObjects.push({
	ID = "perk.legend_wolfform",
	Script = "scripts/skills/perks/perk_legend_wolfform",
	Name = ::Const.Strings.PerkName.LegendWolfform,
	Tooltip = ::Const.Strings.PerkDescription.LegendWolfform,
	Icon = "ui/perks/wolf2_circle.png",
	IconDisabled = "ui/perks/wolf2_circle_bw.png",
	Const = "LegendWolfform"
});

::Legends.Perk.LegendTrueForm <- null;
perkDefObjects.push({
	ID = "perk.legend_true_form",
	Script = "scripts/skills/perks/perk_legend_true_form",
	Name = ::Const.Strings.PerkName.LegendTrueForm,
	Tooltip = ::Const.Strings.PerkDescription.LegendTrueForm,
	Icon = "ui/perks/true_form_circle.png",
	IconDisabled = "ui/perks/true_form_circle_bw.png",
	Const = "LegendTrueForm"
});

::Legends.Perk.LegendSummonStorm <- null;
perkDefObjects.push({
	ID = "perk.legend_summon_storm",
	Script = "scripts/skills/perks/perk_legend_summon_storm",
	Name = ::Const.Strings.PerkName.LegendSummonStorm,
	Tooltip = ::Const.Strings.PerkDescription.LegendSummonStorm,
	Icon = "ui/perks/rain_circle.png",
	IconDisabled = "ui/perks/rain_circle_bw.png",
	Const = "LegendSummonStorm"
});

::Legends.Perk.LegendCallLightning <- null;
perkDefObjects.push({
	ID = "perk.legend_call_lightning",
	Script = "scripts/skills/perks/perk_legend_call_lightning",
	Name = ::Const.Strings.PerkName.LegendCallLightning,
	Tooltip = ::Const.Strings.PerkDescription.LegendCallLightning,
	Icon = "ui/perks/storm_circle.png",
	IconDisabled = "ui/perks/storm_circle_bw.png",
	Const = "LegendCallLightning"
});

::Legends.Perk.LegendScryTrance <- null;
perkDefObjects.push({
	ID = "perk.legend_scry_trance",
	Script = "scripts/skills/perks/perk_legend_scry_trance",
	Name = ::Const.Strings.PerkName.LegendScryTrance,
	Tooltip = ::Const.Strings.PerkDescription.LegendScryTrance,
	Icon = "ui/perks/scry_trance_circle.png",
	IconDisabled = "ui/perks/scry_trance_circle_bw.png",
	Const = "LegendScryTrance"
});

::Legends.Perk.LegendReadOmensTrance <- null;
perkDefObjects.push({
	ID = "perk.legend_read_omens_trance",
	Script = "scripts/skills/perks/perk_legend_read_omens_trance",
	Name = ::Const.Strings.PerkName.LegendReadOmensTrance,
	Tooltip = ::Const.Strings.PerkDescription.LegendReadOmensTrance,
	Icon = "ui/perks/omens_circle.png",
	IconDisabled = "ui/perks/omens_circle_bw.png",
	Const = "LegendReadOmensTrance"
});

::Legends.Perk.LegendDistantVisions <- null;
perkDefObjects.push({
	ID = "perk.legend_distant_visions",
	Script = "scripts/skills/perks/perk_legend_distant_visions",
	Name = ::Const.Strings.PerkName.LegendDistantVisions,
	Tooltip = ::Const.Strings.PerkDescription.LegendDistantVisions,
	Icon = "ui/perks/vision_circle.png",
	IconDisabled = "ui/perks/vision_circle_bw.png",
	Const = "LegendDistantVisions"
});

::Legends.Perk.LegendScrollIngredients <- null;
perkDefObjects.push({
	ID = "perk.legend_scroll_ingredients",
	Script = "scripts/skills/perks/perk_legend_scroll_ingredients",
	Name = ::Const.Strings.PerkName.LegendScrollIngredients,
	Tooltip = ::Const.Strings.PerkDescription.LegendScrollIngredients,
	Icon = "ui/perks/scroll_circle.png",
	IconDisabled = "ui/perks/scroll_circle_bw.png",
	Const = "LegendScrollIngredients"
});

::Legends.Perk.LegendScholar <- null;
perkDefObjects.push({
	ID = "perk.legend_scholar",
	Script = "scripts/skills/perks/perk_legend_scholar",
	Name = ::Const.Strings.PerkName.LegendScholar,
	Tooltip = ::Const.Strings.PerkDescription.LegendScholar,
	Icon = "ui/perks/scholar_circle.png",
	IconDisabled = "ui/perks/scholar_circle_bw.png",
	Const = "LegendScholar"
});

::Legends.Perk.LegendCitrinitas <- null;
perkDefObjects.push({
	ID = "perk.legend_citrinitas",
	Script = "scripts/skills/perks/perk_legend_citrinitas",
	Name = ::Const.Strings.PerkName.LegendCitrinitas,
	Tooltip = ::Const.Strings.PerkName.LegendCitrinitas,
	Icon = "ui/perks/perk_34.png", //todo: add icon
	IconDisabled = "ui/perks/perk_34_sw.png",
	Const = "LegendCitrinitas"
});

::Legends.Perk.LegendAlbedo <- null;
perkDefObjects.push({
	ID = "perk.legend_albedo",
	Script = "scripts/skills/perks/perk_legend_albedo",
	Name = ::Const.Strings.PerkName.LegendAlbedo,
	Tooltip = ::Const.Strings.PerkName.LegendAlbedo,
	Icon = "ui/perks/MaxToolsT1.png", //todo icons
	IconDisabled = "ui/perks/MaxToolsT1_bw.png",
	Const = "LegendAlbedo"
});

::Legends.Perk.LegendNigredo <- null;
perkDefObjects.push({
	ID = "perk.legend_nigredo",
	Script = "scripts/skills/perks/perk_legend_nigredo",
	Name = ::Const.Strings.PerkName.LegendNigredo,
	Tooltip = ::Const.Strings.PerkName.LegendNigredo,
	Icon = "ui/perks/MaxToolsT1.png",
	IconDisabled = "ui/perks/MaxToolsT1_bw.png",
	Const = "LegendNigredo"
});

::Legends.Perk.LegendHerbcraft <- null;
perkDefObjects.push({
	ID = "perk.legend_herbcraft",
	Script = "scripts/skills/perks/perk_legend_herbcraft",
	Name = ::Const.Strings.PerkName.LegendHerbcraft,
	Tooltip = ::Const.Strings.PerkDescription.LegendHerbcraft,
	Icon = "ui/perks/herbcraft.png",
	IconDisabled = "ui/perks/herbcraft_bw.png",
	Const = "LegendHerbcraft"
});

::Legends.Perk.LegendWoodworking <- null;
perkDefObjects.push({
	ID = "perk.legend_woodworking",
	Script = "scripts/skills/perks/perk_legend_woodworking",
	Name = ::Const.Strings.PerkName.LegendWoodworking,
	Tooltip = ::Const.Strings.PerkDescription.LegendWoodworking,
	Icon = "ui/perks/woodworking.png",
	IconDisabled = "ui/perks/woodworking_bw.png",
	Const = "LegendWoodworking"
});

::Legends.Perk.LegendSurpressUrges <- null;
perkDefObjects.push({
	ID = "perk.legend_surpress_urges",
	Script = "scripts/skills/perks/perk_legend_surpress_urges",
	Name = ::Const.Strings.PerkName.LegendSurpressUrges,
	Tooltip = ::Const.Strings.PerkDescription.LegendSurpressUrges,
	Icon = "ui/perks/surpress_urges.png",
	IconDisabled = "ui/perks/surpress_urges_bw.png",
	Const = "LegendSurpressUrges"
});

::Legends.Perk.LegendControlInstincts <- null;
perkDefObjects.push({
	ID = "perk.legend_control_instincts",
	Script = "scripts/skills/perks/perk_legend_control_instincts",
	Name = ::Const.Strings.PerkName.LegendControlInstincts,
	Tooltip = ::Const.Strings.PerkDescription.LegendControlInstincts,
	Icon = "ui/perks/control_instincts.png",
	IconDisabled = "ui/perks/control_instincts_bw.png",
	Const = "LegendControlInstincts"
});

::Legends.Perk.LegendMasterAnger <- null;
perkDefObjects.push({
	ID = "perk.legend_master_anger",
	Script = "scripts/skills/perks/perk_legend_master_anger",
	Name = ::Const.Strings.PerkName.LegendMasterAnger,
	Tooltip = ::Const.Strings.PerkDescription.LegendMasterAnger,
	Icon = "ui/perks/master_anger.png",
	IconDisabled = "ui/perks/master_anger_bw.png",
	Const = "LegendMasterAnger"
});

::Legends.Perk.LegendMagicBurningHands <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_burning_hands",
	Script = "scripts/skills/perks/perk_legend_magic_burning_hands",
	Name = ::Const.Strings.PerkName.LegendMagicBurningHands,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicBurningHands,
	Icon = "ui/perks/burning_hands_circle_01.png",
	IconDisabled = "ui/perks/burning_hands_circle_01_bw.png",
	Const = "LegendMagicBurningHands"
});

::Legends.Perk.LegendMagicChainLightning <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_chain_lightning",
	Script = "scripts/skills/perks/perk_legend_magic_chain_lightning",
	Name = ::Const.Strings.PerkName.LegendMagicChainLightning,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicChainLightning,
	Icon = "ui/perks/lightning_circle.png",
	IconDisabled = "ui/perks/lightning_circle_bw.png",
	Const = "LegendMagicChainLightning"
});

::Legends.Perk.LegendMagicCircleOfProtection <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_circle_of_protection",
	Script = "scripts/skills/perks/perk_legend_magic_circle_of_protection",
	Name = ::Const.Strings.PerkName.LegendMagicCircleOfProtection,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicCircleOfProtection,
	Icon = "ui/perks/mage_legend_magic_circle_of_protection_circle.png",
	IconDisabled = "ui/perks/mage_legend_magic_circle_of_protection_circle_bw.png",
	Const = "LegendMagicCircleOfProtection"
});

::Legends.Perk.LegendMagicDaze <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_daze",
	Script = "scripts/skills/perks/perk_legend_magic_daze",
	Name = ::Const.Strings.PerkName.LegendMagicDaze,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicDaze,
	Icon = "ui/perks/daze56_circle.png",
	IconDisabled = "ui/perks/daze56_circle_bw.png",
	Const = "LegendMagicDaze"
});

::Legends.Perk.LegendMagicHailstone <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_magic_hailstone",
	Script = "scripts/skills/perks/perk_legend_magic_hailstone",
	Name = ::Const.Strings.PerkName.LegendMagicHailstone,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicHailstone,
	Icon = "ui/perks/mage_legend_magic_hailstone_circle.png",
	IconDisabled = "ui/perks/mage_legend_magic_hailstone_circle_bw.png",
	Const = "LegendMagicHailstone"
});

::Legends.Perk.LegendMagicHealingWind <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_healing_wind",
	Script = "scripts/skills/perks/perk_legend_magic_healing_wind",
	Name = ::Const.Strings.PerkName.LegendMagicHealingWind,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicHealingWind,
	Icon = "ui/perks/magic_mist_circle_01.png",
	IconDisabled = "ui/perks/magic_mist_circle_01_bw.png",
	Const = "LegendMagicHealingWind"
});

::Legends.Perk.LegendMagicImbue <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_imbue",
	Script = "scripts/skills/perks/perk_legend_magic_imbue",
	Name = ::Const.Strings.PerkName.LegendMagicImbue,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicImbue,
	Icon = "ui/perks/magic_imbue_circle_01.png",
	IconDisabled = "ui/perks/magic_imbue_circle_01_bw.png",
	Const = "LegendMagicImbue"
});

::Legends.Perk.LegendMagicLevitate <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_levitate",
	Script = "scripts/skills/perks/perk_legend_magic_levitate",
	Name = ::Const.Strings.PerkName.LegendMagicLevitate,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicLevitate,
	Icon = "ui/perks/levitate.png",
	IconDisabled = "ui/perks/levitate_bw.png",
	Const = "LegendMagicLevitate"
});

::Legends.Perk.LegendMagicBurningHands <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_burning_hands",
	Script = "scripts/skills/perks/perk_legend_magic_burning_hands",
	Name = ::Const.Strings.PerkName.LegendMagicBurningHands,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicBurningHands,
	Icon = "ui/perks/burning_hands_circle_01.png",
	IconDisabled = "ui/perks/burning_hands_circle_01_bw.png",
	Const = "LegendMagicBurningHands"
});

::Legends.Perk.LegendChainLightning <- null;
perkDefObjects.push({
	ID = "perk.legend_chain_lightning",
	Script = "scripts/skills/perks/perk_legend_chain_lightning",
	Name = ::Const.Strings.PerkName.LegendChainLightning,
	Tooltip = ::Const.Strings.PerkDescription.LegendChainLightning,
	Icon = "ui/perks/storm_circle.png",
	IconDisabled = "ui/perks/storm_circle_bw.png",
	Const = "LegendChainLightning"
});

::Legends.Perk.LegendMagicCircleOfProtection <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_circle_of_protection",
	Script = "scripts/skills/perks/perk_legend_magic_circle_of_protection",
	Name = ::Const.Strings.PerkName.LegendMagicCircleOfProtection,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicCircleOfProtection,
	Icon = "ui/perks/mage_legend_magic_circle_of_protection_circle.png",
	IconDisabled = "ui/perks/mage_legend_magic_circle_of_protection_circle_bw.png",
	Const = "LegendMagicCircleOfProtection"
});

::Legends.Perk.LegendMagicDaze <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_daze",
	Script = "scripts/skills/perks/perk_legend_magic_daze",
	Name = ::Const.Strings.PerkName.LegendMagicDaze,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicDaze,
	Icon = "ui/perks/daze56_circle.png",
	IconDisabled = "ui/perks/daze56_circle_bw.png",
	Const = "LegendMagicDaze"
});

::Legends.Perk.LegendMagicHailstone <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_hailstone",
	Script = "scripts/skills/perks/perk_legend_magic_hailstone",
	Name = ::Const.Strings.PerkName.LegendMagicHailstone,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicHailstone,
	Icon = "ui/perks/mage_legend_magic_hailstone_circle.png",
	IconDisabled = "ui/perks/mage_legend_magic_hailstone_circle_bw.png",
	Const = "LegendMagicHailstone"
});

::Legends.Perk.LegendMagicHealingWind <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_healing_wind",
	Script = "scripts/skills/perks/perk_legend_magic_healing_wind",
	Name = ::Const.Strings.PerkName.LegendMagicHealingWind,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicHealingWind,
	Icon = "ui/perks/magic_mist_circle_01.png",
	IconDisabled = "ui/perks/magic_mist_circle_01_bw.png",
	Const = "LegendMagicHealingWind"
});

::Legends.Perk.LegendMagicImbue <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_imbue",
	Script = "scripts/skills/perks/perk_legend_magic_imbue",
	Name = ::Const.Strings.PerkName.LegendMagicImbue,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicImbue,
	Icon = "ui/perks/magic_imbue_circle_01.png",
	IconDisabled = "ui/perks/magic_imbue_circle_01_bw.png",
	Const = "LegendMagicImbue"
});

::Legends.Perk.LegendMagicLevitate <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_levitate",
	Script = "scripts/skills/perks/perk_legend_magic_levitate",
	Name = ::Const.Strings.PerkName.LegendMagicLevitate,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicLevitate,
	Icon = "ui/perks/levitate.png",
	IconDisabled = "ui/perks/levitate_bw.png",
	Const = "LegendMagicLevitate"
});

::Legends.Perk.LegendMagicMissile <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_missile",
	Script = "scripts/skills/perks/perk_legend_magic_missile",
	Name = ::Const.Strings.PerkName.LegendMagicMissile,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicMissile,
	Icon = "ui/perks/magic_missile_01.png",
	IconDisabled = "ui/perks/magic_missile_01_bw.png",
	Const = "LegendMagicMissile"
});

::Legends.Perk.LegendMagicPsybeam <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_psybeam",
	Script = "scripts/skills/perks/perk_legend_magic_psybeam",
	Name = ::Const.Strings.PerkName.LegendMagicPsybeam,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicPsybeam,
	Icon = "ui/perks/psybeam_circle_01.png",
	IconDisabled = "ui/perks/psybeam_circle_01_bw.png",
	Const = "LegendMagicPsybeam"
});

::Legends.Perk.LegendMagicSleep <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_sleep",
	Script = "scripts/skills/perks/perk_legend_magic_sleep",
	Name = ::Const.Strings.PerkName.LegendMagicSleep,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicSleep,
	Icon = "ui/perks/sleep_56.png",
	IconDisabled = "ui/perks/sleep_56_bw.png",
	Const = "LegendMagicSleep"
});

::Legends.Perk.LegendMagicSoothingWind <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_soothing_wind",
	Script = "scripts/skills/perks/perk_legend_magic_soothing_wind",
	Name = ::Const.Strings.PerkName.LegendMagicSoothingWind,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicSoothingWind,
	Icon = "ui/perks/soothing_wind_circle_01.png",
	IconDisabled = "ui/perks/soothing_wind_circle_01_bw.png",
	Const = "LegendMagicSoothingWind"
});

::Legends.Perk.LegendMagicTeleport <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_teleport",
	Script = "scripts/skills/perks/perk_legend_magic_teleport",
	Name = ::Const.Strings.PerkName.LegendMagicTeleport,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicTeleport,
	Icon = "ui/perks/teleport_perk.png",
	IconDisabled = "ui/perks/teleport_perk_bw.png",
	Const = "LegendMagicTeleport"
});

::Legends.Perk.LegendMagicWebBolt <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_web_bolt",
	Script = "scripts/skills/perks/perk_legend_magic_web_bolt",
	Name = ::Const.Strings.PerkName.LegendMagicWebBolt,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicWebBolt,
	Icon = "ui/perks/web_bolt_circle_01.png",
	IconDisabled = "ui/perks/web_bolt_circle_01_bw.png",
	Const = "LegendMagicWebBolt"
});

::Legends.Perk.LegendMasteryBurningHands <- null;
perkDefObjects.push({
	ID = "perk.legend_mastery_burning_hands",
	Script = "scripts/skills/perks/perk_legend_mastery_burning_hands",
	Name = ::Const.Strings.PerkName.LegendMasteryBurningHands,
	Tooltip = ::Const.Strings.PerkDescription.LegendMasteryBurningHands,
	Icon = "ui/perks/burning_hands_circle_02.png",
	IconDisabled = "ui/perks/burning_hands_circle_02_bw.png",
	Const = "LegendMasteryBurningHands"
});

::Legends.Perk.LegendMasteryChainLightning <- null;
perkDefObjects.push({
	ID = "perk.legend_mastery_chain_lightning",
	Script = "scripts/skills/perks/perk_legend_mastery_chain_lightning",
	Name = ::Const.Strings.PerkName.LegendMasteryChainLightning,
	Tooltip = ::Const.Strings.PerkDescription.LegendMasteryChainLightning,
	Icon = "ui/perks/lightning_cirlce_02.png",
	IconDisabled = "ui/perks/lightning_cirlce_02_bw.png",
	Const = "LegendMasteryChainLightning"
});

::Legends.Perk.LegendMasteryHailstone <- null;
perkDefObjects.push({
	ID = "perk.legend_mastery_hailstone",
	Script = "scripts/skills/perks/perk_legend_mastery_hailstone",
	Name = ::Const.Strings.PerkName.LegendMasteryHailstone,
	Tooltip = ::Const.Strings.PerkDescription.LegendMasteryHailstone,
	Icon = "ui/perks/mage_legend_magic_hailstone_circle.png",
	IconDisabled = "ui/perks/mage_legend_magic_hailstone_circle_bw.png",
	Const = "LegendMasteryHailstone"
});

::Legends.Perk.LegendMagicMissileFocus <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_missile_focus",
	Script = "scripts/skills/perks/perk_legend_mastery_magic_missile_focus",
	Name = ::Const.Strings.PerkName.LegendMagicMissileFocus,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicMissileFocus,
	Icon = "ui/perks/missile_circle.png",
	IconDisabled = "ui/perks/missile_circle_bw.png",
	Const = "LegendMagicMissileFocus"
});

::Legends.Perk.LegendMagicMissileMastery <- null;
perkDefObjects.push({
	ID = "perk.legend_magic_missile_mastery",
	Script = "scripts/skills/perks/perk_legend_mastery_magic_missile_mastery",
	Name = ::Const.Strings.PerkName.LegendMagicMissileMastery,
	Tooltip = ::Const.Strings.PerkDescription.LegendMagicMissileMastery,
	Icon = "ui/perks/missile_circle.png",
	IconDisabled = "ui/perks/missile_circle_bw.png",
	Const = "LegendMagicMissileMastery"
});

::Legends.Perk.LegendUnarmedTraining <- null;
perkDefObjects.push({
	ID = "perk.legend_unarmed_training",
	Script = "scripts/skills/perks/perk_legend_unarmed_training",
	Name = ::Const.Strings.PerkName.LegendUnarmedTraining,
	Tooltip = ::Const.Strings.PerkDescription.LegendUnarmedTraining,
	Icon = "ui/perks/unarmed_training.png",
	IconDisabled = "ui/perks/unarmed_training_bw.png",
	Const = "LegendUnarmedTraining"
});

::Legends.Perk.LegendUnarmedLunge <- null;
perkDefObjects.push({
	ID = "perk.legend_unarmed_lunge",
	Script = "scripts/skills/perks/perk_legend_unarmed_lunge",
	Name = ::Const.Strings.PerkName.LegendUnarmedLunge,
	Tooltip = ::Const.Strings.PerkDescription.LegendUnarmedLunge,
	Icon = "ui/perks/unarmed_lunge.png",
	IconDisabled = "ui/perks/unarmed_lunge_bw.png",
	Const = "LegendUnarmedLunge"
});

::Legends.Perk.LegendBoondockBlade <- null;
perkDefObjects.push({
	ID = "perk.legend_boondock_blade",
	Script = "scripts/skills/perks/perk_legend_boondock_blade",
	Name = ::Const.Strings.PerkName.LegendBoondockBlade,
	Tooltip = ::Const.Strings.PerkDescription.LegendBoondockBlade,
	Icon = "ui/perks/boondock_01.png", //TODO
	IconDisabled = "ui/perks/boondock_01_bw.png",
	Const = "LegendBoondockBlade"
});

::Legends.Perk.LegendThrowSand <- null;
perkDefObjects.push({
	ID = "perk.legend_throw_sand",
	Script = "scripts/skills/perks/perk_legend_throw_sand",
	Name = ::Const.Strings.PerkName.LegendThrowSand,
	Tooltip = ::Const.Strings.PerkDescription.LegendThrowSand,
	Icon = "ui/perks/throw_sand_01.png",
	IconDisabled = "ui/perks/throw_sand_01_bw.png",
	Const = "LegendThrowSand"
});

::Legends.Perk.LegendBackflip <- null;
perkDefObjects.push({
	ID = "perk.legend_backflip",
	Script = "scripts/skills/perks/perk_legend_backflip",
	Name = ::Const.Strings.PerkName.LegendBackflip,
	Tooltip = ::Const.Strings.PerkDescription.LegendBackflip,
	Icon = "ui/perks/backflip_circle.png",
	IconDisabled = "ui/perks/backflip_circle_bw.png",
	Const = "LegendBackflip"
});

::Legends.Perk.LegendTwirl <- null;
perkDefObjects.push({
	ID = "perk.legend_twirl",
	Script = "scripts/skills/perks/perk_legend_twirl",
	Name = ::Const.Strings.PerkName.LegendTwirl,
	Tooltip = ::Const.Strings.PerkDescription.LegendTwirl,
	Icon = "ui/perks/twirl_circle.png",
	IconDisabled = "ui/perks/twirl_circle_bw.png",
	Const = "LegendTwirl"
});

::Legends.Perk.LegendDeflect <- null;
perkDefObjects.push({
	ID = "perk.legend_deflect",
	Script = "scripts/skills/perks/perk_legend_deflect",
	Name = ::Const.Strings.PerkName.LegendDeflect,
	Tooltip = ::Const.Strings.PerkDescription.LegendDeflect,
	Icon = "ui/perks/perk_02.png", // todo icons?
	IconDisabled = "ui/perks/perk_02_sw.png",
	Const = "LegendDeflect"
});

::Legends.Perk.LegendTasteThePain <- null;
perkDefObjects.push({
	ID = "perk.legend_taste_the_pain",
	Script = "scripts/skills/perks/perk_legend_taste_the_pain",
	Name = ::Const.Strings.PerkName.LegendTasteThePain,
	Tooltip = ::Const.Strings.PerkDescription.LegendTasteThePain,
	Icon = "ui/perks/twirl_circle.png", // todo icons?
	IconDisabled = "ui/perks/twirl_circle_bw.png",
	Const = "LegendTasteThePain"
});

::Legends.Perk.LegendLionheart <- null;
perkDefObjects.push({
	ID = "perk.legend_lionheart",
	Script = "scripts/skills/perks/perk_legend_lionheart",
	Name = ::Const.Strings.PerkName.LegendLionheart,
	Tooltip = ::Const.Strings.PerkDescription.LegendLionheart,
	Icon = "ui/perks/lionheart.png",
	IconDisabled = "ui/perks/lionheart_bw.png",
	Const = "LegendLionheart"
});

::Legends.Perk.Captain <- null;
perkDefObjects.push({
	ID = "perk.captain",
	Script = "scripts/skills/perks/perk_captain",
	Name = ::Const.Strings.PerkName.Captain,
	Tooltip = ::Const.Strings.PerkDescription.Captain,
	Icon = "ui/perks/perk_26.png",
	IconDisabled = "ui/perks/perk_26_sw.png",
	Const = "Captain"
});

::Legends.Perk.BatteringRam <- null;
perkDefObjects.push({
	ID = "perk.battering_ram",
	Script = "scripts/skills/perks/perk_battering_ram",
	Name = ::Const.Strings.PerkName.BatteringRam,
	Tooltip = ::Const.Strings.PerkDescription.BatteringRam,
	Icon = "ui/perks/passive_03.png",
	IconDisabled = "ui/perks/passive_03_sw.png",
	Const = "BatteringRam"
});

::Legends.Perk.LegendStrengthInNumbers <- null;
perkDefObjects.push({
	ID = "perk.legend_strength_in_numbers",
	Script = "scripts/skills/perks/perk_legend_strength_in_numbers",
	Name = ::Const.Strings.PerkName.LegendStrengthInNumbers,
	Tooltip = ::Const.Strings.PerkDescription.LegendStrengthInNumbers,
	Icon = "ui/perks/strength_in_numbers.png",
	IconDisabled = "ui/perks/strength_in_numbers_bw.png",
	Const = "LegendStrengthInNumbers"
});

::Const.Perks.addPerkDefObjects(perkDefObjects);
