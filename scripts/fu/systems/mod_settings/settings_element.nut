::FU.Class.SettingsElement <- class
{
	Name = null;
	ID = null;
	static Type = "Element";
	Data = null;
	Description = null;
	Page = null;

	constructor( _id, _name = null, _description = null )
	{
		if (_id.find(" ") != null)
		{
			::logError("The ID of a Settings Element must not have spaces");
			throw ::FU.Exception.InvalidValue(_id);
		}
		this.Name = _name == null ? _id : _name;
		this.ID = _id;
		this.Data = {};
		this.Description = _description == null ? "" : _description;
	}

	function getType()
	{
		return this.Type;
	}

	function setPage( _page )
	{
		this.Page = _page.weakref();
	}

	function getPage()
	{
		return this.Page;
	}

	function getPanelID()
	{
		return this.getPage().getPanelID();
	}

	function getMod()
	{
		return this.getPage().getMod();
	}

	function setDescription( _description )
	{
		this.Description = _description;
	}

	function getDescription()
	{
		return this.Description;
	}

	function getName()
	{
		return this.Name;
	}

	function getID()
	{
		return this.ID;
	}

	function getData()
	{
		return this.Data;
	}

	function getTooltip( _data )
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function verifyFlags( _flags )
	{
		if (_flags != null)
		{
			if ("required" in _flags)
			{
				foreach (required in _flags.required)
				{
					if (!(required in this.Data))
					{
						return false;
					}
				}
			}
			if ("excluded" in _flags)
			{
				foreach (excluded in _flags.excluded)
				{
					if (excluded in this.Data)
					{
						return false;
					}
				}
			}
		}
		return true;
	}

	function getUIData( _flags = [] )
	{
		local ret = {
			type = this.getType(),
			id = this.getID(),
			name = this.getName(),
			data = this.Data,
			panel = this.getPanelID(),
			mod = this.getMod().getID(),
			hidden = !this.verifyFlags(_flags)
		}
		return ret;
	}
}
