var FUBackendConnection = function ()
{
	this.mSQHandle = null;
};

FUBackendConnection.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

FUBackendConnection.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;
};

FUBackendConnection.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;
};
