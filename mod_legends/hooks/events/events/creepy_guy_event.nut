::mods_hookExactClass("events/events/creepy_guy_event", function(o) {
	o.m.Shieldmaiden <- null;
	o.m.Militia <- null;

	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			local start = _screen.start;
			_screen.start <- function(_event) {
				start(_event);
				if (_event.m.Shieldmaiden != null && this.Options.len() < 6) {
					this.Options.insert(this.Options.len() - 1, {
						Text = "Our shieldmaiden seems interested, how about she takes the lead?",
						getResult = @(_event) "Shieldmaiden"
					});
				}
				if (_event.m.Militia != null && this.Options.len() < 6) {
					this.Options.insert(this.Options.len() - 1, {
						Text = "%militia% is eager to take action.",
						getResult = @(_event) "Militia"
					});
				}
			}
		});
		::Legends.Screens.hook(this, "Good", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_43.png[/img]You muscle your way into the crowd, looking for fingers and toes or bloodied pockets. One man\'s got a good, lumpy sag in his pocket. You drive him into a corner and shake him down with a dagger to his throat.\n\n After him, you see a woman with a sickly grin on her face prancing along the cobbled stones. That\'s a scornful wench if you\'ve ever seen one. Pulling her aside, you quickly find a finger and a toe in the linens of her frock. She lies and says they\'re just cooking ingredients. You tell her if that\'s the case then you\'ll report her to the guards for cannibalism. She gives them up.\n\n Returning the grossly extremities to the old man, you are promptly paid the five hundred crowns. He hardly even thanks you for your \'work\' before rushing away. He never did explain what, exactly, such things were for. You don\'t care. Five hundred crowns is five hundred crowns.";
		});
		::Legends.Screens.hook(this, "Thief", function (_screen) {
			local start = _screen.start;
			_screen.start <- function(_event) {
				start(_event);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases slightly"
				});
			}
		});

		this.m.Screens.push({
			ID = "Shieldmaiden"
			Text = "[img]gfx/ui/events/event_50.png[/img]As though waiting to be called forward, %shieldmaiden% steps before the old man and grimaces. She doesn\'t try to hide the blatant disgust she has for this connoisseur of loose limbs, but nevertheless invites him forward.%SPEECH_ON%You want the fingers of a violent, dangerous person? Take mine.%SPEECH_OFF%She offers her sword hand out to the creep who\'s almost as confused as you are by the offer. After sizing her up and perhaps satisfied to the malice of the hand offered to him, he produces a rust-mottled knife and reaches for the shieldmaiden\'s outstretched hand, eyes glazed over in a disturbing, hungry trance. In an instant, %shieldmaiden% pulls back and uses her shield to smash the outstretched arm of the old fool - a disgusting snap at the elbow and immediate wail of agony confirms your shieldmaiden struck true. Without relenting, the shield coils back for another strike, this time on the flapping jaw of the hollering creep, and one crunch later, his screams are notably muffled as he falls to the dirt. %shieldmaiden% stands proud over the crumpled mess of a man, notices his coin purse that now furnishes the floor, and soundly grabs it. She pockets some of it, then throws the rest back to you.%SPEECH_ON%Aww, tough luck old man. You\'ll have to be quicker than that.%SPEECH_OFF%Your shock at the swift and brutal violence is quickly dispelled as you see the digit-hungry crowd start to turn to investigate the commotion. Grabbing your shieldmaiden by the shoulder, you decide it\'s best if you get out of there."
			Image = ""
			List = []
			Characters = []
			Options = [{
				Text = "Well, can\'t say that\'s what I would have done"
				getResult = @(_event) 0
			}]
			function start(_event) {
				this.Characters.push(_event.m.Shieldmaiden.getImagePath());

				this.List.extend([
					::Legends.EventList.changeMoney(200),
					::Legends.EventList.changeMeleeSkill(_event.m.Shieldmaiden, ::Math.rand(1, 2)),
					::Legends.EventList.changeMeleeDefense(_event.m.Shieldmaiden, ::Math.rand(1, 2)),
					::Legends.EventList.changeResolve(_event.m.Shieldmaiden, 2),
					::Legends.EventList.changeMood(_event.m.Shieldmaiden, 1.0, "Enjoyed beating some old creep to the ground")
				]);
			}
		});

		this.m.Screens.push({
			ID = "Militia"
			Text = "[img]gfx/ui/events/event_65.png[/img]%militia% looks at the throng of peasants - all clamouring for their own macabre memento – and shakes %their_militia% head. You see them pull a number of mismatched rags from their jacket pocket and quickly tie one around their arm before passing the rest to a few of the sturdier looking men from the company. %SPEECH_ON%With me. Follow my lead, and this should be over quick.%SPEECH_OFF%The deputised mercenaries are confused but agree nonetheless, perhaps eager to dispense lawful violence against such a lawless mob, or perhaps obliged by the unquestionable gravitas in %militia%\'s order. One ties a floral patch around their arm, earning smirks from the rest of the company as they set off into the rabble. What follows resembles the sound of battle – as though the mob had suddenly become feral and decided to gorge themselves on your ad-hoc militia\'s flesh. Orders, roars, jeers, thuds, boos, and a few embarrassing yelps later, the crowd begins to calm, albeit with a few loud grumbles about them “ruining the fun”. The shouts of your impromptu militia turn to firm but measured commands to disperse and leave the dead alone, no matter how guilty they are. With the peasants returning to the less exciting doldrum of their insignificant realities, %militia% approaches with a self-assured smile.%SPEECH_ON%Well, captain. It can be a real ball-ache at times, but it\'s just like wrangling chickens: you find the cockerel and shut it up, and the rest don\'t feel as cocky all of a sudden.%SPEECH_OFF%%They_militia% turns and gestures to a battered peasant – the instigator perhaps- dazed and slipping in the churned earth of the mob as they slip away. You can\'t say you\'ve ever been involved in chicken wrangling, but you feel you have a better idea of it now. The creep smiles a near toothless smile and slips a purse into your hands, looking through you to the now abandoned corpse. They lick their cracked lips as %militia% undoes their armband and pockets it as they join the rest of the company.%SPEECH_ON%Wait, who was that?%SPEECH_OFF%"
			Image = ""
			List = []
			Characters = []
			Options = [{
				Text = "Don't worry about it, let's go."
				getResult = @(_event) 0
			}]
			function start(_event) {
				this.Characters.push(_event.m.Militia.getImagePath());

				this.List.extend([
					::Legends.EventList.changeMoney(500),
					::Legends.EventList.changeFatigue(_event.m.Militia, ::Math.rand(1, 2)),
					::Legends.EventList.changeResolve(_event.m.Militia, ::Math.rand(1, 2)),
					::Legends.EventList.changeMood(_event.m.Militia, 1.5, "Happy to restore order to a town.")
				]);
			}
		});
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		onUpdateScore();

		if (!this.m.Score)
			return;

		local candidates_shieldmaiden = ::World.getPlayerRoster().getAll().filter(@(idx, _bro) _bro.getBackground().getID() == "background.legend_shieldmaiden");
		if (candidates_shieldmaiden.len() != 0)
			this.m.Shieldmaiden = candidates_shieldmaiden[this.Math.rand(0, candidates_shieldmaiden.len() - 1)];

		local candidates_militia = ::World.getPlayerRoster().getAll().filter(@(idx, _bro) _bro.getBackground().getID() == "background.militia");
		if (candidates_militia.len() != 0)
			this.m.Militia = candidates_militia[this.Math.rand(0, candidates_militia.len() - 1)];

	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function (_vars) {
		onPrepareVariables(_vars);
		if (this.m.Shieldmaiden != null) {
			_vars.push(["shieldmaiden", this.m.Shieldmaiden.getNameOnly()]);
		}
		if (this.m.Militia != null) {
			_vars.push(["militia", this.m.Militia.getNameOnly()]);
		}
	}

	local onClear = o.onClear;
	o.onClear = function () {
		onClear();
		this.m.Shieldmaiden = null;
		this.m.Militia = null;
	}
})
