::mods_hookExactClass("events/events/dlc4/cultist_origin_vs_uneducated_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]A few mercenaries come to you looking rather worried. They say %cultist% has been sitting with %uneducated% for a few hours now. When you ask what\'s the worry, they remind you that the cultist has a scarred forehead and speaks of incredibly strange things. Yeah. Those are the demands of Davkul, an example of one\'s committment. You do not understand what could possibly be wrong with that.\n\n You go and see the two of them. %uneducated% looks up at you, smiling, and says the cultist actually has a lot to teach. Perhaps so, but you know Davkul\'s presence need not be felt in all, and if it desired being forced upon the world it would be a misapprehension of Davkul\'s purpose.";
				s.Options[0].Text = "Show the darkness.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]You nod and turn away. By next morning, %uneducated% is found with a freshly wounded forehead, the blood of conversion and the price some must pay to devote themselves to Davkul. When you ask how  %uneducated% is doing, the reply is simple.%SPEECH_ON%Davkul is coming.%SPEECH_OFF%Shaking your head, you correct the initiate.%SPEECH_ON%Davkul is not coming. Davkul AWAITS us all.%SPEECH_OFF%";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Cultist.getImagePath());
					this.Characters.push(_event.m.Uneducated.getImagePath());
					_event.m.Uneducated.getBackground().Convert();
					_event.m.Uneducated.getBackground().m.RawDescription += " " + _event.m.Cultist.getName() + " helped " + _event.m.Uneducated.getName() + " see the darkness.";
					_event.m.Uneducated.getBackground().buildDescription(true);
					_event.m.Uneducated.getBaseProperties().DailyWage -= _event.m.Uneducated.getDailyCost() / 2;
					_event.m.Uneducated.getSkills().update();

					this.List = [{
						id = 13,
						icon = _event.m.Uneducated.getBackground().getIcon(),
						text = _event.m.Uneducated.getName() + " has been converted to a Cultist"
					}];

					_event.m.Cultist.getBaseProperties().Bravery += 2;
					_event.m.Uneducated.getBaseProperties().MeleeSkill += 10;
					_event.m.Cultist.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Cultist.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] Resolve"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/melee_skill.png",
						text = _event.m.Uneducated.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+10[/color] Melee Skill"
					});
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]You separate the two, telling %uneducated% to go count some inventory. With that done, %cultist% sneers at you.%SPEECH_ON%Davkul awaits. You see him in your sleep. You see him in the nights. His darkness is coming. No light burns forever.%SPEECH_OFF%The cultist pauses and stares into your soul. And you stare back from somewhere not of your body. You can only see infinite blackness around you and a pip of light through which %cultist% is looking. Slowly, you float back toward the light and find yourself blinking and staring. %cultist%  bows.%SPEECH_ON%Apologies, captain, I did not know that Davkul had such plans.%SPEECH_OFF%Blinking again, you can only nod.";
			}
		}
	}

	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() != "scenario.cultists" && this.World.Assets.getOrigin().getID() != "scenario.legends_necro" )
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
			return;

		local cultist_candidates = [];
		local uneducated_candidates = [];

		foreach( bro in brothers ) {
			switch (true)
			{
				case bro.getFlags().get("IsSpecial"):
				case bro.getFlags().get("IsPlayerCharacter"):
				case bro.getBackground().getID() == "background.slave":
				case bro.getBackground().getID() == "background.legend_puppet":
				case bro.getBackground().getID() == "background.legend_commander_berserker":
				case bro.getBackground().getID() == "background.legend_berserker":
				case bro.getBackground().getID() == "background.legend_donkey":
					continue;
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist):
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist):
					{
						cultist_candidates.push(bro);
						continue;
					}
				case bro.getSkills().hasTrait(::Legends.Trait.Dumb):
				case bro.getSkills().hasSkill("injury.brain_damage"):
				{
					uneducated_candidates.push(bro);
					continue;
				}
				case bro.getSkills().hasTrait(::Legends.Trait.Bright):
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.Noble):
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.Educated):
				case !bro.getBackground().isBackgroundType(this.Const.BackgroundType.Lowborn):
					continue;
			}
			uneducated_candidates.push(bro);
		}

		if (cultist_candidates.len() == 0 || uneducated_candidates.len() == 0)
			return;

		this.m.Cultist = cultist_candidates[this.Math.rand(0, cultist_candidates.len() - 1)];
		this.m.Uneducated = uneducated_candidates[this.Math.rand(0, uneducated_candidates.len() - 1)];
		this.m.Score = cultist_candidates.len() * 9;
	}
})
