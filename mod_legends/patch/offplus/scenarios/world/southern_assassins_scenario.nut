::mods_hookExactClass("scenarios/world/southern_assassins_scenario", function (sas) {
	local create = ::mods_getMember(sas, "create");
	local onSpawnAssets = ::mods_getMember(sas, "onSpawnAssets");

	::mods_override(sas, "create", function () {
		create();

		this.m.StartingBusinessReputation = 55;
		this.setRosterReputationTiers(::Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	});

	::mods_override(sas, "onSpawnAssets", function () {
		onSpawnAssets();

		local bros = ::World.getPlayerRoster().getAll();

		// Legends veteran level perk points, ick, eww, cooties
		bros[0].setVeteranPerks(2);
		bros[1].setVeteranPerks(2);

		bros[0].getBackground().m.RawDescription = "%name% is your most talented pupil, a truly rare combination of skilled, efficient, and professional. You've never quite been able to get a read on the %person%, but you know %their% skills will be invaluable to the %companyname%, and when you asked %them% to join you in exile %they% agreed without a moment's hesitation. If only more were like %them%.";
		bros[0].getBackground().buildDescription(true);

		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Head));

		items.equip(::Const.World.Common.pickArmor([
			[1, "oriental/assassin_robe"]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[1, "oriental/assassin_head_wrap"]
		]));

		bros[1].getBackground().m.RawDescription = "%name% is a peculiar sort, even by the abnormal standards of the guilds. Assassins prefer the certainty afforded by melee weapons almost as a rule, yet the %person% seems downright uncomfortable unless %they% has a bow in %their% hands. Similarly, most of the guild opt for a spartan life with few comforts so as to not stand out, yet %name% would live in hedonism to rival the viziers, could %they% afford it. These eccentricities might concern you more were %they% not also one of the most deadly killers in the south, with dozens of arrow-riddled corpses to %their% name. You decide you're willing to overlook a few quirks, and not just because %they% agreed to join you in exile.";
		bros[1].getBackground().buildDescription(true);

		items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Head));

		items.equip(::Const.World.Common.pickArmor([
			[1, "oriental/thick_nomad_robe"]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[1, "oriental/assassin_head_wrap"]
		]));
	});
});

::mods_hookExactClass("retinue/followers/assassin_master_follower", function (amf) {
	local create = ::mods_getMember(amf, "create");

	::mods_override(amf, "create", function () {
		create();

		m.Requirements = [
			{
				Text = "You are a trusted assassin of the Southern guilds",
				IsSatisfied = true,
				CheckRequirement = function () {
					return true;
				},
				NotImportant = false
			}
		];
	});
});

::mods_hookExactClass("retinue/followers/poison_master_follower", function (pmf) {
	local create = ::mods_getMember(pmf, "create");

	::mods_override(pmf, "create", function () {
		create();

		m.Requirements = [
			{
				Text = "You are a trusted assassin of the Southern guilds",
				IsSatisfied = true,
				CheckRequirement = function () {
					return true;
				},
				NotImportant = false
			}
		];
	});
});

::mods_hookNewObject("events/offplus_assassins_events/events/assassins_poison_sickness_event", function (apse) {
	local screen = apse.m.Screens.filter(function (index, screen) {
		return screen.ID == "A";
	})[0];

	local screenText = screen.Text;
	local textToReplaceIndex = -1;
	do {
		textToReplaceIndex = screenText.find("the men");
		if (textToReplaceIndex != null) {
			screenText = screenText.slice(0, textToReplaceIndex) + "the company" + screenText.slice(textToReplaceIndex + 7);
		}
	} while (textToReplaceIndex != null);

	screen.Text = screenText;
});

::mods_hookNewObject("events/offplus_assassins_events/events/assassins_training_accident_event", function (atae) {
	local screen = atae.m.Screens.filter(function (index, screen) {
		return screen.ID == "A";
	})[0];

	local screenText = screen.Text;
	local textToReplaceIndex = -1;
	textToReplaceIndex = screenText.find("other men");
	if (textToReplaceIndex != null) {
		screenText = screenText.slice(0, textToReplaceIndex) + "others" + screenText.slice(textToReplaceIndex + 9);
	}

	textToReplaceIndex = screenText.find("a man");
	if (textToReplaceIndex != null) {
		screenText = screenText.slice(0, textToReplaceIndex) + "one" + screenText.slice(textToReplaceIndex + 5);
	}

	textToReplaceIndex = screenText.find("the men");
	if (textToReplaceIndex != null) {
		screenText = screenText.slice(0, textToReplaceIndex) + "the company" + screenText.slice(textToReplaceIndex + 7);
	}

	textToReplaceIndex = screenText.find("One man");
	if (textToReplaceIndex != null) {
		screenText = screenText.slice(0, textToReplaceIndex) + "One" + screenText.slice(textToReplaceIndex + 7);
	}

	screen.Text = screenText;
});

::mods_hookNewObject("events/offplus_assassins_events/events/northern_assassin_offers_to_join_event", function (atae) {
	local screen = atae.m.Screens.filter(function (index, screen) {
		return screen.ID == "B";
	})[0];

	local start = screen.start;

	screen.start = function (_event) {
		start(_event);
		_event.m.Dude.setGender(0);
		_event.m.Dude.getBackground().setGender(0);
	};
});
