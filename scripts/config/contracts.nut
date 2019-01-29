local gt = this.getroottable();

if (!("Contracts" in gt.Const))
{
	gt.Const.Contracts <- {};
}

gt.Const.Contracts.Settings <- {
	NegotiationMaxAnnoyance = 9,
	NegotiationAnnoyanceGainMin = 3,
	NegotiationAnnoyanceGainMax = 6,
	NegotiationRefuseChance = 10,
	PaymentOnCompletionMult = 1.0,
	PaymentInAdvanceMult = 0.75,
	PaymentPerHeadMult = 0.0500000007,
	IntroChance = 20
};
