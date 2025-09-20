::FU.Class.KeybindSQ <- class extends ::FU.Class.AbstractKeybind
{
	Function = null;
	State = null;
	KeyState = null;

	constructor( _modID, _id, _keyCombinations, _state, _function, _name = null, _keyState = null )
	{
		if (_keyState == null) _keyState = ::FU.Key.KeyState.Release;
		::FU.requireFunction(_function);
		base.constructor(_modID, _id, _keyCombinations, _name);
		::FU.Key.isValidCombination(this.KeyCombinations);

		this.Function = _function;
		this.State = _state;
		this.KeyState = _keyState;
	}

	function getState()
	{
		return this.State;
	}

	function hasState( _state )
	{
		return (this.State & _state) != 0;
	}

	function callOnKeyState( _keyState )
	{
		return (_keyState & this.KeyState) != 0;
	}

	function getKeyState()
	{
		return this.KeyState;
	}

	function setFunction( _function )
	{
		this.Function = _function;
	}

	function call( _environment )
	{
		return this.Function.call(_environment);
	}

	function tostring()
	{
		return base.tostring() + ", Keystate: " + this.getKeyState() + ", State: " + this.getState();
	}
}
