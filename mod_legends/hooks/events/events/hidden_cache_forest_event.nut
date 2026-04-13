::mods_hookExactClass("events/events/hidden_cache_forest_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_25.png[/img]The forest is no friend of man which is why men of ill-repute sure love to put their keepsakes there. And today you\'ve stumbled across one: a cache that %otherbrother% found by way of stubbing %their_otherbrother% toe on the edge of it. Digging out the crate and cracking it open, you find an assortment of weapons, armor, and gold. You clap the sellsword on the shoulder and thank him for %their_otherbrother% \'hard work\'. %They_otherbrother% wags %their_otherbrother% boot around.%SPEECH_ON%Yessir, I\'ve got a toe like the nose of a bloodhound.%SPEECH_OFF%",
			_screen.start <- function ( _event ) {
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
					[1, ::Legends.Armor.Standard.gambeson],
					[1, ::Legends.Armor.Standard.leather_tunic],
					[1, ::Legends.Armor.Standard.thick_tunic],
					[1, ::Legends.Armor.Standard.wizard_robe],
					[1, ::Legends.Armor.Standard.worn_mail_shirt],
				]);

				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}
		});
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function ()
	{
		if (this.Stash.getNumberOfEmptySlots() < 2)
			return;
		onUpdateScore();
	}
});
