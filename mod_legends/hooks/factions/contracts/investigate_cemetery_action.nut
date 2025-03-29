::mods_hookExactClass("factions/contracts/investigate_cemetery_action", function(o) 
{
	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.investigate_cemetery_contract))
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated())
		{
			return;
		}

		if (!this.World.FactionManager.isUndeadScourge() && this.World.getTime().Days > 3 && this.Math.rand(1, 100) > 75)
		{
			return;
		}

		local myTile = _faction.getSettlements()[0].getTile();
		this.m.Target = null;
		local undead = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getSettlements();

		foreach( b in undead )
		{
			if (myTile.getDistanceTo(b.getTile()) < 15 && (b.getTypeID() == "location.undead_graveyard" || b.getTypeID() == "location.undead_crypt"))
			{
				this.m.Target = b;
				break;
			}
		}

		if (this.m.Target == null)
		{
			return;
		}

		this.m.Score = 1;
		
		if (this.World.Assets.getOrigin().getID() == "scenario.legends_inquisition")
		{
			this.m.Score = 10;
		}
	}
});