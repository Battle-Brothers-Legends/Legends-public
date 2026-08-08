::mods_hookExactClass("skills/actives/coat_with_poison_skill", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.IsStacking = false;
		this.m.Description = "Coat your weapons and arrowtips with poison. Can not be used while engaged in melee. Costs 0 Action Points during the first round of combat.";
	}

	o.onAfterUpdate <- function (_properties) {
		if (::Time.getRound() == 1) {
			this.m.ActionPointCost = 0;
		}
	}

	o.isHidden <- function () {
		return this.getCurrentItem().m.Ammo <= 0;
	}

	o.getCurrentItem <- function() { // search for more poison bottles if the one under this.m.Item is empty
        if (this.m.Item.m.Ammo <= 0) {
			local self = this;
			local filledPoisons = this.getContainer().getActor().getItems().getAllItems().filter(@(_,_item) (_item.getID() == self.m.Item.getID() && _item.m.Ammo > 0));
			foreach (item in filledPoisons) {
				this.setItem(item);
				return item;
			}
		}

        return this.m.Item;
    }

	o.isUsable = function () {
		local actor = this.getContainer().getActor();
		return (!::Tactical.isActive() || this.skill.isUsable()	&& !actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions())) && (this.getCurrentItem().m.Ammo > 0);
	}

	o.onUse = function (_user, _targetTile) {
		local poison = ::Legends.Effects.get(_user, ::Legends.Effect.PoisonCoat);

		if (poison != null) {
			poison.resetTime();
		} else {
			::Legends.Effects.grant(this.m.Container, ::Legends.Effect.PoisonCoat);
		}

		this.getCurrentItem().consumeAmmo();

		return true;
	}
});
