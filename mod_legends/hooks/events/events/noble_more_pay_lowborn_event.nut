::mods_hookExactClass("events/events/noble_more_pay_lowborn_event", function(o) {
	o.onUpdateScore = function () {
		if (this.World.Assets.getMoney() < 500)
			return;

		if (this.World.Assets.getOrigin().getID() == "scenario.lone_wolf")
			return;

		if (this.World.Retinue.hasFollower("follower.paymaster"))
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local lowestPay = 1000;
		local lowestNoble;

		foreach( bro in brothers ) {
			if (bro.getSkills().hasTrait(::Legends.Trait.Player) || (bro.getFlags().get("IsPlayerCharacter")))
				continue;

			if (bro.getDailyCost() < lowestPay && bro.getBackground().isBackgroundType(this.Const.BackgroundType.Noble)) {
				lowestNoble = bro;
				lowestPay = bro.getDailyCost();
			}
		}

		if (lowestNoble == null)
			return;

		local lowborn_candidates = [];

		foreach( bro in brothers )
			if (bro.getDailyCost() > lowestPay && bro.getBackground().isBackgroundType(this.Const.BackgroundType.Lowborn) && bro.getBackground().getID() != "background.slave")
				lowborn_candidates.push(bro);

		if (lowborn_candidates.len() == 0)
			return;

		this.m.Noble = lowestNoble;
		this.m.Lowborn = lowborn_candidates[this.Math.rand(0, lowborn_candidates.len() - 1)];
		this.m.Score = 7 + (lowestNoble.getSkills().hasTrait(::Legends.Trait.Greedy) ? 9 : 0);
	}
})
