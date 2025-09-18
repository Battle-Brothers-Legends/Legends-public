// TODO this is supposed to be contract twist!
this.legends_husk_vs_witch <- ::inherit("scripts/events/event", {
	m = {
	}
	function create()
	{
		this.m.ID = "event.legends.husk_vs_witch";
		this.m.Title = "During camp...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_140.png[/img]%bowyer% the fletcher comes to you with a bit of request: %they_bowyer% wish to build a weapon for the ages. Apparently, %bowyer% has been attempting to build a quiver of legendary qualities for many years, but now that %they_bowyer%\'s been on the road %they_bowyer%\'s picked up a few things to fill in the gaps of knowledge. Truly, %bowyer% believes %they_bowyer% can get it right this time. All the mercenary needs is a few resources to help procure the elements needed to construct it. A sum of 500 crowns is humbly requested, and the unhold skin you carry.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Davkul awaits us all.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}
		});
	}

	function onUpdateScore()
	{
		this.m.Score = 0;
		return;
		local activeContract = ::World.Contracts.getActiveContract();
		if (activeContract == 0)
			return;
	}

	function onPrepareVariables( _vars )
	{
//		_vars.push(["EldersSon", this.m.Bowyer.getNameOnly()]);
//		_vars.push(["ElderName", this.m.Bowyer.getNameOnly()]);
//		_vars.push(["ChosenHusk", this.m.Bowyer.getNameOnly()]);
//		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Bowyer.getGender(), "bowyer");
	}

	function onClear()
	{

	}
});

// --- Husk vs Witch --- //
//  Event for Husk background for the Cultist origin.
//  Happens during witch contract instead of combat with Witch.

//Requirements:
//  Witch Contract Active
//  Contract’s Witch Attacks the Party
//  Husk bro in party: (lvl10+) + (Davkul Candles: 4+)
//  Husk bro has 60%+ hp

//Results:
//  Contract completed.
//  Reward: Witch battle loot
//  %ChosenHusk% effects
//  Takes damage: 10%-59%
//  If not having Resilient perk: random light wound
//  Gains +3-5 Resolve permanently

//Word Count: 265

// --- Event Text --- //
// Empty gazes stare deep into the unnatural fog, thick with a malevolent green tone, concealing everything within. When the mysterious mist began to appear, %CompanyName% remained in deathly silence, except for the whimpering of %EldersSon%. It was not the bravest hour for %ElderName%’s son, who deeply regretted asking %ChosenHusk% any questions about the upcoming battle.
//
// When the soft tapping of a walking cane from within the thick fog finally reached his ears, the elder son's whimpering turned into cries for help. The ugly old witch was closer than expected. She stood just in front of %ChosenHusk%, whispering her magical lies…
//
// It was a grave mistake as a deep look into %ChosenHusk%'s eyes froze her into her place. She could see shattered pieces of mind drowning in the void, small islands of sanity floating in the endless ocean of emptiness. But in all that nothingness, something was hidden, and it had been staring at her the entire time. It was primordial all consuming darkness, which awaits us all. There was no one to charm, merely hollow flesh to which pain and misery simply brings the blessing of feeling alive.
//
// The old crone managed to utter an ancient curse just as %ChosenHusk%, charging forward, slammed them both to the ground. Powerful punches brutally deformed the repulsive woman’s face even further. Hot blood poured onto her in waterfalls as the ruinous curse consumed and broke %ChosenHusk%’s body as well. Nevertheless, the blows continued to fall.
//
// And suddenly, the end came.
// %ChosenHusk% rises, bleeding from every visible orifice, and utters: “The witch is with Davkul now.”
