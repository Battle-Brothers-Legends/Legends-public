::Legends.CampContracts <- {
	EmployerFaction = {
		Barbarians = 0,
		Bandits = 1,
		Necromancers = 2
	}
}

::Legends.CampContracts.IntroBarbarians <- [{
	ID = "Intro",
	Title = "Negotiations",
	Text = "[img]gfx/ui/events/event_20.png[/img]{A man surprises you by sliding into your shoulder. You just about draw your sword when he quickly explains that a man by the name of %employer% has sought your acquaintance. Sheathing your weapon, you tell the stranger to take you to him - if he\'s got business, he should tell you himself. The messenger nods and leads the way to a nobleman\'s house. | A messenger - a young lad about as tall as a longsword - sprints by you, throwing a scroll into the air as he swings past. You catch it, but by the time you can look for the kid he\'s already gone. Shrugging, you open the scroll and find the name of %employer%. He appears to be in need of your services. Directions to a nobleman\'s house tag the bottom of the scroll. | While walking about %townname%, a messenger eases up next to you. A glance at him has the poor guy throwing a scroll into your hands before running off. You open up to see that a local nobleman has requested your audience. | %townname% seems peaceful enough, but something must be going wrong because a messenger comes to you with a notice from a local nobleman. And where there\'s riches, there\'s trouble... | A messenger greets you. He names himself as someone forgettable, because you instantly forget his name. However, his information is quite important: a local nobleman has requested your audience. | A bird flies to your shoulder and plants itself there. It coos at you, then gestures towards its feet where a notice has been rolled up. The second you take the message, the bird is off, no friend of anything but its own delivery services. Reading the note reveals that a local nobleman, and presumed friend of the aviary critters, has requested your audience. | A leashed dog runs up to you with a whole lotta barking. The man at the end of the leash nods toward the canine. You see a scroll hooked to its collar, the beast some sort of messenger mongrel. That or someone is having a bit of a laugh.\n\n Taking the note, you read that a local nobleman has requested your services. Maybe it\'s not a joke after all. The dog simply barks again and wags its tail, sitting dutifully and looking rather accomplished. | A straight-backed man walks toward you. He\'s got a scroll in a lifted arm, approaching you like a message board on stilts. He says nothing, merely extends his arm and you merely take the message as you\'re gestured to do. It reads that a local nobleman is looking for you and presumably your services. You thank the messenger, but he says nothing, simply turning and stilting his way down the road. | While walking down %townname%\'s road, a few men cry out from a local tavern, howling with laughter as they wave you over. Snickering and doubling over, they can barely spit out their news: apparently some nobleman has been looking for a sellsword. Interesting, but you can\'t help but ask why they were laughing. The men go silent for a moment and one shrugs while another coughs out an answer.%SPEECH_ON%Because we\'re drunk?%SPEECH_OFF%The men keep a strained set of straight faces for but a second longer before bursting into laughter once more. | A servant of a local noble asks you to follow him on his master\'s behest. He leads you into the wealthier part of %townname%, where the buildings get taller and the people streets don\'t reek of horse manure. Eventually you reach a manor that looks as if it used to be a temple. Fake owls dot the eaves, staring you down as you walk by. A depressed-looking cat idles on the front steps. You enter through a front door that squalls with opulence, its hinges and wide swing echoing into the foyer. Your mouth drops open as you hardly even know the words to describe the grandeur inside.}",
	Image = "",
	List = [],
	ShowEmployer = false,
	ShowDifficulty = true,
	Options = [
		{
			Text = "Let\'s talk business.",
			function getResult() {
				return "Task";
			}
		}
	]
}];

