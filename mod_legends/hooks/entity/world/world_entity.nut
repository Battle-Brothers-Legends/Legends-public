::mods_hookBaseClass("entity/world/world_entity", function ( o )
{
	while(!("Flags" in o.m)) o=o[o.SuperName];

	o.m.Resources <- 0;

	o.getDefenderCount <- function ()
	{
		return this.m.Troops.len()
	}

	o.getTroopComposition = function ()
	{
		local entities = [];
		local champions = [];
		local entityTypes = [];
		entityTypes.resize(this.Const.EntityType.len(), 0);

		foreach( t in this.m.Troops )
		{
			if (t.Script.len() != "")
			{
				if (t.Variant != 0 && this.Const.DLC.Wildmen)
				{
					champions.push(t);
				}
				else
				{
					++entityTypes[t.ID];
				}
			}
		}

		foreach( c in champions )
		{
			entities.push({
				id = 21,
				type = "text",
				icon = "ui/orientation/" + this.Const.EntityIcon[c.ID] + ".png",
				text = c.Name
			});
		}

		for( local i = 0; i < entityTypes.len(); i = ++i )
		{
			if (entityTypes[i] > 0)
			{
				if (entityTypes[i] == 1)
				{
					local start = this.isFirstCharacter(this.Const.Strings.EntityName[i], [
						"A",
						"E",
						"I",
						"O",
						"U"
					]) ? "An " : "A ";
					entities.push({
						id = 20,
						type = "text",
						icon = "ui/orientation/" + this.Const.EntityIcon[i] + ".png",
						text = start + this.removeFromBeginningOfText("The ", this.Const.Strings.EntityName[i])
					});
				}
				else if (::Legends.Mod.ModSettings.getSetting("ExactEngageNumbers").getValue())
				{
					entities.push({
						id = 20,
						type = "text",
						icon = "ui/orientation/" + this.Const.EntityIcon[i] + ".png",
						text = entityTypes[i] + " " + this.Const.Strings.EntityNamePlural[i]
					});
				}
				else
				{
					entities.push({
						id = 20,
						type = "text",
						icon = "ui/orientation/" + this.Const.EntityIcon[i] + ".png",
						text = getEngageNumberNames(entityTypes[i]) + " " + this.Const.Strings.EntityNamePlural[i]
					});
				}
			}
		}

		return entities;
	}

	o.getEngageNumberNames <- function ( _entityType)
	{
		foreach (key, value in this.Const.Strings.EngageEnemyNumbers)
		{
			if (_entityType >= value[0] && _entityType <= value[1])
			{
				return this.Const.Strings.EngageEnemyNumbersNames[key];
			}
		}
	}

	o.getResources <- function ()
	{
		return this.m.Resources;
	}

	o.setResources <- function (_v)
	{
		this.m.Resources = this.Math.max(0, this.Math.round(_v));
	}

	o.onSerialize = function ( _out )
	{
		_out.writeString(this.m.Name);
		_out.writeString(this.m.Description);
		_out.writeU8(this.Math.min(255, this.m.Troops.len()));

		foreach( t in this.m.Troops ) {
			::Const.World.Common.serializeTroop(_out, t)
		}

		_out.writeI32(this.m.CombatID);
		_out.writeI32(this.m.CombatSeed);
		_out.writeF32(this.m.VisionRadius);
		_out.writeF32(this.m.VisibilityMult);
		local numInventoryItems = this.Math.min(255, this.m.Inventory.len());
		_out.writeU8(numInventoryItems);

		for( local i = 0; i < numInventoryItems; i = ++i )
		{
			_out.writeString(this.m.Inventory[i]);
		}

		_out.writeF32(this.m.LootScale);
		_out.writeBool(this.m.IsAttackable);
		_out.writeBool(this.m.IsAttackableByAI);
		_out.writeBool(this.m.IsUsingGlobalVision);
		_out.writeBool(this.m.IsShowingName);
		_out.writeBool(this.m.IsLooting);
		_out.writeBool(this.m.IsDroppingLoot);
		_out.writeU16(::Math.abs(this.m.Resources));
		this.m.Flags.onSerialize(_out);
	}

	o.onDeserialize = function ( _in )
	{
		this.getSprite("selection").Visible = false;
		this.setSpriteOffset("selection", this.createVec(-30, 30));
		this.m.Troops = [];
		this.m.Strength = 0;
		this.m.Inventory = [];
		this.m.Name = _in.readString();
		this.m.Description = _in.readString();

		if (this.hasLabel("name"))
		{
			this.getLabel("name").Text = this.getName();
		}

		local numTroops = _in.readU8();

		for( local i = 0; i < numTroops; i = ++i )
		{
			local troop = ::Const.World.Common.deserializeTroop(_in);
			troop.Party = this.WeakTableRef(this);
			troop.Faction = this.getFaction();
			if (troop.Script != "scripts/entity/tactical/enemies/alp_illusion") {
				this.m.Troops.push(troop);
			}
		}

		this.updateStrength();
		this.m.CombatID = _in.readI32();
		this.m.CombatSeed = _in.readI32();
		this.m.VisionRadius = _in.readF32();
		this.m.VisibilityMult = _in.readF32();
		local numInventoryItems = _in.readU8();

		for( local i = 0; i != numInventoryItems; i = ++i )
		{
			this.m.Inventory.push(_in.readString());
		}

		this.m.LootScale = _in.readF32();
		this.m.IsAttackable = _in.readBool();
		this.m.IsAttackableByAI = _in.readBool();
		this.m.IsUsingGlobalVision = _in.readBool();
		this.m.IsShowingName = _in.readBool();
		this.m.IsLooting = _in.readBool();
		this.m.IsDroppingLoot = _in.readBool();
		this.m.Resources = _in.readU16();

		if (this.hasLabel("name"))
		{
			this.getLabel("name").Visible = true;
		}

		this.m.Flags.onDeserialize(_in);
	}
});
