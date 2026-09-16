::mods_hookExactClass("items/supplies/food_item", function (o) {
	o.m.AddGenericSkill <- true;
	o.m.StaminaModifier <- 0;
	o.m.StashModifier <- 0;
	o.m.IsRandomized <- false;
	o.m.MaxStack <- 0;

	o.isDesirable = function () {
		return this.m.IsUndesirable;
	}

	o.getValue = function () {
		if (this.m.IsRandomized) {
			return ::Math.floor(this.m.Amount / this.m.MaxStack * (this.getSpoilInDays() / (this.m.GoodForDays * 1.0)) * this.m.Value);
		}
		return ::Math.floor(1 * (this.getSpoilInDays() / (this.m.GoodForDays * 1.0)) * this.m.Value);
	}

	o.getBestBeforeTime = function () {
		return this.m.BestBefore + (("State" in ::World) && ::World.State != null ? ::World.Assets.m.ProfessionEffect.LegendFoodPreservation * ::World.getTime().SecondsPerDay : 0);
	}

	o.randomizeAmount = function () {
		this.m.IsRandomized = true;
		this.m.MaxStack = this.m.Amount;
		this.m.Amount = ::Math.rand(::Math.ceil(this.m.MaxStack * 0.4), this.m.MaxStack);
	}

	o.getStaminaModifier <- function () {
		return this.m.StaminaModifier;
	}

	o.getStashModifier <- function () {
		return this.m.StashModifier;
	}

	o.onUpdateProperties <- function (_properties) {}
});
