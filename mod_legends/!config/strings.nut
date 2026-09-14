::Const.Strings.EngageEnemyNumbersNames <- {
	Few = "A few",
	Some = "Some",
	Several = "Several",
	Pack = "Pack of",
	Many = "Many",
	Lots = "Lots of",
	Plethora = "Plethora of",
	Hordes = "Hordes of",
	Throng = "Throng of",
	Swarm = "Swarm of",
	Legion = "Legion of",
	Myriad = "Myriad of"
};

::Const.Strings.MercenaryCompanyNames.extend([
	"Iron Brigade",
	"The Ubermensche",
	"Bottle Brothers",
	"Mordhau Brigands",
	"Rules of Poss",
	"The Elder Ones",
	"Enduring Eels",
	"Rat Petters",
	"Placid Hunters",
	"Heartpiercers",
	"Silver Company",
	"Kraken Band",
	"Sons of Talos",
	"Steel Born",
	"Stormtaken",
	"Unhold Breakers",
	"Tunnel Snakes",
	"Moronic Plungers",
	"The Bloodhound Gang"
]);
::Const.Strings.FreeCompanyNames <- clone ::Const.Strings.MercenaryCompanyNames;
::Const.Strings.CityEncounterNames <- [
	"While at %settlement%...",
	"Strolling through %settlement%.",
	"Something\'s up at %settlement%."
];
::Const.Strings.CampEncounterNames <- [
	"During camp..."
];

::Const.Strings.randomCityEncounterName <- function ()
{
	return ::Const.Strings.CityEncounterNames[this.Math.rand(0, ::Const.Strings.CityEncounterNames.len() - 1)];
}

::Const.Strings.randomCampEncounterName <- function ()
{
	return ::Const.Strings.CampEncounterNames[this.Math.rand(0, ::Const.Strings.CampEncounterNames.len() - 1)];
}
