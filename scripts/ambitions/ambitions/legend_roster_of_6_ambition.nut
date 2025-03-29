this.legend_roster_of_6_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.legend_roster_of_6";
		this.m.Duration = 20.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "We shall get the company strength back to a half dozen men! It will make us\na formidable force again and will allow us to take on more profitable work.";
		this.m.UIText = "Have a roster of at least 6 men";
		this.m.TooltipText = "Hire enough men to have a crew roster of at least 6 men. Visit settlements across the lands to find recruits that suit your needs. Having a fuller roster will allow you to take on more dangerous and better paying contracts.";
		this.m.SuccessText = "[img]gfx/ui/events/event_80.png[/img]Having finally gathered the coin and equipment, you manage to assemble a full complement of six able fighters. When next you walk down %currenttown%\'s main street, the men break into a full-throated marching song. A few of the townsfolk mutter under their breath about dirty mercenaries taking over the town, but others walk alongside and shout the words with you. %SPEECH_ON%Stand tall, brothers. People can see this is a real mercenary company now, and not a handful of wandering vagabonds.%SPEECH_OFF%%highestexperience_brother% declares.%SPEECH_ON%We trade in strength, and now that our numbers have gone up, so will our price.%SPEECH_OFF%It appears he has the right of it. You notice one particularly fat nobleman sizing up the company as if he already has a task in mind. The %companyname% are now a more formidable force. Once the men have settled in for a celebratory drink, perhaps you should take another stroll through town to see if any more lucrative contracts may be available.";
		this.m.SuccessButtonText = "We\'re getting there.";
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getBrothersMax() < 6 || this.World.Assets.getOrigin().getID() == "scenario.lone_wolf") return;

		if (this.World.getPlayerRoster().getSize() >= 6)
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.getPlayerRoster().getSize() >= 6)
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
