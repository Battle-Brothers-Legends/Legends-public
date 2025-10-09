::mods_hookExactClass("events/events/dlc6/runaway_harem_event", function(o) {
	o.m.Dude <- null;

	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Options[2].getResult <- function (_event) {
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_escaped_slaves" || this.World.Assets.getOrigin().getID() == "scenario.legends_sisterhood")
						return "E";
					else
						return "B";
				}
			}
		}

		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/legend_harem_slave.png[/img]{You draw your sword and tell the Vizier\'s men to lose themselves before they lose their lives. The declaration shifts the balance of power in favour of the nomads, and the vizier\'s men retreat.  The nomads thank you, as do the freed harem. One woman steps forward.%SPEECH_ON%You have shown bravery stranger. We hate that man of the Vizier. He lies, and worse. If you have set your blade against him, then I wish to join you. I have a score to settle.%SPEECH_OFF%}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
			{
				Text = "Welcome. I hope you know how to use a weapon.",
				function getResult( _event )
				{
					this.World.getPlayerRoster().add(_event.m.Dude);
					this.World.getTemporaryRoster().clear();
					_event.m.Dude.onHired();
					_event.m.Dude = null;
					return 0;
				}

			},
			{
				Text = "We don\'t have room for another",
				function getResult( _event )
				{
					this.World.getTemporaryRoster().clear();
					_event.m.Dude = null;
					return 0;
				}

			}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(2);
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_southern_background"
				], true, 1);
				_event.m.Dude.setTitle("of the dance");
				_event.m.Dude.getBackground().m.RawDescription = "You rescued %name% from a life in slavery after she was forced into the vizier\'s harem. She seeks revenge on the vizier.";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				_event.m.Dude.getItems().equip(this.new("scripts/items/weapons/oriental/qatal_dagger"));
				local talents = _event.m.Dude.getTalents();
				talents.resize(this.Const.Attributes.COUNT, 0);
				talents[this.Const.Attributes.MeleeSkill] = 3;
				talents[this.Const.Attributes.Bravery] = 3;
				::Legends.Perks.grant(_event.m.Dude, ::Legends.Perk.CoupDeGrace);
				::Legends.Perks.grant(_event.m.Dude, ::Legends.Perk.LegendFavouredEnemySoutherner);
				::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendTalented);
				::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendPragmatic);
				_event.m.Dude.worsenMood(1.0, "Got taken captive by manhunters");
				_event.m.Dude.improveMood(2.0, "Got saved from a life in slavery");
				this.Characters.push(_event.m.Dude.getImagePath());
				local cityStates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

				foreach( c in cityStates )
				{
					c.addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "You aided in the escape of a Vizier\'s harem");
				}
			}

		});
	}


	local onClear = o.onClear;
	o.onClear = function () {
		onClear();
		this.m.Dude = null;
	}
})
