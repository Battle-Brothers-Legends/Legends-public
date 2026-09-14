::Const.Contracts.Negotiation <- {};

::Const.Contracts.Negotiation.setNegotiationText <- function (_contract) {
	if (!_contract.m.Payment.IsNegotiating)	{
		return "[img]gfx/ui/events/event_04.png[/img]{%They_employer% nods.%SPEECH_ON%Yes. Good. I was thinking about payment for your task earlier. | %They_employer% smiles.%SPEECH_ON%This will make you rich, my friend. | %They_employer% takes a deep breath.%SPEECH_ON%Very well, this is what I\'m prepared to offer you. | %They_employer% puts %their_employer% hand on your shoulder, smiling reaffirmingly.%SPEECH_ON%I think I know an adequate compensation for your services. | %They_employer% gesticulates with %their_employer% hands, pointing at %their_employer% fingers as if counting something, but it means nothing to you.%SPEECH_ON%Judging from experience, this is good payment for the task. | %They_employer% nods. %SPEECH_ON%You look able, so I am willing to pay quite a bit. | %They_employer% jingles with a bag of coins.%SPEECH_ON%This will be yours if you help me out on this. | %They_employer% opens the palm of %their_employer% hands.%SPEECH_ON%I\'m tight on crowns, so before you ask, this is all I have right now. | %SPEECH_ON%Rest assured that what I\'m offering you now is a fine prize for your work.} ";
		_contract.m.Payment.IsNegotiating = true;
	} else if (_contract.m.Payment.IsFinal)	{
		return "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%I refuse to pay any more for this.  | %SPEECH_START%Be reasonable.  | %SPEECH_START%No, no, no.  | %SPEECH_START%Who do you think you are? I tell you how you\'re getting paid.  | %They_employer% just looks at you sternly and shakes %their_employer% head.%SPEECH_ON% | %SPEECH_START%No, you are already getting more than you\'re worth.  | %SPEECH_START%No. Do not push me too far!  | %SPEECH_START%I don\'t think you quite understand how this works. We need to come to terms if you want to be paid for this. My offer still stands. }";
	} else {
		return "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%This is it then?  | %They_employer% takes a deep breath.%SPEECH_ON% | %They_employer% sighs.%SPEECH_ON% | %SPEECH_START%Fair enough.  | %SPEECH_START%Fine, fine.  | %SPEECH_START%If it must be.  | %SPEECH_START%Fine. How about this?  | %SPEECH_START%Sure, sure, I understand.  | %SPEECH_START%Reasonable.  | %SPEECH_START%Interesting. I think this would be more appropiate then.  | %SPEECH_START%Would you take this instead?  | %SPEECH_START%Let me make the following offer.  | %SPEECH_ON%Fair. Would you accept this instead?  | %SPEECH_START%Very well. Given your demands I offer you this.  | %SPEECH_START%Let\'s get this over with quickly. Here is my new offer.  | %SPEECH_START%We\'re all friends here, aren\'t we? Let\'s see... }";
	}
}

::Const.Contracts.Negotiation.setNegotiationPayoutText <- function (_contract, _return) {
	if (_contract.m.Payment.Completion != 0 && _contract.m.Payment.Advance == 0 && _contract.m.Payment.Count == 0) {
		return "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_completion% crowns when the contract is done.%SPEECH_OFF%";
	} else if (_contract.m.Payment.Completion == 0 && _contract.m.Payment.Advance != 0 && _contract.m.Payment.Count == 0) {
		return "{You\'ll get | You are to receive | You\'ll be paid} all %reward_advance% crowns in advance.%SPEECH_OFF%";
	} else if (_contract.m.Payment.Completion == 0 && _contract.m.Payment.Advance == 0 && _contract.m.Payment.Count != 0) {
		return "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_count% crowns per head you " + (_return ? "bring back" : "arrive with") + ", {for up to %maxcount% heads | and I\'ll pay for up to %maxcount% heads | %maxcount% heads at most}.%SPEECH_OFF%";
	} else if (_contract.m.Payment.Completion != 0 && _contract.m.Payment.Advance != 0 && _contract.m.Payment.Count == 0) {
		return "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_advance% crowns in advance, and another %reward_completion% when the job is done.%SPEECH_OFF%";
	} else if (_contract.m.Payment.Completion == 0 && _contract.m.Payment.Advance != 0 && _contract.m.Payment.Count != 0) {
		return "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_advance% crowns in advance, and another %reward_count% crowns per head you " + (_return ? "bring back" : "arrive with") + ", {for up to %maxcount% heads | and I\'ll pay for up to %maxcount% heads | %maxcount% heads at most}.%SPEECH_OFF%";
	} else if (_contract.m.Payment.Completion != 0 && _contract.m.Payment.Advance == 0 && _contract.m.Payment.Count != 0) {
		return "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_count% crowns per head you " + (_return ? "return" : "arrive") + " with, {for up to %maxcount% heads | and I\'ll pay for up to %maxcount% heads | %maxcount% heads at most}, and another %reward_completion% when the job is done.%SPEECH_OFF%";
	} else if (_contract.m.Payment.Completion != 0 && _contract.m.Payment.Advance != 0 && _contract.m.Payment.Count != 0) {
		return "{You\'ll get | You are to receive | You\'ll be paid | It\'s} %reward_advance% crowns in advance, %reward_count% crowns per head you " + (_return ? "bring" : "arrive with") + ", {for up to %maxcount% heads | and I\'ll pay for up to %maxcount% heads | %maxcount% heads at most}, and another %reward_completion% when the job is done.%SPEECH_OFF%";
	} else {
		return "You\'ll be paid nothing. Is that what you want?%SPEECH_OFF%";
	}
}

