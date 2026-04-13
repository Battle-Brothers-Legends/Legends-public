::Legends.Stash <- {
	Flags = {
		StartingSize = "LegendStartingStash",
		CartUpgrades = "LegendUpgradesStash",
		CaravanHandEvent = "LegendCaravanHandStash",
	}
};

::Legends.Stash.setStartingSize <- function (_size) {
	::World.Flags.set(::Legends.Stash.Flags.CartUpgrades, 0);
	::World.Flags.set(::Legends.Stash.Flags.CaravanHandEvent, 0);
	::World.Flags.set(::Legends.Stash.Flags.StartingSize, _size);
}

::Legends.Stash.getStartingSize <-
	@() ::World.Flags.getAsInt(::Legends.Stash.Flags.StartingSize);

::Legends.Stash.upgradeCart <-
	@() ::World.Flags.increment(::Legends.Stash.Flags.CartUpgrades, 1);

::Legends.Stash.resize <-
	@() ::World.Assets.getStash().resize(::Legends.Stash.getSize());

::Legends.Stash.getSize <- function() {
	local size = ::Legends.Stash.getStartingSize();
	foreach (bro in ::World.getPlayerRoster().getAll()) {
		size += bro.getStashModifier();
	}
	size += ::World.Retinue.hasFollower("follower.quartermaster") ? 27 : 0;
	size += ::World.Flags.getAsInt(::Legends.Stash.Flags.CaravanHandEvent);
	size += ::World.Flags.getAsInt(::Legends.Stash.Flags.CartUpgrades) * 27;
	return size;
}
