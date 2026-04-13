::mods_hookExactClass("events/events/troublemakers_bully_peasants_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "%townImage%Entering %townname%, it isn\'t long until %troublemaker% is bothering the locals. %They_troublemaker%\'s slapping buckets out of their hands and kicking women into the mud. When an old man confronts %them_troublemaker%, the sellsword draws out %their_troublemaker% weapon. Other peasants beg that you put a stop to this at once.";
			_screen.start <- function ( _event )
			{
				if (_event.m.Peacekeeper != null) {
					this.Options.push({
						Text = "%peacekeeperfull%, see if you can calm %troublemaker% with your wisdom.",
						function getResult( _event ) {
							return this.Math.rand(1, 100) <= 70 ? "E" : "F";
						}
					});
				}

				this.World.Assets.addMoralReputation(-1);

				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation decreases slightly"
				});
				local f = _event.m.Town.getFactionOfType(this.Const.FactionType.Settlement);
				f.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "One of your company caused havoc in town");
				this.Characters.push(_event.m.Troublemaker.getImagePath());
			}
		});
		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.Text = "%townImage%You shrug. %troublemaker% doesn\'t run the old man through, but %they_troublemaker% does threaten to, raising the weapon on high. When the old man cowers, the sellsword delivers a punch that knocks the elderly right out, his teeth peppering the muck like spits of white rain. This brings a few jeers from the villagers, but they know not to contest your presence any further.\n\nA few men drag the elder away while children boo and women hiss. One child even runs up to the sellsword, pointing at him as he yells \'%they_troublemaker%\'s a bad %person_troublemaker%.\' %troublemaker% shrugs as %they_troublemaker% sheathes %their_troublemaker% weapon.%SPEECH_ON%And yet the bad %person_troublemaker% still stands. Would you also like a taste of the mud, little one?%SPEECH_OFF%The kid quickly runs off.";
			_screen.start <- function ( _event ) {
				this.Characters.push(_event.m.Troublemaker.getImagePath());
				this.World.Assets.addMoralReputation(-3);

				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation decreases"
				});
				local f = _event.m.Town.getFactionOfType(this.Const.FactionType.Settlement);
				f.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "One of your company caused havoc in town");
				_event.m.Troublemaker.improveMood(1.0, "Bullied the peasantfolk");

				if (_event.m.Troublemaker.getMoodState() >= this.Const.MoodState.Neutral)
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Troublemaker.getMoodState()],
						text = _event.m.Troublemaker.getName() + this.Const.MoodStateEvent[_event.m.Troublemaker.getMoodState()]
					});
			}
		});
		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "%townImage%As %troublemaker% raises %their_troublemaker% weapon on high, you grab %them_troublemaker% by the forearm and bring it back down. %They_troublemaker% swings around, looking at you sternly. The cowering old man backs off, soon collected by caretakers that shuttle %them_troublemaker% back inside before %they_troublemaker% gets himself hurt.\n\nA few other peasants linger around, watching with keen interest. You tell the sellsword to back down. %They_troublemaker%\'s paid to fight who you deem %they_troublemaker% should fight, not a bunch of peasants who are minding their own.\n\n As %troublemaker% glances around, you realize you\'ve left %them_troublemaker% no \'out\' that will save face. In %their_troublemaker% eyes, there is a look that says %they_troublemaker%\'s about to kill you. It\'d be the end of %them_troublemaker%, but %they_troublemaker%\'d go out with %their_troublemaker% suicidal pride intact. But the look fades, and embarrassment and humiliation take its place. %They_troublemaker% sheathes %their_troublemaker% weapon, spits, and remarks that %they_troublemaker% was only having some fun.";
		});
		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_30.png[/img]You look at the peasant who hailed you down.%SPEECH_ON%Who are you, peasant, to tell me or my company what to do?%SPEECH_OFF%The man takes a step back, stammering something about \'only trying to help.\' Laughing, you tell your mercenaries to take what they want. If this village has no respect for the authority of armed warriors, then you will have to teach them that respect.\n\nWomen scream and bundle up their children as the order leaves your tongue. They run off and a few men join them. Other men stay behind, protecting their homes, but the %companyname% makes quick work of their modest defenses. Your mercenaries are soon pillaging each and every home, taking what they can with roaring laughter. Today is a good day.";
			_screen.start <- function ( _event )
			{
				this.Characters.push(_event.m.Troublemaker.getImagePath());
				this.World.Assets.addMoralReputation(-5);

				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation decreases greatly"
				});

				local f = _event.m.Town.getFactionOfType(this.Const.FactionType.Settlement);
				f.addPlayerRelation(this.Const.World.Assets.RelationAttacked, "You pillaged the town");
				local money = this.Math.rand(100, 500);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasTrait(::Legends.Trait.Bloodthirsty) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat))
					{
						bro.improveMood(1.0, "Enjoyed raiding and pillaging");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.OffendedByViolence) && this.Math.rand(1, 100) <= 75)
					{
						bro.worsenMood(1.0, "Was appalled by the company\'s conduct");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}
		});
		::Legends.Screens.hook(this, "E", function (_screen) {
			_screen.Text = "%townImage%%peacekeeperfull% places %themselves_peacekeeper% between %troublemaker% and the old man. %They_peacekeeper% shakes %their_peacekeeper% head \'no\' in a very modest fashion, but you can\'t help but notice that %their_peacekeeper% swordhand is also on the pommel of %their_peacekeeper% weapon. The troublemaking sellsword briefly seems to consider cutting the %person_peacekeeper% down, but then a smile snaps across %their_troublemaker% face. %They_troublemaker% laughs as %they_troublemaker% sheathes %their_troublemaker% weapon.%SPEECH_ON%Only having a bit of fun, my friend.%SPEECH_OFF%The peasants slowly start going about their business again, but they are wary and stare side-eyed at your men for the rest of your duration in %townname%.";
		});
		::Legends.Screens.hook(this, "F", function (_screen) {
			_screen.Text = "%townImage%%peacekeeperfull% steps in between %troublemaker% and the old man. The troublemaking sellsword laughs and sheathes %their_troublemaker% weapon. %They_troublemaker% turns back to the rest of the company, grinning and shaking %their_troublemaker% head, but you notice that this smile quickly fades. Before you can say anything, %troublemaker% wheels a fist back around and knocks %peacekeeper% out cold.\n\n Well, that\'s one way to mollify a mercenary.";
			_screen.start <- function ( _event ) {
				this.Characters.push(_event.m.Troublemaker.getImagePath());
				this.Characters.push(_event.m.Peacekeeper.getImagePath());
				this.List.push({
					id = 10,
					icon = "ui/icons/relation.png",
					text = _event.m.Troublemaker.getName() + " and " + _event.m.Peacekeeper.getName() + " grow distant"
				});
				local injury = _event.m.Peacekeeper.addInjury(this.Const.Injury.Knockout);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Peacekeeper.getName() + " suffers " + injury.getNameOnly()
				});
				_event.m.Peacekeeper.worsenMood(2.0, "Was humiliated in front of the company");

				if (_event.m.Peacekeeper.getMoodState() < this.Const.MoodState.Neutral) {
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Peacekeeper.getMoodState()],
						text = _event.m.Peacekeeper.getName() + this.Const.MoodStateEvent[_event.m.Peacekeeper.getMoodState()]
					});
				}
			}
		});
		foreach (s in this.m.Screens) {
			if (s.ID == "F") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Troublemaker.getImagePath());
					this.Characters.push(_event.m.Peacekeeper.getImagePath());
					this.List.push({
						id = 10,
						icon = "ui/icons/relation.png",
						text = _event.m.Troublemaker.getName() + " and " + _event.m.Peacekeeper.getName() + " grow distant"
					});
					local injury = _event.m.Peacekeeper.addInjury(this.Const.Injury.Knockout);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Peacekeeper.getName() + " suffers " + injury.getNameOnly()
					});
					_event.m.Peacekeeper.worsenMood(2.0, "Was humiliated in front of the company");

					if (_event.m.Peacekeeper.getMoodState() < this.Const.MoodState.Neutral) {
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Peacekeeper.getMoodState()],
							text = _event.m.Peacekeeper.getName() + this.Const.MoodStateEvent[_event.m.Peacekeeper.getMoodState()]
						});
					}
				}
			}
		}
	}
})
