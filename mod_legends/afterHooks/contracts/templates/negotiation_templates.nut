// record the NegotiatingTries flag
foreach (option in ::Const.Contracts.Overview[0].Options)
{
	if (option.Text != "I accept this contract.")
		continue;

	local getResult = option.getResult;
	option.getResult <- function()
	{
		::World.Statistics.getFlags().increment("NegotiatingTries", this.Contract.m.Flags.getAsInt("NegotiatingTries"));
		return getResult();
	};
	break;
}

local OverviewStart = ::Const.Contracts.Overview[0].start;
::Const.Contracts.Overview[0].start <- function()
{
	this.Contract.m.BulletpointsPayment = [];

	if (this.Contract.m.Payment.Advance != 0)
		this.Contract.m.BulletpointsPayment.push("Get " + this.Contract.m.Payment.getInAdvance() + " crowns in advance");

	if (this.Contract.m.Payment.Count != 0)
		this.Contract.m.BulletpointsPayment.push("Get " + this.Contract.m.Payment.getPerCount() + " crowns per head you bring back, up to " + this.Contract.m.Payment.MaxCount + " total");

	if (this.Contract.m.Payment.Completion != 0)
		this.Contract.m.BulletpointsPayment.push("Get " + this.Contract.m.Payment.getOnCompletion() + " crowns on completion");

	if (this.Contract.m.Payment.IsFinal)
		this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%I refuse to pay any more for this.  | %SPEECH_START%Be reasonable.  | %SPEECH_START%No, no and no.  | %SPEECH_START%Who do you think you are? I tell you how much you\'re getting paid!  | They look at you sternly and shake their head.%SPEECH_ON% | %SPEECH_START%No, you are already getting more than you\'re worth.  | %SPEECH_START%No. Don\'t not push me too far! | %SPEECH_START%This isn\'t worth that much to me. | %SPEECH_START%I don\'t think you quite understand how this works. We need to come to terms if you want to be paid for this. My offer still stands. }%SPEECH_OFF%";

	OverviewStart();
}

