::mods_hookExactClass("skills/actives/footwork", function (o) {
	o.m.IsFootwork <- false;

	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Use skillful footwork to leave a Zone of Control without triggering attacks of opportunity or alternatively moving quickly to an adjacent tile.";
	}

	o.getTooltip = function () {
		local ret = this.getDefaultUtilityTooltip();
		if (this.getContainer().getActor().getCurrentProperties().IsRooted) {
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used while rooted[/color]"
			});
		}
		return ret;
	}

	o.onAfterUpdate = function (_properties) {
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendBackflip) && this.m.IsFootwork) {
			this.m.MaxRange = 2;
		}
		if (this.m.IsFootwork) {
			this.m.FatigueCost -= 5;
			this.m.ActionPointCost -= 2;
		}

		_properties.SkillCostAdjustments.push({
			// fix vanilla with hard setting fat cost in onAfterUpdate
			ID = this.m.ID,
			APAdjust = ::Legends.Effects.has(this.getContainer(), ::Legends.Effect.GoblinGruntPotion) ? -1: 0,
			FatigueMultAdjust = _properties.IsFleetfooted ? 0.5: 1.0
		});
	}

	o.onUpdate <- function (_properties) {
		this.m.IsFootwork = this.getContainer().getActor().isEngagedInMelee();
	}

	o.isUsable = function () {
		return this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted;
	}
});
