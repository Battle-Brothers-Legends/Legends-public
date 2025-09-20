::FU.Class.SettingsPage <- class
{
	Name = null;
	ID = null;
	Components = null; // Changed from Settings to Components
	Panel = null;

	/**
	 * Constructor for SettingsPage.
	 * @param _id {string} - The unique identifier for the settings page.
	 * @param _name {string} - The name of the settings page.
	 */
	constructor(_id, _name = null)
	{
		this.ID = _id;	
		this.Name = _name == null ? _id : _name;
		this.Components = ::FU.Class.OrderedMap(); // Changed from Settings to Components
	}

	/**
	 * Adds a PageComponent to the settings page.
	 * @param _component {PageComponent} - The component to add.
	 * @returns {PageComponent} - The added component.
	 */
		function addComponent(_component)
		{
			// Accept any SettingsElement (FU base type). MSU counterparts also use SettingsElement.
			if (!(_component instanceof ::FU.Class.SettingsElement))
			{
				::logError("Failed to add component: component needs to extend SettingsElement");
				throw ::FU.Exception.InvalidType(_component);
			}
		_component.setPage(this);
		this.Components[_component.getID()] <- _component;
		return _component;
	}

	/**
	 * Adds a divider component to the settings page.
	 * @param _id {string} - The unique identifier for the divider.
	 * @returns {PageComponent} - The added divider component.
	 */
	function addDivider(_id)
	{
		return this.addComponent(::FU.Class.SettingsDivider(_id));
	}

	/**
	 * Adds a heading component to the settings page.
	 * @param _id {string} - The unique identifier for the heading.
	 * @param _name {string} - The name of the heading.
	 * @param _description {string} - The description of the heading.
	 * @returns {PageComponent} - The added heading component.
	 */
	function addHeading(_id, _name, _description = null)
	{
		return this.addComponent(::FU.Class.SettingsHeading(_id, _name, _description));
	}

	// Backwards-compat: MSU used addTitle; map to our heading/title element
	function addTitle(_id, _name, _description = null)
	{
		return this.addComponent(::FU.Class.SettingsTitle(_id, _name, _description));
	}

	/**
	 * Adds a spacer component to the settings page.
	 * @param _id {string} - The unique identifier for the spacer.
	 * @param _width {integer} - The width of the spacer.
	 * @param _height {integer} - The height of the spacer.
	 * @returns {PageComponent} - The added spacer component.
	 */
	function addSpacer(_id, _width, _height)
	{
		return this.addComponent(::FU.Class.SettingsSpacer(_id, _width, _height));
	}

	/**
	 * Adds a toggle setting component to the settings page.
	 * @param _id {string} - The unique identifier for the toggle setting.
	 * @param _value {boolean} - The value of the toggle setting.
	 * @param _name {string} - The name of the toggle setting.
	 * @param _description {string} - The description of the toggle setting.
	 * @returns {PageComponent} - The added toggle setting component.
	 */
		function addToggleSetting(_id, _value, _name = null, _description = null)
		{
			return this.addComponent(::FU.Class.BooleanSetting(_id, _value, _name, _description));
		}

	/**
	 * Adds a button setting component to the settings page.
	 * @param _id {string} - The unique identifier for the button setting.
	 * @param _name {string} - The name of the button setting.
	 * @param _description {string} - The description of the button setting.
	 * @returns {PageComponent} - The added button setting component.
	 */
		// MSU-compatible signature: addButtonSetting(_id, _value?, _name = null, _description = null)
		// FU ignores the value parameter for buttons; preserve name/description
		function addButtonSetting(_id, _maybeValueOrName = null, _name = null, _description = null)
		{
			local name = null;
			local desc = null;
			if (typeof _maybeValueOrName == "string" || _maybeValueOrName == null)
			{
				name = _maybeValueOrName;
				desc = _name;
			}
			else
			{
				name = _name;
				desc = _description;
			}
			return this.addComponent(::FU.Class.ButtonSetting(_id, name, desc));
		}

	/**
	 * Adds a dropdown setting component to the settings page.
	 * @param _id {string} - The unique identifier for the dropdown setting.
	 * @param _value {variant} - The value of the dropdown setting.
	 * @param _array {array} - The array of possible values for the dropdown setting.
	 * @param _name {string} - The name of the dropdown setting.
	 * @param _description {string} - The description of the dropdown setting.
	 * @returns {PageComponent} - The added dropdown setting component.
	 */
		function addDropdownSetting(_id, _value, _array, _name = null, _description = null)
		{
			return this.addComponent(::FU.Class.EnumSetting(_id, _value, _array, _name, _description));
		}

		// MSU-compatible alias
		function addEnumSetting(_id, _value, _array, _name = null, _description = null)
		{
			return this.addDropdownSetting(_id, _value, _array, _name, _description);
		}

	/**
	 * Adds a slider setting component to the settings page.
	 * @param _id {string} - The unique identifier for the slider setting.
	 * @param _value {integer|float} - The value of the slider setting.
	 * @param _min {integer|float} - The minimum value for the slider.
	 * @param _max {integer|float} - The maximum value for the slider.
	 * @param _step {integer|float} - The step value for the slider.
	 * @param _name {string} - The name of the slider setting.
	 * @param _description {string} - The description of the slider setting.
	 * @returns {PageComponent} - The added slider setting component.
	 */
		function addSliderSetting(_id, _value, _min, _max, _step, _name = null, _description = null)
		{
			return this.addComponent(::FU.Class.RangeSetting(_id, _value, _min, _max, _step, _name, _description));
		}

		// MSU-compatible alias
		function addRangeSetting(_id, _value, _min, _max, _step, _name = null, _description = null)
		{
			return this.addSliderSetting(_id, _value, _min, _max, _step, _name, _description);
		}

	/**
	 * Adds a text input setting component to the settings page.
	 * @param _id {string} - The unique identifier for the text input setting.
	 * @param _value {string|integer|float} - The value of the text input setting.
	 * @param _name {string} - The name of the text input setting.
	 * @param _description {string} - The description of the text input setting.
	 * @returns {PageComponent} - The added text input setting component.
	 */
		function addTextInputSetting(_id, _value, _name = null, _description = null)
		{
			return this.addComponent(::FU.Class.StringSetting(_id, _value, _name, _description));
		}

		// MSU-compatible alias
		function addStringSetting(_id, _value, _name = null, _description = null)
		{
			return this.addTextInputSetting(_id, _value, _name, _description);
		}

	/**
	 * Adds a color picker setting component to the settings page.
	 * @param _id {string} - The unique identifier for the color picker setting.
	 * @param _value {string} - The value of the color picker setting in RGBA format.
	 * @param _name {string} - The name of the color picker setting.
	 * @param _description {string} - The description of the color picker setting.
	 * @returns {PageComponent} - The added color picker setting component.
	 */
		function addColorPickerSetting(_id, _value, _name = null, _description = null)
		{
			return this.addComponent(::FU.Class.ColorPickerSetting(_id, _value, _name, _description));
		}

		// MSU-compatible boolean naming
		function addBooleanSetting(_id, _value, _name = null, _description = null)
		{
			return this.addToggleSetting(_id, _value, _name, _description);
		}

	/**
	 * Adds a multiselect setting component to the settings page.
	 * @param _id {string} - The unique identifier for the multiselect setting.
	 * @param _value {array} - The value of the multiselect setting.
	 * @param _name {string} - The name of the multiselect setting.
	 * @param _description {string} - The description of the multiselect setting.
	 * @returns {PageComponent} - The added multiselect setting component.
	 */
		function addMultiselectSetting(_id, _value, _name = null, _description = null)
		{
			return this.addComponent(::FU.Class.ArraySetting(_id, _value, _name, _description));
		}

		function addArraySetting(_id, _value, _name = null, _description = null)
		{
			return this.addComponent(::FU.Class.ArraySetting(_id, _value, _name, _description));
		}

	/**
	 * Sets the panel for the settings page.
	 * @param _panel {Object} - The panel object.
	 */
	function setPanel(_panel)
	{
		this.Panel = _panel.weakref();
	}

	/**
	 * Gets the panel for the settings page.
	 * @returns {Object} - The panel object.
	 */
	function getPanel()
	{
		return this.Panel;
	}

	/**
	 * Gets the panel ID for the settings page.
	 * @returns {string} - The panel ID.
	 */
	function getPanelID()
	{
		return this.getPanel().getID();
	}

	/**
	 * Gets the mod for the settings page.
	 * @returns {Object} - The mod object.
	 */
	function getMod()
	{
		return this.getPanel().getMod();
	}

	/**
	 * Gets the ID of the settings page.
	 * @returns {string} - The ID of the settings page.
	 */
	function getID()
	{
		return this.ID;
	}

	/**
	 * Gets the name of the settings page.
	 * @returns {string} - The name of the settings page.
	 */
	function getName()
	{
		return this.Name;
	}

	/**
	 * Gets the components of the settings page.
	 * @returns {OrderedMap} - The components of the settings page.
	 */
		function getComponents()
		{
			return this.Components;
		}

		// Backwards-compat: MSU pages used getSettings(); map to our Components map
		function getSettings()
		{
			return this.Components;
		}

	/**
	 * Gets all components as an array, with an optional filter.
	 * @param _filter {function|class} - The filter function or class.
	 * @returns {array} - The array of components.
	 */
	function getAllComponentsAsArray(_filter = null)
	{
		local ret = this.getComponents().values();
		if (_filter != null)
		{
			if (typeof _filter == "function")
			{
				ret = ret.filter(_filter);
			}
			else if (typeof _filter == "class")
			{
				ret = ret.filter(@(_idx, _component) _component instanceof _filter);
			}
			else
			{
				::logError("_filter must be of type function or class (not class instance!)");
				throw ::FU.Exception.InvalidType(_filter);
			}
		}

		return ret;
	}

	/**
	 * Resets the settings of the settings page.
	 */
	function resetSettings()
	{
		foreach (setting in this.getAllComponentsAsArray(::FU.Class.TemplateSetting))
		{
			setting.reset();
		}
	}

	/**
	 * Gets a component by its ID.
	 * @param _settingID {string} - The ID of the component.
	 * @returns {PageComponent} - The component object.
	 */
	function get(_settingID)
	{
		return this.Components[_settingID];
	}

	/**
	 * Verifies the flags for the settings page.
	 * @param _flags {array} - The flags to verify.
	 * @returns {boolean} - True if the flags are verified, false otherwise.
	 */
	function verifyFlags(_flags)
	{
		foreach (setting in this.Components)
		{
			if (setting.verifyFlags(_flags))
			{
				return true;
			}
		}
		return false;
	}

	/**
	 * Gets the UI data for the settings page.
	 * @param _flags {array} - The flags to verify.
	 * @returns {object} - The UI data for the settings page.
	 */
	function getUIData(_flags = [])
	{
		local ret = {
			name = this.getName(),
			id = this.getID(),
			settings = [],
			hidden = !this.verifyFlags(_flags)
		};

		foreach (setting in this.Components)
		{
			ret.settings.push(setting.getUIData(_flags));
		}
		return ret;
	}

	/**
	 * Converts the settings page to a string representation.
	 * @returns {string} - A string representation of the settings page.
	 */
	function tostring()
	{
		local ret = "Name: " + this.getName() + " | ID: " + this.getID() + " | Settings:\n";

		foreach (setting in this.Components)
		{
			ret += " " + setting;
		}
	}

	/**
	 * Alias for tostring.
	 * @returns {string} - A string representation of the settings page.
	 */
	function _tostring()
	{
		return this.tostring();
	}
}

// Helper function for backward compatibility
::FU.Class.SettingsPage.addElement <- ::FU.Class.SettingsPage.addComponent;

