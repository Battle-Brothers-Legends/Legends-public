::mods_hookExactClass("items/supplies/dried_fruits_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. Fruits from orchards are both tasty and nutritious. They are dried to preserve them longer. Can be eaten in battle to provide up to 3 healing and fatigue recovery over ten turns, based on the amount remaining. Will be used as provisions if left in the company stash.";
		this.m.Amount = 30.0;
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
