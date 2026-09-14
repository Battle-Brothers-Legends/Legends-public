::mods_hookExactClass("ai/world/orders/raid_order", function(o)
{
	o.onExecute = function ( _entity, _hasChanged ) {
		if (this.m.TargetTile != null && _entity.getTile().ID != this.m.TargetTile.ID) {
			local move = this.new("scripts/ai/world/orders/move_order");
			move.setDestination(this.m.TargetTile);
			this.getController().addOrderInFront(move);
			return true;
		}

		_entity.setOrders("Raiding");

		if (this.m.Start == 0.0)
		{
			this.m.Start = this.Time.getVirtualTimeF();
		}
		else if (this.Time.getVirtualTimeF() - this.m.Start >= this.m.Time)
		{
			local entities = this.World.getAllEntitiesAndOneLocationAtPos(_entity.getPos(), 1.0);

			foreach( e in entities ) {
				if (!e.isLocation())
					continue;
				if (!::MSU.isKindOf(e, "settlement"))
					continue;

				e.setActive(false);

				if (e.getSettlement() != null && !e.getSettlement().isNull() && e.getSettlement().isAlive()) {
					local situation;
					local f = this.World.FactionManager.getFaction(_entity.getFaction());

					if (f != null && (f.getType() == this.Const.FactionType.Undead || f.getType() == this.Const.FactionType.Zombies)) {
						situation = this.new("scripts/entity/world/settlements/situations/terrified_villagers_situation");
					} else {
						situation = this.new("scripts/entity/world/settlements/situations/raided_situation");
					}

					situation.setValidForDays(2);
					e.getSettlement().addSituation(situation);
				}

				break;
			}

			this.getController().popOrder();
		}

		if (!this.m.IsBurning) {
			this.m.IsBurning = true;
			local entities = this.World.getAllEntitiesAndOneLocationAtPos(_entity.getPos(), 1.0);

			foreach( e in entities ) {
				if (e.isLocation()) {
					e.spawnFireAndSmoke();
					break;
				}
			}
		}

		return true;
	}
});
