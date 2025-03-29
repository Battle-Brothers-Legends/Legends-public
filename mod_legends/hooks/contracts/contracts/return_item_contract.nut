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
		"Lady Gwendoline\'s OnlyScrolls"
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
			if (s.ID == "Failure1")
			{
				s.Text = "[img]gfx/ui/events/event_75.png[/img]{You lower yourself to the earth, letting some dirt filter through your fingers. But it is only dirt - there are no footprints that have crossed its path. In fact, you haven\'t seen any footprints in a good while. %randombrother% joins you, crouching low and shrugging.%SPEECH_ON%Sir, I think we lost \'em.%SPEECH_OFF%You nod. %employer% won\'t be happy about this, but it is what it is. | You\'ve been following the trail of the stolen %itemLower% for a good while now, but the leads have dried up. The commoners you; pass know nothing, and the earth shows no footprints with which to track. For all intents and purposes, the %itemLower% is gone. %employer% will not be pleased. | A footprint left long enough is soon stepped on by another. And another. And another. You spent so long catching up to the thieves who stole the %itemLower% that the circuitry of the world, ever busy, has covered their tracks. You\'ve no hope of finding them now and %employer% will be most displeased. | The tracks of the %itemLower%\'s thieves have gone dry. The last set of footprints you followed took you to a homestead, and they didn\'t look like the thieving sort, nor did they know of any such fellows. %employer% won\'t be happy about the loss of his goods, but there\'s little you can do here now.}"
			}
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
			}
		}
	}
});