// have to overwrite these
::Const.Contracts.NegotiationDefault[0].start <- function()
{
	this.Options = [];
	this.Options.push({
		Text = "I accept your offer.",
		function getResult()
		{
			this.Contract.m.BulletpointsPayment = [];

			if (this.Contract.m.Payment.Advance != 0)
			{
				this.Contract.m.BulletpointsPayment.push("Get " + this.Contract.m.Payment.getInAdvance() + " crowns in advance");
			}

			if (this.Contract.m.Payment.Completion != 0)
			{
				this.Contract.m.BulletpointsPayment.push("Get " + this.Contract.m.Payment.getOnCompletion() + " crowns on completion");
			}

			return "Overview";
		}

	});
	this.Options.push({
		Text = "We need to be paid more for this.",
		function getResult()
		{
			if (!this.World.Retinue.hasFollower("follower.negotiator"))
			{
				if (this.Math.rand(1, 100) <= 66) {
					this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
				}
			}
			else
			{
				if (this.Math.rand(1, 100) <= 10) {
					this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
				}
			}

			this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

			local failChance = this.Math.min(90, this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance);

			if (this.Math.rand(1, 100) <= failChance)
			{
				return "Negotiation.Fail";
			}
			else if (this.Math.rand(1, 100) <= failChance)
			{
				this.Contract.m.Payment.IsFinal = true;
				this.Contract.m.Flags.increment("NegotiatingTries");
				return "Overview"
			}
			else
			{
				this.Contract.m.Payment.IsFinal = false;
				this.Contract.m.Flags.increment("NegotiatingTries");
				if (this.World.Retinue.hasFollower("follower.negotiator"))
				{
					this.Contract.m.Payment.Pool = this.Contract.m.Payment.Pool * (1.0 + this.Math.rand(3, 10) * 0.01);
				}
				else
				{
					this.Contract.m.Payment.Pool = this.Contract.m.Payment.Pool * (1.0 + this.Math.rand(6, 15) * 0.01);
				}

			}

			return "Negotiation";
		}

	});

	if (this.Contract.m.Payment.Advance < 1.0)
	{
		this.Options.push({
			Text = (this.Contract.m.Payment.Advance == 0 ? "We need payment in advance." : "We need more payment in advance."),
			function getResult()
			{

				if (!this.World.Retinue.hasFollower("follower.negotiator"))
				{
					if (this.Math.rand(1, 100) <= 10) {
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}
				}

				this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);
				this.Contract.m.Flags.increment("NegotiatingTries");

				local failChance = this.Math.min(90, this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance * 2);

				if (this.Math.rand(1, 100) <= failChance || this.Contract.m.Payment.Advance >= this.World.Assets.m.AdvancePaymentCap)
				{
					this.Contract.m.Payment.IsFinal = true;
					return "Overview"
				}
				else
				{
					this.Contract.m.Payment.IsFinal = false;

					local p = 1.0 * this.Math.rand(15, 30);
					p = p / 100.0;
					if (this.World.Retinue.hasFollower("follower.negotiator"))
					{
						p = p * 2
					}

					this.Contract.m.Payment.Advance = this.Math.minf(1.0, this.Contract.m.Payment.Advance + p);
					this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - p);
				}

				return "Negotiation";
			}

		});
	}

	if (this.Contract.m.Payment.Completion < 1.0)
	{
		this.Options.push({
			Text = (this.Contract.m.Payment.Completion == 0 ? "We need payment once the work is done." : "We need more payment once the work is done."),
			function getResult()
			{
				if (!this.World.Retinue.hasFollower("follower.negotiator"))
				{
					if (this.Math.rand(1, 100) <= 10) {
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}
				}

				this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);
				this.Contract.m.Flags.increment("NegotiatingTries");

				local failChance = this.Math.min(90, this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance * 2);

				if (this.Math.rand(1, 100) <= failChance)
				{
					this.Contract.m.Payment.IsFinal = true;
					return "Overview"
				}
				else
				{
					this.Contract.m.Payment.IsFinal = false;

					local p = 1.0 * this.Math.rand(15, 30);
					p = p / 100.0;
					if (this.World.Retinue.hasFollower("follower.negotiator"))
					{
						p = p * 2
					}

					this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - p);
					this.Contract.m.Payment.Completion = this.Math.minf(1.0, this.Contract.m.Payment.Completion + p);
				}

				return "Negotiation";
			}

		});
	}

	this.Options.push({
		Text = "Forget it, this isn\'t worth it.",
		function getResult()
		{
			this.World.Contracts.removeContract(this.Contract);
			this.World.State.getTownScreen().updateContracts();
			return 0;
		}

	});

	if (!this.Contract.m.Payment.IsNegotiating)
	{
		this.Text = "[img]gfx/ui/events/event_04.png[/img]{%They_employer% nods.%SPEECH_ON%Yes. Good. I was thinking about payment for your task earlier. | %They_employer% straightens up.%SPEECH_ON%So, payment. | %They_employer% smiles.%SPEECH_ON%This will make you rich, my friend. | %They_employer% takes a deep breath.%SPEECH_ON%Very well, this is what I\'m prepared to offer you. | %They_employer% puts %their_employer% hand on your shoulder, smiling reaffirmingly.%SPEECH_ON%I think I know an adequate compensation for your services. | %They_employer% gesticulates with %their_employer% hands, pointing at %their_employer% fingers as if counting something, but it means nothing to you.%SPEECH_ON%Judging from experience, this is good payment for the task. | %They_employer% nods. %SPEECH_ON%You look able, so I am willing to pay quite a bit. | %They_employer% jingles with a bag of coins.%SPEECH_ON%This will be yours if you help me out on this. | %They_employer% opens the palm of %their_employer% hands.%SPEECH_ON%I\'m tight on crowns, so before you ask, this is all I have right now. | %SPEECH_ON%Rest assured that what I\'m offering you now is a fine prize for your work.} ";
		this.Contract.m.Payment.IsNegotiating = true;
	}
	else if (this.Contract.m.Payment.IsFinal)
	{
		this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%I refuse to pay any more for this.  | %SPEECH_START%Be reasonable.  | %SPEECH_START%No, no, no.  | %SPEECH_START%Who do you think you are? I tell you how you\'re getting paid.  | %They_employer% just looks at you sternly and shakes %their_employer% head.%SPEECH_ON% | %SPEECH_START%No, you are already getting more than you\'re worth.  | %SPEECH_START%No. Do not push me too far!  | %SPEECH_START%I don\'t think you quite understand how this works. We need to come to terms if you want to be paid for this. My offer still stands. }";
	}
	else
	{
		this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%This is it then?  | %They_employer% takes a deep breath.%SPEECH_ON% | %They_employer% sighs.%SPEECH_ON% | %SPEECH_START%Fair enough.  | %SPEECH_START%Fine, fine.  | %SPEECH_START%If it must be.  | %SPEECH_START%Fine. How about this?  | %SPEECH_START%Sure, sure, I understand.  | %SPEECH_START%Reasonable.  | %SPEECH_START%Interesting. I think this would be more appropiate then.  | %SPEECH_START%Would you take this instead?  | %SPEECH_START%Let me make the following offer.  | %SPEECH_ON%Fair. Would you accept this instead?  | %SPEECH_START%Very well. Given your demands I offer you this.  | %SPEECH_START%Let\'s get this over with quickly. Here is my new offer.  | %SPEECH_START%We\'re all friends here, aren\'t we? Let\'s see... }";
	}

	if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance == 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_completion% crowns when the contract is done.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance != 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid} all %reward_advance% crowns in advance.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance != 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_advance% crowns in advance, and another %reward_completion% when the job is done.%SPEECH_OFF%";
	}
	else
	{
		this.Text += "You\'ll be paid nothing. Is that what you want?%SPEECH_OFF%";
	}
};
::Const.Contracts.NegotiationDefault[1].Text = "[img]gfx/ui/events/event_74.png[/img]{%SPEECH_START%You act as if you were the only ones to hold a sword for coin. I think I\'ll look elsewhere for the men I need. Good day.%SPEECH_OFF% | %SPEECH_START%My patience has limits, too, and I think I\'m wasting my time here.%SPEECH_OFF% | %SPEECH_START%I\'ve had enough of this! I\'m sure I\'ll find someone else to do the job!%SPEECH_OFF% | %SPEECH_START%Do not insult my intelligence! Forget about this contract. We\'re done.%SPEECH_OFF% | %Their_employer% face turns red with anger.%SPEECH_ON%Get out of here, I\'m not in the habit of making deals with greedy devils!%SPEECH_OFF% | %They_employer% sighs. %SPEECH_ON%Just... forget it. I shouldn\'t have trusted you in the first place. Leave me so I can look for other, more sensible men.%SPEECH_OFF% | %SPEECH_START%I really thought we had a good relationship here. But know that I can only be pushed so far. I don\'t think this is working out. I\'ll take my leave.%SPEECH_OFF% | %SPEECH_ON%This has been an utter waste of time for me. Don\'t bother coming back until you learned some reason.%SPEECH_OFF%}";

