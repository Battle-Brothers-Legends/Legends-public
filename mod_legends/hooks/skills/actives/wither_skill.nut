::mods_hookExactClass("skills/actives/wither_skill", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Wither a target for three turns, reducing their damage, fatigue and initiative by [color=%negative%]-30%[/color]. The effect reduces by 10% each turn.";
		this.m.IsRanged = true;
		this.m.IconDisabled = ::Legends.Actives.ActiveDefObjects[::Legends.Active.Wither].IconDisabled;
	}

	o.getTooltip <- function () {
		return this.skill.getDefaultUtilityTooltip();
	}

	o.onAfterUpdate <- function (_properties) {
		if (_properties.IsSpecializedInStaves) {
			this.m.FatigueCostMult = ::Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost -= 1;
			this.m.MaxRange += 1;
		}
	}
});
