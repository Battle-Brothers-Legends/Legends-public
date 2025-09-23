// FU Popup System - User notification and dialog management
this.popup <- {
	// Internal state management
	_state = {
		isDisplayed = false,
		inTransition = false,
		uiConnection = null,
		pendingMessages = [],
		exitOnClose = false
	},

	// Public API: Check if popup is currently displayed
	function isVisible()
	{
		return this._state.isDisplayed;
	}

	// Public API: Check if popup is in transition (showing/hiding)
	function isAnimating()
	{
		return this._state.inTransition;
	}

	// Public API: Display text message to user
	function showRawText( _message, _shouldExitGame = false )
	{
		// Update exit behavior if requested
		if (_shouldExitGame)
		{
			this._state.exitOnClose = true;
		}

		// Queue message if UI not ready, otherwise send immediately
		if (this._state.uiConnection == null)
		{
			this._queueMessage(_message);
		}
		else
		{
			this._sendToUI({
				content = _message,
				shouldExit = this._state.exitOnClose
			}, "showRawText");
		}
	}

	// Public API: Show mod update notifications
	function showModUpdates( _updateData )
	{
		if (this._state.uiConnection != null)
		{
			this._sendToUI(_updateData, "showModUpdates");
		}
	}

	// Public API: Set whether popup should exit game when closed
	function forceQuit( _shouldExit )
	{
		this._state.exitOnClose = _shouldExit;
	}

	// Public API: Check if popup will exit game when closed
	function isForceQuitting()
	{
		return this._state.exitOnClose;
	}

	// Public API: Establish connection to UI layer
	function connect()
	{
		this._state.uiConnection = ::UI.connect("FUPopup", this);
		this._processPendingMessages();
	}

	// Public API: Hide the popup
	function hide()
	{
		if (this._state.uiConnection != null)
		{
			this._sendToUI(null, "hide");
		}
	}

	// Public API: Exit game - implementation provided by main menu hook
	function quitGame()
	{
		// Implementation injected by main menu system
	}

	// UI Event: Called when popup becomes visible
	function onScreenShown()
	{
		this._updateDisplayState(true, false);
	}

	// UI Event: Called when popup becomes hidden
	function onScreenHidden()
	{
		this._updateDisplayState(false, false);
	}

	// UI Event: Called during show/hide transitions
	function onScreenAnimating()
	{
		this._state.inTransition = true;
	}

	// Internal: Queue message for later delivery
	function _queueMessage( _text )
	{
		if (this._state.pendingMessages.len() > 0)
		{
			// Concatenate with line break for readability
			local lastMessage = this._state.pendingMessages.pop();
			this._state.pendingMessages.push(lastMessage + "<br>" + _text);
		}
		else
		{
			this._state.pendingMessages.push(_text);
		}
	}

	// Internal: Process any queued messages after UI connection
	function _processPendingMessages()
	{
		foreach (message in this._state.pendingMessages)
		{
			this.showRawText(message);
		}
		this._state.pendingMessages.clear();
	}

	// Internal: Send data to UI with error handling
	function _sendToUI( _payload, _method )
	{
		try
		{
			this._state.uiConnection.asyncCall(_method, _payload);
		}
		catch (error)
		{
			// Fallback: queue for retry if connection fails
			if (_method == "showRawText" && _payload != null)
			{
				this._queueMessage(_payload.content);
			}
		}
	}

	// Internal: Update display and animation state
	function _updateDisplayState( _visible, _animating )
	{
		this._state.isDisplayed = _visible;
		this._state.inTransition = _animating;
	}
};