::Const.Contracts.NegotiationPerHead[0].start <- function()
{
	this.Options = [];
	this.Options.push({
		Text = "I accept your offer.",
		function getResult()
		{
			this.Contract.m.BulletpointsPayment = [];

			if (this.Contract.m.Payment.Advance != 0)
			{
				this.Contract.m.BulletpointsPayment.push("Get " + this.Contract.m.Payment.getInAdvance() + " crowns in advance");
			}

			if (this.Contract.m.Payment.Count != 0)
			{
				this.Contract.m.BulletpointsPayment.push("Get " + this.Contract.m.Payment.getPerCount() + " crowns per head you bring back, up to " + this.Contract.m.Payment.MaxCount + " total");
			}

			if (this.Contract.m.Payment.Completion != 0)
			{
				this.Contract.m.BulletpointsPayment.push("Get " + this.Contract.m.Payment.getOnCompletion() + " crowns on completion");
			}

			return "Overview";
		}

	});
	this.Options.push({
		Text = "We need to be paid more for this.",
		function getResult()
		{
			if (!this.World.Retinue.hasFollower("follower.negotiator"))
			{
				if (this.Math.rand(1, 100) <= 66) {
					this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
				}
			}
			else
			{
				if (this.Math.rand(1, 100) <= 10) {
					this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
				}
			}


			this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

			local failChance = this.Math.min(90, this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance);

			if (this.Math.rand(1, 100) <= failChance)
			{
				return "Negotiation.Fail";
			}
			else if (this.Math.rand(1, 100) <= failChance)
			{
				this.Contract.m.Payment.IsFinal = true;
				this.Contract.m.Flags.increment("NegotiatingTries");
				return "Overview"
			}
			else
			{
				this.Contract.m.Payment.IsFinal = false;
				this.Contract.m.Flags.increment("NegotiatingTries");
				if (this.World.Retinue.hasFollower("follower.negotiator"))
				{
					this.Contract.m.Payment.Pool = this.Contract.m.Payment.Pool * (1.0 + this.Math.rand(3, 10) * 0.01);
				}
				else
				{
					this.Contract.m.Payment.Pool = this.Contract.m.Payment.Pool * (1.0 + this.Math.rand(6, 15) * 0.01);
				}
			}

			return "Negotiation";
		}

	});

	if (this.Contract.m.Payment.Count < 1.0)
	{
		this.Options.push({
			Text = (this.Contract.m.Payment.Count == 0 ? "We need to be paid per head we return with." : "We need to be paid more per head we return with."),
			function getResult()
			{
				if (!this.World.Retinue.hasFollower("follower.negotiator"))
				{
					if (this.Math.rand(1, 100) <= 66) {
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}
				}
				else
				{
					if (this.Math.rand(1, 100) <= 10) {
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}
				}

				this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

				local failChance = this.Math.min(90, this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance);

				if (this.Math.rand(1, 100) <= failChance)
				{
					return "Negotiation.Fail";
				}
				else if (this.Math.rand(1, 100) <= failChance)
				{
					this.Contract.m.Payment.IsFinal = true;
					this.Contract.m.Flags.increment("NegotiatingTries");
					return "Overview"
				}
				else
				{
					this.Contract.m.Payment.IsFinal = false;
					this.Contract.m.Flags.increment("NegotiatingTries");

					if (this.Contract.m.Payment.Completion > 0 && this.Contract.m.Payment.Advance > 0)
					{
						this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.125);
						this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.125);
					}
					else if (this.Contract.m.Payment.Advance > 0)
					{
						this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.25);
					}
					else
					{
						this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.25);
					}

					this.Contract.m.Payment.Count = this.Math.minf(1.0, this.Contract.m.Payment.Count + 0.25);
				}

				return "Negotiation";
			}

		});
	}

	if (this.Contract.m.Payment.Advance < 1.0)
	{
		this.Options.push({
			Text = (this.Contract.m.Payment.Advance == 0 ? "We need payment in advance." : "We need more payment in advance."),
			function getResult()
			{
				if (!this.World.Retinue.hasFollower("follower.negotiator"))
				{
					if (this.Math.rand(1, 100) <= 10) {
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}
				}

				this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);
				this.Contract.m.Flags.increment("NegotiatingTries");

				local failChance = this.Math.min(90, this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance * 2);

				if (this.Math.rand(1, 100) <= failChance || this.Contract.m.Payment.Advance >= this.World.Assets.m.AdvancePaymentCap)
				{
					this.Contract.m.Payment.IsFinal = true;
					return "Overview"
				}
				else
				{
					this.Contract.m.Payment.IsFinal = false;

					if (this.Contract.m.Payment.Completion > 0 && this.Contract.m.Payment.Count > 0)
					{
						this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.125);
						this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.125);
					}
					else if (this.Contract.m.Payment.Count > 0)
					{
						this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.25);
					}
					else
					{
						this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.25);
					}

					this.Contract.m.Payment.Advance = this.Math.minf(1.0, this.Contract.m.Payment.Advance + 0.25);
				}

				return "Negotiation";
			}

		});
	}

	if (this.Contract.m.Payment.Completion < 1.0)
	{
		this.Options.push({
			Text = (this.Contract.m.Payment.Completion == 0 ? "We need payment once the work is done." : "We need more payment once the work is done."),
			function getResult()
			{
				if (!this.World.Retinue.hasFollower("follower.negotiator"))
				{
					if (this.Math.rand(1, 100) <= 10) {
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}
				}

				this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);
				this.Contract.m.Flags.increment("NegotiatingTries");

				local failChance = this.Math.min(90, this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance * 2);

				if (this.Math.rand(1, 100) <= failChance)
				{
					this.Contract.m.Payment.IsFinal = true;
					return "Overview"
				}
				else
				{
					this.Contract.m.Payment.IsFinal = false;

					if (this.Contract.m.Payment.Advance > 0 && this.Contract.m.Payment.Count > 0)
					{
						this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.125);
						this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.125);
					}
					else if (this.Contract.m.Payment.Count > 0)
					{
						this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.25);
					}
					else
					{
						this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.25);
					}

					this.Contract.m.Payment.Completion = this.Math.minf(1.0, this.Contract.m.Payment.Completion + 0.25);
				}

				return "Negotiation";
			}

		});
	}

	this.Options.push({
		Text = "Forget it, this isn\'t worth it.",
		function getResult()
		{
			this.World.Contracts.removeContract(this.Contract);
			this.World.State.getTownScreen().updateContracts();
			return 0;
		}

	});

	if (!this.Contract.m.Payment.IsNegotiating)
	{
		this.Text = "[img]gfx/ui/events/event_04.png[/img]{%They_employer% nods.%SPEECH_ON%Yes. Good. I was thinking about payment for your task earlier. | %They_employer% smiles.%SPEECH_ON%This will make you rich, my friend. | %They_employer% takes a deep breath.%SPEECH_ON%Very well, this is what I\'m prepared to offer you. | %They_employer% puts %their_employer% hand on your shoulder, smiling reaffirmingly.%SPEECH_ON%I think I know an adequate compensation for your services. | %They_employer% gesticulates with %their_employer% hands, pointing at %their_employer% fingers as if counting something, but it means nothing to you.%SPEECH_ON%Judging from experience, this is good payment for the task. | %They_employer% nods. %SPEECH_ON%You look able, so I am willing to pay quite a bit. | %They_employer% jingles with a bag of coins.%SPEECH_ON%This will be yours if you help me out on this. | %They_employer% opens the palm of %their_employer% hands.%SPEECH_ON%I\'m tight on crowns, so before you ask, this is all I have right now. | %SPEECH_ON%Rest assured that what I\'m offering you now is a fine prize for your work.} ";
		this.Contract.m.Payment.IsNegotiating = true;
	}
	else if (this.Contract.m.Payment.IsFinal)
	{
		this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%I refuse to pay any more for this.  | %SPEECH_START%Be reasonable.  | %SPEECH_START%No, no, no.  | %SPEECH_START%Who do you think you are? I tell you how you\'re getting paid.  | %They_employer% just looks at you sternly and shakes %their_employer% head.%SPEECH_ON% | %SPEECH_START%No, you are already getting more than you\'re worth.  | %SPEECH_START%No. Do not push me too far!  | %SPEECH_START%I don\'t think you quite understand how this works. We need to come to terms if you want to be paid for this. My offer still stands. }";
	}
	else
	{
		this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%This is it then?  | %They_employer% takes a deep breath.%SPEECH_ON% | %They_employer% sighs.%SPEECH_ON% | %SPEECH_START%Fair enough.  | %SPEECH_START%Fine, fine.  | %SPEECH_START%If it must be.  | %SPEECH_START%Fine. How about this?  | %SPEECH_START%Sure, sure, I understand.  | %SPEECH_START%Reasonable.  | %SPEECH_START%Interesting. I think this would be more appropiate then.  | %SPEECH_START%Would you take this instead?  | %SPEECH_START%Let me make the following offer.  | %SPEECH_ON%Fair. Would you accept this instead?  | %SPEECH_START%Very well. Given your demands I offer you this.  | %SPEECH_START%Let\'s get this over with quickly. Here is my new offer.  | %SPEECH_START%We\'re all friends here, aren\'t we? Let\'s see... }";
	}

	if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance == 0 && this.Contract.m.Payment.Count == 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_completion% crowns when the contract is done.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count == 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid} all %reward_advance% crowns in advance.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance == 0 && this.Contract.m.Payment.Count != 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_count% crowns per head you bring back, {for up to %maxcount% heads | and I\'ll pay for up to %maxcount% heads | %maxcount% heads at most}.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count == 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_advance% crowns in advance, and another %reward_completion% when the job is done.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count != 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_advance% crowns in advance, and another %reward_count% crowns per head you bring back, {for up to %maxcount% heads | and I\'ll pay for up to %maxcount% heads | %maxcount% heads at most}.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance == 0 && this.Contract.m.Payment.Count != 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_count% crowns per head you return with, {for up to %maxcount% heads | and I\'ll pay for up to %maxcount% heads | %maxcount% heads at most}, and another %reward_completion% when the job is done.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count != 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_advance% crowns in advance, %reward_count% crowns per head you bring, {for up to %maxcount% heads | and I\'ll pay for up to %maxcount% heads | %maxcount% heads at most}, and another %reward_completion% when the job is done.%SPEECH_OFF%";
	}
	else
	{
		this.Text += "You\'ll be paid nothing. Is that what you want?%SPEECH_OFF%";
	}
};
::Const.Contracts.NegotiationPerHead[1].Text = "[img]gfx/ui/events/event_74.png[/img]{%SPEECH_START%You act as if you were the only ones to hold a sword for coin. I think I\'ll look elsewhere for the men I need. Good day.%SPEECH_OFF% | %SPEECH_START%My patience has limits, too, and I think I\'m wasting my time here.%SPEECH_OFF% | %SPEECH_START%I\'ve had enough of this! I\'m sure I\'ll find someone else to do the job!%SPEECH_OFF% | %SPEECH_START%Do not insult my intelligence! Forget about this contract. We\'re done.%SPEECH_OFF% | %Their_employer% face turns red with anger.%SPEECH_ON%Get out of here, I\'m not in the habit of making deals with greedy devils!%SPEECH_OFF% | %They_employer% sighs. %SPEECH_ON%Just... forget it. I shouldn\'t have trusted you in the first place. Leave me so I can look for other, more sensible men.%SPEECH_OFF% | %SPEECH_START%I really thought we had a good relationship here. But know that I can only be pushed so far. I don\'t think this is working out. I\'ll take my leave.%SPEECH_OFF% | %SPEECH_START%This has been an utter waste of time for me. Don\'t bother coming back until you learned some reason.%SPEECH_OFF%}";

