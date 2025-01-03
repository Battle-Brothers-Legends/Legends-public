::mods_hookExactClass("events/events/dlc8/disowned_noble_welcomed_back_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
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
			if (s.ID == "E") {
				s.start = function (_event)
				{
					local item;
					local stash = this.World.Assets.getStash();

					local armor_list = this.Const.World.Common.pickArmor([
						[1, "footman_armor"],
						[1, "light_scale_armor"],
						[1, "sellsword_armor"],
						[1, "noble_mail_armor"]
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
