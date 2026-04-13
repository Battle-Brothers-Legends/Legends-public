::mods_hookExactClass("events/events/dlc8/disowned_noble_welcomed_back_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_20.png[/img]{While in %townname%, you receive a letter from a messenger. He asks that you not read it, but as soon as he\'s around the corner you do just that, breaking apart a wax royal seal. You read that %disowned%, the disowned noble%person_disowned%, is no longer exiled. Instead, %them_disowned% place is on the family throne as soon as %them_disowned% already gravely-ill father passes away.\n\nYou hold the letter in your hand, unsure of what to do with it. %disowned% has long been a member of the %companyname%. For some, there is a strange appeal to a %person_disowned% who was once in the royal rooms of the world, and now finds %themselves_disowned% in the veritable lowlands of a mercenary company. But while a bloodline may dry, a lineage never truly dies...}";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_82.png[/img]{Sighing with the realization of what might happen, you decide to go and show %them_disowned% the letter. %They_disowned% reads it for a length of time, then looks up.%SPEECH_ON%I know you\'ve read this.%SPEECH_OFF%%They_disowned% holds the letter back toward you.%SPEECH_ON%And I know you could have just as easily burned this letter. But you didn\'t. That only goes to show me what I already know: the %companyname% is my family now. If you want me to stay, I\'ll stay, if you want me to go, I\'ll go.%SPEECH_OFF%}";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_82.png[/img]{You take the letter back, then put it toward a nearby candle. It burns quickly, ashes feathering way from your fingertips as the fire climbs up the paper. %disowned% nods.%SPEECH_ON%I\'m glad you did it. If my homelands need me, I shall only return when my work with the %companyname% is over. But until then, you shall have my sword, my sweat, and my blood.%SPEECH_OFF%%They_disowned% grins.%SPEECH_ON%For the right price, of course. I am, as it is, still yet a sellsword.%SPEECH_OFF%}";
				s.start <- function ( _event ) //Uses King's guard format. Could use cultist onconvert function from character_background.nut but this would require a new savegame.
				{
					this.Characters.push(_event.m.Disowned.getImagePath());
					local background = this.new("scripts/skills/backgrounds/regent_in_absentia_background");
					background.m.IsNew = false;
					local oldPerkTree = _event.m.Disowned.getBackground().m.CustomPerkTree;
					_event.m.Disowned.getSkills().removeByID("background.disowned_noble");
					_event.m.Disowned.getSkills().add(background);
					background.buildDescription();
					_event.m.Disowned.m.Background = background;
					_event.m.Disowned.getBackground().rebuildPerkTree(oldPerkTree);
					_event.m.Disowned.resetPerks();

					this.List = [{
						id = 13,
						icon = _event.m.Disowned.getBackground().getIcon(),
						text = _event.m.Disowned.getName() + " is now a Regent in Absentia"
					}];

					local resolve_boost = this.Math.rand(10, 15);
					local initiative_boost = this.Math.rand(6, 10);
					local melee_defense_boost = this.Math.rand(2, 4);
					local ranged_defense_boost = this.Math.rand(3, 5);
					_event.m.Disowned.getBaseProperties().Bravery += resolve_boost;
					_event.m.Disowned.getBaseProperties().Initiative += initiative_boost;
					_event.m.Disowned.getBaseProperties().MeleeDefense += melee_defense_boost;
					_event.m.Disowned.getBaseProperties().RangedDefense += ranged_defense_boost;
					_event.m.Disowned.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Disowned.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve_boost + "[/color] Resolve"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/initiative.png",
						text = _event.m.Disowned.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative_boost + "[/color] Initiative"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/melee_defense.png",
						text = _event.m.Disowned.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + melee_defense_boost + "[/color] Melee Defense"
					});
					this.List.push({
						id = 16,
						icon = "ui/icons/ranged_defense.png",
						text = _event.m.Disowned.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + ranged_defense_boost + "[/color] Ranged Defense"
					});
				}
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_74.png[/img]{You push the letter back toward %them_disowned%.%SPEECH_ON%I think a %person_disowned% removed from %their_disowned% family is more in need of that family when they call %them_disowned% back, and certainly they must be in dire need of %them_disowned%. Your time with the %companyname% is over.%SPEECH_OFF%At first, the disowned noble%person_disowned% appears despondent, but %they_disowned% then begins to nod, agreeing with your assessment that %their_disowned% family must be in need of %them_disowned% and %they_disowned% should not leave them twisting in the wind. %They_disowned% says %their_disowned% goodbyes to you and the rest of the company, but before %they_disowned% leaves for good %they_disowned% has prepared you a letter.%SPEECH_ON%You will have my thanks, captain. Don\'t think I\'d ever just leave without acknowledging how important you were to saving my life, because that\'s precisely what you did, whether you realize it or not.%SPEECH_OFF%}";
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_98.png[/img]{There\'s no way you\'re showing that to %disowned%. You promptly burn the letter and all details of %their_disowned% acceptance back into %their_disowned% family lineage. Just then, %they_disowned% comes around the corner. He looks a little perplexed and asks if there\'s anything wrong. You shake your head and ask if %they_disowned% wants to help count inventory. %disowned% grins.%SPEECH_ON%Of course. The %companyname% can\'t do what it does without a good inventory, or without your command, captain.%SPEECH_OFF%Just as you turn to join %them_disowned%, you see the messenger from earlier pulling something over. You leave %disowned% to the task and head the man off, asking what it is now. He pulls a heavy chest over and then wipes his brow, stating that this was also intended for the disowned noble%person_disowned%. You kick it open to find a litany of arms and armor, some of which have %their_disowned% family crest on them. You thank the messenger, send %them_disowned% on %their_disowned% way, and then hurriedly break the crests off and throw the emblems into the gutters lest the noble%person_disowned% see them %themselves_disowned%. Curious, %they_disowned% hollers over if anything is wrong. You shake your head.%SPEECH_ON%No, nothing wrong. Just got a shipment of new gear, that\'s all.%SPEECH_OFF%}";
				s.start = function (_event)
				{
					local item;
					local stash = this.World.Assets.getStash();

					local armor_list = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.footman_armor],
						[1, ::Legends.Armor.Standard.light_scale_armor],
						[1, ::Legends.Armor.Standard.sellsword_armor],
						[1, ::Legends.Armor.Standard.noble_mail_armor]
					]);

					local weapons_list = [
						"noble_sword",
						"fighting_spear",
						"fighting_axe",
						"warhammer",
						"winged_mace",
						"arming_sword",
						"warbrand"
					];

					item = this.new("scripts/items/armor/" + armor_list[this.Math.rand(0, armor_list.len() - 1)]);
					stash.add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});

					item = this.new("scripts/items/weapons/" + weapons_list[this.Math.rand(0, weapons_list.len() - 1)]);
					stash.add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});

					item = this.new("scripts/items/weapons/" + weapons_list[this.Math.rand(0, weapons_list.len() - 1)]);
					stash.add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
			}
		}
	}
})