::Const.Contracts.NegotiationPerHeadAtDestination[0].start <- function()
{
	this.Options = [];
	this.Options.push({
		Text = "I accept your offer.",
		function getResult()
		{
			this.Contract.m.BulletpointsPayment = [];

			if (this.Contract.m.Payment.Advance != 0)
			{
				this.Contract.m.BulletpointsPayment.push("Get " + this.Contract.m.Payment.getInAdvance() + " crowns in advance");
			}

			if (this.Contract.m.Payment.Count != 0)
			{
				this.Contract.m.BulletpointsPayment.push("Get " + this.Contract.m.Payment.getPerCount() + " crowns per head you arrive with, up to " + this.Contract.m.Payment.MaxCount + " total");
			}

			if (this.Contract.m.Payment.Completion != 0)
			{
				this.Contract.m.BulletpointsPayment.push("Get " + this.Contract.m.Payment.getOnCompletion() + " crowns on completion");
			}

			return "Overview";
		}

	});
	this.Options.push({
		Text = "We need to be paid more for this.",
		function getResult()
		{
			if (!this.World.Retinue.hasFollower("follower.negotiator"))
			{
				if (this.Math.rand(1, 100) <= 66) {
					this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
				}
			}
			else
			{
				if (this.Math.rand(1, 100) <= 10) {
					this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
				}
			}


			this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

			local failChance = this.Math.min(90, this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance);

			if (this.Math.rand(1, 100) <= failChance)
			{
				return "Negotiation.Fail";
			}
			else if (this.Math.rand(1, 100) <= failChance)
			{
				this.Contract.m.Payment.IsFinal = true;
				this.Contract.m.Flags.increment("NegotiatingTries");
				return "Overview"
			}
			else
			{
				this.Contract.m.Payment.IsFinal = false;
				this.Contract.m.Flags.increment("NegotiatingTries");
				if (this.World.Retinue.hasFollower("follower.negotiator"))
				{
					this.Contract.m.Payment.Pool = this.Contract.m.Payment.Pool * (1.0 + this.Math.rand(3, 10) * 0.01);
				}
				else
				{
					this.Contract.m.Payment.Pool = this.Contract.m.Payment.Pool * (1.0 + this.Math.rand(6, 15) * 0.01);
				}

			}

			return "Negotiation";
		}

	});

	if (this.Contract.m.Payment.Count < 1.0)
	{
		this.Options.push({
			Text = (this.Contract.m.Payment.Count == 0 ? "We need to be paid per head we arrive with." : "We need to be paid more per head we arrive with."),
			function getResult()
			{
				if (!this.World.Retinue.hasFollower("follower.negotiator"))
				{
					if (this.Math.rand(1, 100) <= 66) {
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}
				}
				else
				{
					if (this.Math.rand(1, 100) <= 10) {
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}
				}


				this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

				local failChance = this.Math.min(90, this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance);

				if (this.Math.rand(1, 100) <= failChance)
				{
					return "Negotiation.Fail";
				}
				else if (this.Math.rand(1, 100) <= failChance)
				{
					this.Contract.m.Payment.IsFinal = true;
					this.Contract.m.Flags.increment("NegotiatingTries");
					return "Overview"
				}
				else
				{
					this.Contract.m.Payment.IsFinal = false;
					this.Contract.m.Flags.increment("NegotiatingTries");

					if (this.Contract.m.Payment.Completion > 0 && this.Contract.m.Payment.Advance > 0)
					{
						this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.125);
						this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.125);
					}
					else if (this.Contract.m.Payment.Advance > 0)
					{
						this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.25);
					}
					else
					{
						this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.25);
					}

					this.Contract.m.Payment.Count = this.Math.minf(1.0, this.Contract.m.Payment.Count + 0.25);
				}

				return "Negotiation";
			}

		});
	}

	if (this.Contract.m.Payment.Advance < 1.0)
	{
		this.Options.push({
			Text = (this.Contract.m.Payment.Advance == 0 ? "We need payment in advance." : "We need more payment in advance."),
			function getResult()
			{
				if (!this.World.Retinue.hasFollower("follower.negotiator"))
				{
					if (this.Math.rand(1, 100) <= 10) {
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}
				}

				this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);
				this.Contract.m.Flags.increment("NegotiatingTries");

				local failChance = this.Math.min(90, this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance * 2);

				if (this.Math.rand(1, 100) <= failChance || this.Contract.m.Payment.Advance >= this.World.Assets.m.AdvancePaymentCap)
				{
					this.Contract.m.Payment.IsFinal = true;
					return "Overview"
				}
				else
				{
					this.Contract.m.Payment.IsFinal = false;

					if (this.Contract.m.Payment.Completion > 0 && this.Contract.m.Payment.Count > 0)
					{
						this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.125);
						this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.125);
					}
					else if (this.Contract.m.Payment.Count > 0)
					{
						this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.25);
					}
					else
					{
						this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.25);
					}

					this.Contract.m.Payment.Advance = this.Math.minf(1.0, this.Contract.m.Payment.Advance + 0.25);
				}

				return "Negotiation";
			}

		});
	}

	if (this.Contract.m.Payment.Completion < 1.0)
	{
		this.Options.push({
			Text = (this.Contract.m.Payment.Completion == 0 ? "We need payment once the work is done." : "We need more payment once the work is done."),
			function getResult()
			{
				if (!this.World.Retinue.hasFollower("follower.negotiator"))
				{
					if (this.Math.rand(1, 100) <= 10) {
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}
				}

				this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);
				this.Contract.m.Flags.increment("NegotiatingTries");

				local failChance = this.Math.min(90, this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance * 2);

				if (this.Math.rand(1, 100) <= failChance)
				{
					this.Contract.m.Payment.IsFinal = true;
					return "Overview"
				}
				else
				{
					this.Contract.m.Payment.IsFinal = false;

					if (this.Contract.m.Payment.Advance > 0 && this.Contract.m.Payment.Count > 0)
					{
						this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.125);
						this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.125);
					}
					else if (this.Contract.m.Payment.Count > 0)
					{
						this.Contract.m.Payment.Count = this.Math.maxf(0.0, this.Contract.m.Payment.Count - 0.25);
					}
					else
					{
						this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.25);
					}

					this.Contract.m.Payment.Completion = this.Math.minf(1.0, this.Contract.m.Payment.Completion + 0.25);
				}

				return "Negotiation";
			}

		});
	}

	this.Options.push({
		Text = "Forget it, this isn\'t worth it.",
		function getResult()
		{
			this.World.Contracts.removeContract(this.Contract);
			this.World.State.getTownScreen().updateContracts();
			return 0;
		}

	});

	if (!this.Contract.m.Payment.IsNegotiating)
	{
		this.Text = "[img]gfx/ui/events/event_04.png[/img]{%They_employer% nods.%SPEECH_ON%Yes. Good. I was thinking about payment for your task earlier. | %They_employer% smiles.%SPEECH_ON%This will make you rich, my friend. | %They_employer% takes a deep breath.%SPEECH_ON%Very well, this is what I\'m prepared to offer you. | %They_employer% puts %their_employer% hand on your shoulder, smiling reaffirmingly.%SPEECH_ON%I think I know an adequate compensation for your services. | %They_employer% gesticulates with %their_employer% hands, pointing at %their_employer% fingers as if counting something, but it means nothing to you.%SPEECH_ON%Judging from experience, this is good payment for the task. | %They_employer% nods. %SPEECH_ON%You look able, so I am willing to pay quite a bit. | %They_employer% jingles with a bag of coins.%SPEECH_ON%This will be yours if you help me out on this. | %They_employer% opens the palm of %their_employer% hands.%SPEECH_ON%I\'m tight on crowns, so before you ask, this is all I have right now. | %SPEECH_ON%Rest assured that what I\'m offering you now is a fine prize for your work.} ";
		this.Contract.m.Payment.IsNegotiating = true;
	}
	else if (this.Contract.m.Payment.IsFinal)
	{
		this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%I refuse to pay any more for this.  | %SPEECH_START%Be reasonable.  | %SPEECH_START%No, no, no.  | %SPEECH_START%Who do you think you are? I tell you how you\'re getting paid.  | %They_employer% just looks at you sternly and shakes %their_employer% head.%SPEECH_ON% | %SPEECH_START%No, you are already getting more than you\'re worth.  | %SPEECH_START%No. Do not push me too far!  | %SPEECH_START%I don\'t think you quite understand how this works. We need to come to terms if you want to be paid for this. My offer still stands. }";
	}
	else
	{
		this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%This is it then?  | %They_employer% takes a deep breath.%SPEECH_ON% | %They_employer% sighs.%SPEECH_ON% | %SPEECH_START%Fair enough.  | %SPEECH_START%Fine, fine.  | %SPEECH_START%If it must be.  | %SPEECH_START%Fine. How about this?  | %SPEECH_START%Sure, sure, I understand.  | %SPEECH_START%Reasonable.  | %SPEECH_START%Interesting. I think this would be more appropiate then.  | %SPEECH_START%Would you take this instead?  | %SPEECH_START%Let me make the following offer.  | %SPEECH_ON%Fair. Would you accept this instead?  | %SPEECH_START%Very well. Given your demands I offer you this.  | %SPEECH_START%Let\'s get this over with quickly. Here is my new offer.  | %SPEECH_START%We\'re all friends here, aren\'t we? Let\'s see... }";
	}

	if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance == 0 && this.Contract.m.Payment.Count == 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_completion% crowns when the contract is done.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count == 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid} all %reward_advance% crowns in advance.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance == 0 && this.Contract.m.Payment.Count != 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_count% crowns per head you arrive with, {for up to %maxcount% heads | and I\'ll pay for up to %maxcount% heads | %maxcount% heads at most}.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count == 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_advance% crowns in advance, and another %reward_completion% when the job is done.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count != 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_advance% crowns in advance, and another %reward_count% crowns per head you arrive with, {for up to %maxcount% heads | and I\'ll pay for up to %maxcount% heads | %maxcount% heads at most}.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance == 0 && this.Contract.m.Payment.Count != 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_count% crowns per head you arrive with, {for up to %maxcount% heads | and I\'ll pay for up to %maxcount% heads | %maxcount% heads at most}, and another %reward_completion% when the job is done.%SPEECH_OFF%";
	}
	else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance != 0 && this.Contract.m.Payment.Count != 0)
	{
		this.Text += "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_advance% crowns in advance, %reward_count% crowns per head you arrive with, {for up to %maxcount% heads | and I\'ll pay for up to %maxcount% heads | %maxcount% heads at most}, and another %reward_completion% when the job is done.%SPEECH_OFF%";
	}
	else
	{
		this.Text += "You\'ll be paid nothing. Is that what you want?%SPEECH_OFF%";
	}
};
::Const.Contracts.NegotiationPerHeadAtDestination[1].Text = "[img]gfx/ui/events/event_74.png[/img]{%SPEECH_START%You act as if you were the only ones to hold a sword for coin. I think I\'ll look elsewhere for the men I need. Good day.%SPEECH_OFF% | %SPEECH_START%My patience has limits, too, and I think I\'m wasting my time here.%SPEECH_OFF% | %SPEECH_START%I\'ve had enough of this! I\'m sure I\'ll find someone else to do the job!%SPEECH_OFF% | %SPEECH_START%Do not insult my intelligence! Forget about this contract. We\'re done.%SPEECH_OFF% | %Their_employer% face turns red with anger.%SPEECH_ON%Get out of here, I\'m not in the habit of making deals with greedy devils!%SPEECH_OFF% | %They_employer% sighs. %SPEECH_ON%Just... forget it. I shouldn\'t have trusted you in the first place. Leave me so I can look for other, more sensible men.%SPEECH_OFF% | %SPEECH_START%I really thought we had a good relationship here. But know that I can only be pushed so far. I don\'t think this is working out. I\'ll take my leave.%SPEECH_OFF% | %SPEECH_START%This has been an utter waste of time for me. Don\'t bother coming back until you learned some reason.%SPEECH_OFF%}";
