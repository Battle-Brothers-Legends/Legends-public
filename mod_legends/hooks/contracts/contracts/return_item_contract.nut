::mods_hookExactClass("contracts/contracts/return_item_contract", function(o)
{
	o.m.StolenItemNames <- [
		"Rare Coin Collection",
		"Ceremonial Staff",
		"Idol of Fertility",
		"Golden Talisman",
		"Tome of Arcane Knowledge",
		"Ornate Lockbox",
		"Demonic Statuette",
		"Crystal Skull",
		"Golden Goose",
		"Bronze Bust",
		"Rune Engraved Chest",
		"Silver Bracelet",
		"Moonstone Circlet",
		"Jewelled Hairbrush",
		"Erotic Taxidermy Collection",
		"Luxury Stuffed Hyena",
		"Stollwurm Scales",
		"Ancient Crown",
		"Enchanted Dagger",
		"Prized Owlcat",
		"Pedigree Hound",
		"Exotic Hairless Cat",
		"Tattered Warbanner",
		"Fingerbones of St Cicero",
		"Famed Butterfly Collection",
		"Necromancy Amulet",
		"Monkey Paw",
		"Dragon Orb",
		"Black Book of Magick",
		"Sapphire Brooch",
		"Amber Wristguards",
		"Glass Warbow",
		"Mechanical Bird",
		"Pale Warhorn",
		"Leviathan Fang",
		"Exotic Spice Box",
		"Onyx Lifestone",
		"Chaos Emerald",
		"Phoenix Feather",
		"Ebonwood Harp",
		"Ice Tribe Flute",
		"Haunted Vase",
		"Legendary Brandy",
		"Bad Tempered Parrot",
		"Crested Signet Ring",
		"Blood Chalice",
		"Moonstone Amulet",
		"Grimoire of the Rat",
		"Orb of Whispers",
		"Antique Book of Bloodlines",
		"Embroidered Tapestry",
		"Skull of Lady Rosalia",
		"Family Portrait",
		"Vintage Wine Collection",
		"Golden Snuffbox",
		"Silver Sword",
		"Ancestral Helm",
		"Dragon Tears Elixir",
		"Stuffed Bear",
		"Mask of Masquerade",
		"Forbidden Book Collection",
		"Heraldic Banner",
		"Masterpiece Painting",
		"Lady Gwendoline\'s OnlyScrolls",
		"Neolithic Pig-Shaped Pot",
		"Jewelled Chamber Pot",
		"Gold-Plated Chamber Pot with Heraldic Lions",
		"Fabulous Direwolf Cloak",
		"Fashionable Hyena-Fur Waistcoat",
		"Ceremonial Fox-Fur Slippers",
		"Black Ledger of Coin",
		"Ser Alric\'s Signet Ring",
		"Ironbound Chest of Tithes",
		"Crimson Banner of Westwatch",
		"Guildmaster\'s Seal",
		"War Medallion",
		"Bloodstained Letter",
		"Ivory Dice",
		"Book of Debts",
		"Favorite Hunting Falcon",
		"Exquisite Pet Peacock",
		"Tattered Map of the Southern Road",
		"Knight Tournament Spurs",
		"Velvet Hat of Twenty Feathers",
		"Gold-Plated Duck Decoy",
		"Marble Bust of Himself (twice life-size)", 
		"Silver-Filigree Wig Stand",
		"Golden Tournament Goblet",
		"Engraved Whalebone Snuffbox",
		"Silken Banner",
		"Emerald-Handled Toothpick",
		"Gilded Astrological Chart",
		"Bronze Indoor Sun-Dial",
		"Decorative Jousting Lance",
		"Lady Tilda\'s Perfume Chest",
		"Lady Helgwyn\'s Collection of Rare Imported Soaps",
		"Personal Portrait of the Late Duchess",
		"A Nobleman/'s Guide to Writing Romantic Poetry",
		"Ornamental Boar Spear",
		"Silver-Gilt Chamberstick",
		"Antique Rosewood Pipe",
		"Treaty of Shimmerlake",
		"Folded Letters of Blackmail",
		"Crest of Nobility", 
		"Last Will and Testament of Dame Hennel",
		"Leather-Bound Book of Forgotten Tithes",
		"Whispering Locket",
		"Polished Riding Spurs",
		"Antique Map of Feudal Holdings",
		"Highly-polished Brass Armor",
		"Silver Hunting Horn",
		"Wax-Sealed Military Orders",
		"Knightly Silk Sash",
		"Nobleman's Illustrated Guide to Horse Fashion",
		"Stuffed Weasel, Lord Whiskerford",
		"Luxury Monogrammed Bathrobe",
		"Wine Bottle of Rare Vintage",
		"Arcane Signet",
		"Intimate Portrait of a Mistress",
		"Heirloom Blade",
		"Gilded Wedding Invitation"
	];
	
	local create = o.create;
	o.create = function()
	{
		create();
		local orig = this.getDifficultyMult();
		if (this.getDifficultyMult() >= 1.45 && this.getDifficultyMult() <= 1.65) //lazy man's tweak to make the 4 skull return item contract a bit harder
		{
			local dm = this.Math.rand(155, 175) * 0.01;
			this.m.DifficultyMult = (dm > orig) ? dm : orig
		}

		this.m.DescriptionTemplates = [
			"Brigands have stolen the %s from his lordship. He wants it back.",
			"Some dastards have stolen the famed %s!",
			"Follow the tracks, return the stolen %s.",
			"Thieves have made off with the %s!",
			"Devious fraudsters have stolen quite the item from a local lord.",
			"Some thieves have stolen the %s from a noble lord, who is frankly astonished at their audacity.",
			"A local lord woke up to find his %s display case was emptier than a bard\'s promise.",
			"A local lord discovered his cherished %s has vanished after hosting a banquet.",
			"A noble lord is flabbergasted to find his cherished %s missing. He wants it found.",
			"His wife\'s cherished %s has been stolen. This nobleman needs you to track it down or he\'ll never hear the end of it.",
			"Enterprising thieves have made off with the %s, seeking to make a fortune.",
			"Some scoundrels have pulled off quite the daring heist of his lordships private quarters.",
			"A most urgent matter concerning his lordships private collection has arisen...",
			"The prized %s has been stolen from his lordship by moonlight. Track down the thief for a reward.",
			"The %s has been stolen from under the nose of this lordship. Venture forth to reclaim it.",
			"A noble lord has what he terms a \'fetch\' quest for you to retrieve his missing %s.",
			"Find the thieves, kill them if you want, just bring back the %s.",
			"Reclaim the stolen %s before it falls into the wrong hands.",
			"Hunt down some thieves to claim the reward and gratitude of the local ruler.",
			"Recover the stolen %s for his lordship and you may earn his gratitude.",
			"Track down some local thieves and kill them all to set an example to others.",
			"Stealing from nobility is a crime punishable by death. Today you are the appointed executioner.",
			"Given his dreadful reputation, you are amazed anyone had the stones to steal from his lordship in the first place.",
			"In the name of our lordship, pursue the thieves and reclaim what is rightfully his.",
			"His lordship\'s honor is at stake! Hunt down the thieves and return the stolen %s swiftly.",
			"Pursue the thieves and recover the stolen %s with utmost haste. Their lives matter not.",
			"Pursue the footpads and bring back the missing %s directly to his lordship. No-one else.",
			"Track down the thieves and ensure the stolen %s is returned to its rightful owner.",
			"Seek out the knaves and restore the stolen %s to the noble lord\'s estate.",
			"In service to the local ruler, recover a stolen artifact and kill the thieves responsible.",
			"The %s has been stolen from his lordships chambers!",
			"The local ruler has taken the theft of his %s rather badly. Find and kill everyone involved.",
			"Those varlets! Those ruffians! Return his lordships %s at once!",
			"You had better return the stolen %s, lest his lordships ego never recover."
		];
	}

	// Ran when we actually add the contract
	o.formatDescription <- function ()
	{
		if (!this.m.Flags.has("Item"))
			this.m.Flags.set("Item", ::MSU.Array.rand(this.m.StolenItemNames));

		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = format(r, ::Const.UI.getColorized(this.m.Flags.get("Item"), ::Const.UI.Color.getHighlightLightBackgroundValue()));

		this.m.Description = r;
	}

	o.start = function ()
	{
		this.m.Payment.Pool = 400 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		if (!this.m.Flags.has("Item"))
			this.m.Flags.set("Item", ::MSU.Array.rand(this.m.StolenItemNames));

		this.contract.start();
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
				s.Text = "[img]gfx/ui/events/event_20.png[/img]{%employer% restlessly walks back and forth while explaining what troubles %them_employer%.%SPEECH_ON%There has been an audacious act of thievery! The despicable brigands stole my %itemLower% which is of immeasurable value to me. I implore you to hunt down those thieves and return that item to me.%SPEECH_OFF%%They_employer% lowers %their_employer% voice to an insisting tone.%SPEECH_ON%Not only will you get paid handsomely, but you would also set the worried minds of the good people of %townname% to rest!%SPEECH_OFF% | %employer%\'s reading one of many scrolls. %They_employer% angrily tosses it onto a pile of others.%SPEECH_ON%The people of %townname% are rightfully furious. Do you know a brigand, possibly in league with other vagabonds, managed to steal my %itemLower% from us? That artifact is of immeasurable value to me! And... to the people, of course.%SPEECH_OFF%You shrug.%SPEECH_ON%And you want me to get it back for you?%SPEECH_OFF%The %person_employer% points a finger.%SPEECH_ON%Precisely, smart sellsword! That is exactly what I want you to do. Follow the footprints of thievery and return to me the item which I... the town, rightfully owns!%SPEECH_OFF% | %employer%\'s turning an apple in hand. %They_employer% seems frustrated with it, almost as if %they_employer% wishes it were something else like a valuable trinket or perhaps just a tastier fruit.%SPEECH_ON%Have you ever lost something you loved?%SPEECH_OFF%You shrug and answer.%SPEECH_ON%There was this girl...%SPEECH_OFF%The %person_employer% shakes %their_employer% head.%SPEECH_ON%No, not some woman. More important. Because I have! Thieves stole my %itemLower%. How they managed to do get beyond my guards is, well, beyond me. But I know if I set you on them I\'ll be having what is rightfully mine back where it belongs. Isn\'t that right? Or have I been mislead as to the quality of your services?%SPEECH_OFF% | A dog is snoring at the feet of %employer%. %They_employer% leans forward to gently pet the hound behind its ears.%SPEECH_ON%I hear you have a nose for finding people, sellsword. For... solving problems.%SPEECH_OFF%You nod. It is true, after all.%SPEECH_ON%Good... good... I have a task for you. A simple one. Something of great value to me has been stolen, my %itemLower%. I need you to track down those who stole it, kill them, obviously, and then bring back the item.%SPEECH_OFF% | A bird is perched on %employer%\'s window. The %person_employer%, seated, points at it.%SPEECH_ON%I wonder if that\'s how they got in. The brigands, I mean. I think they must\'ve snuck through a window and then right back out. That\'s how they got away with my %itemLower%.%SPEECH_OFF%The %person_employer% slowly rises and stalks across the room. %They_employer% crouches, about ready to pounce on the bird, but the creature scatters before the %person_employer% can so much as flinch.%SPEECH_ON%Damn.%SPEECH_OFF%%They_employer% returns to %their_employer% seat, wiping %their_employer% hands as if %they_employer%\'d worked up a sweat during %their_employer% attempted avian ambush.%SPEECH_ON%My task is simple, sellsword. Bring my property back to me. Kill the brigands, too, if you wouldn\'t mind.%SPEECH_OFF% | Dust covers %employer%\'s table, but there is a spot oddly cleaner than the rest. %They_employer% gestures to it.%SPEECH_ON%That\'s where my %itemLower% used to sit. If you couldn\'t tell, it\'s gone.%SPEECH_OFF%You nod. It does appear to be missing.%SPEECH_ON%The thieves who took it should be easy to track down. They\'re good thinkers in the night, those brigands, but they make mistakes aplenty during the day. Footprints, crowns ill-spent... you should be able to track them down with ease.%SPEECH_OFF%%They_employer% looks at you with a stern eye.%SPEECH_ON%Do you understand, mercenary? I want you to get my property back. I want it placed right where it belongs. And... I want those thieves dead in the mud.%SPEECH_OFF%}";
			}
			if (s.ID == "CounterOffer1")
			{
				s.Options = [
					{
						Text = "I know a good deal when I see one. Hand over the crowns.",
						function getResult()
						{
							this.updateAchievement("NeverTrustAMercenary", 1, 1);
							return "CounterOffer2";
						}

					},
					{
						Text = "We\'re paid %reward_completion% to return it, and that\'s what we\'ll do.",
						function getResult()
						{
							this.Contract.setState("Return");
							return 0;
						}

					}
				];
				s.Text = "[img]gfx/ui/events/event_76.png[/img]{You clean the blood off your sword and then go to retrieve the item. As you bend over to pick it up, you spot a man watching you in the distance. He comes forth, his two hands totemed together with long sleeves.%SPEECH_ON%I see you\'ve killed my benefactor\'s men.%SPEECH_OFF%Sheathing your sword, you nod at the man. He continues.%SPEECH_ON%My benefactor paid good money for that artifact. It appears those he paid are no longer owed, so maybe I can speak to you directly. I will give you %bribe% crowns for the item.%SPEECH_OFF%That... is a good amount of money. %employer%, however, will not be happy if you decide to accept... | After the battle, a man emerges from a tree line, clapping his hands together.%SPEECH_ON%I paid those men a great deal of crowns, but it appears I should have paid you. And now that all these skeevy brigands are dead, I can!%SPEECH_OFF%You tell the man to get to the point before you run him through with a sword. He gestures toward the artifact.%SPEECH_ON%I\'ll pay you %bribe% crowns (originally %reward_completion% crowns) for the item. It was what was originally owed to these thieves, plus a little more. What do you say?%SPEECH_OFF%%employer% won\'t take kindly to your betrayal, but that is a good bit of money... | The battle over, you pick up the %itemLower% and look it over. Was this really worth the lives of so many people?%SPEECH_ON%I know what you\'re thinking, sellsword.%SPEECH_OFF%The voice breaks in. You draw your sword and aim it at a stranger who has seemingly appeared from nowhere.%SPEECH_ON%You\'re thinking, what if someone paid good money to steal that there artifact? What if that someone would pay me a good deal of money? Perhaps... more than the man who paid you to retrieve it in the first place.%SPEECH_OFF%You lower your weapon and nod.%SPEECH_ON%An interesting thought.%SPEECH_OFF%The man smiles.%SPEECH_ON%%bribe% crowns (originally %reward_completion% crowns). That\'s how much I\'ll give you for it. That was the thieves\' share plus extra. A more than fair deal. Of course, your employer will be most unhappy, but... well, that\'s not my choice to make.%SPEECH_OFF%}";
			}
			if (s.ID == "BattleDone") {
				s.Text = "[img]gfx/ui/events/event_22.png[/img]{The battle over, you retrieve the %itemLower% from the wasted clutches of your enemies and prepare to return to %employer%. %They_employer% will surely be happy to see of your success! | Those who stole the %itemLower% are dead, and thankfully you were able to find the item itself. %employer% will be most pleased with your work here. | Well, you found those responsible for stealing the %itemLower% and put them to the sword. Now you just need to put the %itemLower% back into %employer%\'s hands and get your reward! | The battle is done and the %itemLower% was easy to find amongst the corpses of your enemies. You should probably return it to %employer% for your just reward!}";
			}
			if (s.ID == "Success1") {
				s.Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% takes the %itemLower% from you, hugging it close as though %they_employer%\'d retrieved a lost child. %Their_employer% eyes get a little teary just looking at %their_employer% artifact.%SPEECH_ON%Thank you, sellsword. This means a lot to me... I mean, uh, the town. You have our gratitude!%SPEECH_OFF%%They_employer% pauses as you stare at %them_employer%. %Their_employer% eyes bounce to a corner of the room.%SPEECH_ON%Our... gratitude, sellsword...%SPEECH_OFF%A large wooden chest is opened by a guard. You count the crowns and go. | When you return to %employer%, %they_employer% is playing with a bird in a cage.%SPEECH_ON%Ah, the sellsword returns... and?%SPEECH_OFF%You hold up the artifact and then set it on %their_employer% desk. %They_employer% takes it, turns it, nods, then puts it away.%SPEECH_ON%Excellent. And for your troubles...%SPEECH_OFF%%They_employer% waves %their_employer% hand to a wooden chest filled with crowns. | %employer%\'s resting %their_employer% legs on two dogs, each one passed out atop the other.%SPEECH_ON%These beasts could rip my throat out, yet... look at them. How does that happen? I didn\'t even train them. Someone else did. I\'m a stranger to them yet there they are.%SPEECH_OFF%You place the artifact on the %person_employer%\'s table and slide it across. %They_employer% leans forward, takes it, then places it under %their_employer% desk. When %their_employer% hand returns, %they're_employer% got a satchel in hand. %They_employer% tosses it over.%SPEECH_ON%As promised. Good work, sellsword.%SPEECH_OFF% | When you enter %employer%\'s room, there are a host of guards surrounding %them_employer%. For a second, you think you\'ve stumbled upon a coup, but the men clear out, leaving behind dice and cards. %employer% waves you in.%SPEECH_ON%Come, come. I just lost a good deal of crowns, sellsword. Perhaps you\'ve brought something to help ease my pains...?%SPEECH_OFF%You take out the %itemLower% and hold it in your hand. Rather gingerly, the %person_employer% takes it.%SPEECH_ON%Good... very good... your pay, of course, is here.%SPEECH_OFF%%They_employer% hands over a satchel of crowns before turning around in %their_employer% chair. %They_employer% seems too consumed by the artifact to say anything else. | %employer% grins as you enter.%SPEECH_ON%Sellsword, sellsword, will you sell me word of your success?%SPEECH_OFF%You take out the artifact and place it on %their_employer% table.%SPEECH_ON%Sure.%SPEECH_OFF%The %person_employer% jolts forward in his chair and takes the item away. %They_employer% turns back to you, calming %themselves_employer% returning %their_employer% composure.%SPEECH_ON%Good. You did good. Very good. %reward_completion% crowns, as promised.%SPEECH_OFF%%They_employer% hands over a sack of coins.}";
			}
			if (s.ID == "Failure1")
			{
				s.Text = "[img]gfx/ui/events/event_75.png[/img]{You lower yourself to the earth, letting some dirt filter through your fingers. But it is only dirt - there are no footprints that have crossed its path. In fact, you haven\'t seen any footprints in a good while. %randombrother% joins you, crouching low and shrugging.%SPEECH_ON%Sir, I think we lost \'em.%SPEECH_OFF%You nod. %employer% won\'t be happy about this, but it is what it is. | You\'ve been following the trail of the stolen %itemLower% for a good while now, but the leads have dried up. The commoners you pass know nothing, and the earth shows no footprints with which to track. For all intents and purposes, the %itemLower% is gone. %employer% will not be pleased. | A footprint left long enough is soon stepped on by another. And another. And another. You spent so long catching up to the thieves who stole the %itemLower% that the circuitry of the world, ever busy, has covered their tracks. You\'ve no hope of finding them now and %employer% will be most displeased. | The tracks of the %itemLower%\'s thieves have gone dry. The last set of footprints you followed took you to a homestead, and they didn\'t look like the thieving sort, nor did they know of any such fellows. %employer% won\'t be happy about the loss of his goods, but there\'s little you can do here now.}"
			}
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
			}
		}
	}
});