::Const.Contracts.Negotiation.setNegotiationFailureText <- function () {
	return "[img]gfx/ui/events/event_74.png[/img]{%SPEECH_START%You act as if you were the only ones to hold a sword for coin. I think I\'ll look elsewhere for the men I need. Good day.%SPEECH_OFF% | %SPEECH_START%My patience has limits, too, and I think I\'m wasting my time here.%SPEECH_OFF% | %SPEECH_START%I\'ve had enough of this! I\'m sure I\'ll find someone else to do the job!%SPEECH_OFF% | %SPEECH_START%Do not insult my intelligence! Forget about this contract. We\'re done.%SPEECH_OFF% | %Their_employer% face turns red with anger.%SPEECH_ON%Get out of here, I\'m not in the habit of making deals with greedy devils!%SPEECH_OFF% | %They_employer% sighs. %SPEECH_ON%Just... forget it. I shouldn\'t have trusted you in the first place. Leave me so I can look for other, more sensible men.%SPEECH_OFF% | %SPEECH_START%I really thought we had a good relationship here. But know that I can only be pushed so far. I don\'t think this is working out. I\'ll take my leave.%SPEECH_OFF% | %SPEECH_START%This has been an utter waste of time for me. Don\'t bother coming back until you learned some reason.%SPEECH_OFF%}";
}

::Const.Contracts.Negotiation.createBulletPoints <- function (_contract) {
	_contract.m.BulletpointsPayment = [];

	if (_contract.m.Payment.Advance != 0) {
		_contract.m.BulletpointsPayment.push("Get " + _contract.m.Payment.getInAdvance() + " crowns in advance");
	}

	if (_contract.m.Payment.Count != 0) {
		_contract.m.BulletpointsPayment.push("Get " + _contract.m.Payment.getPerCount() + " crowns per head you arrive with, up to " + _contract.m.Payment.MaxCount + " total");
	}

	if (_contract.m.Payment.Completion != 0) {
		_contract.m.BulletpointsPayment.push("Get " + _contract.m.Payment.getOnCompletion() + " crowns on completion");
	}
}

// record the NegotiatingTries flag
foreach (option in ::Const.Contracts.Overview[0].Options) {
	if (option.Text != "I accept this contract.")
		continue;

	local getResult = option.getResult;
	option.getResult <- function() {
		::World.Statistics.getFlags().increment("NegotiatingTries", this.Contract.m.Flags.getAsInt("NegotiatingTries"));
		return getResult();
	};
	break;
}

local OverviewStart = ::Const.Contracts.Overview[0].start;
::Const.Contracts.Overview[0].start <- function() {
	::Const.Contracts.Negotiation.createBulletPoints(this.Contract);

	if (this.Contract.m.Payment.IsFinal)
		this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%I refuse to pay any more for this.%SPEECH_OFF%  | %SPEECH_START%Be reasonable.%SPEECH_OFF%  | %SPEECH_START%No, no and no.%SPEECH_OFF%  | %SPEECH_START%Who do you think you are? I tell you how much you\'re getting paid!%SPEECH_OFF%  | %They_employer% looks at you sternly and shakes %their_employer% head. | %SPEECH_START%No, you are already getting more than you\'re worth.%SPEECH_OFF%  | %SPEECH_START%No. Don\'t not push me too far!%SPEECH_OFF% | %SPEECH_START%This isn\'t worth that much to me.%SPEECH_OFF% | %SPEECH_START%I don\'t think you quite understand how this works. We need to come to terms if you want to be paid for this. My offer still stands.%SPEECH_OFF% }";
	OverviewStart();
}

