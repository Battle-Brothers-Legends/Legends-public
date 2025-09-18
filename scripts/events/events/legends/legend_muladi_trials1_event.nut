this.legend_muladi_trials1_event <- this.inherit("scripts/events/event", {
	m = {
		Muladi = null
	},
	function create() {
		this.m.ID = "event.legends.muladi.trials1";
		this.m.Title = "Whilst in the City...";
		this.m.Cooldown = 15.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_163.png[/img]{Perusing the exotic and aggressively colourful bazaars of %CityName%, your attention is drawn to one of the city\'s many snaking alleyways. In the gloom of a dusty dead end, the familiar sound of violence beckons you to the creeping maw of the passageway. Under a barrage of kicks and clubs and curses is none other than %brother%, the company\'s wayfaring muladi. A shout and brandishing of steel scares the attackers away, scurrying away into crevices and around blind corners where you imagine the labyrinth of alleys and hidden paths stretches on for untold miles. Sputtering dust, blood, and what looks like a tooth, %brother% tries to rise to %their_brother% feet, but crumples back down under the stress of the beating they\'d just suffered. Kneeling to check their wounds aren\'t too severe, your own bones ache having witnessed only the end of what seems a most savage beatdown.%SPEECH_ON%Ah, shit. Hey, captain. Fancy meeting you in such a classy side of town. You just missed my good friends I\'m afraid.%SPEECH_OFF%Indeed. You remark it seemed the attackers showed no signs of stopping their mauling until your interference, to which %brother% chuckles and confirms your musing. Your inspection reveals %brother%\'s injuries are grizzly, but not life threatening; while they won\'t be dancing any time soon, you suspect they can follow you back to camp. You ask them what the hells happened.%SPEECH_ON%As I say, just catching up with old friends- we go way back.%SPEECH_OFF%A frown and demanding gaze makes it clear you aren\'t taking that for an answer. Slinging %their_brother% arm over your shoulder and hauling their weight into your side, %brother% braces against you and manages to stand, albeit like some caricature of a %person_muladi% with pudding for bones. They match your frown, and say %they_brother%\'ll tell you when you get back to camp, preferably after taking something stiff for the pain which you can almost feel radiating off %them_brother%. Fair enough. Hobbling your way through the market and the arteries of the city, you make sure to stick to the most open streets, though even there the many people of the city spit at and curse the half-corpse clinging to you. Even a throng of indebted pause their labour to gawk at the pariah before them, their eyes betraying a mix of both desperate sadness and disgust as you both limp past.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "So much for southern hospitality..."
				getresult = @(_event) "1"
			}],
			function start(_event) {
				this.Characters.push(_event.m.Muladi.getImagePath());
			}
		});

		this.m.Screens.push({
			ID = "1"
			Title = "Back at camp..."
			Text = "[img]gfx/ui/events/event_05.png[/img]{Stumbling your way back to camp, a few of the company rise and meet you with visible concern for the battered muladi clinging to your frame. Crashing into a cot, %muladi% lets out a noise not unlike a draught animal\'s death rattle. After dispersing the onlookers and sourcing some suitably strong liquid medicine, you sit beside the battered wayfarer and ask what really happened. They take a swig of drink, sigh, and look towards the city\'s gleaming walls and banners.%SPEECH_ON%I\'ve been here many times, captain. Sometimes as a sellsword, other times a merchant of foreign goods. I\'ve solved problems, started others; helped folks, hurt some. I have spent a veritable lifetime learning the many dialects of the tribes, the endless protocol of city life, the patterns of fashion, trade, politics. What drives the people who call this land home, and the plights of those who don\t but are otherwise stuck here. All of it, and yet what am I to the peoples of these lands?%SPEECH_OFF%You shrug. A damn good speaker despite the recent punishment, that\'s for sure. %They_brother% let out a sharp and markedly venomous word you don\'t understand, undoubtedly of the local tongue.%SPEECH_ON%\'Outsider\'. It\'s the closest single word I can think of in our speech. But it\'s closer to \'one without home\', or \'forever wanderer\'. They see not a person of the south, nor do they even regard me as a northerner. I am neither from the north or the south, the city or the tribes, and for this, they both fear and are disgusted by me. Those men back there-  my \'good friends\'- they took issue with my lifestyle- called me a charlatan and mongrel, which of course they have for years. But today they said they would no longer tolerate me, if in fact they ever did; they planned to make a pulped example of me, to warn others who they claimed threatened their order of being. Of course, I\'ve heard this before in many cities, from many people, but I think were it not for you, they would have followed through on their mission.%SPEECH_OFF%For a moment, you sit in silence, looking to the ground with your arms bowed between your knees. You have no doubt the muladi has suffered and battled with these thoughts long before joining the company, and unfortunately the life of a sellsword has offered no peace from it. While many within your ranks know their origins, their lives or callings back home, or the lands they consider familiar enough to one day become home, you know the pain %muladi% bears. You open your mouth to speak, but %muladi% stops you.%SPEECH_ON%It\'s quite alright, captain, you don\'t need to say anything. I\'ve had such beatings before, and these thoughts are almost as old and good friends as the ruffians from that alleyway. I think I just needed to speak it, put it out in the open air for once.%SPEECH_OFF%You nod, and think to pat %muladi%\'s shoulder, though their current state makes you reconsider. You leave the skin of booze with them, and rise to find someone to properly dress %their_brother% wounds.}",
			Options = [{
				Text = "Get well soon, %muladi%."
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Muladi.getImagePath());

				_event.m.Muladi.getFlags().set("MuladiTrials", ::World.getTime().Days + 15);

				this.List.extend([
					::Legends.EventList.changeMood(_event.m.Muladi, -2, "Was battered and alienated by southerners"),
					::Legends.EventList.addInjury(_event.m.Muladi, ::Const.Injury.Brawl),
					::Legends.EventList.addLightInjury(_event.m.Muladi),
					::Legends.EventList.changeResolve(_event.m.Muladi, -2),
					::Legends.EventList.changeHitpoints(_event.m.Muladi, ::Math.rand(-4, -2))
				]);
			}
		});
	}

	function onUpdateScore() {
		local candidatesMuladi = ::World.getPlayerRoster().getAll().filter(@(_, _bro) _bro.getBackground().getID() == "background.legend_muladi");
		if (!candidatesMuladi.len())
			return;

		local currentTile = ::World.State.getPlayer().getTile();
		local nearbyTowns = ::World.EntityManager.getSettlements().filter(@(_, _town) _town.getTile().getDistanceTo(currentTile) <= 4 && _town.isSouthern());
		if (!nearbyTowns.len())
			return;

		foreach (bro in candidatesMuladi) {
			if (bro.getFlags().has("MuladiTrials"))
				return; // just one muladi allowed
			if (bro.getFlags().getAsInt("MuladiTrials") < ::World.getTime().Days)
				return; // too early for it to happen
		}

		this.m.Muladi = candidatesMuladi[::Math.rand(0, candidatesMuladi.len() - 1)];
		this.m.Score = 50;
	}

	function onPrepareVariables(_vars) {
		_vars.push(["muladi", this.m.Muladi.getNameOnly()]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Muladi.getGender(), "muladi");
	}

	function onClear() {
		this.m.Muladi = null;
	}
});
