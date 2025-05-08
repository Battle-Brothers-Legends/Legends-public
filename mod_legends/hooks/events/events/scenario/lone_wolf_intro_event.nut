::mods_hookExactClass("events/events/scenario/lone_wolf_intro_event", function(o) {
	o.m.Dude <- null;

	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.start <- function ( _event ) {
					this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
				}
				s.Options[0].getResult <-  function ( _event ) {
					return "B"; //B = Pick a weapon, any weapon
				}
			}
		}
		this.m.Screens.push({ //Pick a weapon, any weapon
			ID = "B",
			Text = "[img]gfx/ui/events/event_62.png[/img]{It occurs to you that before you embark on this journey of self discovery, you should probably arm yourself a little better - a lance is pointless without a horse. Your armour is old and you can trade it in for a fair price in exchange for a new set\n\n Visiting the local weaponsmith you spot an array of killing instruments, each carefully dressed and arranged like a breadmaker\'s stall. You only have enough crowns for one set, so you better choose wisely.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [ //maximum 6 options
				{
				Text = "A longsword and medium armour has never failed me.",
				function getResult( _event )
				{
					return "C"; //2h sword
				}

			},
			{
				Text = "A strong hammer, a sturdy shield and medium armour can weather anything.",
				function getResult( _event )
				{
					return "D"; //1h hammer + heater shield
				}

			},
			{
				Text = "An axe and buckler with light armour is the best choice.",
				function getResult( _event )
				{
					return "E"; //Axe and buckler
				}

			},
			{
				Text = "I always was a good shot - I'll take the crossbow, a sword and light armour.",
				function getResult( _event )
				{
					return "F"; //Crossbow + 1h sword
				}

			},
			{
				Text = "I\'m a little rusty, but a bow and dagger with some nice cloth armour is the proper choice.",
				function getResult( _event )
				{
					return "G"; //Bow + dagger
				}
			},
			{
				Text = "I\'ll stick to what I know - a pike is almost a jousting lance, right?",
				function getResult( _event )
				{
					return "H"; //Polearm
				}
			}
			],
			function start( _event ) {
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}
		});

		this.m.Screens.push({ //Longsword
			ID = "C",
			Text = "[img]gfx/ui/events/event_01.png[/img]{You pick up the longsword from the weapon rack - while not expertly made it has good balance and reach to win almost any fight.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
			{
				Text = "{Well balanced and fast. | Versatile and strong.}",
				function getResult( _event ) {
					return 0;
				}
			}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/legend_longsword");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				item = this.Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Standard.leather_lamellar]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				item = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.padded_kettle_hat]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.SwordTree.Tree);
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.HammerTree.Tree);
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.MediumArmorTree.Tree);
			}
		});

		this.m.Screens.push({ //1h hammer + heater shield
			ID = "D",
			Text = "[img]gfx/ui/events/event_01.png[/img]{You take a heater shield and a sturdy pick from the table, the weight of the pick feels good in your hand and balances out the weight of the shield nicely.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
			{
				Text = "{No knight will stand before me! | Nothing is getting past this shield...}",
				function getResult( _event ) {
					return 0;
				}
			}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/military_pick");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				local item = this.new("scripts/items/shields/heater_shield");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				item = this.Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Standard.patched_mail_shirt]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				item = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.padded_kettle_hat]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.SwordTree.Tree);
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.HammerTree.Tree);
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.ShieldTree.Tree);
			}
		});

		this.m.Screens.push({ //Axe and buckler
			ID = "E",
			Text = "[img]gfx/ui/events/event_01.png[/img]{Always wanting to break convention - you take a heavy fighting axe and what remains of your crowns is spent on a light buckler.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
			{
				Text = "{Heavy hitting and light on my feet.}",
				function getResult( _event )
				{
					return 0;
				}

			}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/fighting_axe");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				local item = this.new("scripts/items/shields/buckler_shield");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				item = this.Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Standard.leather_lamellar]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				item = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.padded_kettle_hat]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.SwordTree.Tree);
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.AxeTree.Tree);
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.LightArmorTree.Tree);
			}
		});

		this.m.Screens.push({ //Crossbow + 1h sword
			ID = "F",
			Text = "[img]gfx/ui/events/event_01.png[/img]{You grab the crossbow and arming sword from the rack. You look down the sights and wonder how hard it could be to get back into firing one again since your younger days hunting rabbits.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
			{
				Text = "{Well, if a peasant can use it... | If all else fails, I still have the sword.}",
				function getResult( _event ) {
					return 0;
				}
			}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/crossbow");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				local item = this.new("scripts/items/weapons/arming_sword");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				local item = this.new("scripts/items/ammo/quiver_of_bolts");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				item = this.Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Standard.padded_leather]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				item = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.closed_mail_coif]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.CrossbowTree.Tree);
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.DaggerTree.Tree);
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.BowTree.Tree);
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.MediumArmorTree.Tree);
			}
		});

		this.m.Screens.push({ //Bow + dagger
			ID = "G",
			Text = "[img]gfx/ui/events/event_01.png[/img]{You test the string on the hunting bow. Pulling it back reminds you of all the archery tournaments you won in the past and how hard it would be to hit a living, breathing and possible very angry target.\n\nEither way - you still have a nice, sharp dagger if they get close.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
			{
				Text = "{I wonder how far the arrow goes... | It\'s better than a servant\'s knife I guess...}",
				function getResult( _event ) {
					return 0;
				}
			}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/hunting_bow");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				local item = this.new("scripts/items/ammo/quiver_of_arrows");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				local item = this.new("scripts/items/weapons/rondel_dagger");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				item = this.Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Standard.patched_mail_shirt]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				item = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.closed_mail_coif]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.BowTree.Tree);
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.CrossbowTree.Tree);
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.DaggerTree.Tree);
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.LightArmorTree.Tree);
			}
		});

		this.m.Screens.push({ //Polearm
			ID = "H",
			Text = "[img]gfx/ui/events/event_01.png[/img]{Perhaps it\'s best to stick to what you are familiar with - a long pike that is much like a jousting lance in function and handling.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
			{
				Text = "{I\'m about to ruin somebody\'s day with this... | Can\'t be much harder than using a lance...}",
				function getResult( _event ) {
					return 0;
				}
			}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/pike");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				item = this.Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Standard.reinforced_mail_hauberk]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				item = this.Const.World.Common.pickHelmet([
					[1, ::Legends.Helmet.Standard.conic_helmet_with_closed_mail]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.PolearmTree.Tree);
				_event.m.Dude.getBackground().addPerkGroup(::Const.Perks.MediumArmorTree.Tree);
			}
		});
	}

	o.onUpdateScore = function ()
	{
		this.m.Dude = this.World.getPlayerRoster().getAll()[0];
		return;
	}

	o.onClear = function ()
	{
		this.m.Dude = null;
	}
})