// have to overwrite these
::Const.Contracts.NegotiationDefault[0].start <- function() {
	this.Options = [];
	this.Options.push({
		Text = "I accept your offer.",
		function getResult() {
			::Const.Contracts.Negotiation.createBulletPoints(this.Contract);
			return "Overview";
		}

	});
	this.Options.push({
		Text = "We need to be paid more for this.",
		getResult = @() ::Const.Contracts.Negotiation.askForMorePayment(this.Contract)
	});

	if (this.Contract.m.Payment.Advance < 1.0) {
		this.Options.push({
			Text = (this.Contract.m.Payment.Advance == 0 ? "We need payment in advance." : "We need more payment in advance."),
			getResult = @() ::Const.Contracts.Negotiation.askForAdvancePayment(this.Contract)
		});
	}

	if (this.Contract.m.Payment.Completion < 1.0) {
		this.Options.push({
			Text = (this.Contract.m.Payment.Completion == 0 ? "We need payment once the work is done." : "We need more payment once the work is done."),
			getResult = @() ::Const.Contracts.Negotiation.askForCompletionPayment(this.Contract)
		});
	}

	this.Options.push({
		Text = "Forget it, this isn\'t worth it.",
		function getResult() {
			::World.Contracts.removeContract(this.Contract);
			::World.State.getTownScreen().updateContracts();
			return 0;
		}

	});

	this.Text = ::Const.Contracts.Negotiation.setNegotiationText(this.Contract) + ::Const.Contracts.Negotiation.setNegotiationPayoutText(this.Contract, true);
};
::Const.Contracts.NegotiationDefault[1].Text = ::Const.Contracts.Negotiation.setNegotiationFailureText();

::Const.Contracts.NegotiationPerHead[0].start <- function() {
	this.Options = [];
	this.Options.push({
		Text = "I accept your offer.",
		function getResult() {
			::Const.Contracts.Negotiation.createBulletPoints(this.Contract);
			return "Overview";
		}

	});
	this.Options.push({
		Text = "We need to be paid more for this.",
		getResult = @() ::Const.Contracts.Negotiation.askForMorePayment(this.Contract)
	});

	if (this.Contract.m.Payment.Count < 1.0) {
		this.Options.push({
			Text = (this.Contract.m.Payment.Count == 0 ? "We need to be paid per head we return with." : "We need to be paid more per head we return with."),
			getResult = @() ::Const.Contracts.Negotiation.askForHeadPayment(this.Contract)
		});
	}

	if (this.Contract.m.Payment.Advance < 1.0) {
		this.Options.push({
			Text = (this.Contract.m.Payment.Advance == 0 ? "We need payment in advance." : "We need more payment in advance."),
			getResult = @() ::Const.Contracts.Negotiation.askForAdvanceHeadPayment(this.Contract)
		});
	}

	if (this.Contract.m.Payment.Completion < 1.0) {
		this.Options.push({
			Text = (this.Contract.m.Payment.Completion == 0 ? "We need payment once the work is done." : "We need more payment once the work is done."),
			getResult = @() ::Const.Contracts.Negotiation.askForCompletionHeadPayment(this.Contract)
		});
	}

	this.Options.push({
		Text = "Forget it, this isn\'t worth it.",
		function getResult() {
			this.World.Contracts.removeContract(this.Contract);
			this.World.State.getTownScreen().updateContracts();
			return 0;
		}
	});

	this.Text = ::Const.Contracts.Negotiation.setNegotiationText(this.Contract) + ::Const.Contracts.Negotiation.setNegotiationPayoutText(this.Contract, true);
};
::Const.Contracts.NegotiationPerHead[1].Text = ::Const.Contracts.Negotiation.setNegotiationFailureText();

