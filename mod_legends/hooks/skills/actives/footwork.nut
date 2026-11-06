::mods_hookExactClass("skills/actives/footwork", function (o) {
	o.m.IsFootwork <- false;
	o.m.IsQuickStep <- true;

	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Use skillful footwork to leave a Zone of Control without triggering attacks of opportunity or alternatively moving quickly to an adjacent tile.";
	}
	o.onAfterUpdate = function (_properties) {
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendBackflip) && this.m.IsFootwork) {
			this.m.MaxRange = 2;
		}
		if (this.m.IsFootwork) {
			this.m.FatigueCost = 15;
			this.m.ActionPointCost = 1;
		} else if (this.m.IsFootwork) {
			this.m.FatigueCost = 20;
			this.m.ActionPointCost = 3;
		}

		_properties.SkillCostAdjustments.push({
			// fix vanilla bullshit with hard setting fat cost in onAfterUpdate
			ID = this.m.ID,
			APAdjust = ::Legends.Effects.has(this.getContainer(), ::Legends.Effect.GoblinGruntPotion) ? -1: 0,
			FatigueMultAdjust = _properties.IsFleetfooted ? 0.5: 1.0
		});
	}

	o.onUpdate <- function (_properties) {
		this.m.IsFootwork = this.getContainer().getActor().isEngagedInMelee();
	}

	o.isUsable = function () {
		if (this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted) {
			return true;
		}
		return false;
	}
});
