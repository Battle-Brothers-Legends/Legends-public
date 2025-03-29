::mods_hookExactClass("contracts/contracts/marauding_greenskins_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Greenskins are terrorizing the region around %s, burning everything in their path. The ferocity of the attacks have left many unnerved.",
			"Greenskin raiders have brought a miserable tide of violence and bloodshed to %s.",
			"Through either bloodlust or sheer stupidity, greenskins raids often continue deep into human territory." ,
			"Greenskin marauders, while formidable in strength, often fall prey to their own reckless aggression, their impulsive actions leading them into traps and ambushes.",
			"The cruelty of greenskin raiders knows no bounds, as they delight in inflicting pain and suffering upon their victims.",
			"The desire for power and dominance over weaker beings drives greenskin marauders, along with a taste for plunder.",
		];
	}

	o.formatDescription <- function ()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = format(r, ::Const.UI.getColorized(this.m.Origin.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));
		
		this.m.Description = r;
	}

	o.start = function ()
	{
		if (this.m.Home == null)
		{
			this.setHome(this.World.State.getCurrentTown());
		}

		local myTile = this.m.Origin.getTile();
		local orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getNearestSettlement(myTile);
		local goblins = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getNearestSettlement(myTile);

		if(goblins == null)
		{
			this.m.Flags.set("IsOrcs", true);
		}
		else if (orcs == null)
		{
			this.m.Flags.set("IsOrcs", false);
		}
		else
		{
			if (myTile.getDistanceTo(orcs.getTile()) + this.Math.rand(0, 8) < myTile.getDistanceTo(goblins.getTile()) + this.Math.rand(0, 8))
			{
				this.m.Flags.set("IsOrcs", true);
			}
			else
			{
				this.m.Flags.set("IsOrcs", false);
			}
		}


		local bestDist = 9000;
		local best;
		local settlements = this.World.EntityManager.getSettlements();

		foreach( s in settlements )
		{
			if (s.isMilitary() || s.isSouthern() || !s.isDiscovered())
			{
				continue;
			}

			if (s.getID() == this.m.Origin.getID() || s.getID() == this.m.Home.getID())
			{
				continue;
			}

			local d = this.getDistanceOnRoads(s.getTile(), this.m.Origin.getTile());

			if (d < bestDist)
			{
				bestDist = d;
				best = s;
			}
		}

		if (best != null)
		{
			local distance = this.getDistanceOnRoads(best.getTile(), this.m.Origin.getTile());
			this.m.Flags.set("MerchantReward", this.Math.max(150, distance * 5.0 * this.getPaymentMult()));
			this.setObjective(best);
			this.m.Flags.set("MerchantID", best.getFactionOfType(this.Const.FactionType.Settlement).getRandomCharacter().getID());
		}

		this.m.Payment.Pool = 800 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.contract.start();
	}

});