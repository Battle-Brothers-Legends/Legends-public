::mods_hookNewObject("ambitions/ambition_manager", function(o) 
{
	o.isAvailable = function ()
	{
		if (this.World.State.getMenuStack().hasBacksteps() || this.LoadingScreen != null && (this.LoadingScreen.isAnimating() || this.LoadingScreen.isVisible()))
		{
			return;
		}

		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
			return false;
		}

		//if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() < 3.0)
		//{
		//	return false;
		//}

		if (this.Time.getVirtualTimeF() < this.m.DelayUntil)
		{
			return false;
		}

		if (this.World.getTime().Days < 2 && this.World.Assets.getOrigin().getID() != "scenario.paladins")
		{
			return false;
		}

		//if (this.m.Thread == null && this.m.Selection == null && this.Time.getVirtualTimeF() - this.m.LastTime < 1.0 * this.World.getTime().SecondsPerHour)
		//{
		//	return false;
		//}

		if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getType() == "contract.tutorial")
		{
			return false;
		}

		//local parties = this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);
		//
		//foreach( party in parties )
		//{
		//	if (!party.isAlliedWithPlayer())
		//	{
		//		return false;
		//	}
		//}

		return true;
	}

	o.setAmbition = function ( _ambition )
	{
		this.m.LastPickedAmbitionID = _ambition.getID();

		if (_ambition.getID() == "ambition.none")
		{
			this.setDelay(24 * 3);
		}
		else
		{
			this.m.ActiveAmbition = _ambition;
			this.m.ActiveAmbition.activate();
			this.setDelay(0);
			this.World.TopbarAmbitionModule.setText(_ambition.getUIText());
		}
	}
});