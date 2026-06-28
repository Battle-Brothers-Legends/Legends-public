this.legend_have_all_camp_activities_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create() {
		this.ambition.create();
		this.m.ID = "ambition.legend_have_all_camp_activities";
		this.m.Duration = 45.0 * ::World.getTime().SecondsPerDay;
		this.m.ButtonText = "We need to enhance our camping skills. Visit the local towns and learn what you can.";
		this.m.UIText = "Learn all camping skills";
		this.m.TooltipText = "Discover all camping skills. Visit settlements across the lands to find buildings that perform the required skills. Having learned all camp skills, you will be able to sustain and maintain the company for longer periods without having to visit settlements.";
		this.m.SuccessText = "[img]gfx/ui/events/event_80.png[/img]Having finally learned all the skills required to properly run your company while camped, you feel confident that you will be able to venture further into the wilderness and keep the company running smoothly.";
		this.m.SuccessButtonText = "Lets go camping!";
	}

	function getTooltipText() {
		if (this.hasAllProvisions()) {
			return this.m.TooltipText;
		}

		local crafting = ::World.Flags.get(::Legends.Camp.Flag.Craft) == true;
		local training = ::World.Flags.get(::Legends.Camp.Flag.Training) == true;
		local fletching = ::World.Flags.get(::Legends.Camp.Flag.Fletcher) == true;
		local hunting = ::World.Flags.get(::Legends.Camp.Flag.Hunter) == true;
		local gathering = ::World.Flags.get(::Legends.Camp.Flag.Gather) == true;
		local scrapping = ::World.Flags.get(::Legends.Camp.Flag.Scrap) == true;
		local scouting = ::World.Flags.get(::Legends.Camp.Flag.Scout) == true;

		local ret = this.m.TooltipText + "\n\nSkills we still need to learn.\n";
		if (!crafting) {
			ret += "\n- Crafting";
		}
		if (!fletching) {
			ret += "\n- Fletching";
		}
		if (!gathering) {
			ret += "\n- Gathering";
		}
		if (!hunting) {
			ret += "\n- Hunting";
		}
		if (!scouting) {
			ret += "\n- Patrolling";
		}
		if (!scrapping) {
			ret += "\n- Scrapping";
		}
		if (!training) {
			ret += "\n- Training";
		}
		return ret;
	}

	function hasAllProvisions() {
		local crafting = ::World.Flags.get(::Legends.Camp.Flag.Craft) == true;
		local training = ::World.Flags.get(::Legends.Camp.Flag.Training) == true;
		local fletching = ::World.Flags.get(::Legends.Camp.Flag.Fletcher) == true;
		local hunting = ::World.Flags.get(::Legends.Camp.Flag.Hunter) == true;
		local gathering = ::World.Flags.get(::Legends.Camp.Flag.Gather) == true;
		local scrapping = ::World.Flags.get(::Legends.Camp.Flag.Scrap) == true;
		local scouting = ::World.Flags.get(::Legends.Camp.Flag.Scout) == true;
		return crafting && training && fletching && hunting && gathering && scrapping && scouting;
	}

	function onUpdateScore() {
		if (::Legends.Settings.skipCamp()) {
			this.m.IsDone = true;
			return;
		}
		if (this.hasAllProvisions()) {
			this.m.IsDone = true;
			return;
		}
		this.m.Score = 6;
	}

	function onCheckSuccess() {
		return this.hasAllProvisions();
	}

	function onSerialize(_out) {
		this.ambition.onSerialize(_out);
	}

	function onDeserialize(_in) {
		this.ambition.onDeserialize(_in);
	}
});
