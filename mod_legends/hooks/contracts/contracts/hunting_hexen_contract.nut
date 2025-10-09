::mods_hookExactClass("contracts/contracts/hunting_hexen_contract", function(o)
{
	o.m.Husk <- null;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Secrets, magic, contracts in blood. The local lord\'s firstborn is in danger after a foolish deal with a Hag.",
			"Her beauty is flawless, her heart cruel, her talons razor sharp. Careful she does not claim your soul.",
			"With a mere whisper, the witch can ensnare the hearts of men, twisting their desires to serve her own dark purposes.",
			"Beware the witch\'s beauty, for behind her beguiling facade lies a heart as cold and merciless as winter\'s frost.",
			"Most who cross paths with a hexen are doomed to fall under her spell, their minds clouded until they are nothing but pawns in her sinister games.",
			"Hexen cunning knows no bounds. They prey upon the weaknesses of men, enthralling them with promises of power and pleasure.",
			"Beneath her seductive guise lies a heart as black as pitch.",
			"Beware the hexen, for she is a creature of unfathomable malice, whose thirst for power knows no bounds.",
		];
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		this.m.Screens.push({
			ID = "HuskSmash",
			Title = "Near %townname%",
			Text = "[img]gfx/ui/events/event_106.png[/img]{Empty gazes stare deep into the unnatural fog, thick with a malevolent green tone, concealing everything within. When the mysterious mist began to appear, %companyname% remained in deathly silence, except for the whimpering of %protectee%. It was not the bravest hour for %employer%\'s son, who deeply regretted asking %ChosenHusk% any questions about the upcoming battle.\n\nWhen the soft tapping of a walking cane from within the thick fog finally reached his ears, the elder son's whimpering turned into cries for help. The ugly old witch was closer than expected. She stood just in front of %ChosenHusk%, whispering her magical lies...\n\nIt was a grave mistake as a deep look into %ChosenHusk%\'s eyes froze her into her place. She could see shattered pieces of mind drowning in the void, small islands of sanity floating in the endless ocean of emptiness. But in all that nothingness, something was hidden, and it had been staring at her the entire time. It was primordial all consuming darkness, which awaits us all. There was no one to charm, merely hollow flesh to which pain and misery simply brings the blessing of feeling alive.\n\nThe old crone managed to utter an ancient curse just as %ChosenHusk%, charging forward, slammed them both to the ground. Powerful punches brutally deformed the repulsive woman\'s face even further. Hot blood poured onto her in waterfalls as the ruinous curse consumed and broke %ChosenHusk%\'s body as well. Nevertheless, the blows continued to fall.\n\nAnd suddenly, the end came.\n\n%ChosenHusk% rises, bleeding from every visible orifice, and utters:%SPEECH_ON%The witch is with Davkul now.%SPEECH_OFF%}There are some beasts scattered around.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "To arms!",
				function getResult()
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "Hexen";
					p.Entities = [];
					p.Music = this.Const.Music.CivilianTracks;
					p.PlayerDeploymentType = ::Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = ::Const.Tactical.DeploymentType.Random;
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.RandomHexenBeastsNoSpiders, 70 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
					this.World.Contracts.startScriptedCombat(p, false, true, true);
					return 0;
				}
			}],
			function start () {
				if (this.Contract.m.Husk == null)
					return;

				this.Characters.push(this.Contract.m.Husk.getImagePath());

				this.List.push(::Legends.EventList.changeResolve(this.Contract.m.Husk, ::Math.rand(3, 5)));
				this.List.push(::Legends.EventList.addHeavyInjury(this.Contract.m.Husk));
				if (!::Legends.Perks.has(this.Contract.m.Husk, ::Legends.Perk.HoldOut)) {
					this.List.push(::Legends.EventList.addInjury(this.Contract.m.Husk, ::Const.Injury.Brawl));
				}

				local loot = [];
				local r = this.Math.rand(1, 100);
				if (r <= 35)
					loot.push(this.new("scripts/items/misc/witch_hair_item"));
				else if (r <= 70)
					loot.push(this.new("scripts/items/misc/mysterious_herbs_item"));
				else
					loot.push(this.new("scripts/items/misc/poisoned_apple_item"));
				if (this.Math.rand(1, 100) <= 30)
					loot.push(this.new("scripts/items/loot/jade_broche_item"));
				this.List.extend(::Legends.EventList.addItems(loot, ::World.Assets.getStash()));
			}

			function end() {
				this.Contract.m.Husk = null;
			}
		});

		foreach (s in this.m.Screens) {
			if (s.ID == "Task") {
				s.Title = this.m.Name;
			}
		}
	}

	o.setScreen <- function (_screen, _restartIfAlreadyActive = true) {
		if (this.isHuskValid(_screen)) {
			this.contract.setScreen(this.getScreen("HuskSmash"), _restartIfAlreadyActive);
			return;
		}
		// otherwise just proceed
		this.contract.setScreen(_screen, _restartIfAlreadyActive);
	}

	o.isHuskValid <- function (_screen) {
		if (::World.Assets.getOrigin().getID() != "scenario.cultists")
			return false; // skip non-cultists
		if (!::Legends.S.oneOf(_screen, "SpiderQueen", "SinisterDeal", "Encounter"))
			return false; // skip if other screen
		local candidates_husk = ::World.getPlayerRoster().getAll().filter(@(_, _bro)
			_bro.getLevel() >= 10 &&
			_bro.getHitpointsPct() > 0.6 &&
			_bro.getSkills().hasSkill("background.legend_husk") && (
				::Legends.Traits.has(_bro, ::Legends.Trait.CultistDisciple) ||
				::Legends.Traits.has(_bro, ::Legends.Trait.CultistChosen) ||
				::Legends.Traits.has(_bro, ::Legends.Trait.CultistProphet)
			));
		if (candidates_husk.len() == 0)
			return false; // skip if no husks
		if (::Math.rand(0, 1) != 0)
			return false;
		this.m.Husk = candidates_husk[::Math.rand(0, candidates_husk.len() - 1)];
		return true;
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars )
	{
		onPrepareVariables(_vars);
		_vars.push([
			"ChosenHusk",
			this.m.Husk != null ? this.m.Husk.getName() : ""
		]);
	}
});
