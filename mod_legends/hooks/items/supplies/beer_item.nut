::mods_hookExactClass("items/supplies/beer_item", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Provisions. This fermented hop or barley drink is more durable and safer to drink than plain water.  Can either be consumed as provisions or drunk in battle";
		this.m.Amount = 20.0;
		this.m.GoodForDays = 25;
		this.m.SlotType = ::Const.ItemSlot.Bag;
		this.m.IsAllowedInBag = true;
		this.m.IsChangeableInBattle = true;
	}

	o.onPutIntoBag <- function () {
		this.onEquip();
	}

	o.onEquip <- function () {
		this.item.onEquip();

		if (this.m.AddGenericSkill) {
			this.addGenericItemSkill();
		}

		if (::World.State.getPlayer() != null && this.m.StashModifier > 0) {
			::World.State.getPlayer().calculateStashModifier();
		}

		::Legends.Actives.grant(this, ::Legends.Active.LegendDrinkBeer, function (_skill) {
			_skill.setItem(this);
		}.bindenv(this));
	}

	o.onUnequip <- function () {
		this.item.onUnequip();
		if (::World.State.getPlayer() != null && this.m.StashModifier > 0) {
			::World.State.getPlayer().calculateStashModifier();
		}
	}
});
