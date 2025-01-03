::mods_hookExactClass("events/events/crisis/greenskins_slayer_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_35.png[/img]While marching, a stranger crosses paths with the %companyname%. %They% wears light armor while looking aloof and distant at first - as if staring off at something you can\'t see. %SPEECH_ON%Evening, sellswords.%SPEECH_OFF%The warrior waves. There\'s an uncanny air to this character, as though you can barely see %them% while %they% is standing right in front of you. %They% nods and continues speaking.%SPEECH_ON%You seem the greenskin skinnin\' sort, and that\'s the sort of company I\'d be most agreeable to joining.%SPEECH_OFF%%randombrother% exchanges a glance with you and shrugs. %They1% whispers %their1% indifference.%SPEECH_ON%If %they% becomes a problem, we can handle %them%.%SPEECH_OFF%The warrior shakes %their% head.%SPEECH_ON%Oh, I\'ll be no problem. I just want to kill orcs and goblins. What more do you need to know? Shall we get on with killing some greenskins, then?%SPEECH_OFF%";
				s.start <- function (_event) {
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					if (this.World.Assets.getOrigin().getID() == "scenario.legends_rangers") {
						_event.m.Dude.setStartValuesEx([
							"legend_druid_background"
						]);
						_event.m.Dude.getBaseProperties().Hitpoints += 5;
						_event.m.Dude.getBaseProperties().MeleeSkill += 5;
						_event.m.Dude.getBaseProperties().MeleeDefense += 4;
						_event.m.Dude.getBackground().m.RawDescription = "The forests scream and wail. Nature has been out of balance for a long time and %name% is one of the few chosen to listen.";
						_event.m.Dude.getBackground().buildDescription(true);
					} else {
						_event.m.Dude.setStartValuesEx([
							"legend_ranger_background"
						]);
						_event.m.Dude.getBackground().m.RawDescription = "Part of an ancient order somewhere in the forests, %name% vowed to maintain balance of nature and all other things, even if violence was necessary.";
						_event.m.Dude.getBackground().buildDescription(true);
					}
					_event.m.Dude.getSkills().add(this.new("scripts/skills/traits/hate_greenskins_trait"));
					local necklace = this.new("scripts/items/accessory/special/slayer_necklace_item");
					necklace.m.Name = _event.m.Dude.getNameOnly() + "\'s Necklace";
					_event.m.Dude.getItems().equip(necklace);
					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.World.FactionManager.isGreenskinInvasion())
			return;

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
			return;

		local roster = this.World.getPlayerRoster().getAll();
		foreach( bro in roster) {
			if (bro.getBackground().getID() == "background.legend_ranger")
				return

			if (bro.getBackground().getID() == "background.legend_commander_ranger")
				return
		}
		this.m.Score = 10;
	}

	o.onPrepareVariables = function (_vars) {
		this.Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Dude.getGender());
	}
})
