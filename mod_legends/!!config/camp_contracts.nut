::Legends.CampContracts <- {
	EmployerFactory = [],
	EmployerBanner = [],
	EmployersPerFaction = 4,
	EmployerFaction = {
		COUNT = 0
	}
	addFaction = function (_banner, _factory) {
		local faction = this.EmployerFaction.COUNT++;
		if (_banner.find(".png") != null)
			_banner = _banner.slice(0, _banner.len() - 4);
		this.EmployerBanner.push(_banner);
		this.EmployerFactory.push(_factory);
		return faction;
	}
}

::Legends.CampContracts.EmployerFaction.Barbarians <- ::Legends.CampContracts.addFaction("ui/banners/factions/banner_legend_barbarians_s.png", function (_factionID, _roster) {
	local unit = ::Const.World.Spawn.Troops.BarbarianChampion;
	local character = _roster.create("scripts/entity/tactical/employer/legend_barbarian_employer");
	character.setFaction(_factionID);
	character.m.HairColors = ::Const.HairColors.Young;
	character.setAppearance();
	character.assignRandomEquipment();
	character.setName(::Const.World.Common.generateName(unit.NameList) + (unit.TitleList != null ? " " + unit.TitleList[::Math.rand(0, unit.TitleList.len() - 1)] : ""));
});

::Legends.CampContracts.EmployerFaction.Bandits <- ::Legends.CampContracts.addFaction("ui/banners/factions/banner_legend_bandits_s.png", function (_factionID, _roster) {
	local unit = ::Const.World.Spawn.Troops.BanditLeader;
	local character = _roster.create("scripts/entity/tactical/employer/legend_bandit_employer");
	character.setFaction(_factionID);
	character.m.HairColors = ::Const.HairColors.Young;
	character.setAppearance();
	character.assignRandomEquipment();
	character.setName(::Const.World.Common.generateName(unit.NameList) + (unit.TitleList != null ? " " + unit.TitleList[::Math.rand(0, unit.TitleList.len() - 1)] : ""));
});

::Legends.CampContracts.EmployerFaction.Necromancers <- ::Legends.CampContracts.addFaction("ui/banners/factions/banner_legend_necro_s.png", function (_factionID, _roster) {
	local unit = ::Const.World.Spawn.Troops.Necromancer;
	local character = _roster.create("scripts/entity/tactical/employer/legend_necromancer_employer");
	character.setFaction(_factionID);
	character.m.HairColors = this.Const.HairColors.Old;
	character.setAppearance();
	character.assignRandomEquipment();
	character.setName(::Const.World.Common.generateName(unit.NameList) + (unit.TitleList != null ? " " + unit.TitleList[::Math.rand(0, unit.TitleList.len() - 1)] : ""));
});

::Legends.CampContracts.EmployerFaction.Legion <- ::Legends.CampContracts.addFaction("ui/banners/factions/banner_legend_legion_s.png", function (_factionID, _roster) { //needs new banner art for legion ideally. this is a placeholder.
	local unit = ::Const.World.Spawn.Troops.SkeletonHeavy; //may change to priest later
	local character = _roster.create("scripts/entity/tactical/employer/legend_legion_employer"); //need to refine this - clothes and style
	character.setFaction(_factionID);
	character.assignRandomEquipment();
	character.setName(::Const.World.Common.generateName(unit.NameList) + (unit.TitleList != null ? " " + unit.TitleList[::Math.rand(0, unit.TitleList.len() - 1)] : "")); //double check
});


::Legends.CampContracts.IntroBarbarians <- [{
	ID = "Intro",
	Title = "Negotiations",
	Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]{A group of scarred warriors walk into camp like they own the place. One grunts a greeting, another spits in the dirt, and the largest tosses a half-roasted leg of meat onto your fire. %SPEECH_ON%We talk. You listen.%SPEECH_OFF%Seems they want to hire you, or maybe fight you. Either way, best to hear them out. | You wake to find a pile of unhold bones stacked at the edge of the camp. A moment later, barbarian drums rumble from the treeline, and hulking silhouettes approach. This is either a challenge or an invitation. Or both.}",
	Image = "",
	List = [],
	ShowEmployer = false,
	ShowDifficulty = true,
	Options = [{
		Text = "Let\'s talk business.",
		function getResult() {
			return "Task";
		}
	}]
}];

::Legends.CampContracts.IntroBandits <- [{
	ID = "Intro",
	Title = "Negotiations",
	Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]{A man surprises you by sliding into your shoulder. You just about draw your sword when he quickly explains that a man by the name of %employer% has sought your acquaintance. Sheathing your weapon, you tell the stranger to take you to him - if he\'s got business, he should tell you himself. The messenger nods and leads the way to a bandit\'s hideut. | A messenger - a young lad about as tall as a longsword - sprints by you, throwing a scroll into the air as he swings past. You catch it, but by the time you can look for the kid he\'s already gone. Shrugging, you open the scroll and find the name of %employer%. Directions to a bandit\'s hideout tag the bottom of the scroll.}",
	Image = "",
	List = [],
	ShowEmployer = false,
	ShowDifficulty = true,
	Options = [
		{
			Text = "Let\'s talk business.",
			function getResult() {
				return "Task";
			}
		}
	]
}];

::Legends.CampContracts.IntroNecromancers <- [{
	ID = "Intro",
	Title = "Negotiations",
	Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]{Your fire dims without warning. Flames hiss, shrinking to embers. Then you see a %person_employer% made of shadow and silk, gliding closer. %SPEECH_ON%Don\'t be alarmed. I need help… not a heart.%SPEECH_OFF% A ritual has gone wrong. Something is feeding on the dead, but it\'s not %them_employer% doing. %SPEECH_ON%Not everything that reeks of death is mine.%SPEECH_OFF%%They_employer% offers more gold than sense.}",
	Image = "",
	List = [],
	ShowEmployer = false,
	ShowDifficulty = true,
	Options = [
		{
			Text = "Let\'s talk business.",
			function getResult() {
				return "Task";
			}
		}
	]
}];

::Legends.CampContracts.IntroLegion <- [{
	ID = "Intro",
	Title = "An Envoy",
	Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]{The camp is punctuated with the sharpening of blades and the creaking of bones. Little other noise is made outside of preparation for the next battle, only accented by quiet servitude. With little ceremony, announcement or forewarning, you find an %person_employer% stepping into the camp. Without a word, they hand you a sealed scroll...}",
	Image = "",
	List = [],
	ShowEmployer = false,
	ShowDifficulty = true,
	Options = [
		{
			Text = "Let\'s talk business.",
			function getResult() {
				return "Task";
			}
		}
	]
}];
