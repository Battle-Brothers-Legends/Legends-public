::mods_hookExactClass("contracts/contracts/confront_warlord_contract", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.DescriptionTemplates = [
			"Amid the slaughter, a fearsome greenskin Warlord has emerged. Goad him into fighting you and put an end to his carnage.",
			"He\'s big, he\'s mean and he\'s green. Someone needs to kill him.",
			"The time has come to confront the malevolent orc warlord ravaging these lands.",
			"For those with steel in their veins: a mercenary contract to kill the savage greenskin warlord.",
			"Nobody wants to fight him, as nobody wants to die.",
			"He\'s violently killed everyone who has ever faced him, but perhaps you will get lucky.",
		];
	}

	// Ran when we actually add the contract
	o.formatDescription <- function() {
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = ::format(r, ::Const.UI.getColorized(this.m.Origin.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));

		this.m.Description = r;
	}

	local createScreens = o.createScreens;
	o.createScreens = function() {
		createScreens();
		::Legends.Screens.hook(this, "Task", function(_screen) {
			_screen.Title = "Confront the Orc Warlord";
		});
		::Legends.Screens.hook(this, "Berserkers2", function(_screen) {
			_screen.Title = "Confront the Orc Warlord";
			_screen.start <- function() {
				local brothers = this.World.getPlayerRoster().getAll();

				foreach (bro in brothers) {
					if (!::Legends.Backgrounds.has(bro, ::Legends.Background.Houndmaster, ::Legends.Background.LegendMuladi))
						continue;

					local entry = ::Legends.EventList.changeMood(bro, -1.0, "You didn\'t help wardogs being eaten by orcs");
					if (bro.getMoodState() < this.Const.MoodState.Neutral) {
						this.List.push(entry);
					}
				}
			}
		});
	}
});
