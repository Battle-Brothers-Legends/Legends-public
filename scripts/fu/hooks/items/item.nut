::mods_hookBaseClass("items/item", function(o) {
	o = o[o.SuperName];

	o.isItemType = function( _t, _any = true, _only = false )
	{
		if (_any)
		{
			return _only ? this.m.ItemType - (this.m.ItemType & _t) == 0 : (this.m.ItemType & _t) != 0;
		}
		else
		{
			return _only ? (this.m.ItemType & _t) == this.m.ItemType : (this.m.ItemType & _t) == _t;
		}
	}

	o.addItemType <- function ( _t )
	{
		this.m.ItemType = this.m.ItemType | _t;
	}

	o.setItemType <- function( _t )
	{
		this.m.ItemType = _t;
	}

	o.removeItemType <- function( _t )
	{
		if (this.isItemType(_t, false)) this.m.ItemType -= _t;
		else throw ::FU.Exception.KeyNotFound(_t);
	}

	o.getSkills <- function()
	{
		return this.m.SkillPtrs.filter(@(idx, skill) skill.getID() != "items.generic");
	}

	o.getMovementSpeedMult <- function()
	{
		return 1.0;
	}

	local getDescription = o.getDescription;
	o.getDescription = function()
	{
		if (!::FU.Mod.ModSettings.getSetting("ExpandedItemTooltips").getValue())
		{
			return getDescription();
		}

		local names = "";
		foreach (itemType in ::Const.Items.ItemType)
		{
			if (this.isItemType(itemType))
			{
				local name = ::Const.Items.getItemTypeName(itemType);
				if (name != "")
				{
					names += name + ", "
				}
			}
		}

		return names != "" ? "[color=" + ::Const.UI.Color.NegativeValue + "]" + names.slice(0, -2) + "[/color]\n\n" + getDescription() : getDescription();
	}

	o.onAfterUpdateProperties <- function( _properties )
	{			
	}

	o.onAnySkillUsed <- function( _skill, _targetEntity, _properties )
	{
	}
});