::Const.Contracts.NegotiationPerHeadAtDestination[0].start <- function() {
	this.Options = [];
	this.Options.push({
		Text = "I accept your offer.",
		function getResult() {
			::Const.Contracts.Negotiation.createBulletPoints(this.Contract);
			return "Overview";
		}

	});
	this.Options.push({
		Text = "We need to be paid more for this.",
		getResult = @() ::Const.Contracts.Negotiation.askForMorePayment(this.Contract)
	});

	if (this.Contract.m.Payment.Count < 1.0) {
		this.Options.push({
			Text = (this.Contract.m.Payment.Count == 0 ? "We need to be paid per head we arrive with." : "We need to be paid more per head we arrive with."),
			getResult = @() ::Const.Contracts.Negotiation.askForHeadPayment(this.Contract)
		});
	}

	if (this.Contract.m.Payment.Advance < 1.0) {
		this.Options.push({
			Text = (this.Contract.m.Payment.Advance == 0 ? "We need payment in advance." : "We need more payment in advance."),
			getResult = @() ::Const.Contracts.Negotiation.askForAdvanceHeadPayment(this.Contract)
		});
	}

	if (this.Contract.m.Payment.Completion < 1.0) {
		this.Options.push({
			Text = (this.Contract.m.Payment.Completion == 0 ? "We need payment once the work is done." : "We need more payment once the work is done."),
			getResult = @() ::Const.Contracts.Negotiation.askForCompletionHeadPayment(this.Contract)
		});
	}

	this.Options.push({
		Text = "Forget it, this isn\'t worth it.",
		function getResult() {
			this.World.Contracts.removeContract(this.Contract);
			this.World.State.getTownScreen().updateContracts();
			return 0;
		}
	});

	this.Text = ::Const.Contracts.Negotiation.setNegotiationText(this.Contract) + ::Const.Contracts.Negotiation.setNegotiationPayoutText(this.Contract, false);
};
::Const.Contracts.NegotiationPerHeadAtDestination[1].Text = ::Const.Contracts.Negotiation.setNegotiationFailureText();



::Const.Contracts.Negotiation.askForMorePayment <- function (_contract) {
	::Const.Contracts.Negotiation.addAskMalus(_contract, 10, 66);

	local negotiationResult = ::Const.Contracts.Negotiation.getNegotiationResult(_contract, 1, true);
	if (negotiationResult == true) {
		_contract.m.Payment.Pool *= (::World.Assets.m.ProfessionEffect.LegendNegotiator > 0	? (1.0 + ::Math.rand(::Math.floor(4 * ::World.Assets.m.ProfessionEffect.LegendNegotiator), 10 * ::World.Assets.m.ProfessionEffect.LegendNegotiator) * 0.01)	: (1.0 + ::Math.rand(3, 10) * 0.01));
		return "Negotiation";
	} else {
		return negotiationResult;
	}
}

::Const.Contracts.Negotiation.askForHeadPayment <- function (_contract) {
	::Const.Contracts.Negotiation.addAskMalus(_contract, 10, 66);

	local negotiationResult = ::Const.Contracts.Negotiation.getNegotiationResult(_contract, 1, true);
	if (negotiationResult == true) {
		::Const.Contracts.Negotiation.switchPaymentType(_contract, "Count");
		return "Negotiation";
	} else {
		return negotiationResult;
	}
}

::Const.Contracts.Negotiation.askForAdvancePayment <- function (_contract) {
	::Const.Contracts.Negotiation.addAskMalus(_contract, 0, 10);

	local negotiationResult = ::Const.Contracts.Negotiation.getNegotiationResult(_contract, 2, false, _contract.m.Payment.Advance >= (::World.Assets.m.ProfessionEffect.LegendNegotiator > 0 ? ::World.Assets.m.ProfessionEffect.LegendNegotiator.m.AdvancePaymentCap : 0.5));
	if (negotiationResult == true) {
		local p = ((::World.Assets.m.ProfessionEffect.LegendNegotiator > 0 ? 2.0 : 1.0) * ::Math.rand(15, 30)) / 100.0;
		_contract.m.Payment.Advance = ::Math.minf(1.0, _contract.m.Payment.Advance + p);
		_contract.m.Payment.Completion = ::Math.maxf(0.0, _contract.m.Payment.Completion - p);
		return "Negotiation";
	} else {
		return negotiationResult;
	}
}

::Const.Contracts.Negotiation.askForAdvanceHeadPayment <- function (_contract) {
	::Const.Contracts.Negotiation.addAskMalus(_contract, 0, 10);

	local negotiationResult = ::Const.Contracts.Negotiation.getNegotiationResult(_contract, 2, false, _contract.m.Payment.Advance >= (::World.Assets.m.ProfessionEffect.LegendNegotiator > 0 ? ::World.Assets.m.ProfessionEffect.LegendNegotiator.m.AdvancePaymentCap : 0.5));
	if (negotiationResult == true) {
		::Const.Contracts.Negotiation.switchPaymentType(_contract, "Advance");
		return "Negotiation";
	} else {
		return negotiationResult;
	}
}

