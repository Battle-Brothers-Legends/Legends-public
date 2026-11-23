::mods_hookExactClass("items/supplies/wine_item", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Description = "Provisions. Wine made from squashed and fermented grapes. Both elaborate to produce and expensive to buy. Can be drunk in battle to gain +6% resolve, melee and ranged skill, at the expense of -12% initiative, melee and ranged defense. Will be used as provisions if left in the company stash";
		this.m.Value = 140;
		this.m.Amount = 35.0;
		this.m.GoodForDays = 11;
	}

	o.onPutIntoBag <- function() {
		this.onEquip();
	}

	o.onEquip <- function() {
		this.food_item.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendDrinkWine, function(_skill) {
			_skill.setItem(this);
		}.bindenv(this));
	}
});
