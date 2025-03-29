::mods_hookExactClass("events/events/pimp_vs_harlot_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_92.png[/img]With a parental appeal you take the pimp by the shoulder.%SPEECH_ON%You can take the woman out of a whore, but you can\'t take the whore out of a woman.%SPEECH_OFF%The pimp thinks it over. You do, too, as you were never one for logic. The pimp looks at you.%SPEECH_ON%What?%SPEECH_OFF%The lady steps forward, taking the pimp by the other shoulder.%SPEECH_ON%I think he\'s saying to cut me loose.%SPEECH_OFF%When the pimp raises an eyebrow, the woman clarifies.%SPEECH_ON%Figuratively speaking.%SPEECH_OFF%The pimp sighs.%SPEECH_ON%I don\'t understand what the hell you two are saying, but alright. I thought maybe I could get a business going here. A woman here, a woman there, peddle their gooches and mooches, make some crowns, retire early. Oh well, back to grinding wheat into flour until I keel over and die.%SPEECH_OFF%The man walks off, his nose sniffling.";
			}
			if (s.ID == "Minstrel") {
				s.Text = "[img]gfx/ui/events/event_92.png[/img]%minstrel% the minstrel glides forward.%SPEECH_ON%Ahoy, what is this but a tale of a dullard and tail of a whore? With one look I know what you need to do my friend: profess your undying love to this minge!%SPEECH_OFF%The woman crosses her arms and creases her eyebrows.%SPEECH_ON%Just what are you on abou--%SPEECH_OFF%The minstrel bats her out of the way and raises an arm and a singly voice with it.%SPEECH_ON%Ahoyyy! Love, yes, love is in the air! Best let it flare! - and I\'m not just talking about his cock and balls. He loves you, my dear, can\'t you see? Why else would he make a harlot out of only thee? A pimp needs a diverse portfolio, not a business of one holy-oh, ohhh!%SPEECH_OFF%The pimp drops his head, face red and embarrassed. He admits it\'s true, all of it. The woman looks over, her face flushed. They lock eyes. You roll yours. They embrace and make off all lovey-dovey. %minstrel% scratches their chin.%SPEECH_ON%I\'m a poet and I didn\'t even... realize it.%SPEECH_OFF%";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Minstrel.getImagePath());
					_event.m.Minstrel.improveMood(2.0, "Enchanted by their own poetry");

					if (_event.m.Minstrel.getMoodState() >= this.Const.MoodState.Neutral)
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Minstrel.getMoodState()],
							text = _event.m.Minstrel.getName() + this.Const.MoodStateEvent[_event.m.Minstrel.getMoodState()]
						});
				}
			}
			if (s.ID == "Tailor") {
				s.Text = "[img]gfx/ui/events/event_92.png[/img]\'Tsk, tsk, tsk.\' %tailor% the tailor struts on up shaking their head and running a finger along the prostitute\'s dress. %tailor% remarks that whores are supposed to be pretty. The pimp raises his hand.%SPEECH_ON%That\'s my property you\'re spittin\' on.%SPEECH_OFF%%tailor% bows.%SPEECH_ON%Apologies, sir, but I do believe you have already spit on her yourself dressing her in such a manner. I\'d not know she\'s looking for a whore\'s coin had you not yelled at her with a pimp\'s, hm, lackadaisical sense of economics.%SPEECH_OFF%The pimp draws a dagger out and attacks. The tailor pirouettes, spinning beneath the blade\'s strike then springing back upright and jamming a thick pair of scissors to the pimp\'s throat.%SPEECH_ON%Mmm, what a quaint position to be in. I daresay you have but two ways out, and one is much shinier than the other. Yes, that\'s right, you get it don\'t you? Pay up or I\'ll cut yer throat and clip your nuts and the order which I do it just might surprise you.%SPEECH_OFF%The pimp hastily forks over some crowns to spare his life. The tailor \'snips\' his scissors closed and pockets them.%SPEECH_ON%Good. Now for some advice. You can find linens for cheap down the street yonder. The man who works the shop there is, hm, particularly good at outfitting women... and men. Tata now.%SPEECH_OFF%%tailor% turns to you with a grin and asks for permission to go and visit some shops to spend the newly found gold.";
			}
			if (s.ID == "Monk") {
				s.Text = "[img]gfx/ui/events/event_92.png[/img]%monk% the monk steps forward, taking the pimp by the hands. Were you to do that, the pimp would no doubt shrink back or strike you. But the holy figure does it with such grace and humility that the pimp simply stares. The holy one smiles warmly.%SPEECH_ON%This is not the path for you, that much is clear. You have not the means to handle this woman, and this is but one woman, when a pimp really needs many. The old gods tell me you are meant for a different path, one which is for hardier men. I daresay you are fit for a mercenary company. Leave the women-wrangling to the snake handlers.%SPEECH_OFF%The pimp thinks for a time, but you can tell the words have gotten to him. He asks if you\'d accept him into your company.";
				s.start <- function ( _event ) {
					_event.m.Monk.improveMood(1.0, "Led a man back onto the path of rightenousness");

					if (_event.m.Monk.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Monk.getMoodState()],
							text = _event.m.Monk.getName() + this.Const.MoodStateEvent[_event.m.Monk.getMoodState()]
						});
					}

					this.Characters.push(_event.m.Monk.getImagePath());
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
					{
						_event.m.Dude.getFlags().add("PlayerSkeleton");
						_event.m.Dude.getFlags().add("undead");
						_event.m.Dude.getFlags().add("skeleton");
						_event.m.Dude.setStartValuesEx([
							"pimp_background"
						]);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.RacialSkeleton);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendFleshless);
					}
					else
					{

						_event.m.Dude.setStartValuesEx([
							"pimp_background"
						]);
					}

					_event.m.Dude.setTitle("the Pimp");
					_event.m.Dude.getBackground().m.RawDescription = "While visiting " + _event.m.Town.getName() + ", you found %name% quarreling with his only harlot. " + _event.m.Monk.getName() + " persuaded him to join the company and you agreed to take him along. Hopefully, he\'s better fighting in the shield wall than he is wrangling whores.";
					_event.m.Dude.getBackground().buildDescription(true);
					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
		}
	}

	o.onUpdateScore = function () {
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
			return;

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns ) {
			if (t.getSize() >= 2 && !t.isMilitary() && !t.isSouthern() && t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer()) {
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
			return;

		local candidate_minstrel = [];
		local candidate_monk = [];
		local candidate_tailor = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().getID() == "background.minstrel")
				candidate_minstrel.push(bro);
			else if (bro.getBackground().getID() == "background.monk")
				candidate_monk.push(bro);
			else if (bro.getSkills().hasPerk(::Legends.Perk.LegendScholar))
				candidate_monk.push(bro);
			else if (bro.getBackground().getID() == "background.tailor")
				candidate_tailor.push(bro);
		}

		if (candidate_minstrel.len() != 0)
			this.m.Minstrel = candidate_minstrel[this.Math.rand(0, candidate_minstrel.len() - 1)];

		if (candidate_monk.len() != 0)
			this.m.Monk = candidate_monk[this.Math.rand(0, candidate_monk.len() - 1)];

		if (candidate_tailor.len() != 0)
			this.m.Tailor = candidate_tailor[this.Math.rand(0, candidate_tailor.len() - 1)];

		this.m.Town = town;
		this.m.Score = 15;
	}
})
