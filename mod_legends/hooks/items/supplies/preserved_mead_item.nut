::mods_hookExactClass("items/supplies/preserved_mead_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. This ashen liquid has small sparkles of silver swirrling about. The taste is off, but it hardly ever spoils. Can be drunk in battle to grant +9% resolve, melee and ranged skill in exchange for -36% initiative, and -18% melee defense and ranged defense. The effect lasts for three turns.";
		this.m.Amount = 20.0;
		this.m.GoodForDays = 25;
	}

	o.getBuyPrice = function ()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = false;
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * this.World.State.getCurrentTown().getFoodPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseBuyPrice : this.Const.World.Assets.BuyPriceNotProducedHere)));
		}

		return this.item.getBuyPrice();
	}

	o.onPutIntoBag <- function ()
	{
		this.onEquip();
	}

	o.onEquip <- function ()
	{
		this.legend_usable_food.onEquip();
		local skill = this.new("scripts/skills/actives/legend_drink_mead_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}
});