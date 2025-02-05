this.rest_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {},
	function create()
	{
		this.camp_building.create();
		this.m.ID = this.Const.World.CampBuildings.Rest;
		this.m.Escorting = true;
		this.m.Slot = "rest";
		this.m.Name = "Rest";
		this.m.Description = "Company personnel who have not been assigned a task will rest and relax here. .";
		this.m.BannerImage = "ui/buttons/banner_rest.png";
		this.m.CanEnter = false;
	}

	function getDescription()
	{
		local desc = "";
		desc += "Kicking ass is tough work. Grab a log, kick the shoes off and relax by the camp fire. ";
		desc += "Resting can improve the mood of even the grumpiest mercenary.";
		return desc;
	}

	function getLevel()
	{
		local pro = "dude";
		local sub = "empty";
		if (this.getAssignedBros() > 0) {
			sub =  "full";
		}
		return pro + "_" + sub;
	}

	function getAssignedBros()
	{
		local mod = this.getModifiers();
		return mod.Assigned;
	}

	function getModifiers()
	{
		local ret = {
			Assigned = 0
		}
		local roster = this.World.getPlayerRoster().getAll();
		foreach( bro in roster )
		{
			if (bro.getCampAssignment() != this.m.ID)
			{
				continue;
			}
			++ret.Assigned;
		}
		return ret;
	}


	function completed()
	{
		local roster = this.World.getPlayerRoster().getAll();

		if (this.m.Camp.getCampTimeHours() < 8)
		{
			return;
		}

		local mood = 0.5;
		if (this.m.Camp.getCampTimeHours() >= 12)
		{
			mood = 1.0;
		}

		if (this.m.Camp.getCampTimeHours() >= 16)
		{
			mood = 1.5;
		}

		foreach( b in roster )
		{
			if (b.getCampAssignment() != this.m.ID)
			{
				continue;
			}

			if (b.getLastCampTime() == 0 || this.Time.getVirtualTimeF() - b.getLastCampTime() > this.World.getTime().SecondsPerDay)
			{
				b.improveMood(mood, "Was able to rest in camp");
				b.setLastCampTime(this.m.Camp.getStopTime());
			}
		}
	}

	function getResults()
	{
		local res = [];
		local roster = this.World.getPlayerRoster().getAll();
		local moodCount = 150;
		foreach( b in roster )
		{
			if (b.getLastCampTime() == this.m.Camp.getStopTime())
			{
				++moodCount;
				res.push({
					id = moodCount,
					icon =  this.Const.MoodStateIcon[b.getMoodState()],
					text = b.getName() + this.Const.MoodStateEvent[b.getMoodState()]
				});
			}
		}
		return res;
	}

	function onClicked( _campScreen )
	{
		_campScreen.showRestDialog();
		this.camp_building.onClicked(_campScreen);
	}

	function onSerialize( _out )
	{
		this.camp_building.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.camp_building.onDeserialize(_in);
	}

});
