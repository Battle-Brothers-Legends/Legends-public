::mods_hookExactClass("events/events/hidden_cache_forest_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Otherbrother.getImagePath());
					local money = this.Math.rand(30, 150);
					this.World.Assets.addMoney(money);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns"
					});
					local r = this.Math.rand(1, 8);
					local item;

					if (r == 1)
						item = this.new("scripts/items/weapons/bludgeon");
					else if (r == 2)
						item = this.new("scripts/items/weapons/falchion");
					else if (r == 3)
						item = this.new("scripts/items/weapons/knife");
					else if (r == 4)
						item = this.new("scripts/items/weapons/dagger");
					else if (r == 5)
						item = this.new("scripts/items/weapons/shortsword");
					else if (r == 6)
						item = this.new("scripts/items/weapons/woodcutters_axe");
					else if (r == 7)
						item = this.new("scripts/items/weapons/scramasax");
					else if (r == 8)
						item = this.new("scripts/items/weapons/hand_axe");

					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});

					item = this.Const.World.Common.pickArmor([
						[1, "gambeson"],
						[1, "leather_tunic"],
						[1, "thick_tunic"],
						[1, "wizard_robe"],
						[1, "worn_mail_shirt"],
					]);

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
})
