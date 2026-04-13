::mods_hookExactClass("events/events/dlc8/oathtaker_joins_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();

		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_180.png[/img]{A %person_dude% in armor approaches the company. %They_dude% seems most usual, until %they_dude% opens %their_dude%  mouth.%SPEECH_ON%Hear ye, hear ye, I am a proud Oathtaker! Now, I see you also have what appears to be a high regard for doing what is right. That makes me believe you, too, are Oathtakers. So! I have but one question for you: that skull hanging from a necklace, what is his name? If it is the one I seek, then ye shall have my hand.%SPEECH_OFF% | %People_dude%  in armor are not a rare sight on the roads these days, but this %person_dude% has a certain level of pomp and theatrics that draws the eye, as does the fact %they_dude% confidently strides right over to you.%SPEECH_ON%I\'d been carousing at a local pub when I got word that a band of Oathtakers had been passing through these lands. Now, either that is some graveyard skullduggery hanging from yer neck, or that is...well, you tell me. Give me the right name of that skull and I\'ll join you right here and now.%SPEECH_OFF% | You come across a %person_dude% in armor. %They_dude% stands in the road like %they_dude% either wants to commit suicide by sellsword, or he\'s looking to risk %their_dude%  neck for a coin. As you draw near, %they_dude% waves you down.%SPEECH_ON%Ah, the company I am looking for. Are you with the Oathtakers? I wish to join you on the path. The path of...%SPEECH_OFF%%They_dude% pauses, gesturing toward the company\'s resident skull. Oh, %they_dude% means... | A %person_dude% in armor hurries out onto the road. You put a hand to your sword, but %they_dude% simply bows as though you were an executioner.%SPEECH_ON%I prayed to the old gods to harden my virtues and keep me on the path. Surely, stranger, surely that is his skull there hanging from your neck? If it is, I shall join you and the oaths you\'re on this very minute. Please, tell me, is that the jawless skull of our dear...our...%SPEECH_OFF%}";
			_screen.start <- function (_event) {
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"paladin_background"
				]);
				local dudeItems = _event.m.Dude.getItems();

				if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Head) != null && dudeItems.getItemAtSlot(this.Const.ItemSlot.Head).getID() == "armor.head.adorned_full_helm")
				{
					dudeItems.unequip(dudeItems.getItemAtSlot(this.Const.ItemSlot.Head));
					dudeItems.equip(::Const.World.Common.pickHelmet([1, ::Legends.Helmet.Standard.adorned_closed_flat_top_with_mail]));
				}

				if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Body) != null && dudeItems.getItemAtSlot(this.Const.ItemSlot.Body).getID() == "armor.body.adorned_heavy_mail_hauberk")
				{
					dudeItems.unequip(dudeItems.getItemAtSlot(this.Const.ItemSlot.Body));
					dudeItems.equip(::Const.World.Common.pickArmor([1, ::Legends.Armor.Standard.adorned_warriors_armor]));
				}

				this.Characters.push(_event.m.Dude.getImagePath());
			}
		});

		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_180.png[/img]{The %person_dude% drops to a knee, %their_dude% head down.%SPEECH_ON%Truly, Young Anselm has guided me here! I shall join you on the path, fellow Oathtakers!%SPEECH_OFF%}";
		});

		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_180.png[/img]{The %person_dude% sighs.%SPEECH_ON%Ah, I see now. There are far too many Hugos in this world, it does not surprise me that yet another has appeared in such a state as that dreary skull, though I know not why you carry it around like so.%SPEECH_OFF% | %SPEECH_ON%Hugo.%SPEECH_OFF%The %person_dude% says.%SPEECH_ON%Another farkin\' Hugo, huh? How many are out here? Every other man I run into is a Hugo.%SPEECH_OFF%%they_dude% turns and walks off, mumbling angrily about the commoners and their unoriginal naming schemes. | The %person_dude% sighs.%SPEECH_ON%Hugo, huh? Alright. Whelp, see you later.%SPEECH_OFF%}";
		});
	}
})
