::mods_hookBaseClass("entity/world/world_entity", function ( o )
{
	while(!("Flags" in o.m)) o=o[o.SuperName];

	o.m.Resources <- 0;

	o.getDefenderCount <- function () {
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

	o.onSerialize = function (_out) {
		_out.writeString(this.m.Name);
		_out.writeString(this.m.Description);
		if (this.m.Troops.len() > 255) {
			::logError("world_entity.onSerialize: " + this.m.Name + " has " + this.m.Troops.len() + " troops, truncating to 255");
		}
		local numTroops = this.Math.min(255, this.m.Troops.len());
		_out.writeU8(numTroops);

		// CRITICAL SAVE CORRUPTION BUG: Do not serialize more troops than numTroops !!!!
		// DONT DO THIS ----> foreach( t in this.m.Troops ) { <---- DONT DO THIS
		for (local i = 0; i < numTroops; i = ++i) {
			::Const.World.Common.serializeTroop(_out, this.m.Troops[i])
		}

		_out.writeI32(this.m.CombatID);
		_out.writeI32(this.m.CombatSeed);
		_out.writeF32(this.m.VisionRadius);
		_out.writeF32(this.m.VisibilityMult);
		local numInventoryItems = this.Math.min(255, this.m.Inventory.len());
		_out.writeU8(numInventoryItems);

		for (local i = 0; i < numInventoryItems; i = ++i) {
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

	o.onDeserialize = function (_in) {
		this.getSprite("selection").Visible = false;
		this.setSpriteOffset("selection", this.createVec(-30, 30));
		this.m.Troops = [];
		this.m.Strength = 0;
		this.m.Inventory = [];
		this.m.Name = _in.readString();
		this.m.Description = _in.readString();

		if (this.hasLabel("name")) {
			this.getLabel("name").Text = this.getName();
		}

		local numTroops = _in.readU8();

		for (local i = 0; i < numTroops; i = ++i) {
			local troop = ::Const.World.Common.deserializeTroop(_in);
			troop.Party = this.WeakTableRef(this);
			troop.Faction = this.getFaction();
			this.m.Troops.push(troop);
		}

		// Temp fix for corrupted saves: a previous bug wrote all troops
		// but capped the count at 255, leaving extra troop data unread.
		// This tries to detect and skip extra troops by peeking at the next U16.
		// CombatID (I32) is either 0 or a large entity ID (>100000 normally),
		// so its low U16 is never a valid troop type ID (1-999).
		// Can be removed later.
		local combatIDLow = _in.readU16();
		while (numTroops == 255 && combatIDLow > 0 && combatIDLow < 1000) {
			// This U16 is a troop type ID, not part of CombatID.
			// Consume the rest of the troop fields to skip it.
			::logWarning("world_entity.onDeserialize: skipping extra troop (typeID=" + combatIDLow + ") for " + this.m.Name);
			_in.readU8();  // Variant
			_in.readF32(); // Strength
			_in.readI8();  // Row
			_in.readString(); // Name
			if (_in.readBool()) { // hasOutfits
				local outfitCount = _in.readU8();
				for (local j = 0; j < outfitCount; j = ++j) {
					if (_in.readU8() == 2) {
						_in.readU8();
						_in.readString();
					} else {
						_in.readU8();
						_in.readString();
						_in.readString();
					}
				}
			}
			_in.readI32(); // ScriptHash
			_in.readI16(); // Credits
			_in.readI8();  // DieRoll
			combatIDLow = _in.readU16();
		}
		// Reconstruct CombatID from the two U16 halves
		local combatIDHigh = _in.readU16();
		this.m.CombatID = combatIDLow | (combatIDHigh << 16);

		this.updateStrength();
		this.m.CombatSeed = _in.readI32();
		this.m.VisionRadius = _in.readF32();
		this.m.VisibilityMult = _in.readF32();
		local numInventoryItems = _in.readU8();

		for (local i = 0; i != numInventoryItems; i = ++i) {
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

		if (this.hasLabel("name")) {
			this.getLabel("name").Visible = true;
		}

		this.m.Flags.onDeserialize(_in);
	}
});
