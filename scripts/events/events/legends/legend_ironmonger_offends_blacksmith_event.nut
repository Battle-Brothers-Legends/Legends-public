this.legend_ironmonger_offends_blacksmith_event <- this.inherit("scripts/events/event", {
	m = {
		Ironmonger = null,
		Blacksmith = null
	},
	function create() {
		this.m.ID = "event.legends.ironmonger_offends_blacksmith";
		this.m.Title = "At camp...";
		this.m.Cooldown = 30 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_82.png[/img]{The singing of an anvil\'s steel within camp is nothing new, but its sudden stop, followed by shouting and sounds of a commotion steals your attention away from your maps and ledgers. Joined together like a fine piece of chain mail, %blacksmith% and %ironmonger% grapple and struggle amidst the camp\'s makeshift smithy. A few ineffective jabs and the occasional good hook later, %blacksmith% leaves %their_blacksmith% quarry in the dirt and lurches to %their_blacksmith% feet in such an awkward movement you half expect them to crash back down. A tinge of shame makes itself known as they notice you and the rest of the company judging their handiwork.%SPEECH_ON%They - %they_ironmonger% - look at what they\'ve done, captain!%SPEECH_ON%, they gesture to the now thoroughly wrecked workshop: anvil overturned, equipment strewn across the floor, bags of tools now empty and strewn about this corpse of a smithy. It\'s apparently only the latter which concerns %blacksmith%, as they limply grab and thrust a bag before the company, seemingly pleading to the impromptu court before them. They stammer: %SPEECH_ON%These were full not even an hour ago! This, this BUTCHER has broken tongs, shredded steel, dented hammers, and for what? I’ve had one of those pliers for years!%SPEECH_OFF%. You cast your eyes to the littered remains of metal strewn across the floor, in %blacksmith%\'s defence, you cant tell the remains apart, whether they used to belong to tong or chisel. Spitting and rising with a groan, %ironmonger% defends the metal massacre around %them_ironmonger%. %SPEECH_ON%You had already written these pieces off as junk! You didn\'t listen when I told you there were viable pieces in here, just insisted they\'d make scrap and slag. But look, look at what your stubbornness couldn\t see-%SPEECH_OFF%, they invite the crowd to look upon the assortment of gear they\'d mended. Indeed, you remember recording some of these items as nothing more than mangled junk when you first acquired them- now they looked sturdy enough to save a life, and sharp enough to take one. The company\'s apparent bewilderment at the state of the armaments swings some of the men in the ironmonger\'s favour, and %blacksmith% looks as though they\'re ready to begin their fight anew before %ironmonger% continues. %SPEECH_ON%Your tools are made to be used, you old fool. Not hoarded like some dragon of old.%SPEECH_OFF% Murmurs amongst the company, and eventual eyes upon you force your hand as the final judge of this bizarre tool trial.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Our blacksmith is right, your overzealous use of our tools has gone too far.",
				getResult = @(_event) "1"
				function getResult(_event) {
					return "1";
				}
			}, {
				Text = "The ironmonger\'s method may be messy, but the results speak for themself.",
				function getResult(_event) {
					return "2";
				}
			}, {
				Text = "Clean up this mess, both of you! And let me hear no more of this nonsense!"
				function getResult(_event) {
					return "3";
				}
			}],
			function start(_event) {
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				this.Characters.push(_event.m.Ironmonger.getImagePath());
			}
		});

		this.m.Screens.push({
			ID = "1",
			Text = "[img]gfx/ui/events/event_82.png[/img]{While the pieces are impressive, and you cant help but respect the tenacity of the company ironmonger, the barren tool stores speak for themself. Such excessive use of the company\'s limited resources is negligent and only puts needless strain on the company coffers. You wonder out loud if it would be fair to have %ironmonger% pay for the destroyed tools, but figure they have paid enough in blood and bruised ego before the others. You order the two clean themselves up, and the ironmonger\'s restored equipment properly catalogued and added to the wagon. After all - steel is steel.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "They really put the hammer to %ironmonger%\'s anvil...",
				function getResult(_event) {
					return 0;
				}
			}],
			function start(_event) {
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				this.Characters.push(_event.m.Ironmonger.getImagePath());

				this.List.push(::Legends.EventList.changeMeleeSkill(_event.m.Blacksmith, ::Math.rand(1, 2)));
				this.List.push(::Legends.EventList.addLightInjury(_event.m.Blacksmith));
				this.List.push(::Legends.EventList.changeMood(_event.m.Blacksmith, 1.5, "Was supported in their fight with the ironmonger."));
				_event.m.Blacksmith.getSkills().update();

				this.List.push(::Legends.EventList.addInjury(_event.m.Ironmonger, ::Const.Injury.Brawl));
				this.List.push(::Legends.EventList.addLightInjury(_event.m.Ironmonger));
				this.List.push(::Legends.EventList.changeMood(_event.m.Ironmonger, -1.5, "Was beaten and humiliated in front of the company."));
				repairItems(this);
			}
		});


		this.m.Screens.push({
			ID = "2",
			Text = "[img]gfx/ui/events/event_82.png[/img]{The company ironmonger has a point, and by admiring a piece of their restored work, you make your favour known. Tools are but a means to an end of keeping the company ready for action; if %ironmonger% can see what the trained blacksmith cannot, then perhaps it\'s better to have them look over more of our stores. %blacksmith% protests, but your word is final, and you order %them_blacksmith% to clean up the mess left in the wake of their fight. The rest of the company disperses, and you can almost see a spring in %ironmonger%\'s step, although that might just be a fresh limp.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "The old make way for the new…",
					function getResult(_event) {
						return 0;
					}
				}],
			function start(_event) {
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				this.Characters.push(_event.m.Ironmonger.getImagePath());

				this.List.push(::Legends.EventList.addLightInjury(_event.m.Blacksmith));
				this.List.push(::Legends.EventList.changeMood(_event.m.Blacksmith, -1.0, "Was humiliated in their fight with the ironmonger."));

				this.List.push(::Legends.EventList.changeMeleeDefense(_event.m.Ironmonger, ::Math.rand(1, 2)));
				this.List.push(::Legends.EventList.addInjury(_event.m.Ironmonger, ::Const.Injury.Brawl));
				this.List.push(::Legends.EventList.addLightInjury(_event.m.Ironmonger));
				this.List.push(::Legends.EventList.changeMood(_event.m.Ironmonger, 1.0, "Was supported in their fight against the blacksmith."));
				_event.m.Ironmonger.getSkills().update();

				repairItems(this);
			}
		});


		this.m.Screens.push({
			ID = "3",
			Text = "[img]gfx/ui/events/event_82.png[/img]{Such a display of hotheadedness and waste puts us all at risk, and you cannot stand for it. You make your disappointment in both parties known, and demand they clean up the battlefield they made of the camp workshop. The company\'s tools are not to be used so brazenly, and the ironmonger is not to be treated as an anvil for the blacksmith\'s wrath. While an uneasy peace has been restored, the scowls and muttered curses reiterate that no one won this day; though they may be angry for a while, you trust that such a repeat of today\'s drama is unlikely. With an exasperated sigh, you return to your ledgers to record the newly repaired armaments and the loss of several good tools.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Who would have thought smiths could have such animosity for their peers?",
				function getResult(_event) {
					return 0;
				}
			}],
			function start(_event) {
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				this.Characters.push(_event.m.Ironmonger.getImagePath());

				this.List.push(::Legends.EventList.addLightInjury(_event.m.Blacksmith));
				this.List.push(::Legends.EventList.changeMood(_event.m.Blacksmith, -0.5, "Unsatisfied with the captain\'s decision."));

				this.List.push(::Legends.EventList.addLightInjury(_event.m.Ironmonger));
				this.List.push(::Legends.EventList.changeMood(_event.m.Ironmonger, -0.5, "Unsatisfied with the captain\'s decision."));

				repairItems(this);
			}
		});
	}

	function repairItems(_screen) {
		local stash = ::World.Assets.getStash().getItems();
		local items = 0;

		foreach(item in stash) {
			if (item != null && (item.isItemType(::Const.Items.ItemType.Weapon) || item.isItemType(::Const.Items.ItemType.Armor)) && item.getCondition() < item.getConditionMax()) {
				item.setCondition(item.getRepairMax());
				_screen.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "Your " + item.getName() + " is repaired"
				});
				items++;
				if (items > 4)
					break;
			}
		}

		local toolsSpent = ::Math.rand(10, 20);
		::World.Assets.addArmorParts(-toolsSpent);
		_screen.List.push({
			id = 10,
			icon = "ui/icons/asset_supplies.png",
			text = ::format("You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]%d[/color] Tools and Supplies", toolsSpent)
		});
	}

	function onUpdateScore() {
		if (::World.Assets.getArmorParts() < 20)
			return;

		local brothers = ::World.getPlayerRoster().getAll();

		local candidates_blacksmith = brothers.filter(@(idx, bro) bro.getBackground().getID() == "background.legend_blacksmith");
		if (candidates_blacksmith.len() == 0)
			return;

		local candidates_ironmonger = brothers.filter(@(idx, bro) bro.getBackground().getID() == "background.legend_ironmonger");
		if (candidates_ironmonger.len() == 0)
			return;

		this.m.Blacksmith = candidates_blacksmith[::Math.rand(0, candidates_blacksmith.len() - 1)];
		this.m.Ironmonger = candidates_ironmonger[::Math.rand(0, candidates_ironmonger.len() - 1)];

		this.m.Score = 5;
	}

	function onPrepareVariables(_vars) {
		_vars.push(["blacksmith", this.m.Blacksmith.getNameOnly()]);
		_vars.push(["ironmonger", this.m.Ironmonger.getNameOnly()]);
	}

	function onClear() {
		this.m.Blacksmith = null;
		this.m.Ironmonger = null;
	}
});
