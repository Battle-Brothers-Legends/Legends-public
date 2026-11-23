this.rest_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		Results = []
	},
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

		foreach( bro in roster )
		{
			if (bro.getCampAssignment() != this.m.ID)
			{
				continue;
			}

			if (bro.getLastCampTime() == 0 || this.Time.getVirtualTimeF() - bro.getLastCampTime() > this.World.getTime().SecondsPerDay)
			{
				this.getRested(bro);
				bro.improveMood(mood, "Was able to rest in camp");
				bro.setLastCampTime(this.m.Camp.getStopTime());
			}
		}
	}

	function getRested(bro)
	{
		local background = bro.getBackground();
		local activities = [
			"While resting at camp, " + bro.getName() + " has a liquid lunch or three",
			bro.getName() + " makes shadow puppets by the fire",
			bro.getName() + " naps through the day", // can technically make this for multiple days
			bro.getName() + " yells unconstructive criticism at the rest of the camp",
			bro.getName() + " frolics through a nearby flower patch",
			bro.getName() + " draws generously proportioned figures with a stick",
			bro.getName() + " talks about putting a handgonne on an axe",
			bro.getName() + " makes a makeshift flail with a stick and some onions"
			// "Bill and Jill dance a merry jig around camp",
			// "Bill and Jill take turns kicking a leather ball around",
			// "Bill and Jill take turns swapping increasingly tall stories",
			// "Bill and Jill take turns arm wrestling",
			// "Bill and Jill play dice to wile away the hours"
		];

		if (background.getID() == "background.monk")
			activities.push(bro.getName() + " enthusiastically lectured the camp on the importance of living a holy life");

		if (background.getID() == "background.flagellant")
			activities.push(bro.getName() + " spends their time in front of an idol of the Old Gods, slowly offering a flesh sacrifice");

		if (background.getID() == "background.cultist" || background.getID() == "background.converted_cultist")
			activities.push(bro.getName() + " enthusiastically spends their free time raving to the camp about the glories of Davkul");

		if (background.getID() == "background.gladiator")
			activities.push(bro.getName() + " decides the best use of free time is to flex freshly oiled muscles");

		if (background.getID() == "background.ratcatcher")
			activities.push(bro.getName() + " plays with a captured rat");

		if (background.getID() == "background.nomad" || background.getID() == "background.legend_conscript")
			activities.push(bro.getName() + " spends their time filling their pockets with sand");

		if (background.isBackgroundType(this.Const.BackgroundType.Performing))
			activities.push(bro.getName() + " sings and dances, to the entertainment of the entire camp");

		if (bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury) || bro.getSkills().hasSkillOfType(this.Const.SkillType.SemiInjury))
		{
			activities.extend([
				bro.getName() + " blew some happy powder to take away from the pain",
				bro.getName() + " lied in a bedroll moaning in pain",
				bro.getName() + " spent time tending to fresh wounds",
				bro.getName() + " creatively cursed at anything and everything to distract from the pain"
			]);
		}

		if (background.getID() == "background.assassin" || background.getID() == "background.killer_on_the_run" || background.getID() == "background.assassin_southern" || background.getID() == "background.legend_bounty_hunter")
		{
			activities.extend([
				bro.getName() + " organized a growing poison collection",
				bro.getName() + " practiced standing menacingly on doorways",
				bro.getName() + " menacingly cleaned dirt under fingernails with a knife",
				bro.getName() + " sharpened a dagger with an intense purpose"
			]);
		}
		this.m.Results.push({
			id = 150,
			Icon = this.Const.MoodStateIcon[bro.getMoodState()],
			Text = activities[this.Math.rand(0, activities.len() - 1)] + " " + this.Const.MoodStateEvent[bro.getMoodState()]
		});

		// if (background.isBackgroundType(this.Const.BackgroundType.Combat))
		// {
		// 	local randomItem = ["weapon", "shield", "armor", ];
		// 	activities.extend([
		// 		bro.getName() + " spends their time in front of an idol of the Old Gods, slowly offering a flesh sacrifice"
		// 	])
		// } i want to do have this randomly choose a weapon/armor but i'm too lazy rn
	}

	function getResults()
	{
		return this.m.Results;
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
