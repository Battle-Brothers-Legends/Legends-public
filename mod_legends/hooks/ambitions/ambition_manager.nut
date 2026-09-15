::mods_hookNewObject("ambitions/ambition_manager", function(o) 
{
	o.isAvailable = function ()
	{
		if (::World.State.getMenuStack().hasBacksteps() || this.LoadingScreen != null && (this.LoadingScreen.isAnimating() || this.LoadingScreen.isVisible()))
		{
			return;
		}

		if (("State" in ::Tactical) && ::Tactical.State != null)
		{
			return false;
		}

		//if (this.Time.getVirtualTimeF() - ::World.Events.getLastBattleTime() < 3.0)
		//{
		//	return false;
		//}

		if (this.Time.getVirtualTimeF() < this.m.DelayUntil)
		{
			return false;
		}

		if (::World.getTime().Days < 2 && ::World.Assets.getOrigin().getID() != "scenario.paladins")
		{
			return false;
		}

		//if (this.m.Thread == null && this.m.Selection == null && this.Time.getVirtualTimeF() - this.m.LastTime < 1.0 * ::World.getTime().SecondsPerHour)
		//{
		//	return false;
		//}

		if (::World.Contracts.getActiveContract() != null && ::World.Contracts.getActiveContract().getType() == "contract.tutorial")
		{
			return false;
		}

		//local parties = ::World.getAllEntitiesAtPos(::World.State.getPlayer().getPos(), 400.0);
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
			::World.TopbarAmbitionModule.setText(_ambition.getUIText());
		}
	}
});