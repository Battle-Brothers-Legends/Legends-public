::mods_hookExactClass("events/events/dlc8/lindwurm_slayer_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]{You\'re enjoying a drink at one of %townname%\'s cozy taverns. Naturally, this comfort doesn\'t last long as a %person_dragonslayer% struts into the place with %their_dragonslayer% armor clinking and clanking. You make the error of glancing at %them_dragonslayer% and catching %their_dragonslayer% eye. %They_dragonslayer% immediately heads over. Sighing, you put your opposite hand onto your sword and await what this could possibly be. The %person_dragonslayer% stomps to the end of your table and straightens up.%SPEECH_ON%Let me introduce myself, in case rumor and myth have not done it already. I am %dragonslayer%. My chosen life in this world is to hunt and slay dragons.%SPEECH_OFF%You take a drink and set it down, telling the %person_dragonslayer% that dragons don\'t exist. %They_dragonslayer% grins.%SPEECH_ON%That is because my father slew them all. In truth, I am a killer of lindwurms, and I hear you are the captain of the %companyname%, an outfit of some renown, almost as much as renown as yours truly. What would you say to combining our skills and talents, hm? I\'d be willing to join you for %price% crowns.%SPEECH_OFF%}";
				s.start <- function ( _event )
				{
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					_event.m.Dude.setStartValuesEx([
						"lindwurm_slayer_background"
					]);
					_event.m.Dude.getBackground().m.RawDescription = "{%name% is a supposedly famous monster hunter with a particular talent for slaying lindwurms. They says he is the son of Dirk the Dragonslayer, the monster hunter who ostensibly slew the last living dragon.}";
					_event.m.Dude.getBackground().buildDescription(true);

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).removeSelf();

					_event.m.Dude.getItems().equip(this.new("scripts/items/weapons/fighting_spear"));
					_event.m.Dude.getItems().equip(this.new("scripts/items/shields/buckler_shield"));
					_event.m.Dude.getItems().equip(this.new("scripts/items/helmets/heavy_mail_coif"));
					_event.m.Dude.getItems().equip(this.new("scripts/items/legend_armor/legendary/legend_lindwurm_armor"));
					this.Characters.push(_event.m.Dude.getImagePath());
				}

			}
			if (s.ID == "B") {
				s.start <- function ( _event ) {
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					_event.m.Dude.setStartValuesEx([
						"lindwurm_slayer_background"
					]);
					// _event.m.Dude.getBackground().m.RawDescription = "{%name% is a supposedly famous monster hunter with a particular talent for slaying lindwurms. They say they are the child of Dirk the Dragonslayer, the monster hunter who ostensibly slew the last living dragon.}";
					// _event.m.Dude.getBackground().buildDescription(true);

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).removeSelf();

					_event.m.Dude.getItems().equip(this.new("scripts/items/weapons/fighting_spear"));
					_event.m.Dude.getItems().equip(this.new("scripts/items/shields/buckler_shield"));
					_event.m.Dude.getItems().equip(this.new("scripts/items/helmets/heavy_mail_coif"));
					_event.m.Dude.getItems().equip(this.new("scripts/items/legend_armor/legendary/legend_lindwurm_armor"));
					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]{You reach into your pockets and put the purse on the table. The %person_dragonslayer% takes it up, picking through the change. %They_dragonslayer% nods and cinches the pursestrings.%SPEECH_ON%Very well. You have my services, captain of the %companyname%, and by my father\'s good name you shall not regret it.%SPEECH_OFF%}";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]{The %person_dragonslayer% will either prove %themselves_dragonslayer% to be worthy of %their_dragonslayer% stated accomplishments, or %they_dragonslayer%\'ll end up dead meat. If %they_dragonslayer%\'s willing to join without any upfront cost to you, what does it hurt to see how %they_dragonslayer% fares? You hold your hand out and the %person_dragonslayer% shakes it. %Their_dragonslayer% armor clinks and clanks as %their_dragonslayer% arm bounces up and down.%SPEECH_ON%Your Oathtakers will not be disappointed, that I can promise you.%SPEECH_OFF%}"
			}
			if (s.ID == "A") {

			}
		}
	}
	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars ) {
		onPrepareVariables(_vars);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Dude.getGender(), "dragonslayer");
	}

})
