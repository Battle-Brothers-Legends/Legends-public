/**
* For item reward based contracts.
* This contract negotiation template requires `this.Contract.m.Payment.ItemPool` being not empty.
* Monetary compensation will be converted to items defined in that list.
* It does not support both money and items at once.
*/
// TODO, doesn't work, to be fixed
::Const.Contracts.NegotiationMoneyAndItems <- @(_count) [{
	ID = "Negotiation",
	Title = "Negotiations",
	Text = "",
	Image = "",
	List = [],
	ShowEmployer = true,
	ShowDifficulty = true,
	Options = [],
	function start() {
		while (this.Contract.m.Payment.Items.len() < _count) {
			local item = ::Const.World.Common.pickItem(this.Contract.m.Payment.ItemPool, "scripts/items/");
			this.Contract.m.Payment.Items.push(item);
			this.Contract.m.Payment.Pool -= item.getValue() / 2;
		}

		this.Options = [];
		this.Options.push({
			Text = "I accept your offer.",
			function getResult() {
				::Const.Contracts.Negotiation.createBulletPoints(this.Contract);
				if (this.Contract.m.Payment.Items.len() != 0) {
					this.Contract.m.BulletpointsPayment.push("Get " + this.Contract.m.Payment.Items.len() + " various items on completion");
				}

				return "Overview";
			}
		});
		this.Options.push({
			Text = "{We need to be paid more for this.}",
			function getResult() {
				::Const.Contracts.Negotiation.addAskMalus(this.Contract, 10, 66);
				
				this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * (::World.Assets.m.ProfessionEffect.LegendNegotiator > 0 ? ::World.Assets.m.ProfessionEffect.LegendNegotiator.m.NegotiationAnnoyanceMult : 1.0));

				if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance) {
					return "Negotiation.Fail";
				}

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance) {
					this.Contract.m.Payment.IsFinal = true;
				} else {
					this.Contract.m.Payment.IsFinal = false;
					this.Contract.m.Payment.Pool += 200;
				}

				return "Negotiation";
			}

		});

		this.Options.push({
			Text = "{Forget it, this isn\'t worth it. | What a waste of time. }",
			function getResult() {
				this.World.Contracts.removeContract(this.Contract);
				this.World.State.getTownScreen().updateContracts();
				return 0;
			}
		});

		if (this.Contract.m.Payment.Advance < 1.0)
		{
			this.Options.push({
				Text = this.Contract.m.Payment.Advance == 0 ? "We need payment in advance." : "We need more payment in advance.",
				function getResult()
				{
					this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * (::World.Assets.m.ProfessionEffect.LegendNegotiator > 0 ? ::World.Assets.m.ProfessionEffect.LegendNegotiator.m.NegotiationAnnoyanceMult : 1.0));

					if (this.Contract.m.Payment.Advance >= (::World.Assets.m.ProfessionEffect.LegendNegotiator > 0 ? ::World.Assets.m.ProfessionEffect.LegendNegotiator.m.AdvancePaymentCap : 0.5) || this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
					{
						return "Negotiation.Fail";
					}

					if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
					{
						this.Contract.m.Payment.IsFinal = true;
					}
					else
					{
						this.Contract.m.Payment.IsFinal = false;
						this.Contract.m.Payment.Advance = this.Math.minf(1.0, this.Contract.m.Payment.Advance + 0.25);
						this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.25);
					}

					return "Negotiation";
				}
			});
		}


		if (this.Contract.m.Payment.Completion < 1.0)
		{
			this.Options.push({
				Text = this.Contract.m.Payment.Completion == 0 ? "We need payment once the work is done." : "We need more payment once the work is done.",
				function getResult()
				{
					this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * (::World.Assets.m.ProfessionEffect.LegendNegotiator > 0 ? ::World.Assets.m.ProfessionEffect.LegendNegotiator.m.NegotiationAnnoyanceMult : 1.0));

					if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
					{
						return "Negotiation.Fail";
					}

					if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
					{
						this.Contract.m.Payment.IsFinal = true;
					}
					else
					{
						this.Contract.m.Payment.IsFinal = false;
						this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.25);
						this.Contract.m.Payment.Completion = this.Math.minf(1.0, this.Contract.m.Payment.Completion + 0.25);
					}

					return "Negotiation";
				}

			});
		}

		this.Text = ::Const.Contracts.Negotiation.setNegotiationText(this.Contract) + ::Const.Contracts.Negotiation.setNegotiationPayoutText(this.Contract, true);
		if (this.Contract.m.Payment.Items.len() != 0) {
			this.Text += "%SPEECH_START%{You\'ll also get} this pile of %reward_item_count% items when the contract is done.%SPEECH_OFF%";
			this.List.extend(this.Contract.getPaymentItems());
		}
	}
}, {
	ID = "Negotiation.Fail",
	Title = "Negotiations",
	Text = ::Const.Contracts.Negotiation.setNegotiationFailureText(),
	Image = "",
	List = [],
	ShowEmployer = true,
	ShowDifficulty = true,
	Options = [
		{
			Text = "We won\'t risk our lives for such meager pay...",
			function getResult() {
				::World.Contracts.removeContract(this.Contract);
				return 0;
			}

		}
	]
}];
