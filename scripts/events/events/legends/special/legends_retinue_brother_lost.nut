this.legends_retinue_brother_lost <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legends.retinue_brother_lost";
		this.m.Title = "At camp...";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_39.png[/img]After a brief headcount you realise the company is a little smaller than before. Checking the rolecall you can make out %a few% missing character%s%:\n%bronames%%Their% equipment lies abandoned in the camp, silently awaiting the return of their master. There comes a question of who will fill the role%s% %they% had in the company - for now %their% loss will cause a few problems in camp when tasks go uncompleted.\n\n Finding %a %suitable candidate%s% for the task%s% at hand will allow %companyname% to return to a sense of normalcy, and hopefully not cause any problems with your employers...",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Not everything goes as planned. | Oh well. | The mercs will understand. | This won\'t stop the %companyname%. | The important thing is that we\'re moving forward.}",
					function getResult( _event )
					{
						this.World.Retinue.removeDisabledFollowers();
						return 0;
					}
				}
			],
			function start( _event )
			{
			}
		});
	}

	function isValid()
	{
		return this.World.Retinue.hasFollowersToRemove();
	}

	function canFire()
	{
		return this.isValid();
	}

	function onPrepareVariables( _vars )
	{
		local lostFollowers = this.World.Retinue.getFollowersToRemove();

		_vars.push([
			"s",
			lostFollowers.len() == 1 ? "" : "s"
		]);
		_vars.push([
			"a ",
			lostFollowers.len() == 1 ? "a " : ""
		]);
		_vars.push([
			"a few",
			lostFollowers.len() == 1 ? "a" : "a few"
		]);
		_vars.push([
			"companyname",
			this.World.Assets.getName()
		]);

		local followers = "";
		foreach (follower in lostFollowers)
		{
			followers += " - ";
			followers += follower.getLinkedBro() == null ? "Unknown" : follower.getLinkedBro().getName();
			followers += " (" + follower.getName() + ")\n"
		}

		::Const.LegendMod.extendVarsWithPronouns(_vars, lostFollowers.len() == 1 ? (lostFollowers[0].getLinkedBro() == null ? -1 : lostFollowers[0].getLinkedBro().getGender()) : -1);

		_vars.push([
			"bronames",
			followers
		])
	}
});
