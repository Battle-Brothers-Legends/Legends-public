::mods_hookExactClass("items/supplies/preserved_mead_item", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Provisions. This ashen liquid has small sparkles of silver swirrling about. The taste is off, but it hardly ever spoils. Can be drunk in battle to grant +9% resolve, melee and ranged skill in exchange for -36% initiative, and -18% melee defense and ranged defense. The effect lasts for three turns.";
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
			this.World.State.getPlayer().calculateStashModifier();
		}

		::Legends.Actives.grant(this, ::Legends.Active.LegendDrinkMead, function (_skill) {
			_skill.setItem(this);
		}.bindenv(this));
	}

	o.onUnequip <- function () {
		this.item.onUnequip();
		if (::World.State.getPlayer() != null && this.m.StashModifier > 0) {
			this.World.State.getPlayer().calculateStashModifier();
		}
	}
});
