::mods_hookExactClass("events/events/crisis/civilwar_ambush_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				s.start <- function (_event) {
					this.Banner = _event.m.NobleHouse.getUIBannerSmall();
					_event.m.NobleHouse.addPlayerRelation(::Const.World.Assets.RelationOffense, "Ambushed some of their men");
					this.List.push(::Legends.EventList.changeMoralReputation(-1));
					_event.m.Town.getFactionOfType(::Const.FactionType.Settlement).addPlayerRelation(::Const.World.Assets.RelationFavor, "Helped in an ambush against " + _event.m.NobleHouse.getName());
					local item;
					local banner = _event.m.NobleHouse.getBanner();
					local r = ::Math.rand(1, 4);
					if (r == 1)
						item = this.new("scripts/items/weapons/arming_sword");
					else if (r == 2)
						item = this.new("scripts/items/weapons/morning_star");
					else if (r == 3)
						item = this.new("scripts/items/weapons/military_pick");
					else if (r == 4)
						item = this.new("scripts/items/weapons/billhook");

					::World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + ::Const.Strings.getArticle(item.getName()) + item.getName()
					});

					r = ::Math.rand(1, 4);
					if (r == 1)	{
						item = this.new("scripts/items/shields/faction_wooden_shield");
						item.setFaction(banner);
					} else if (r == 2) {
						item = this.new("scripts/items/shields/faction_kite_shield");
						item.setFaction(banner);
					} else {
						item = ::Const.World.Common.pickArmor([
							[1, ::Legends.Armor.Standard.mail_shirt],
							[1, ::Legends.Armor.Standard.basic_mail_shirt],
						]);
					}

					::World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						imageOverlayPath = item.getIconOverlay(),
						text = "You gain " + item.makeName()
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
		if (::Stash.getNumberOfEmptySlots() < 2)
			return;
		onUpdateScore();
	}
});
