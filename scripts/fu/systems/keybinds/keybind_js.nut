::FU.Class.KeybindJS <- class extends ::FU.Class.AbstractKeybind
{
	constructor( _modID, _id, _keyCombinations, _name = null)
	{
		base.constructor(_modID, _id, _keyCombinations, _name);
		::FU.Key.isValidCombination(this.KeyCombinations, false);
	}

	function getUIData( _flags = [] )
	{
		return {
			modID = this.getMod().getID(),
			id = this.getID(),
			keyCombinations = this.getKeyCombinations()
		};
	}
}
