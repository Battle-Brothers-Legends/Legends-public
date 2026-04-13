this.legend_have_all_camp_activities_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.legend_have_all_camp_activities";
		this.m.Duration = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "We need to enhance our camping skills. Visit the local towns and learn what you can.";
		this.m.UIText = "Learn all camping skills";
		this.m.TooltipText = "Discover all camping skills. Visit settlements across the lands to find buildings that perform the required skills. Having learned all camp skills, you will be able to sustain and maintain the company for longer periods without having to visit settlements.";
		this.m.SuccessText = "[img]gfx/ui/events/event_80.png[/img]Having finally learned all the skills required to properly run your company while camped, you feel confident that you will be able to venture further into the wilderness and keep the company running smoothly.";
		this.m.SuccessButtonText = "Lets go camping!";
	}

	function getTooltipText()
	{
		if (this.hasAllProvisions())
		{
			return this.m.TooltipText;
		}

		local crafting = false;
		local training = false;
		local fletching = false;
		local hunting = false;
		local gathering = false;
		local scraping = false;
		local scouting = false;

		local ret = this.m.TooltipText + "\n\nSkills we still need to learn.\n";

		if (this.World.Flags.get("HasLegendCampCrafting"))
		{
			crafting = true;
		}

		if (this.World.Flags.get("HasLegendCampFletching"))
		{
			fletching = true;
		}

		if (this.World.Flags.get("HasLegendCampHunting"))
		{
			hunting = true;
		}

		if (this.World.Flags.get("HasLegendCampGathering"))
		{
			gathering = true;
		}

		if (this.World.Flags.get("HasLegendCampScraping"))
		{
			scraping = true;
		}

		if (this.World.Flags.get("HasLegendCampScouting"))
		{
			scouting = true;
		}

		if (this.World.Flags.get("HasLegendCampTraining"))
		{
			training = true;
		}

		if (!crafting)
		{
			ret = ret + "\n- Crafting";
		}

		if (!fletching)
		{
			ret = ret + "\n- Fletching";
		}

		if (!gathering)
		{
			ret = ret + "\n- Gathering";
		}

		if (!hunting)
		{
			ret = ret + "\n- Hunting";
		}

		if (!scouting)
		{
			ret = ret + "\n- Patrolling";
		}

		if (!scraping)
		{
			ret = ret + "\n- Scraping";
		}

		if (!training)
		{
			ret = ret + "\n- Training";
		}

		return ret;
	}

	function hasAllProvisions()
	{
		local crafting = false;
		local training = false;
		local fletching = false;
		local hunting = false;
		local gathering = false;
		local scraping = false;
		local scouting = false;

		if (this.World.Flags.get("HasLegendCampCrafting"))
		{
			crafting = true;
		}

		if (this.World.Flags.get("HasLegendCampFletching"))
		{
			fletching = true;
		}

		if (this.World.Flags.get("HasLegendCampHunting"))
		{
			hunting = true;
		}

		if (this.World.Flags.get("HasLegendCampGathering"))
		{
			gathering = true;
		}

		if (this.World.Flags.get("HasLegendCampScraping"))
		{
			scraping = true;
		}

		if (this.World.Flags.get("HasLegendCampScouting"))
		{
			scouting = true;
		}

		if (this.World.Flags.get("HasLegendCampTraining"))
		{
			training = true;
		}

		return crafting && training && fletching && hunting && gathering && scraping && scouting;
	}

	function onUpdateScore()
	{

		if (::Legends.Settings.skipCamp())
		{
			this.m.IsDone = true;
			return;
		}

		if (this.hasAllProvisions())
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 6;
	}

	function onCheckSuccess()
	{
		if (this.hasAllProvisions())
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
	}

});
