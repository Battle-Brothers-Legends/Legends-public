this.legend_monk_admires_dervish_encounter <- ::inherit("scripts/encounters/encounter", {
	m = {
		Dervish = null,
		Monk = null
	},
	function create() {
		this.encounter.create();
		this.m.Type = "encounter.legend_monk_admires_dervish";
		this.m.Name = ::Const.Strings.randomCampEncounterName();
		this.m.Cooldown = 30 * this.World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Start",
			Text = "[img]gfx/ui/events/event_80.png[/img]{As you move through camp, you notice the resident holy %person_monk% and the southern ascetic sat together away from the rest of the company, their legs crossed and open palms resting on their laps. The northern %person_monk% is studying the dervish\'s posture and expression as though it was one of %them_monk% many holy tomes, scribbling mental notes whilst trying to emulate %their_dervish% peer\'s technique. %SPEECH_ON%I don\'t know how %they_dervish% does it, captain.%SPEECH_OFF% %monk% whispers. %SPEECH_ON%I\'ve been watching this ritual of theirs for a while now, and it\'s completely unlike anything from my monastery\'s archives.%SPEECH_OFF% %monk% squirms uncomfortably, as though they\'re sat on an ant hill or thorn bush. Across from %them_monk%, the statue of a %person_dervish% sat stoic yet firm, eyes and ears gently sealed against the increasing disturbance across from %them_monk%, while a fist sized spider creeps its way up %them_dervish% leg.\n\nWith a grimace, %monk% stumbles to %their_monk% feet and backs away, dusting their legs down of loose earth and twigs, but no spindly stowaways, much to their apparent relief. %They_monk% approaches you, clearly impressed by the dervish\'s resolve. %SPEECH_ON%Every day, captain. Every day %they_dervish% does this, for hours at a time. I\'ve seen %them_dervish% do it in rain and snow, in blistering heat and, uh, crippling cold. If %they_dervish% can withstand such torments in the name of %them_dervish% Gilder, then surely I can suffer what the Gods have deigned necessary for me to endure.%SPEECH_OFF%You nod, though suspect there\'s something much more personal at play you could never truly understand. With a faint smile and hopeful strut, %they_monk% returns to camp, their day a little brighter.\n\nAs you glance back at the dervish deep in trance, the spider clambers across his face, then crawls out of view onto %them_dervish% back.}",
			Title = "During camp..."
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A stronger man than I, that\'s for sure.",
					function getResult(_event) {
						return 0;
					}
				}
			],
			function start(_event) {
				this.Characters.push(_event.m.Dervish.getImagePath());
				this.List.push(::Legends.EventList.changeHitpoints(_event.m.Dervish, ::Math.rand(1, 3)));
				this.List.push(::Legends.EventList.changeMood(_event.m.Dervish, 2.0, "Is pleased to be a paragon for others!"));

				this.Characters.push(_event.m.Monk.getImagePath());
				this.List.push(::Legends.EventList.changeResolve(_event.m.Monk, ::Math.rand(1, 3)));
				this.List.push(::Legends.EventList.changeMood(_event.m.Monk, 2.0, "Was inspired by the dervish\'s iron will!"));
			}
		});
	}

	function isValid(_camp) {
		if (::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return false;

		local brothers = ::World.getPlayerRoster().getAll();

		local candidates_dervish = brothers.filter(@(idx, bro) bro.getBackground().getID() == "background.legend_dervish");
		if (candidates_dervish.len() == 0)
			return false;

		local candidates_monk = brothers.filter(@(idx, bro) bro.getBackground().getID() == "background.monk");
		if (candidates_monk.len() == 0)
			return false;

		local playerTile = ::World.State.getPlayer().getTile();
		local nearbyTowns = ::World.EntityManager.getSettlements().filter(@(idx, t) t.getTile().getDistanceTo(playerTile) <= 6);
		if (nearbyTowns.len() > 0)
			return false;

		this.m.Dervish = candidates_dervish[::Math.rand(0, candidates_dervish.len() - 1)];
		this.m.Monk = candidates_monk[::Math.rand(0, candidates_monk.len() - 1)];

		return !this.isOnCooldown();
	}

	function onPrepareVariables(_vars) {
		_vars.push(["dervish", this.m.Dervish.m.Name]);
		_vars.push(["monk", this.m.Monk.m.Name]);
	}

	function onClear() {
		this.m.Dervish = null;
		this.m.Monk = null;
	}
});