::Legends.CampContracts.IntroBandits <- [{
	ID = "Intro",
	Title = "Negotiations",
	Text = "[img]gfx/ui/events/event_20.png[/img]{A man surprises you by sliding into your shoulder. You just about draw your sword when he quickly explains that a man by the name of %employer% has sought your acquaintance. Sheathing your weapon, you tell the stranger to take you to him - if he\'s got business, he should tell you himself. The messenger nods and leads the way to a nobleman\'s house. | A messenger - a young lad about as tall as a longsword - sprints by you, throwing a scroll into the air as he swings past. You catch it, but by the time you can look for the kid he\'s already gone. Shrugging, you open the scroll and find the name of %employer%. He appears to be in need of your services. Directions to a nobleman\'s house tag the bottom of the scroll. | While walking about %townname%, a messenger eases up next to you. A glance at him has the poor guy throwing a scroll into your hands before running off. You open up to see that a local nobleman has requested your audience. | %townname% seems peaceful enough, but something must be going wrong because a messenger comes to you with a notice from a local nobleman. And where there\'s riches, there\'s trouble... | A messenger greets you. He names himself as someone forgettable, because you instantly forget his name. However, his information is quite important: a local nobleman has requested your audience. | A bird flies to your shoulder and plants itself there. It coos at you, then gestures towards its feet where a notice has been rolled up. The second you take the message, the bird is off, no friend of anything but its own delivery services. Reading the note reveals that a local nobleman, and presumed friend of the aviary critters, has requested your audience. | A leashed dog runs up to you with a whole lotta barking. The man at the end of the leash nods toward the canine. You see a scroll hooked to its collar, the beast some sort of messenger mongrel. That or someone is having a bit of a laugh.\n\n Taking the note, you read that a local nobleman has requested your services. Maybe it\'s not a joke after all. The dog simply barks again and wags its tail, sitting dutifully and looking rather accomplished. | A straight-backed man walks toward you. He\'s got a scroll in a lifted arm, approaching you like a message board on stilts. He says nothing, merely extends his arm and you merely take the message as you\'re gestured to do. It reads that a local nobleman is looking for you and presumably your services. You thank the messenger, but he says nothing, simply turning and stilting his way down the road. | While walking down %townname%\'s road, a few men cry out from a local tavern, howling with laughter as they wave you over. Snickering and doubling over, they can barely spit out their news: apparently some nobleman has been looking for a sellsword. Interesting, but you can\'t help but ask why they were laughing. The men go silent for a moment and one shrugs while another coughs out an answer.%SPEECH_ON%Because we\'re drunk?%SPEECH_OFF%The men keep a strained set of straight faces for but a second longer before bursting into laughter once more. | A servant of a local noble asks you to follow him on his master\'s behest. He leads you into the wealthier part of %townname%, where the buildings get taller and the people streets don\'t reek of horse manure. Eventually you reach a manor that looks as if it used to be a temple. Fake owls dot the eaves, staring you down as you walk by. A depressed-looking cat idles on the front steps. You enter through a front door that squalls with opulence, its hinges and wide swing echoing into the foyer. Your mouth drops open as you hardly even know the words to describe the grandeur inside.}",
	Image = "",
	List = [],
	ShowEmployer = false,
	ShowDifficulty = true,
	Options = [
		{
			Text = "Let\'s talk business.",
			function getResult() {
				return "Task";
			}
		}
	]
}];

::Legends.CampContracts.IntroNecromancers <- [{
	ID = "Intro",
	Title = "Negotiations",
	Text = "[img]gfx/ui/events/event_20.png[/img]{A man surprises you by sliding into your shoulder. You just about draw your sword when he quickly explains that a man by the name of %employer% has sought your acquaintance. Sheathing your weapon, you tell the stranger to take you to him - if he\'s got business, he should tell you himself. The messenger nods and leads the way to a nobleman\'s house. | A messenger - a young lad about as tall as a longsword - sprints by you, throwing a scroll into the air as he swings past. You catch it, but by the time you can look for the kid he\'s already gone. Shrugging, you open the scroll and find the name of %employer%. He appears to be in need of your services. Directions to a nobleman\'s house tag the bottom of the scroll. | While walking about %townname%, a messenger eases up next to you. A glance at him has the poor guy throwing a scroll into your hands before running off. You open up to see that a local nobleman has requested your audience. | %townname% seems peaceful enough, but something must be going wrong because a messenger comes to you with a notice from a local nobleman. And where there\'s riches, there\'s trouble... | A messenger greets you. He names himself as someone forgettable, because you instantly forget his name. However, his information is quite important: a local nobleman has requested your audience. | A bird flies to your shoulder and plants itself there. It coos at you, then gestures towards its feet where a notice has been rolled up. The second you take the message, the bird is off, no friend of anything but its own delivery services. Reading the note reveals that a local nobleman, and presumed friend of the aviary critters, has requested your audience. | A leashed dog runs up to you with a whole lotta barking. The man at the end of the leash nods toward the canine. You see a scroll hooked to its collar, the beast some sort of messenger mongrel. That or someone is having a bit of a laugh.\n\n Taking the note, you read that a local nobleman has requested your services. Maybe it\'s not a joke after all. The dog simply barks again and wags its tail, sitting dutifully and looking rather accomplished. | A straight-backed man walks toward you. He\'s got a scroll in a lifted arm, approaching you like a message board on stilts. He says nothing, merely extends his arm and you merely take the message as you\'re gestured to do. It reads that a local nobleman is looking for you and presumably your services. You thank the messenger, but he says nothing, simply turning and stilting his way down the road. | While walking down %townname%\'s road, a few men cry out from a local tavern, howling with laughter as they wave you over. Snickering and doubling over, they can barely spit out their news: apparently some nobleman has been looking for a sellsword. Interesting, but you can\'t help but ask why they were laughing. The men go silent for a moment and one shrugs while another coughs out an answer.%SPEECH_ON%Because we\'re drunk?%SPEECH_OFF%The men keep a strained set of straight faces for but a second longer before bursting into laughter once more. | A servant of a local noble asks you to follow him on his master\'s behest. He leads you into the wealthier part of %townname%, where the buildings get taller and the people streets don\'t reek of horse manure. Eventually you reach a manor that looks as if it used to be a temple. Fake owls dot the eaves, staring you down as you walk by. A depressed-looking cat idles on the front steps. You enter through a front door that squalls with opulence, its hinges and wide swing echoing into the foyer. Your mouth drops open as you hardly even know the words to describe the grandeur inside.}",
	Image = "",
	List = [],
	ShowEmployer = false,
	ShowDifficulty = true,
	Options = [
		{
			Text = "Let\'s talk business.",
			function getResult() {
				return "Task";
			}
		}
	]
}];
