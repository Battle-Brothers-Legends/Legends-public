::mods_hookExactClass("events/events/dlc8/captured_oathbringer_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();

		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "{[img]gfx/ui/events/event_05.png[/img]You nod.%SPEECH_ON%Torture him until his tongue points us to Young Anselm\'s jaw. I don\'t care how you do it, just do it.%SPEECH_OFF%Turning away, the prisoner screams out that Anselm would not approve. He then just starts screaming indiscriminately and eventually shouting out things that don\'t make a whole lot of sense. You retire to your tent, bouncing your foot to the screams that now take a rhythmic sort of wailing. Eventually, %randombrother% reappears. He has with him some weapons and armor you know weren\'t in inventory.%SPEECH_ON%He led us to a location that had these hidden away, but Anselm\'s jawbone is still missing. I\'m afraid the Oathbringers must have it in their own camp, but he wouldn\'t say where that was. We, uh, we had some difficulties communicating after we cut his tongue out.%SPEECH_OFF%Sighing, you ask where the prisoner is now. The man clears his throat.%SPEECH_ON%Oh he went all white and fell over. He\'s dead, sir.%SPEECH_OFF%We did right by Young Anselm, at least.}";
		});

		::Legends.Screens.hook(this, "C", function (_screen) {
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
				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.paladin" || !bro.getBackground().isOffendedByViolence() && this.Math.rand(1, 100) <= 75)
					{
						local entry = ::Legends.EventList.changeMood(bro, 0.75, "Pleased you slew an Oathbringer heretic");
						if (bro.getMoodState() >= ::Const.MoodState.Neutral)
							this.List.push(entry);
					}
					else if (bro.getBackground().isOffendedByViolence())
					{
						local entry = ::Legends.EventList.changeMood(bro, 0.5, "Disliked that you slew a captive in cold blood");
						if (bro.getMoodState() < ::Const.MoodState.Neutral)
							this.List.push(entry);
					}
				}
			}
		});
	}
})
