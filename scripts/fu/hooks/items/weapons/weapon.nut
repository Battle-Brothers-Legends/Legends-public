::mods_hookDescendants("items/weapons/weapon", function(o) {
	if ("create" in o)
	{
		local create = o.create;
		o.create = function()
		{
			create();
			if (this.getCategories() == "")
			{
				if (this.m.WeaponType != ::Const.Items.WeaponType.None)
				{
					this.setupCategories();
				}
			}
			else
			{
				this.setupWeaponType();
			}
		}
	}
});

::mods_hookExactClass("items/weapons/weapon", function(o) {
	o.m.WeaponType <- ::Const.Items.WeaponType.None;

	o.setCategories <- function( _s, _setupWeaponType = true )
	{
		this.m.Categories = _s;

		if (_setupWeaponType)
		{
			this.setupWeaponType();
		}
	}

	local addSkill = o.addSkill;
	o.addSkill = function( _skill )
	{
		local ret = addSkill(_skill);
		if (::FU.isIn("AdditionalAccuracy", _skill.m, true))
		{
			_skill.resetField("AdditionalAccuracy");
			_skill.m.AdditionalAccuracy += this.m.AdditionalAccuracy;
			_skill.setBaseValue("AdditionalAccuracy", _skill.m.AdditionalAccuracy);
		}
		return ret;
	}

	o.setupWeaponType <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.None;

		local categories = this.getCategories();
		if (categories.len() == 0)
		{
			return;
		}

		foreach (k, w in ::Const.Items.WeaponType)
		{
			if (categories.find(k) != null)
			{
				this.m.WeaponType = this.m.WeaponType | w;
			}
		}

		if (categories.find("One-Handed") != null && !this.isItemType(::Const.Items.ItemType.OneHanded))
		{
			this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.OneHanded;
			if (this.isItemType(::Const.Items.ItemType.TwoHanded))
			{
				this.m.ItemType -= ::Const.Items.ItemType.TwoHanded;
			}
		}

		if (categories.find("Two-Handed") != null && !this.isItemType(::Const.Items.ItemType.TwoHanded))
		{
			this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.TwoHanded;
			if (this.isItemType(::Const.Items.ItemType.OneHanded))
			{
				this.m.ItemType -= ::Const.Items.ItemType.OneHanded;
			}
		}
	}

	o.isWeaponType <- function( _t, _any = true, _only = false )
	{
		if (_any)
		{
			return _only ? this.m.WeaponType - (this.m.WeaponType & _t) == 0 : (this.m.WeaponType & _t) != 0;
		}
		else
		{
			return _only ? (this.m.WeaponType & _t) == this.m.WeaponType : (this.m.WeaponType & _t) == _t;
		}
	}

	o.addWeaponType <- function( _weaponType, _setupCategories = true )
	{
		this.m.WeaponType = this.m.WeaponType | _weaponType;

		if (_setupCategories)
		{
			this.setupCategories();
		}
	}

	o.setWeaponType <- function( _t, _setupCategories = true )
	{
		this.m.WeaponType = _t;

		if (_setupCategories)
		{
			this.setupCategories();
		}
	}

	o.removeWeaponType <- function( _weaponType, _setupCategories = true )
	{
		if (this.isWeaponType(_weaponType, false))
		{
			this.m.WeaponType -= _weaponType;

			if (_setupCategories)
			{
				this.setupCategories();
			}
		}
	}

	o.setupCategories <- function()
	{
		this.m.Categories = "";

		foreach (w in ::Const.Items.WeaponType)
		{
			if (this.isWeaponType(w))
			{
				this.m.Categories += ::Const.Items.getWeaponTypeName(w) + "/";
			}
		}

		if (this.m.Categories != "") this.m.Categories = this.m.Categories.slice(0, -1) + ", ";

		if (this.isItemType(::Const.Items.ItemType.OneHanded))
		{
			this.m.Categories += "One-Handed";
		}
		else if (this.isItemType(::Const.Items.ItemType.TwoHanded))
		{
			this.m.Categories += "Two-Handed";
		}
	}
});
