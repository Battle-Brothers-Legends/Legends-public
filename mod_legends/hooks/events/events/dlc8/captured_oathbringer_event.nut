::mods_hookExactClass("events/events/dlc8/captured_oathbringer_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();

		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.start <- function (_event) {
				local item = null;
				if (::Math.rand(0, 2) == 0) {
					item = ::Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.adorned_mail_shirt]
					]);
				} else {
					item = ::Const.World.Common.pickHelmet([
						[1, ::Legends.Helmet.Standard.heavy_mail_coif]
					]);
				}
				item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 30) * 0.01));
				this.List.push(::Legends.EventList.addItems([item], ::World.Assets.getStash()));

				local brothers = this.World.getPlayerRoster().getAll();
				foreach (bro in brothers) {
					if (bro.getBackground().getID() == "background.paladin"
						|| !bro.getBackground().isOffendedByViolence()
						&& this.Math.rand(1, 100) <= 75)
					{
						local entry = ::Legends.EventList.changeMood(bro, 0.75, "Pleased you slew an Oathbringer heretic");
						if (bro.getMoodState() >= ::Const.MoodState.Neutral) {
							this.List.push(entry);
						}
					} else if (bro.getBackground().isOffendedByViolence()) {
						local entry = ::Legends.EventList.changeMood(bro, -0.5, "Disliked that you slew a captive in cold blood");
						if (bro.getMoodState() < ::Const.MoodState.Neutral) {
							this.List.push(entry);
						}
					}
				}
			}

		});

		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_05.png[/img]{You nod.%SPEECH_ON%Torture him until his tongue points us to Young Anselm\'s jaw. I don\'t care how you do it, just do it.%SPEECH_OFF%Turning away, the prisoner screams out that Anselm would not approve. He then just starts screaming indiscriminately and eventually shouting out things that don\'t make a whole lot of sense. You retire to your tent, bouncing your foot to the screams that now take a rhythmic sort of wailing. Eventually, %randombrother% reappears. %They_randombrother% has with %them_randombrother% some weapons and armor you know weren\'t in inventory.%SPEECH_ON%He led us to a location that had these hidden away, but Anselm\'s jawbone is still missing. I\'m afraid the Oathbringers must have it in their own camp, but he wouldn\'t say where that was. We, uh, we had some difficulties communicating after we cut his tongue out.%SPEECH_OFF%Sighing, you ask where the prisoner is now. The %person_randombrother% clears %their_randombrother% throat.%SPEECH_ON%Oh he went all white and fell over. He\'s dead, sir.%SPEECH_OFF%We did right by Young Anselm, at least.}";
			_screen.start <- function (_event) {
				local item = null;
				if (::Math.rand(0, 2) == 0) {
					item = ::Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.adorned_warriors_armor]
					]);
				} else {
					item = ::Const.World.Common.pickHelmet([
						[1, ::Legends.Helmet.Standard.adorned_closed_flat_top_with_mail]
					]);
				}
				item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 30) * 0.01));
				this.List.push(::Legends.EventList.addItems([item], ::World.Assets.getStash()));

				local weapon = ::Const.World.Common.pickItem([
					[1, "weapons/arming_sword"],
					[1, "weapons/fighting_axe"],
					[1, "weapons/military_cleaver"],
					[1, "shields/heater_shield"],
				], "scripts/items/");

				this.List.push(::Legends.EventList.addItems([weapon], ::World.Assets.getStash()));
				weapon.setCondition(this.Math.max(1, weapon.getConditionMax() * this.Math.rand(10, 30) * 0.01));

				local brothers = this.World.getPlayerRoster().getAll();
				foreach (bro in brothers) {
					if (bro.getBackground().getID() == "background.paladin"
						|| !bro.getBackground().isOffendedByViolence()
						&& this.Math.rand(1, 100) <= 75)
					{
						local entry = ::Legends.EventList.changeMood(bro, 1.25, "Tortured an Oathbringer heretic");
						if (bro.getMoodState() >= ::Const.MoodState.Neutral) {
							this.List.push(entry);
						}
					} else if (bro.getBackground().isOffendedByViolence()) {
						local entry = ::Legends.EventList.changeMood(bro, -0.75, "Is horrified that you ordered a captive tortured");
						if (bro.getMoodState() < ::Const.MoodState.Neutral) {
							this.List.push(entry);
						}
					}
				}
			}
		});

		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_05.png[/img]{You tell the men to torture the man for information. If there\'s one thing every Oathbringer knows, it\'s where Young Anselm\'s jawbone is and that is something every Oathtaker wishes to find out. The man screams as he\'s dragged away, and you retire to your tent to drown out the annoyances of things like shrieking and crying which really put a crimp on your mood. A moment later, %torturer% enters the tent, blood on his shirt. %They_torturer% looks to speak, then collapses to the ground. Another Oathtaker comes in saying the prisoner escaped, shanking his torturer before fleeing. You tell the men to help %torturer% before %they_torturer% bleeds out.%SPEECH_ON%Those damned Oathbringers have no honor! We\'ll find and kill him dead, so sayeth Young Anselm, so sayeth us all!%SPEECH_OFF%You speak with a clenched jaw, and an air of theatrics. The truth is the bastard got away and those Oathbringers are hard to catch, the rats that they are. You just hope that %torturer% survives.}";
		});
	}
});
