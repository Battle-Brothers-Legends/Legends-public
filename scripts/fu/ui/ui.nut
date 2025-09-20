::FU.UI <- {
	Connections = [],
	Callbacks = [],
	JSConnection = null,

	function registerConnection( _connection )
	{
		this.Connections.push(_connection);
	}

	function connect()
	{
		foreach (connection in this.Connections)
		{
			connection.connect();
		}
		this.Connections.clear();
		foreach (callback in this.Callbacks)
		{
			callback();
		}
		this.Callbacks.clear();
	}

	function addOnConnectCallback( _function )
	{
		::FU.requireFunction(_function);
		this.Callbacks.push(_function);
	}
}

