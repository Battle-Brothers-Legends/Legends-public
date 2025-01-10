::mods_hookExactClass("events/events/jousting_tournament_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]%jouster% comes to you with a paper in hand. Slamming it on your table and saying they wish to enter. You pick up the scroll, unfurling it to show that a local town is hosting a jousting tournament. The mercenary crosses arms, awaiting your response.";
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_96.png[/img]You agree to let %jouster% go to the tournament and, wanting to see it for yourself, you go along, too.\n\nThe jousting tourney crackles with energy as you near it. Squires hurry to and fro, carrying great armfulls of armor and weapons, and some step slowly about with enormous lances hefted over their shoulders. Other men brush very regal looking horses, many of which wear breastplates decorated with sigils. In the distance, you listen to brief gallops, heavy hooves stamping roughshod and lumbering and then there\'s a snapping twang of wood on metal and cheers erupt.\n\nAs you look about the festivities, a nobleman walks up and stops you. Weighing a purse in one hand and twisting a piece of broomstraw about the corner of his mouth with the other, he asks if you\'d like to make a wager. You ask what for. He nods, pointing toward %jouster% who is across the mustering point signing themself into the tourney. Apparently he is to face this nobleman\'s own rider, a man by the name of %opponent%.%SPEECH_ON%A little bit of gamesmanship never hurt, no? How does %bet% crowns sound to you? Winner take all, of course.%SPEECH_OFF%";
			}
			if (s.ID == "P") {
				s.Text = "[img]gfx/ui/events/event_96.png[/img]You take a seat amongst commoners and noblemen alike. Only the local lord has any separation from the riff-raff, sitting on a heightened row with the likes of his sons, daughters, and various royalty from around the land.\n\n%jouster% is up next, a squire helping lead the horse to one of the jousting lanes. Down the battleline, %opponent% rides onto the field, his horse black, his armor a vibrant purple with gold trimmings and tassels here and there. Both he and %jouster% take up their lances and slap down the faceplates of their helmets.\n\nA barker shouts their names from the royal-box, and then a clergyman says a few words about how this was ordained by the gods and, were anybody here to die today, they\'d sit amongst the greatest of men in the next realm, and be remembered with them in this one. All that said, the two jousters lower their lances and charge before either the barker or priest can even take a seat.";
			}
			if (s.ID == "Win") {
				s.Text = "[img]gfx/ui/events/event_96.png[/img]Having never been to such an event, you can\'t help but hold your breath as the two riders barrel down the lanes toward each other. The horses are majestic, their legs in rhythm, their hooves tearing up great clods of earth, their armors glinting sundots across the crowds as they run, altogether leaving in their wake streams of giddy observers and shouting kids and drunks spilling their raised mugs and young princesses gripping their dresses and wantingly brave princes clapping their hands and, not knowing how it even came to be, you yourself are standing and shouting.\n\n %opponent% struggles to keep his aim steady, his lance bobbing up and down, the point of it wobbling in search of a true target.\n\n They don\'t find it.";
			}
			if (s.ID == "WinNobet") {
				s.Text = "[img]gfx/ui/events/event_96.png[/img]%jouster%\'s lance shatters on their opponent\'s chest, a proverbial explosion of sawdust and splinters through which rides a horse with no rider, the jouster having been driven back over his cantle and clear of his saddle altogether, coming facedown on the battleground with nary a move or breath. A roar bursts from the crowd, an uncorked tempest which you are quick to join, drowning your ears in a blistering cacophony, swept up in a time and place you will never forget.";
			}
			if (s.ID == "WinBet") {
				s.Text = "[img]gfx/ui/events/event_96.png[/img]%jouster%\'s lance shatters on their opponent\'s chest, a proverbial explosion of sawdust and splinters through which rides a horse with no rider, the jouster having been driven back over his cantle and clear of his saddle altogether, coming facedown on the battleground with nary a move or breath. A roar bursts from the crowd, an uncorked tempest which you are quick to join, drowning your ears in a blistering cacophony, swept up in a time and place you will never forget.\n\nWhile still celebrating, the nobleman you made a wager with comes over and places a purse into your hand. You wish to say a few words, but before you can he angrily turns and walks off.";
			}
			if (s.ID == "Lose") {
				s.Text = "[img]gfx/ui/events/event_96.png[/img]Having never been to such an event, you can\'t help but hold your breath as the two riders barrel down the lanes toward each other. The horses are majestic, their legs in rhythm, their hooves tearing up great clods of earth, their armors glinting sundots across the crowds as they run, altogether leaving in their wake streams of giddy observers and shouting kids and drunks spilling their raised mugs and young princesses gripping their dresses and wantingly brave princes clapping their hands and, not knowing how it even came to be, you yourself are standing and shouting.\n\n%jouster% struggles to keep their aim steady, lance bobbing up and down, the point of it wobbling in search of a true target.\n\n They don\'t find it.";
			}
			if (s.ID == "LoseNobet") {
				s.Text = "[img]gfx/ui/events/event_96.png[/img]%opponent%\'s lance explodes as it lands square on %jouster%\'s chest. Bent back in the saddle, a cloud of spinning splinters and powdered wood swirling in its wake. %jouster% reaches desperately for the reins. Finding them, you think they've recovered, but the bridlebit breaks off and the reins slip free. %jouster% falls backward, tumbling over the mount\'s hindquarters and landing feet first. Standing may be impressive, but %jouster% has lost.\n\nThe crowd erupts, clapping fervently to both winner and loser. Rolling their shoulder in a bit of pain, %jouster% clears the field. You find them back at the mustering grounds. %jouster% He says something was off about the lance, and you mention that the horse\'s bridlebit came loose. Just then, the winner walks by, a retinue of adoring women behind him and a squire leading a rather pompous looking horse. To your surprise, %opponent% and %jouster% shake hands and bid each other congratulations on a well-fought match.";
			}
			if (s.ID == "LoseBet") {
				s.Text = "[img]gfx/ui/events/event_96.png[/img]%opponent%\'s lance explodes as it lands square on %jouster%\'s chest. The mercenary is bent back in his saddle, a cloud of spinning splinters and powdered wood swirling in its wake. %jouster% reaches desperately for the reins. Finding them, you think they've recovered, but the bridlebit breaks off and the reins slip free. %jouster% falls backward, tumbling over the mount\'s hindquarters and landing feet first. Standing may be impressive, but %jouster% has lost.\n\n The crowd erupts, clapping fervently to both winner and loser. Rolling their shoulder in a bit of pain, %jouster% clears the field. You find them back at the mustering grounds. %jouster% says something was off about the lance, and you mention that the horse\'s bridlebit came loose. Just then, the winner walks by, a retinue of adoring women behind him and a squire leading a rather pompous looking horse. To your surprise, %opponent% and %jouster% shake hands and bid each other congratulations on a well-fought match. \n\n The nobleman you made a wager with isn\'t so keen on good sportsmanship. He comes to you rubbing his hands beneath a cheap grin. You begrudgingly pay the man what he is owed.";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_64.png[/img]Telling %jouster% no does not go over well. The mercenary goes on a great deal about how much money they could have made at the tournament and how you are robbing them of those crowns. All very interesting complaints, sure, until they turn to you and demands %compensation% crowns, compensation for claimed lost earnings.";
			}
			if (s.ID == "H") {
				s.Text = "[img]gfx/ui/events/event_64.png[/img]You stand up and pat %jouster% on the shoulder.%SPEECH_ON%I\'ve no doubt that a mercenary of your skill and prowess would have run clean through the tournament. But I need you here, at camp. You need not prove any lost earnings, I will compensate you for them simply enough.%SPEECH_OFF%The rather diplomatic words calm them down. The mercenary nods and briefly looks as though it would be dishonorable to accept the payment. Not wanting the sellsword to test their resolve any further, or perhaps look a fool or of low honor, you order them to take it.";
			}
		}
	}

	o.onUpdateScore = function () {
		if (this.World.Assets.getMoney() < 500)
			return;

		if (this.World.FactionManager.isGreaterEvil())
			return;

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns ) {
			if (t.isSouthern())
				continue;

			if (t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 1)
			return;

		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getSkills().hasTrait(::Legends.Trait.Player))
				continue;

			if (bro.getLevel() < 4)
				continue;

			if ((bro.getBackground().getID() == "background.adventurous_noble" || bro.getBackground().getID() == "background.disowned_noble" || bro.getBackground().getID() == "background.bastard" || bro.getBackground().getID() == "background.hedge_knight") && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
				candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.Jouster = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 25;
	}
})
