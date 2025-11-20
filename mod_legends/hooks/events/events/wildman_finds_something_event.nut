::mods_hookExactClass("events/events/wildman_finds_something_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_25.png[/img]While trying not to lose your temper at just how many low-hanging branches are catching you in the face, %otherguy% hurries to your side and says %wildman% the wildling has run off. You turn round to see the rest of the company looking as confused as you are. Holding your fist up to quiet the company, the forest returns your order of silence with muted chirps of distant birds and the buzz of a bee or wasp somewhere unseen. Shaking your head, you decide to continue the march.\n\nA few hours later, the wildling jumps out of a bush you were about to cleave with a machete. %wildman% has got an armful of random items in hand. Where these things came from, you\'ve no idea, but you have the mercenaries sift through the findings. %wildman% returns to rank as though nothing happened at all. You glance at the wildling who\'s staring at their finger where a butterfly has landed. When you glance again, the butterfly is gone and the wildling is swallowing something. %otherguy% gives you a report on what was brought.";
				s.Options[0].Text = "Where did these come from?";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Wildman.getImagePath());
					local item;
					local items = 0;

					for( local maxitems = this.Math.rand(1, 2); items < maxitems;) {
						item = null;
						local r = this.Math.rand(1, 10);

						if (r == 1)
							item = this.new("scripts/items/weapons/wooden_stick");
						else if (r == 2)
							item = this.Const.World.Common.pickArmor([
								[1, ::Legends.Armor.Standard.tattered_sackcloth],
							]);
						else if (r == 3)
							item = this.new("scripts/items/weapons/knife");
						else if (r == 4)
							this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.hood]]);
						else if (r == 5)
							item = this.new("scripts/items/misc/ghoul_teeth_item");
						else if (r == 6)
							item = this.new("scripts/items/weapons/woodcutters_axe");
						else if (r == 7)
							item = this.new("scripts/items/shields/wooden_shield_old");
						else if (r == 8)
							item = this.new("scripts/items/weapons/militia_spear");
						else
							item = this.new("scripts/items/accessory/berserker_mushrooms_item");

						if (item != null) {
							items = ++items;
							this.World.Assets.getStash().add(item);
							this.List.push({
								id = 10,
								icon = "ui/items/" + item.getIcon(),
								text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
							});
						}
					}
				}
			}
		}
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function ()
	{
		if (this.Stash.getNumberOfEmptySlots() < 2)
			return;
		onUpdateScore();
	}
})
