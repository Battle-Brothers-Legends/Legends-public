this.legend_relationship_check <- this.inherit("scripts/skills/skill", {
	m = {
		// RCMeleeDefense = 0,
		// RCRangedDefense = 0,
		// RCBravery = 0,
		// RCStaminaMult = 1.0
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRelationshipCheck);
		this.m.Icon = "skills/status_effect_01.png";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.Trait;
		this.m.Order = this.Const.SkillOrder.Trait + 600;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = true;
	}

	function relationStringHelper( _name, _relTab )
	{
		local relNum = _relTab.RelationNum;
		local returnString = "";
		returnString += _name + " relation gives: ";
		if ( relNum <= -10 )
		{
			returnString += "-5 Resolve";
		}
		if ( relNum <= -20 )
		{
			returnString += ", -5 Ranged Defense";
		}
		if ( relNum <= -30 )
		{
			returnString += ", -5 Melee Defense";
		}
		if ( relNum > -10 && relNum <= 10)
		{
			returnString += "No Bonuses"
		}
		if ( relNum > 10 )
		{
			returnString += "+5 Resolve";
		}
		if ( relNum > 20 )
		{
			returnString += ", +5 Ranged Defense";
		}
		if ( relNum > 30 )
		{
			returnString += ", +5 Melee Defense";
		}
		returnString += ".\n";
		return returnString;
	}

	function getCombatTooltip()
	{
		local actor = this.getContainer().getActor();
		local targetTile = actor.getTile();
		local returnString = "";

			for (local i = 0; i != 6; ++i)
			{
				if (!targetTile.hasNextTile(i)) {}
				else
				{
					local tile = targetTile.getNextTile(i);
					if (tile.IsOccupiedByActor && tile.getEntity().getMoraleState() != this.Const.MoraleState.Fleeing)
					{

						if (tile.getEntity().getFaction() == this.Const.Faction.Player)
						{
							if (tile.getEntity().getCompanyID() == -1)
							{
								continue;
							}

							if (actor.getCompanyID() == -1)
							{
								continue;
							}

							local relB = this.World.State.getRefFromID(actor.getCompanyID());
							if (relB == null)
							{
								continue
							}

							local relTab = relB.getActiveRelationshipWith(tile.getEntity());
							if (relTab == null)
							{
								continue;
							}

							returnString += relationStringHelper(tile.getEntity().getName(), relTab);
						}

					}
				}
			}

			if (returnString == "")
			{
				returnString = "No Bonuses"
			}

			return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = returnString
			}
		];
	}

	function checkPosition ( _roster, _actor, _position )
	{
		foreach (bro in _roster)
		{
			if (bro.getPlaceInFormation() == _position)
			{
				if (bro.getCompanyID() == -1)
				{
					return "";
				}

				local relB = this.World.State.getRefFromID(bro.getCompanyID());
				if (relB == null)
				{
					return "";
				}
				local relTab = relB.getActiveRelationshipWith(tile.getEntity());
				if (relTab == null)
				{
					return "";
				}

				return relationStringHelper(bro.getName(), relTab);
			}
		}
		return ""; //Will get tooltip reading similar to NULL(0x000000) etc without this because it'll return null but it puts that into the retString
	}

	function getNormalTooltip()
	{
		local actor = this.getContainer().getActor();
		local position = actor.getPlaceInFormation();
		local roster = this.World.getPlayerRoster().getAll();
		local returnString = "";

		if (position <= 8) //check only down (+9)
		{
			if (position != 0) //don't check to left (-1) if pos = 0
			{
				returnString += checkPosition(roster, actor, position - 1);
			}
			if (position != 8) //don't check to right (+1) if pos = 8
			{
				returnString += checkPosition(roster, actor, position + 1);
			}
			returnString += checkPosition(roster, actor, position + 9);
		}
		else if (position <= 17) //check up and down (-+9)
		{
			if (position != 9) //don't check to left (-1)
			{
				returnString += checkPosition(roster, actor, position - 1);
			}
			if (position != 17) //don't check to right (+1)
			{
				returnString += checkPosition(roster, actor, position + 1);
			}
			returnString += checkPosition(roster, actor, position - 9);
			returnString += checkPosition(roster, actor, position + 9);
		}
		else //position <= 26 : check only up (-9)
		{
			if (position != 18) //don't check left (-1)
			{
				returnString += checkPosition(roster, actor, position - 1);
			}
			if (position != 26) //don't check right (+1)
			{
				returnString += checkPosition(roster, actor, position + 1);
			}
			returnString += checkPosition(roster, actor, position - 9);
		}

		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = returnString
			}
		];
	}

	function getTooltip()
	{

		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
			return getCombatTooltip();
		}
		else
		{
			return getNormalTooltip();
		}
	}

	// function resetModifiers()
	// {
	// 	this.m.RCBravery = 0;
	// 	this.m.RCStaminaMult = 1.0;
	// 	this.m.RCRangedDefense = 0;
	// 	this.m.RCMeleeDefense = 0;
	// }

	// function unApplyModifiers()
	// {
	// 	local properties = this.getContainer().getActor().getBaseProperties();

	// 	properties.Bravery -= this.m.RCBravery;
	// 	properties.StaminaMult /= this.m.RCStaminaMult;
	// 	properties.RangedDefense -= this.m.RCRangedDefense;
	// 	properties.MeleeDefense -= this.m.RCMeleeDefense;
	// 	this.resetModifiers();
	// }

	// function applyModifiers()
	// {
	// 	local properties = this.getContainer().getActor().getBaseProperties();

	// 	properties.Bravery += this.m.RCBravery;
	// 	properties.StaminaMult *= this.m.RCStaminaMult;
	// 	properties.RangedDefense += this.m.RCRangedDefense;
	// 	properties.MeleeDefense += this.m.RCMeleeDefense;
	// }



	// function computeModifiers( _properties = null )
	// {
	// 	local actor = this.getContainer().getActor();
	// 	local myTile = actor.getTile();
	// 	local actors = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());

	// 	local properties;
	// 	if ( _properties != null )
	// 		properties = _properties;
	// 	else
	// 		properties = this.getContainer().getActor().getBaseProperties();

	// 	foreach( a in actors )
	// 	{
	// 		if (a.getID() == actor.getID())
	// 		{
	// 			continue;
	// 		}

	// 		if (myTile.getDistanceTo(a.getTile()) > 1)
	// 		{
	// 			continue;
	// 		}

	// 		if (a.getFaction() != actor.getFaction())
	// 		{
	// 			continue;
	// 		}

	// 		// local arrIndex = a.getCompanyID();

	// 		local relation = actor.getActiveRelationshipWith(a).RelationNum;

	// 		if (relation <= -40 )
	// 		{
	// 			this.m.RCStaminaMult *= 0.95;
	// 			this.m.RCBravery -= 5;
	// 			this.m.RCRangedDefense -= 5;
	// 			this.m.RCMeleeDefense -= 5;
	// 		}
	// 		else if (relation <= -30 )
	// 		{
	// 			this.m.RCBravery -= 5;
	// 			this.m.RCRangedDefense -= 5;
	// 			this.m.RCMeleeDefense -= 5;
	// 		}
	// 		else if (relation <= -20 )
	// 		{
	// 			this.m.RCBravery -= 5;
	// 			this.m.RCRangedDefense -= 5;
	// 		}
	// 		else if (relation <= -10 )
	// 		{
	// 			this.m.RCBravery -= 5;
	// 		}
	// 		else if (relation <= 0 )
	// 		{
	// 		}
	// 		else if (relation <= 10 )
	// 		{
	// 		}
	// 		else if (relation <= 20 )
	// 		{
	// 			this.logInfo("giving " + actor.getName() + " +5 bravery with " + a.getName() + " " + relation);
	// 			this.m.RCBravery += 5;
	// 		}
	// 		else if (relation <= 30 )
	// 		{
	// 			this.m.RCBravery += 5;
	// 			this.m.RCRangedDefense += 5;
	// 		}
	// 		else if (relation <= 40 )
	// 		{
	// 			this.m.RCBravery += 5;
	// 			this.m.RCRangedDefense += 5;
	// 			this.m.RCMeleeDefense += 5;
	// 		}
	// 		else if (relation <= 50 )
	// 		{
	// 			this.m.RCStaminaMult *= 1.05;
	// 			this.m.RCBravery += 5;
	// 			this.m.RCRangedDefense += 5;
	// 			this.m.RCMeleeDefense += 5;
	// 		}
	// 	}
	// }

	// function doAllModifiers( _properties = null )
	// {
	// 	this.unApplyModifiers();
	// 	this.computeModifiers( _properties );
	// 	this.applyModifiers();
	// }

	// function onCombatFinished()
	// {
	// 	// this.m.IsHidden = true;
	// 	// this.unApplyModifiers();
	// }

	// function onCombatStarted()
	// {
	// 	this.m.IsHidden = false;
	// 	// local properties = this.getContainer().getActor().getBaseProperties();

	// 	// this.computeModifiers();

	// 	// properties.Bravery += this.m.RCBravery;
	// 	// properties.StaminaMult *= this.m.RCStaminaMult;
	// 	// properties.RangedDefense += this.m.RCRangedDefense;
	// 	// properties.MeleeDefense += this.m.RCMeleeDefense;


	// }

	// function onTurnStart()
	// {
	// 	// this.doAllModifiers();
	// }

	// function onUpdate( _properties )
	// {
	// 	// if (("State" in this.Tactical) && this.Tactical.State != null)
	// 	// {
	// 	// 	//this.doAllModifiers(_properties);
	// 	// }
	// }

});