::Const.Contracts.Negotiation.askForCompletionPayment <- function (_contract) {
	::Const.Contracts.Negotiation.addAskMalus(_contract, 0, 10);

	local negotiationResult = ::Const.Contracts.Negotiation.getNegotiationResult(_contract, 2);
	if (negotiationResult == true) {
		local p = ((::World.Assets.m.ProfessionEffect.LegendNegotiator > 0 ? 2.0 : 1.0) * ::Math.rand(15, 30)) / 100.0;
		_contract.m.Payment.Advance = ::Math.maxf(0.0, _contract.m.Payment.Advance - p);
		_contract.m.Payment.Completion = ::Math.minf(1.0, _contract.m.Payment.Completion + p);
		return "Negotiation";
	} else {
		return negotiationResult;
	}
}

::Const.Contracts.Negotiation.askForCompletionHeadPayment <- function (_contract) {
	::Const.Contracts.Negotiation.addAskMalus(_contract, 0, 10);

	local negotiationResult = ::Const.Contracts.Negotiation.getNegotiationResult(_contract, 2);
	if (negotiationResult == true) {
		::Const.Contracts.Negotiation.switchPaymentType(_contract, "Completion");
		return "Negotiation";
	} else {
		return negotiationResult;
	}
}

::Const.Contracts.Negotiation.addAskMalus <- function (_contract, _chanceWithNegotiator, _chanceWithoutNegotiator) {
	if (::Math.rand(1, 100) <= (::World.Assets.m.ProfessionEffect.LegendNegotiator > 0 ? _chanceWithNegotiator : _chanceWithoutNegotiator)) {
		::World.FactionManager.getFaction(_contract.getFaction()).addPlayerRelationEx(-0.5);
	}
}

::Const.Contracts.Negotiation.getNegotiationResult <- function (_contract, _annoyanceMultiplier = 1 , _canNegotiationFail = false, _extraFailCondition = false) {
	_contract.m.Payment.Annoyance += ::Math.maxf(1.0, ::Math.rand(::Const.Contracts.Settings.NegotiationAnnoyanceGainMin, ::Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * (::World.Assets.m.ProfessionEffect.LegendNegotiator > 0	? ::World.Assets.m.ProfessionEffect.LegendNegotiator.m.NegotiationAnnoyanceMult : 1.0));
	local failChance = ::Math.min(90, ::Const.Contracts.Settings.NegotiationRefuseChance * _contract.m.Payment.Annoyance * _annoyanceMultiplier);

	if (_canNegotiationFail && ::Math.rand(1, 100) <= failChance) {
		return "Negotiation.Fail";
	} else if (::Math.rand(1, 100) <= failChance || _extraFailCondition) {
		_contract.m.Payment.IsFinal = true;
		_contract.m.Flags.increment("NegotiatingTries");
		return "Overview"
	} else {
		_contract.m.Flags.increment("NegotiatingTries");
		_contract.m.Payment.IsFinal = false;
		return true;
	}
}

::Const.Contracts.Negotiation.switchPaymentType <- function (_contract, _chosenType) {
	local otherTypes = ["Count", "Advance", "Completion"];
	otherTypes.remove(otherTypes.find(_chosenType));
	if (_contract.m.Payment[otherTypes[0]] > 0 && _contract.m.Payment[otherTypes[1]] > 0) {
		_contract.m.Payment[otherTypes[0]] = ::Math.maxf(0.0, _contract.m.Payment[otherTypes[0]] - 0.125);
		_contract.m.Payment[otherTypes[1]] = ::Math.maxf(0.0, _contract.m.Payment[otherTypes[1]] - 0.125);
	} else if (_contract.m.Payment[otherTypes[0]] > 0) {
		_contract.m.Payment[otherTypes[0]] = ::Math.maxf(0.0, _contract.m.Payment[otherTypes[0]] - 0.25);
	} else {
		_contract.m.Payment[otherTypes[1]] = ::Math.maxf(0.0, _contract.m.Payment[otherTypes[1]] - 0.25);
	}
	_contract.m.Payment[_chosenType] = ::Math.minf(1.0, _contract.m.Payment[_chosenType] + 0.25);
}
