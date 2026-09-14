::mods_hookExactClass("contracts/contracts/hold_chokepoint_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"A Vizier can find many uses for a Crownling company it would seem. Such as holding a crumbling ruin in the arse-end of nowhere.",
			"This \'desert fortress\' seems little more than a pile of rubble, yet it seems men are destined to die over it.",
			"There are many ancient ruins amidst the sands, all abandoned long ago and now apparently vital to defend.",
			"Hold a sand-blasted ruin against an invading northern army. For an outrageous fee of course.",
		];
	}

	local createScreens = o.createScreens;
	o.createScreens = function() {
		createScreens();
		foreach (s in this.m.Screens) {
			if (s.ID == "Task") {
				s.Text = "[img]gfx/ui/events/event_162.png[/img]{%employer% is surrounded by his military men. They\'re wearing a great deal of pompous clothes that make you think they\'re a little outside their element taking on war. However, despite the rather feathery appearance, one of the commanders takes you aside with a map and speaks clearly.%SPEECH_ON%Crownling, we need you to travel to an abandoned fortress %direction% from here. We have a wing of soldiers marching to the location, but they will not beat the northern savages to it. Of anyone within reach, you are the closest. Go there and defend until our soldiers show. The fortification is decrepit, but I believe a man of your conniving nature can make do with a bit of rubble if he needs to. %reward% crowns will wait upon your return, and your success, of course.%SPEECH_OFF% | %employer% sits on a pillow with a huge rug spread out before him. Well-dressed lieutenants sit around the corners, each armed with a long wooden stick to push pieces around. And at the length of the rug are a few carpetmakers still adding to the map - as far as you can tell they are adding sections of the north. The Vizier sees you and speaks from a distance.%SPEECH_ON%Crownling, there lies a fort %direction% of here. It is a fallen fortress, made of little more than rubble some say, but the ancients built it there for good reason: it is of great strategic importance. While I have soldiers moving swiftly to its location, they will not arrive before a contingent of northerners do. Unclean savages they are, you have to respect their wile in advancing rapidly. So, I need you to occupy the fortress and hold off the northerners until my armies there.%SPEECH_OFF%He holds up a piece of paper with a number you can understand easily: %reward% crowns. | A very tall man in military garb heads you off from entering %employer%\'s room. The Vizier can be heard mingling with his harem, but that\'s not your business. The lieutenant presses a scroll into your chest.%SPEECH_ON%The ancients built a fortress %direction% from here. It has since fallen apart, weak as all things are to the passage of time, but its location still proves strategic. We are currently moving a troop of soldiers to the location, but our scouts have relayed that the northern dogs are as aware of its import and will beat us there. That is where you come in. %reward% crowns to commandeer the fort and hold it until help arrives. Once relieved, you return to us and earn a good little Crownling\'s pay.%SPEECH_OFF%}";
			}
			if (s.ID == "Success2") {
				s.Text = "[img]gfx/ui/events/event_04.png[/img]{You report to %employer% everything which occurred. A smile slowly goes across the Vizier\'s face.%SPEECH_ON%Goodness, my lieutenants sent you there? That fort is worth nothing. Who would play such a trick? I\'d have the notion to behead the man responsible, but alas, what was it, %reward% crowns? It means nothing to me. I\'ve paid more for a northern jester\'s jake to be told to me in person, and their sense of humor is impoverished at best. Take your gold and depart my premises, Crownling.%SPEECH_OFF% | When you return to %employer%, the Vizier is nowhere to be found. Instead, one of his lieutenants takes you aside and thanks you for your service.%SPEECH_ON%Between us and the mice, and let it be known these words were never spoken, and that there are no mice in these halls, that if I were to have men like you in my ranks I would have temptations of conquests in my heart. Alas, I am given troops as useful to me as the single grains of sand are to the desert. Here is your pay, Crown-, soldier.%SPEECH_OFF%He hands over a purse of %reward% crowns. Another lieutenant starts down the hallway, and the man before you slaps you on the shoulder, his face suddenly without humor or congeniality.%SPEECH_ON%Get out of here, Crownling, that is your pay and we will not hear so much as a single syllable from a haggler\'s tongue!%SPEECH_OFF% | You enter the Vizier\'s halls only to find a lone man sweeping the marbled floors. His broom\'s bristles scratch to a stop on your boot and he looks up.%SPEECH_ON%Ah. They told me a man of your stature would be here.%SPEECH_OFF%He sets the broom down, its handle possibly thicker than his frail frame. He walks over to a table and opens a chest filled with trays of %reward% crowns. You ask how the Viziers would ever trust him with so much coin. The man picks up his broom and laughs.%SPEECH_ON%Were I to steal the crowns for myself, how far would I get? It is heavy. I cannot carry it all. So can I take a little? No. I\'m a man of no material presence. As surely as the Gilder\'s eye blossoms the flower, gold in my palm illuminates me as a thief. I would never get far. This here is my station, and this is yours.%SPEECH_OFF%You take the coin, but then ask how he knows you\'re the right sellsword. His broom scratches to a stop again, and a bead of sweat slowly goes down his cheek. Before he answers, you take the crowns and go. | %employer% is found amongst his council. The rarely seen knot of silk-wearing, beard stroking peoples regard you with contempt. You state loudly that the fort has been held and taken by the southern soldiers. All noise is ceased and your words echo about the marbled halls and every servant stops and the council pauses. %employer% stands up.%SPEECH_ON%Servants, fetch this wagging tongue his coin.%SPEECH_OFF%One of the councilmen spits, which a collared child quickly cleans up.%SPEECH_ON%Should have remitted his pay while he was at the fort. How dare he so much as breathe in this room.%SPEECH_OFF%Servants rush to your side with purses of %reward% crowns. The Vizier waves his hand.%SPEECH_ON%Begone, Crownling. I\'ve persons I hire to dally, and you are not one of them.%SPEECH_OFF%}";
			}
		}
	}

	local spawnAllies = o.spawnAllies;
	o.spawnAllies = function () {
		local f = this.World.FactionManager.getFaction(this.getFaction());
		local party = null;
		f.setSpawnListener(function(entity) {
			party = entity;
		});
		spawnAllies();
		party.getLoot().Money = this.Math.rand(100, 300);
		party.getLoot().ArmorParts = this.Math.rand(10, 35);
		party.getLoot().Medicine = this.Math.rand(5, 15);
		party.getLoot().Ammo = this.Math.rand(10, 40);
		local r = this.Math.rand(1, 4);
		local arr = ["trade/silk_item", "trade/silk_item", "trade/incense_item", "trade/spices_item"];
		for(local i = 0; i < this.Math.round(r/2); i++) //adds either 1 silk, 1 silk, 2 incense, 2 spices
			party.addToInventory(arr[r-1]);
	}
});
