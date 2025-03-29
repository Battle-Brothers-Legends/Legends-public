::mods_hookExactClass("entity/world/attached_location", function(o)
{
	o.m.IsNew <- false;
	o.m.IsAbandoned <- false;

	o.getSpriteName <- function ()
	{
		if (this.m.Sprite == "")
		{
			return "";
		}

		local s = this.m.Sprite;
		if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			s = "legend_" + this.m.Sprite;
		}
		return s
	}

	o.getSpriteDestroyedName <- function ()
	{
		if (this.m.IsNew)
		{
			//This is normally gated around our WorldEconomy config, but when reloading a saved game,
			//the sprites on the UI are loaded before the config, so we'll get the wrong sprite
			//to show -- hackish, but we know that IsNew is only used by the WorldEconomy so
			//we can assume it is enabled here.
			local s= "legend_" + this.m.Sprite + "_upgrade";
			return s;
		}

		local s = this.m.SpriteDestroyed;
		if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			s = "legend_" + this.m.SpriteDestroyed;
		}
		return s;
	}

	o.isActive = function ()
	{
		return this.m.IsActive && !this.m.IsNew;
	}

	o.isAbandoned <- function ()
	{
		return this.m.IsAbandoned;
	}

	o.isBuilding <- function ()
	{
		return this.m.IsNew;
	}

	o.getName = function ()
	{
		if (this.m.IsNew) {
			local s = "New " + this.world_entity.getName() + " Construction";
			return s;
		}

		local status = "";
		if (this.m.IsAbandoned)
		{
			status = " (Abandoned)";
		}
		else if (!this.m.IsActive)
		{
			status = " (Ruins)";
		}

		return this.world_entity.getName() + status;
	}

	o.getDescription = function ()
	{
		if (this.m.IsActive || this.m.IsNew)
		{
			return this.world_entity.getDescription();
		}
		else if (this.m.IsAbandoned)
		{
			return "The nearby settlement\'s current economic situation is unable to sustain this location and it has been abandoned. It will be repopulated once the settlement grows to a sufficient level again.";
		}
		else
		{
			return "Once part of the nearby settlement, these are now burned down and abandoned ruins.";
		}
	}

	o.setActive = function ( _a, _force = false)
	{
		if (_a == this.m.IsActive && _force == false)
		{
			return;
		}

		this.m.IsActive = _a;
		if (this.m.Settlement != null && !this.m.Settlement.isNull() && this.m.Settlement.isAlive())
		{
			this.m.Settlement.onAttachedLocationsChanged();
		}
		this.updateSprites();
	}

	o.setAbandoned <- function ( _a, _force = false)
	{
		if (_a == this.m.IsAbandoned && _force == false)
			return;

		this.m.IsAbandoned = _a;
		this.setActive( !_a, _force );
	}

	o.setNew <- function ( _a )
	{
		this.m.IsNew = _a;
	}

	o.updateSprites <- function ()
	{
		local s = this.getSprite("body");
		if (s != null)
		{
			s.setBrush(this.m.IsActive ? this.getSpriteName() : this.getSpriteDestroyedName());
		}
		s = this.getSprite("lighting");
		if (s != null)
		{
			s.Visible = this.m.IsActive || this.m.IsNew;
		}
	}

	o.onUpdateStablesList <- function ( _list )
	{
	}

	o.onInit = function ()
	{
		this.location.onInit();
		this.setDiscovered(true);
		this.setShowName(false);
		local body = this.addSprite("body");
		body.setBrush(this.getSpriteName());
		local lighting = this.addSprite("lighting");
		this.setSpriteColorization("lighting", false);
		lighting.Alpha = 0;
		lighting.IgnoreAmbientColor = true;
	}

	o.getNewResources <- function ()
	{
		return 1;
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out )
	{
		onSerialize(_out);
		_out.writeBool(this.m.IsNew);
		_out.writeBool(this.m.IsAbandoned);
	}

	o.onDeserialize = function ( _in )
	{
		this.location.onDeserialize(_in);
		local settlementID = _in.readU32();

		if (settlementID != 0)
		{
			this.setSettlement(this.World.getEntityByID(settlementID));

			if (this.m.Settlement != null)
			{
				this.m.Settlement.getAttachedLocations().push(this);
				this.m.Settlement.updateProduce();
			}
		}

		local active = _in.readBool();
		this.m.IsNew = _in.readBool();
		this.m.IsAbandoned = _in.readBool();
		this.setActive(active, true);
		this.setAttackable(false);
		this.getSprite("lighting").Color = this.createColor("ffffff00");
	}
});
