this.legend_alchemist_crafts_thing_event <- this.inherit("scripts/events/event", {
	m = {
		Alchemist = null
	},
	function create()
	{
		this.m.ID = "event.legend_alchemist_crafts_thing_event";
		this.m.Title = "During camp...";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{As you stop on the road you begin to take note of your surroundings, only to have your thoughts invaded by the smell of sulphur, meat and acid as if someone was attempting to cook a lindwurm on an open fire. \n\n Your suspicions are asserted when you turn to see %Alchemist% carefully measuring mixtures and heating equipment, keeping a steady eye on instruments while a bead of sweat trembles down their forehead. \n\n There is a sudden gasp and a flurry of action, you brace yourself and look for cover but in the seconds that pass %Alchemist% breathes a sigh of relief as if they had not been breathing at all since they started. A mess of hand motions quickly empties the mixture into a container with a few ingredients added as an afterthought, before the unknown item is committed to a small sack. \n\n %Alchemist% notices their audience and smiles, lobbing the sack and watching it float down into your outstretched palms like a beggar for a coin. \n\n Your heart did stop for a moment, but it begins beating again when %Alchemist% laughs and starts packing up their equipment, you peel back the sack opening and look at the wonders within...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What an interesting concoction.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Alchemist.getImagePath());
				local item;
				local string = "";
				switch(this.Math.rand(0,12))
				{
					case 0:
						string = "tools/daze_bomb_item";
						break;
					case 1:
						string = "tools/fire_bomb_item";
						break;
					case 2:
						string = "tools/smoke_bomb_item";
						break;
					case 3:
						string = "tools/acid_flask_item";
						break;
					case 4:
						string = "accessory/antidote_item";
						break;
					case 5:
						string = "ammo/powder_bag";
						break;
					case 6:
						string = "accessory/cat_potion_item";
						break;
					case 7:
						string = "accessory/iron_will_potion_item";
						break;
					case 8:
						string = "accessory/lionheart_potion_item";
						break;
					case 9:
						string = "accessory/night_vision_elixir_item";
						break;
					case 10:
						string = "accessory/recovery_potion_item";
						break;
					case 11:
						string = "accessory/spider_poison_item";
						break;
					case 12:
						string = "misc/potion_of_knowledge_item";
						break;

				}
				item = this.new("scripts/items/" + string);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_monk = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.legend_alchemist")
			{
				candidates_monk.push(bro);
			}
		}

		if (candidates_monk.len() == 0)
		{
			return;
		}

		this.m.Alchemist = candidates_monk[this.Math.rand(0, candidates_monk.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"Alchemist",
			this.m.Alchemist != null ? this.m.Alchemist.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Alchemist = null;
	}

});

