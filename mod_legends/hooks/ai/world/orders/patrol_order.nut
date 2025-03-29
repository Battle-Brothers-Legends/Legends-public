::mods_hookExactClass("ai/world/orders/patrol_order", function(o)
{
	o.onExecute = function ( _entity, _hasChanged )
	{
		if (this.m.TargetTile == null)
		{
			if (this.m.WaitTime != 0)
			{
				local w = this.new("scripts/ai/world/orders/wait_order");
				w.setTime(this.m.WaitTime);
				this.getController().addOrderInFront(w);
			}

			local f = this.World.FactionManager.getFaction(this.getController().getEntity().getFaction());
			local p = this.World.State.getPlayer().getTile();
			local s = clone f.getSettlements();
			s.sort(function ( _a, _b )
			{
				local a = _a.getTile().getDistanceTo(p);
				local b = _b.getTile().getDistanceTo(p);

				if (a > b)
				{
					return 1;
				}
				else if (a < b)
				{
					return -1;
				}

				return 0;
			});
			local r = this.Math.rand(0, this.Math.max(3, s.len() - 1));
			this.m.TargetTile = s[r].getTile();
			return true;
		}

		// ::logInfo("patrolling");

		_entity.setOrders("Patrolling");

		if (_entity.getTile().ID == this.m.TargetTile.ID)
		{
			if (_entity.getPos().X == this.m.TargetTile.Pos.X + this.m.Offset.X && _entity.getPos().Y == this.m.TargetTile.Pos.Y + this.m.Offset.Y)
			{
				this.m.TargetTile = null;
				return true;
			}
			else
			{
				_entity.setDestination(this.createVec(this.m.TargetTile.Pos.X + this.m.Offset.X, this.m.TargetTile.Pos.Y + this.m.Offset.Y));
			}
		}
		else if (_hasChanged || _entity.getPath() == null)
		{
			local navSettings = this.World.getNavigator().createSettings();
			navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost;
			navSettings.RoadMult = 1.0 / this.Const.World.MovementSettings.RoadMult;

			if (this.m.RoadsOnly)
			{
				navSettings.RoadMult *= 0.05;
			}

			if (this.m.AvoidSettlements)
			{
				navSettings.HeatCost = 100;
			}

			local path = this.World.getNavigator().findPath(_entity.getTile(), this.m.TargetTile, navSettings, 0);

			if (!path.isEmpty())
			{
				_entity.setPath(path);
			}
		}

		return true;
	}
});