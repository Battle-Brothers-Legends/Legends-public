this.legion_origin_item_delivery_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legion_origin_item_delivery";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay; //cart arrives, delives 3 items chosen from an array. reoccours.
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_55.png[/img]A creaking drone emerges in the distance. As you ready yourself and the legion for a battle, a cart makes it\'s way into your midst, driven by a single legionary hunched at the reigns. Their armour drapes their body, years of rain, snow and what else has stripped most of it away, the only remaining fragments held by the enduring posture of it's inhabitant. Arrows pock the cart, the legionary and the skeletal horse itself, none of these parties, especially the cart, seem fazed by this.\n\n Without a word, the legionary dismounts, pulling a large crate from the back of the cart with an even more resounding thud. Without a word, the driver takes the helm once more back where they came as a leisurely pace.\n\n Looking at the crate, you find a piece of parchment nailed to the exterior — all traces of the origin and purpose of this shipment have faded, save for your name, which appears foreign even to you.\n Cracking open the casing, many of the weapons inside have eroded away from a lack of protection or care, except for a few items in the middle that were shielded by the unlucky many...",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Strange, but welcome.",
				getResult = @(_event) 0
			}],
			function start( _event )
			{
				local items = [
					::Const.World.Common.pickItem([
						[1, "weapons/ancient/legend_broad_warscythe"],
						[1, "weapons/ancient/legend_broadhead_spear"],
						[1, "weapons/ancient/legend_decorated_crypt_cleaver"],
						[1, "weapons/ancient/broken_bladed_pike"],
						[1, "weapons/ancient/legend_decorated_sword"],
						[1, "weapons/ancient/legend_honed_warscythe"],
						[1, "weapons/ancient/legend_oxtongue_spear"]
					], "scripts/items/"),
					::Const.World.Common.pickItem([
						[1, "shields/ancient/auxiliary_shield"],
						[1, "weapons/ancient/legend_military_crypt_cleaver"],
						[1, "weapons/ancient/legend_kopis"],
						[1, "weapons/ancient/legend_broken_decorated_sword"],
						[1, "weapons/ancient/legend_sica"],
						[1, "weapons/ancient/legend_gladius"],
						[1, "weapons/ancient/legend_spatha"]
					], "scripts/items/"),
					::Const.World.Common.pickItem([
						[1, "weapons/ancient/ancient_sword"],
						[1, "weapons/ancient/falx"],
						[1, "weapons/ancient/ancient_spear"],
						[1, "weapons/ancient/legend_broken_spatha"],
						[1, "shields/ancient/tower_shield"],
						[1, "weapons/ancient/bladed_pike"],
						[1, "weapons/ancient/legend_military_rhomphaia"]
					], "scripts/items/")
				];
				this.List.extend(::Legends.EventList.addItems(items, ::World.Assets.getStash()));
			}
		});
	}

	function onUpdateScore()
	{
		if (!::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legend_risen_legion"))
			return;

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

