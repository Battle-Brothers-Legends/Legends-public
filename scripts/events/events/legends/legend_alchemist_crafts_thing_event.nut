this.legend_alchemist_crafts_thing_event <- this.inherit("scripts/events/event", {
	m = {
		Alchemist = null
	},
	function create() {
		this.m.ID = "event.legend_alchemist_crafts_thing_event";
		this.m.Title = "During camp...";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{As you stop on the road you begin to take note of your surroundings, only to have your thoughts invaded by the smell of sulphur, meat and acid as if someone was attempting to cook a lindwurm on an open fire. \n\n Your suspicions are asserted when you turn to see %Alchemist% carefully measuring mixtures and heating equipment, keeping a steady eye on instruments while a bead of sweat trembles down their forehead. \n\n There is a sudden gasp and a flurry of action, you brace yourself and look for cover but in the seconds that pass %Alchemist% breathes a sigh of relief as if they had not been breathing at all since they started. A mess of hand motions quickly empties the mixture into a container with a few ingredients added as an afterthought, before the unknown item is committed to a small sack. \n\n%Alchemist% notices their audience and smiles, lobbing the sack and watching it float down into your outstretched palms like a beggar for a coin. \n\n Your heart did stop for a moment, but it begins beating again when %Alchemist% laughs and starts packing up their equipment, you peel back the sack opening and look at the wonders within...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "What an interesting concoction.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Alchemist.getImagePath());
				this.List.extend(::Legends.EventList.addItems([
					::Const.World.Common.pickItem([
						[1, "tools/daze_bomb_item"],
						[1, "tools/fire_bomb_item"],
						[1, "tools/smoke_bomb_item"],
						[1, "tools/acid_flask_item"],
						[1, "accessory/antidote_item"],
						[1, "ammo/powder_bag"],
						[1, "accessory/cat_potion_item"],
						[1, "accessory/iron_will_potion_item"],
						[1, "accessory/lionheart_potion_item"],
						[1, "accessory/night_vision_elixir_item"],
						[1, "accessory/recovery_potion_item"],
						[1, "accessory/spider_poison_item"],
						[1, "misc/potion_of_knowledge_item"],
					], "scripts/items/")
				]), ::World.Assets.getStash());
			}
		});
	}

	function onUpdateScore()
	{
		if (!::World.Assets.getStash().hasEmptySlot())
			return;

		local brothers = ::World.getPlayerRoster().getAll();
		local candidates_monk = brothers.filter(@(_, bro) ::Legends.Backgrounds.has(bro, ::Legends.Background.LegendAlchemist));
		if (candidates_monk.len() == 0)
			return;

		this.m.Alchemist = candidates_monk[::Math.rand(0, candidates_monk.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepareVariables(_vars) {
		_vars.push([
			"Alchemist",
			this.m.Alchemist != null ? this.m.Alchemist.getName() : ""
		]);
	}

	function onPrepare() {}

	function onClear() {
		this.m.Alchemist = null;
	}
});

