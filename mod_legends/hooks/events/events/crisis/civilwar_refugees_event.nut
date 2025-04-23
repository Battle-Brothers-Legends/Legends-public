::mods_hookExactClass("events/events/crisis/civilwar_refugees_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_59.png[/img]{A true war has plenty of living amongst the casualties and this one is no different: going along a path, you find a large group of refugees huddling together. They were washing themselves in a creek when you discovered them, a party half-naked and half-washed and all-terrified. Mostly women and children, a few elders, and a few men who seem ready to lay down their lives for the rest, no matter how fruitless an effort their defense would be. One such man steps forward.%SPEECH_ON%What is it that you want?%SPEECH_OFF%%aggro_bro% approaches you.%SPEECH_ON%Sir, we could take everything they got, but I\'m sure they won\'t give it up willingly.%SPEECH_OFF%%injured_bro% shakes their head.%SPEECH_ON%I\'d say it ain\'t worth it. These people been through enough as it is and they\'ve little left to give the world.%SPEECH_OFF% | You come across a band of refugees. Women, children, elders, and a scattering of wide-eyed men. They\'ve little of value, but they still have things worth taking were you to put in the effort. | Refugees. A band of them stringed along the path in a long and filed row. At the sight of you, the head of the suffering centipede rears to a stop and all the bodies slowly shuffle together into a fearful blob. %aggro_bro% suggests killing them and taking what they got, although what they got doesn\'t appear to be much at all by your measurement.}";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_59.png[/img]You order your mercenaries to take what they can. The refugees reel back in horror and some protest as your warriors file into their ranks. Suddenly, one of the refugees takes a large stone and bashes %injured_bro% over the head with it. Women and children scream and a few other men grab onto the mercenaries, fighting over weapons still sheathed. But the wandering souls haven\'t eaten in days and their weakened bodies are no match for your men. The %companyname% takes what it wants.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_59.png[/img]You order your mercenaries to take what they can. The refugees reel back in horror. Women cry out, children, more confused than understanding, do the same. Some tearful men beg that you simply leave. Unfortunately for this band of useless tramps, the %companyname% takes what it wants. Your warriors freely sift through the crowds, eventually returning with their hauls.";
			}
			if (s.ID == "D") {
				local startD = s.start;
				s.start <- function (_event) {
					startD(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases"
					});
				}
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_59.png[/img]You decide to weigh on a mercenary who has personal experience as a refugee: %refugee_bro%.\n\nThe mercenary heads into the sobbing and praying mass of weary travelers. Talking with them for a time and sharing some food, friendly gesticulations and tales of %refugee_bro%\'s own past gradually bringing the crowd on side. You watch as an old man hands over something wrapped in sheepskin with leather thongs swooping beneath. The sellsword bows, shakes the man\'s hand, and returns.\n\n Throwing the sheepskin back unveils a sword that glints in the light about as sharply as you can imagine it cuts. %refugee_bro% smiles.%SPEECH_ON%Like me mum always said, a bit of friendliness never hurt nobody, but this sword sure will!%SPEECH_OFF%";
				local startE = s.start;
				s.start <- function (_event) {
					startE(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases"
					});
				}
			}
		}
	}

	o.addLoot = function (_list) {
		local r = this.Math.rand(1, 3);
		local food;

		if (r == 1)
			food = this.new("scripts/items/supplies/dried_fish_item");
		else if (r == 2)
			food = this.new("scripts/items/supplies/ground_grains_item");
		else
			food = this.new("scripts/items/supplies/bread_item");

		_list.push({
			id = 10,
			icon = "ui/items/" + food.getIcon(),
			text = "You gain " + food.getName()
		});
		this.World.Assets.getStash().add(food);
		this.World.Assets.updateFood();

		for (local i = 0; i < 2; i++) {
			r = this.Math.rand(1, 10);
			local item;

			if (r == 1)
				item = this.new("scripts/items/weapons/wooden_stick");
			else if (r == 2)
				item = this.new("scripts/items/weapons/knife");
			else if (r == 3)
					item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]);
			else if (r == 4)
				item = this.new("scripts/items/weapons/woodcutters_axe");
			else if (r == 5)
				item = this.new("scripts/items/shields/wooden_shield_old");
			else if (r == 6)
				item = this.new("scripts/items/weapons/pickaxe");
			else if (r == 7)
				item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.feathered_hat]]);
			else {
				item = this.Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Standard.linen_tunic],
					[1, ::Legends.Armor.Standard.leather_wraps],
					[1, ::Legends.Armor.Standard.tattered_sackcloth],
				]);
			}

			this.World.Assets.getStash().add(item);
			_list.push({
				id = 10,
				icon = "ui/items/" + item.getIcon(),
				text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
			});
		}
	}

	o.onUpdateScore = function () {
		if (!this.World.FactionManager.isCivilWar())
			return;

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
			return;

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates_aggro = [];
		local candidates_other = [];
		local candidates_refugees = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat) || bro.getSkills().hasTrait(::Legends.Trait.Bloodthirsty) || bro.getSkills().hasTrait(::Legends.Trait.Brute))
				candidates_aggro.push(bro);
			else if (bro.getBackground().getID() == "background.refugee")
				candidates_refugees.push(bro);
			else if (!bro.getSkills().hasTrait(::Legends.Trait.Player) && bro.getBackground().getID() != "background.slave")
				candidates_other.push(bro);
		}

		if (candidates_aggro.len() == 0 || candidates_other.len() == 0)
			return;

		this.m.AggroDude = candidates_aggro[this.Math.rand(0, candidates_aggro.len() - 1)];
		this.m.InjuredDude = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_refugees.len() != 0)
			this.m.RefugeeDude = candidates_refugees[this.Math.rand(0, candidates_refugees.len() - 1)];

		this.m.Score = 10;
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function ()
	{
		if (this.Stash.getNumberOfEmptySlots() < 2)
			return;
		onUpdateScore();
	}
})
