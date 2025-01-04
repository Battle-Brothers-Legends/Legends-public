this.legend_dock_order <- this.inherit("scripts/ai/world/world_behavior", {
	m = {},
	function create()
	{
		this.world_behavior.create();
		this.m.ID = this.Const.World.AI.Behavior.ID.Dock;
	}

	function onExecute( _entity, _hasChanged )
	{
		local entities = this.World.getAllEntitiesAtPos(_entity.getPos(), 1.0);

		foreach( loc in entities )
		{
			if (!loc.isLocation())
			{
				continue;
			}

			if (!loc.isUsable())
			{
				continue;
			}

			local settlement = loc.getSettlement();

			if (settlement == null)
			{
				continue;
			}

			local inv = _entity.getInventory();

			if (inv.len() == 0)
			{
				_entity.clearInventory();
				break;
			}

			for( local i = 0; i < settlement.getSize(); i = i )
			{
				settlement.addImportedProduce(inv[this.Math.rand(0, inv.len() - 1)]);
				i = ++i;
			}

			break;
		}

		this.getController().popOrder();
		return true;
	}

});

