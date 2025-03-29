this.legend_free_company_order <- this.inherit("scripts/ai/world/world_behavior", {
	m = {
		TargetSettlement = null,
		Theme = null
	},
	function setSettlement( _t )
	{
		this.m.TargetSettlement = this.WeakTableRef(_t);
	}

	function create()
	{
		this.world_behavior.create();
		this.m.ID = this.Const.World.AI.Behavior.ID.FreeCompany;
	}

	function onSerialize( _out )
	{
		this.world_behavior.onSerialize(_out);

		if (this.m.TargetSettlement != null && !this.m.TargetSettlement.isNull() && this.m.TargetSettlement.isAlive())
		{
			_out.writeU32(this.m.TargetSettlement.getID());
		}
		else
		{
			_out.writeU32(0);
		}
	}

	function onDeserialize( _in )
	{
		this.world_behavior.onDeserialize(_in);
		local targetSettlementID = _in.readU32();

		if (targetSettlementID != 0)
		{
			local target = this.World.getEntityByID(targetSettlementID);

			if (target != null)
			{
				this.m.TargetSettlement = this.WeakTableRef(target);
			}
		}
	}

	function onExecute( _entity, _hasChanged )
	{
		if (this.m.TargetSettlement == null || this.m.TargetSettlement.isNull() || !this.m.TargetSettlement.isAlive())
		{
			this.getController().popOrder();
			return true;
		}

		if (this.m.TargetSettlement.getTile().ID != _entity.getTile().ID)
		{
			local move = this.new("scripts/ai/world/orders/move_order");
			move.setDestination(this.m.TargetSettlement.getTile());
			this.getController().addOrderInFront(move);
			return true;
		}

		this.getController().popOrder();
		return true;
	}

});

