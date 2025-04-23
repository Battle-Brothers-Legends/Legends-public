::mods_hookExactClass("events/events/crisis/civilwar_ambush_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				s.start <- function (_event) {
					this.Banner = _event.m.NobleHouse.getUIBannerSmall();
					_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationOffense, "Ambushed some of their men");
					this.World.Assets.addMoralReputation(-1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
					_event.m.Town.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationFavor, "Helped in an ambush against " + _event.m.NobleHouse.getName());
					local item;
					local banner = _event.m.NobleHouse.getBanner();
					local r = this.Math.rand(1, 4);
					if (r == 1)
						item = this.new("scripts/items/weapons/arming_sword");
					else if (r == 2)
						item = this.new("scripts/items/weapons/morning_star");
					else if (r == 3)
						item = this.new("scripts/items/weapons/military_pick");
					else if (r == 4)
						item = this.new("scripts/items/weapons/billhook");

					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});

					r = this.Math.rand(1, 4);
					if (r == 1)	{
						item = this.new("scripts/items/shields/faction_wooden_shield");
						item.setFaction(banner);
					} else if (r == 2) {
						item = this.new("scripts/items/shields/faction_kite_shield");
						item.setFaction(banner);
					} else {
						item = this.Const.World.Common.pickArmor([
							[1, ::Legends.Armor.Standard.mail_shirt],
							[1, ::Legends.Armor.Standard.basic_mail_shirt],
						]);
					}

					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
			}
			if (s.ID == "") {

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
});
