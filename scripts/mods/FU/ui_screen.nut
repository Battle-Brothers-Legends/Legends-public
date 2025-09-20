this.ui_screen <- ::inherit("scripts/mods/FU/js_connection", {
	m = {
		Visible = false,
		Animating = false,
		OnDisconnectedListener = null,
		OnScreenShownListener = null,
		OnScreenHiddenListener = null,
		OnClosePressedListener = null,
		OnConnectedListener = null,
		OnDisconnectedListener = null,
		PopupVisible = false,
	},

	function isVisible()
	{
		return this.m.Visible;
	}

	function isAnimating()
	{
		return this.m.Animating;
	}

	function isPopupVisible()
	{
		return this.m.PopupVisible;
	}

	function setOnConnectedListener( _listener )
	{
		this.m.OnConnectedListener = _listener;
	}

	function setOnDisconnectedListener( _listener )
	{
		this.m.OnDisconnectedListener = _listener;
	}
	
	function setOnClosePressedListener( _listener )
	{
		this.m.OnClosePressedListener = _listener;
	}

	function onPopupVisible( _data )
	{
		this.m.PopupVisible = _data;
	}

	function onOkButtonPressed()
	{
		if (this.m.OnOkButtonPressedListener != null)
		{
			this.m.OnOkButtonPressedListener();
		}
	}

	function onCancelButtonPressed()
	{
		if (this.m.OnCancelButtonPressedListener != null)
		{
			this.m.OnCancelButtonPressedListener();
		}
	}

	function clearEventListeners()
	{
		this.m.OnConnectedListener = null;
		this.m.OnDisconnectedListener = null;
		this.m.OnScreenHiddenListener = null;
		this.m.OnScreenShownListener = null;
	}

	function destroy()
	{
		this.clearEventListeners();
		this.js_connection.destroy();
	}

	function show( _data )
	{
		if (this.m.JSHandle == null)
		{
			throw ::FU.Exception.NotConnected;
		}
		else if (this.isVisible())
		{
			throw ::FU.Exception.AlreadyInState;
		}
		this.m.JSHandle.asyncCall("show", _data);
	}

	function hide()
	{
		if (this.m.JSHandle == null)
		{
			throw ::FU.Exception.NotConnected;
		}
		else if (!this.isVisible())
		{
			throw ::FU.Exception.AlreadyInState;
		}
		this.m.JSHandle.asyncCall("hide", null);
	}

	function onScreenConnected()
	{
		if (this.m.OnConnectedListener != null)
		{
			this.m.OnConnectedListener();
		}
	}

	function onScreenDisconnected()
	{
		if (this.m.OnDisconnectedListener != null)
		{
			this.m.OnDisconnectedListener();
		}
	}

	function onScreenShown()
	{
		this.m.Visible = true;
		this.m.Animating = false;
	}

	function onScreenHidden()
	{
		this.m.Visible = false;
		this.m.Animating = false;

	}

	function onScreenAnimating()
	{
		this.m.Animating = true;
	}

});
