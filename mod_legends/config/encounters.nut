if (!("Encounters" in ::Legends))
	::Legends.Encounters <- {};

::Legends.Encounters.GenericCampIntroduction <- [
	"While going through the frustratingly large amount of paper work that comes with running a mercenary company, you hear a ruckus coming from one end of the camp. Frowning, you grab your sword and exit your tent-preparing yourself for either breaking up a brawl or getting the men in line to defend the camp.",
];

::Legends.Encounters.getCampIntroduction() <- function () {
	return ::MSU.Array.rand(::Legends.Encounters.GenericCampIntroduction);
}

::Legends.Encounters.GenericTownIntroduction <- [
	"TODO",
];

::Legends.Encounters.getTownIntroduction() <- function () {
	return ::MSU.Array.rand(::Legends.Encounters.GenericTownIntroduction);
}
