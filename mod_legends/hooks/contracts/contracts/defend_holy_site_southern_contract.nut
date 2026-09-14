::mods_hookExactClass("contracts/contracts/defend_holy_site_southern_contract", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.DescriptionTemplates = [
			"Northern soldiers are seeking to conquer a place sacred in the Eye of the Gilder. Such heresy cannot be allowed.",
			"Northern rats are coming to defile a sacred place with their presence. The South will pay well to defend it.",
			"The Gilder faithful are edging to mass hysteria at the blasphemy of possibly yielding a revered holy site to the North. This should pay well.",
			"Southern faith demands the defence of all holy places, even if that means hiring heathen crownlings to do so.",
		];
	}

	local createScreens = o.createScreens;
	o.createScreens = function () {
		createScreens();
		::Legends.Screens.hook(this, "Task", function (_screen) {
			_screen.Title = "Defend Holy Site";
		});
		::Legends.Screens.hook(this, "Preparation3", function (_screen) {
			_screen.start <- function () {
				for (local i = 0; i < 2; i = ++i) {
					local r = ::Math.rand(1, 12);
					local item;

					switch (r) {
						case 1:
							item = this.new("scripts/items/weapons/oriental/saif");
							break;

						case 2:
							item = this.new("scripts/items/tools/throwing_net");
							break;

						case 3:
							item = this.new("scripts/items/weapons/oriental/polemace");
							break;

						case 4:
							item = this.new("scripts/items/weapons/ancient/broken_ancient_sword");
							break;

						case 5:
							item = this.Const.World.Common.pickArmor([
								[1, ::Legends.Armor.Ancient.ancient_mail],
							]);
							break;

						case 6:
							item = this.new("scripts/items/supplies/ammo_item");
							break;

						case 7:
							item = this.new("scripts/items/supplies/armor_parts_item");
							break;

						case 8:
							item = this.new("scripts/items/shields/ancient/tower_shield");
							break;

						case 9:
							item = this.new("scripts/items/loot/ancient_gold_coins_item");
							break;

						case 10:
							item = this.new("scripts/items/loot/silver_bowl_item");
							break;

						case 11:
							item = this.new("scripts/items/weapons/wooden_stick");
							break;

						case 12:
							local helmet = [
								[1, ::Legends.Helmet.Southern.spiked_skull_cap_with_mail]
							];
							item = ::Const.World.Common.pickHelmet(helmet);
							break;
					}

					if (item.getConditionMax() > 1) {
						item.setCondition(::Math.max(1, item.getConditionMax() * ::Math.rand(10, 50) * 0.01));
					}

					::World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						imageOverlayPath = item.getIconOverlay(),
						text = "You gain " + item.makeName()
					});
				}

				local amount = ::Math.rand(10, 30);
				::World.Assets.addArmorParts(amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_supplies.png",
					text = "You gain [color=%positiveEvent%]+" + amount + "[/color] Tools and Supplies."
				});
			}
		});
		::Legends.Screens.hook(this, "SallyForth3", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_90.png[/img]{You finish off the last of the soldiers, the look of surprise still grimly shaped across their faces.%SPEECH_ON%Captain, got the rest coming.%SPEECH_OFF%%randombrother% says, returning from a quick gaze of the horizon. Nodding, you order the men to get ready. This time, the northerners are making an approach in good formation, though it briefly waivers at the sight of you and the dead littered about your feet. Their banner rises into the sky and the northerners are revivified, charging forth with anger and energy. You look down at %randombrother% and brush a piece of organ off %their_randombrother% shoulder. When %they_randombrother% looks back you simply smile.%SPEECH_ON%The fun\'s here, you should look nice for it.%SPEECH_OFF%}";
		});
		::Legends.Screens.hook(this, "SallyForth5", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/%illustration%.png[/img]{You figure it\'s best to man the defenses. It might let an opportunity slip, but it is in part the safest of all available options.%SPEECH_ON%Shoulda went out. We missed something there on that one, captain.%SPEECH_OFF%Looking over you find %randombrother% shrugging. You tell %them_randombrother% to mind %their_randombrother% tongue, or %they_randombrother%\'ll be missing something %themselves_randombrother%.}";
		});
		::Legends.Screens.hook(this, "Success", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% is found in a small priory far from %their_employer% palace. It is an unusual place to find %them_employer%, and there\'s but a small crowd of impoverished followers at %their_employer% feet, listening as %they_employer% speaks. The Vizier glances at you, and then, mid-talk, nods at someone else. A moment later, a bearded man with two swords approaches. He looks you up and down, then moves aside to reveal two servants carrying a chest.%SPEECH_ON%The Vizier wishes to thank you Crownling. And may you forever travel the Gilded path.%SPEECH_OFF%Of course, you\'re ushered right back out the moment the money is transferred. Not so much as a nod or wave comes from the Vizier as the doors close behind you. | You are led down a long hall and are brought to an empty room. For a moment, you wonder if you are meant to be betrayed here. Betrayals rarely come in places where a mess would be unwanted. While you stare at the clean stone flooring, %employer% enters from the opposite side. %They_employer% stands many feet away and the room echoes %their_employer% voice.%SPEECH_ON%It is said that you fought well, and that the northerners proved themselves shrill dogs in battle. I imagine this latter statement is an untruth meant to induce my personal happiness. But I am a thinker and a realist. I imagine you found the enemy\'s determination to be quite formidable, just as they would ours. You will be rewarded our agreed price, Crownling.%SPEECH_OFF%A group of men suddenly file into the room behind the Vizier and, again, you wonder if they are meant there for another purpose entirely. Much to your relief, they carry with them purses of coin. When you look back toward the door, %employer% is gone and a moment later %their_employer% servants are gone as well. | %employer% welcomes you into a room with %themselves_employer% and a few select religious figures. Each of these modest priors comes and briefly bows before you. The Vizier does not partake, but %they_employer% does snap %their_employer% fingers and %their_employer% servants lug over a large chest of crowns. Finally, the religious men now turn to the Vizier and in a similar procession bow before %them_employer%. They also kiss %their_employer% feet and a ring, things not on the docket for yourself. %employer% speaks.%SPEECH_ON%My path has been ever gilded, Crownling. For the Gilder to bestow upon me such knowledge that you, a modest sellsword many would overlook, should be the one I hire to spare %holysite%. I am blessed. Truly.%SPEECH_OFF%You take the gold and go, and the last thing you see are the frocked men going back around for seconds.}";
		});
	}

	local spawnAlly = o.spawnAlly;
	o.spawnAlly = function () {
		local party = spawnAlly();
		party.getLoot().Money = ::Math.rand(100, 300);
		party.getLoot().ArmorParts = ::Math.rand(10, 35);
		party.getLoot().Medicine = ::Math.rand(5, 15);
		party.getLoot().Ammo = ::Math.rand(10, 40);
		return party;
	}
});
