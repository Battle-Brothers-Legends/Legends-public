::mods_hookExactClass("items/supplies/cured_rations_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. These rations consist of assorted, well cured meats and vegetables that are sealed in small boxes. The ideal provision to take with you on long journeys and expeditions. Can be eaten in battle to provide up to 5 healing and fatigue recovery over ten turns, based on the amount remaining. Will be used as provisions if left in the company stash.";
		this.m.Value = 300;
		this.m.Amount = 50.0;
		this.m.GoodForDays = 14;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
	}

	o.onPutIntoBag <- function ()
	{
		this.onEquip();
	}

	o.onEquip <- function ()
	{
		this.food_item.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendEatRations, function (_skill) {
			_skill.setItem(this);
		}.bindenv(this));
	}
});
