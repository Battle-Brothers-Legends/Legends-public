::mods_hookExactClass("entity/world/settlement_modifiers", function(o) {
	o.StablesMult <- 1.0;

	local reset = o.reset;
	o.reset = function () {
		reset();
		this.StablesMult = 1.0;

		switch (this.World.Assets.getEconomicDifficulty()) {
			case this.Const.Difficulty.Easy:
				this.RecruitsMult = 2.0;
				break;
			case this.Const.Difficulty.Normal:
				this.RecruitsMult = 1.5;
				break;
			case this.Const.Difficulty.Hard:
				this.RecruitsMult = 1.0;
				break;
			case this.Const.Difficulty.Legendary:
				this.RecruitsMult = 0.5;
				break;
		}
	}
});
