::mods_hookExactClass("events/events/dlc4/kings_guard_1_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "%terrainImage%{The snowy wastes are home to not much of anything, so to find someone half-naked in its frigid geography is rather unusual. That the frozen figure is actually alive even more so. You crouch beside the frigid body, their eyes are hollow and rime frosts make blinking them a struggle, lips are jagged and purple and nose a deep red bordering on black. You ask if the pitiful wretch can speak, and are greeted with nods.%SPEECH_ON%Barbarians. Took. Me.%SPEECH_OFF%You ask where the kidnappers are, the figure shrugs and continues the cold cadence.%SPEECH_ON%They. Got. Bored. And. Left.%SPEECH_OFF%It does seem in tune with the primitives to up and leave a prisoner in the ice. The shivering prisoner explains they were once a sturdy swordfighter. A smile squeezes through the pain.%SPEECH_ON%A. King\'s. Guard. In. The. Kingless. Land. Things. Could. Be. Worse?%SPEECH_OFF%}";
				s.start <- function (_event) {
					_event.m.Dude = ::World.getTemporaryRoster().create("scripts/entity/tactical/" + (::World.Assets.getOrigin().getID() == "scenario.legends_risen_legion" ? "legend_player_legion" : "player"));
					_event.m.Dude.setStartValuesEx([::Legends.Background.Cripple], false);

					_event.m.Dude.setTitle("");
					_event.m.Dude.getBackground().m.RawDescription = "You found %name% frozen half to death in the north. %They% claims %they% was a King\'s Guard once, but looking at %them% now you see but a cripple.";
					_event.m.Dude.getBackground().buildDescription(true);
					_event.m.Dude.getFlags().set("IsSpecial", true);
					_event.m.Dude.getBaseProperties().Bravery += 15;
					_event.m.Dude.getSkills().update();
					_event.m.Dude.m.PerkPoints = 2;
					_event.m.Dude.m.LevelUps = 2;
					_event.m.Dude.m.Level = 3;
					_event.m.Dude.m.XP = ::Const.LevelXP[_event.m.Dude.m.Level - 1];
					_event.m.Dude.m.Talents = [];
					local talents = _event.m.Dude.getTalents();
					talents.resize(::Const.Attributes.COUNT, 0);
					talents[::Const.Attributes.MeleeSkill] = 2;
					talents[::Const.Attributes.MeleeDefense] = 3;
					talents[::Const.Attributes.RangedDefense] = 3;
					_event.m.Dude.m.Attributes = [];
					_event.m.Dude.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);
					_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand));
					_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(::Const.ItemSlot.Offhand));
					_event.m.Dude.worsenMood(1.5, "Got taken by barbarians and left to die in the cold");
					_event.m.Dude.getFlags().set("IsKingsGuard", true);
					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
			if (s.ID == "B") {
				s.Text = "%terrainImage%{You pat the %person_dude% on the head, but tell %them_dude% it\'s already over. %They_dude% nods.%SPEECH_ON%Speak. For. Yourself. Mercenary.%SPEECH_OFF%%They_dude% smiles again, but this time it does release. It sticks. Literally. And %they_dude% leans forward and %their_dude% eyes are open and do not blink and in this state %they_dude% is gone. You get the men back on the road, or what one can make of a road in these snowed stretches.}";
			}
			if (s.ID == "C") {
				s.Text = "%terrainImage%{The nearly frozen %person_dude% joins the company. %They're_dude% a ragged wreck, but if what %they_dude% said is true maybe %they_dude% will someday become the fighter %they_dude% could barely speak of.}";
			}
		}
	}

	o.onUpdateScore = function () {
		if (!::Const.DLC.Wildmen) {
			return;
		}

		local currentTile = ::World.State.getPlayer().getTile();

		if (!currentTile.HasRoad) {
			return;
		}

		if (currentTile.Type != ::Const.World.TerrainType.Snow) {
			return;
		}

		if (::World.getPlayerRoster().getSize() >= ::World.Assets.getBrothersMax()) {
			return;
		}

		local brothers = ::World.getPlayerRoster().getAll();
		local totalbrothers = 0;
		local brotherlevels = 0;
		foreach (bro in brothers) {
			if (::Legends.Backgrounds.has(bro, ::Legends.Background.KingsGuard)) {
				return;
			}
			totalbrothers += 1;
			brotherlevels += bro.getLevel();
		}

		this.m.Score = 20.0 + ((brotherlevels / totalbrothers * 10.00) / ::Const.LevelXP.len());
	}
})
