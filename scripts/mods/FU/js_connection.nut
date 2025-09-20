this.js_connection <- {
	m = {
		JSHandle = null,
		ID = null
	},

	function create()
	{

	}

	function connect()
	{
		this.m.JSHandle = this.UI.connect(this.m.ID, this);
	}

	function destroy()
	{
		this.m.JSHandle = ::UI.disconnect(this.m.JSHandle);
	}

	function isVisible()
	{
		return false
	}

	function isAnimating()
	{
		return false
	}

	function isConnected()
	{
		return this.m.JSHandle != null;
	}
};
