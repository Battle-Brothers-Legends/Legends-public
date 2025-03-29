"use strict";


var TooltipModuleIdentifier =
{
    KeyEvent:
    {
        Namespace: '.tooltip-module'
    }
};


var TooltipModule = function()
{
	this.mSQHandle = null;
	
	// event listener
	this.mEventListener = null;

	// container
	this.mParent    = null;
	this.mContainer = null;
	
	// current element data
	this.mCurrentData    = null;
	this.mCurrentElement = null;

	// constants
	this.mLastMouseX       = 0;
	this.mLastMouseY       = 0;
	this.mMinMouseMovement = 4;
	this.mCursorWidth      = 32;
	this.mCursorHeight     = 32;
	this.mCursorXOffset    = 0;
	this.mCursorYOffset    = 0;
	this.mDefaultYOffset   = 4;
		
	this.mMaxIconsPerRow = 7;
	
	// timing
	this.mShowUITooltipTimer = null;
	this.mShowTileTooltipTimer = null;
	
	this.mShowDelay = 150;//150;
	this.mFadeInTime = 100;//100;
	this.mProgressbarMovementDuration = 600;

	// states
	this.mIsVisible = false;

	this.init();
};


TooltipModule.prototype.setDelay = function (_delay)
{
	this.mShowDelay = _delay;
};

TooltipModule.prototype.isVisibleForElement = function (_element)
{
	if (_element !== undefined && _element !== null &&
		this.mCurrentElement !== undefined && this.mCurrentElement !== null)
	{
		return _element.is(this.mCurrentElement) === true;
	}
	return false;
};


TooltipModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

TooltipModule.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

TooltipModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};


TooltipModule.prototype.createDIV = function ()
{
	this.mContainer = $('<div class="tooltip-module ui-control-tooltip-module display-none"></div>');
};


TooltipModule.prototype.init = function()
{
	this.createDIV();
};


TooltipModule.prototype.register = function (_parentDiv)
{
	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to register Tooltip Module. Reason: Tooltip Module is not initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object' && this.mContainer.parent().length === 0)
	{
		_parentDiv.append(this.mContainer);
		this.mParent = _parentDiv;
	
		// Note: This is a workaround to hide the Tooltip if the Cursor has been moven onto the tooltip...
		this.mContainer.on('mouseenter' + TooltipModuleIdentifier.KeyEvent.Namespace, null, this, function(_event) {
			var self = _event.data;
			self.hideTooltip();
		});
	}
};

TooltipModule.prototype.unregister = function ()
{
	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister Tooltip Module. Reason: Tooltip Module is not initialized.');
		return;
	}

	if (this.mContainer.parent().length !== 0)
	{
		this.mContainer.off(TooltipModuleIdentifier.KeyEvent.Namespace);
		this.mContainer.remove();
	}

	this.mParent = null;
};

TooltipModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


TooltipModule.prototype.registerEventListener = function (_listener)
{
	this.mEventListener = _listener;
};


TooltipModule.prototype.setCursorOffsets = function(_offsets)
{
	if (_offsets === null || typeof(_offsets) != 'object')
	{
		console.error('ERROR: Failed to set Tooltip cursor offsets. Reason: Invalid data.');
		return;
	}

	if ('X' in _offsets)
	{
		this.mCursorXOffset = _offsets.X;
	}
	if ('Y' in _offsets)
	{
		this.mCursorYOffset = _offsets.Y;
	}
};

/**
 *	Bind a Tooltip handler to the given UI Element
 *	@param 1: The Element the Tooltip should be bound too
 *	@param 2: Data Object which could look like:
 *
 *	data: { yOffset: <number>, 
 *			contentType: entity|skill|status-effect|ui-element <string>,
 *			entityId: <number>,
 *			skillId: <number>,
 *			statusEffectId: <number>,
 *			elementId: <number>
 *		}
 *
**/
TooltipModule.prototype.bindToElement = function(_targetDIV, _data)
{
	var baseself = this;
	if (_targetDIV === null || typeof(_targetDIV) != 'object')
	{
		console.error('ERROR: Failed to bind Tooltip to element. Reason: Element is not valid.');
		return;
	}

	// current and previous mouse coordinates
	/*
	var pX, pY;
	var trackMousePosition = function(_event)
	{
		// restart timer
		if ((Math.abs(pX - _event.pageX) + Math.abs(pY - _event.pageY)) > 0)
		{
			hideTooltip();
			
			// restart delay timer
			if (self.mShowUITooltipTimer)
			{
				self.mShowUITooltipTimer = clearTimeout(self.mShowUITooltipTimer);
			}
			self.mShowUITooltipTimer = setTimeout(function(){ showTooltip(_event); }, self.mShowDelay);
			
			pX = _event.pageX;
			pY = _event.pageY;
		}
	};
	*/

	// remove all previous callbacks
	this.unbindFromElement(_targetDIV);
	//_targetDIV.off(TooltipModuleIdentifier.KeyEvent.Namespace);

	// bind callbacks

	_targetDIV.on('mouseenter' + TooltipModuleIdentifier.KeyEvent.Namespace + ' mouseover' + TooltipModuleIdentifier.KeyEvent.Namespace + ' focus' + TooltipModuleIdentifier.KeyEvent.Namespace, null, this, function(_event) {
		var self = _event.data;
		//console.error('killmeeeeeee ' + _data.contentType); 
		//TESTSTART
/* 		var height = baseself.mContainer.outerHeight(true);
		var targetOffset    = _targetDIV.offset();
		var scrollheight = baseself.mContainer.get(0).scrollHeight;
		var divheight = _targetDIV.outerHeight(true);
		console.error('targetdiv ' + divheight + ', height ' + height + ', left ' + baseself.mContainer.css("left") + ', top ' + baseself.mContainer.css("top")); */
		//TESTEND
		//console.log('TooltipModule::mouseenter event triggered');

		// clear timer
		
		if (self.mShowUITooltipTimer)
		{
			self.mShowUITooltipTimer = clearTimeout(self.mShowUITooltipTimer);
		}
		
		// update current mouse position
		/*
		pX = _event.pageX;
		pY = _event.pageY;
		_targetDIV.on('mousemove', trackMousePosition);
		*/

		// remove the tile tooltip
		self.hideTileTooltip();
		
		// start show timer
		self.mShowUITooltipTimer = setTimeout(function() { self.showTooltip(_targetDIV, _data); }, self.mShowDelay);
	});

    _targetDIV.on('mouseleave' + TooltipModuleIdentifier.KeyEvent.Namespace + ' mouseout' + TooltipModuleIdentifier.KeyEvent.Namespace + ' blur' + TooltipModuleIdentifier.KeyEvent.Namespace, null, this, function (_event)
    {
		var self = _event.data;
		//console.error('killmeeeeeee 2 ' + _data.contentType); 
		//console.log('TooltipModule::mouseleave event triggered');

		// remove mouse position listener
		/*
		_targetDIV.off('mousemove', trackMousePosition);
		*/

		self.hideUITooltip();
	});
	
	
/*     _targetDIV.on('keydown' + TooltipModuleIdentifier.KeyEvent.Namespace, null, _targetDIV, function (_event)
    {
		console.error('oilala');
         var code = _event.which || _event.keyCode;
		var scrollheight = baseself.mContainer.get(0).scrollHeight;
		var height = baseself.mContainer.outerHeight(true);
		console.error('scrollheight ' + scrollheight + ', height ' + height);

        if (code === KeyConstants.PageDown)
		{
			
			console.error('scrollheight ' + scrollheight + ', heigh ' + height);
		}
		else if (code === KeyConstants.PageUp)
		{
			
		} 
	}); */

	// bind special callbacks
    _targetDIV.on('update-tooltip' + TooltipModuleIdentifier.KeyEvent.Namespace, null, this, function (_event)
    {
		var self = _event.data;
		//console.error('killmeeeeeee 3 ' + _data.contentType); 

		//console.log('TooltipModule::update-tooltip event triggered');

		self.reloadUITooltip();
	});

    _targetDIV.on('hide-tooltip' + TooltipModuleIdentifier.KeyEvent.Namespace, null, this, function (_event)
    {
		var self = _event.data;

		//console.log('TooltipModule::hide-tooltip event triggered');

		self.hideUITooltip();
	});
};

TooltipModule.prototype.unbindFromElement = function(_targetDIV)
{
	if (_targetDIV === null || typeof(_targetDIV) != 'object')
	{
		console.error('ERROR: Failed to unbind Tooltip from element. Reason: Element is not valid.');
		return;
	}

	if (this.isVisibleForElement(_targetDIV) === true)
	{
		this.hideUITooltip();
	}

	// remove all previous callbacks
	_targetDIV.off(TooltipModuleIdentifier.KeyEvent.Namespace);
};


TooltipModule.prototype.setupUITooltip = function(_targetDIV, _data)
{
	if(_targetDIV === undefined)
		return;

	var offsetY = ('yOffset' in _data) ? _data.yOffset : this.mDefaultYOffset;
	if (offsetY !== null)
	{
		if (typeof(offsetY) === 'string')
		{
			offsetY = parseInt(offsetY, 10);
		}
		else if (typeof(offsetY) !== 'number')
		{
			offsetY = 0;
		}
	}

	var wnd = this.mParent; // $(window);
	
	// calculate tooltip position
	var targetOffset    = _targetDIV.offset(); //from top to element
	var elementWidth    = _targetDIV.outerWidth(true);
	var elementHeight   = _targetDIV.outerHeight(true);
	var containerWidth  = this.mContainer.outerWidth(true);
	var containerHeight = this.mContainer.outerHeight(true);
	
	var posLeft = (targetOffset.left + (elementWidth / 2)) - (containerWidth / 2);
	var posTop  = targetOffset.top - containerHeight - offsetY;
	var monitorheight = screen.height;
	//console.error('posTop ' + posTop + ', contentType ' +  _data.contentType + ', bgimage ' + this.mContainer.css("background-image") + ', size ' + this.mContainer.css("background-size") + ', containerHeight' + containerHeight + ', containerWidth' + containerWidth + ', targetOffset.left' + targetOffset.left + ', targetOffset.top' + targetOffset.top + ', elementHeight' + elementHeight + ', containerWidth' + containerWidth);

	if (posLeft < 0)
	{
		posLeft = targetOffset.left;
	}
	
	if (posLeft + containerWidth > wnd.width())
	{
		posLeft = targetOffset.left + elementWidth - containerWidth;
	}
			
	if (posTop < 0) //below
	{
		posTop = targetOffset.top + elementHeight + offsetY;
		//console.error('posTop 2 ' + posTop + ', targetOffset.top ' + targetOffset.top + ', elementHeight ' + elementHeight + ', offsetY ' + offsetY);
		if ((posTop + containerHeight) > monitorheight && posTop > 100)
		{
			var TCenter = Math.max(Math.min(((targetOffset.top + (elementHeight / 2)) - (containerHeight/2)), monitorheight - containerHeight), offsetY);
			
			posTop = TCenter;
			if ((posLeft - (containerWidth / 2) - (elementWidth / 2)) > 10)
			{
				posLeft = posLeft - (containerWidth / 2) - (elementWidth / 2);
			}
			else
			{
				posLeft = posLeft + (containerWidth / 2) + (elementWidth / 2);
			}
		}
	}

 	//if (containerHeight > 553) //553
	//{
		//var backsize = this.mContainer.css("background-size").split(' ');
		//this.mContainer.css({ 'background-size' : backsize[0] + ' ' + (containerHeight*0.1) + 'rem' });
/* 		if (this.mContainer.css("background-image") == 'url(coui://gfx/ui/skin/tooltip_315_bottom.png)')
		{
			this.mContainer.css({ 'background-size' : '31.5rem ' + (containerHeight*0.1) + 'rem' });
		}
		else if (this.mContainer.css("background-image") == 'url(coui://gfx/ui/skin/tooltip_255_bottom.png)')
		{
			this.mContainer.css({ 'background-size' : '25.5rem ' + (containerHeight*0.1) + 'rem' });
		} */
		//console.error('bgimage: ' + this.mContainer.css("background-image"));
	//} 
	// show & position tooltip & animate
	this.mContainer.removeClass('display-none').addClass('display-block');
	this.mContainer.css({ left: posLeft, top: posTop });
	this.mContainer.css({ 'background-size' : (containerWidth*0.1) + 'rem ' + Math.max((containerHeight*0.1), 55) + 'rem' });
	this.mContainer.velocity("finish", true).velocity({ opacity: 0.99 }, { duration: this.mFadeInTime }); // Anti Alias Fix
	if (containerHeight > monitorheight)
	{
		var scrollingdur = 30 * (containerHeight - monitorheight);
		var finaltop = ((monitorheight - containerHeight)*0.1) + "rem";
		this.mContainer.velocity("finish", true).velocity({ top:  finaltop}, { duration: scrollingdur });
	}
	else
	{
		this.mContainer.velocity("finish", true).velocity({ top:  posTop}, { duration: 10 });
	}
};


TooltipModule.prototype.showTooltip = function(_targetDIV, _data)
{
	// clear timer
	if (this.mShowUITooltipTimer)
	{
		this.mShowUITooltipTimer = clearTimeout(this.mShowUITooltipTimer);
	}

	//console.log('#1 show ui tooltip. InDOM: ' + _targetDIV.isInDOM());

	// #2 sanity check
/* TODO: _targetDIV hat die funktion isInDOM() ned ?!
	if (!_targetDIV.isInDOM())
	{
		console.log('ERROR: Target UI element is not within the DOM.');
		// clean up
		this.mCurrentData    = null;
		this.mCurrentElement = null;
		return;
	}
*/
    // check if the tooltip is enabled for this particular element
    var isEnabled = _targetDIV.data('is-enabled');
    if (isEnabled !== null && isEnabled === false)
    {
        return;
    }

    // get tooltip data
    var self = this;
    this.notifyBackendQueryTooltipData(_data, function (tooltipData)
    {
        if (tooltipData === undefined || tooltipData === null)
        {
            console.log('ERROR: Failed to query Tooltip data. Reason: Data is not valid.');
            return;
        }

        self.mIsVisible = true;
        self.mCurrentData = _data;
        self.mCurrentElement = _targetDIV;

        // setup tooltip div
        self.buildFromData(tooltipData, false, _data.contentType);
        self.setupUITooltip(_targetDIV, _data);
    });   
};

TooltipModule.prototype.hideTooltip = function()
{
    // clear tile tooltip timer
    if (this.mShowTileTooltipTimer)
    {
        this.mShowTileTooltipTimer = clearTimeout(this.mShowTileTooltipTimer);
    }

	// clear UI tooltip timer
	if (this.mShowUITooltipTimer)
	{
		this.mShowUITooltipTimer = clearTimeout(this.mShowUITooltipTimer);
	}
	
	// hide tooltip
	this.mContainer.removeClass('display-block').addClass('display-none');
	this.mIsVisible      = false;
	this.mCurrentData    = null;
	this.mCurrentElement = null;
};


TooltipModule.prototype.hideUITooltip = function()
{
	// clear timer
	if (this.mShowUITooltipTimer)
	{
		this.mShowUITooltipTimer = clearTimeout(this.mShowUITooltipTimer);
	}
	
	// only hide the UI Tooltip if IT IS actually a UI Tooltip
	var hideTooltip = true;
	if (this.mCurrentData !== null && (this.mCurrentData.contentType === 'tile' || this.mCurrentData.contentType === 'tile-entity'))
	{
		//console.log('WARNING: Trying to hide a NON UI Tooltip! - Type: ' + this.mCurrentData.contentType);
		hideTooltip = false;
	}

	// hide the tooltip
	if (hideTooltip)
	{
		this.mContainer.removeClass('display-block').addClass('display-none');
		this.mIsVisible      = false;
		this.mCurrentData    = null;
		this.mCurrentElement = null;
	}
};

TooltipModule.prototype.reloadUITooltip = function()
{
	// 1# sanity check
	if (!this.mIsVisible ||
		(this.mCurrentData === undefined || this.mCurrentData === null) ||
		(this.mCurrentElement === undefined || this.mCurrentElement === null) )
	{
		return;
	}

	//console.log('#1 reload ui tooltip. InDOM: ' + this.mCurrentElement.isInDOM());

	// #2 sanity check
	if (!this.mCurrentElement.isInDOM())
	{
		//console.error('ERROR: Current UI element is not within the DOM.');
		// clean up
		this.mCurrentData    = null;
		this.mCurrentElement = null;

		// TODO: Prüfen ob das hier an der richtigen Stelle ist und nicht noch geprüft werden muss
		// ob es wirklich ein ui tooltip ist!
		//this.hideTooltip(); 
		return;
	}

	// get tooltip data
	var self = this;
	this.notifyBackendQueryTooltipData(this.mCurrentData, function(tooltipData)
	{
		if (tooltipData === null || self.mCurrentData == null || self.mCurrentData == null)
	    {
	        //console.log('ERROR: Failed to query Tooltip data. Reason: Data is not valid.');
	        return;
	    }

	    // update tooltip
	    self.buildFromData(tooltipData, true, self.mCurrentData.contentType);
	    self.setupUITooltip(self.mCurrentElement, self.mCurrentData);
	});
};


TooltipModule.prototype.resetInternal = function()
{
	// stop and remove every animation executed on the tooltip container
	this.mContainer.stop(true, true);

	// NOTE: Special Chrome treatment...removeAttr('styles') does not work properly...
    this.mContainer.css(
    {
		'width': '',
		'height': '',
		'left': '',
		'top': '',
		'bottom': '',
		'right':'',
		'opacity': 0
	});
};


TooltipModule.prototype.mouseEnterTile = function(_event)
{
	if (_event === null || typeof(_event) != 'object' || !('X' in _event) || !('Y' in _event))
	{
		console.error('ERROR: Failed to show Tile Tooltip. Reason: Parameters not valid.');
		return;
	}
	
	// clear timer
	if (this.mShowTileTooltipTimer)
	{
		this.mShowTileTooltipTimer = clearTimeout(this.mShowTileTooltipTimer);
	}
	
	// save current mouse position
	this.mLastMouseX = _event.X;
	this.mLastMouseY = _event.Y;
	
	// save data type
	if ('EntityId' in _event)
	{
		this.mCurrentData = { contentType: 'tile-entity', entityId: _event.EntityId };
	}
	else
	{
		this.mCurrentData = { contentType: 'tile' };
	}
	
	// start delay timer
	var self = this;
	this.mShowTileTooltipTimer = setTimeout(function(){ self.showTileTooltip(); }, this.mShowDelay);
};

TooltipModule.prototype.mouseHoverTile = function(_event)
{
	if (_event === null || typeof(_event) != 'object' || !('X' in _event) || !('Y' in _event))
	{
		console.error('ERROR: Failed to show Tile Tooltip. Reason: Parameters not valid.');
		return;
	}

	// restart timer
	if ((Math.abs(this.mLastMouseX - _event.X) + Math.abs(this.mLastMouseY - _event.Y)) >= this.mMinMouseMovement)
	{
		//console.log('TooltipModule: mouse hover tile! Data + ' + this.mCurrentData);

		// save data as we need to restore it
		var currentData = this.mCurrentData;

		// hide tooltip
		this.hideTileTooltip();
		
		// restore data as we need to identify the tile content
		this.mCurrentData = currentData;

		//console.log('TooltipModule: mouse hover tile! Data + ' + this.mCurrentData);

		var self = this;
		this.mShowTileTooltipTimer = setTimeout(function(){ self.showTileTooltip(); }, this.mShowDelay);
		
		this.mLastMouseX = _event.X;
		this.mLastMouseY = _event.Y;
	}
};

TooltipModule.prototype.mouseLeaveTile = function()
{
	this.hideTileTooltip();
};

TooltipModule.prototype.showTileTooltip = function()
{
	if (this.mCurrentData === undefined || this.mCurrentData === null)
	{
		return;
	}

	//console.log('TooltipModule: show tile tooltip!');

	// clear timer
	if (this.mShowTileTooltipTimer)
	{
		this.mShowTileTooltipTimer = clearTimeout(this.mShowTileTooltipTimer);
	}

	// get tooltip data
	var self = this;
	this.notifyBackendQueryTooltipData(this.mCurrentData, function(tooltipData)
	{
		if (tooltipData === undefined || tooltipData === null)
	    {
	        //console.log('ERROR: Failed to query Tooltip data. Reason: Data is not valid.');
	        return;
	    }

	    // do we need to update the contentType as an entity could have moved on to the hovered tile
	    // while we had our hands in our pants :L
	    var newContentType = self.updateContentType(tooltipData);
	    if (newContentType !== null)
	    {
	        //console.log('Content Typed updated to: ' + newContentType.contentType);
	        self.mCurrentData = newContentType;
	    }
	    /*else
	    {
	    	return;
	    }*/

	    if(self.mCurrentData == null)
	    	return;

		// setup tooltip div
	    self.buildFromData(tooltipData, false, self.mCurrentData.contentType);
	    self.setupTileTooltip();

	    self.mIsVisible = true;
	});
};

TooltipModule.prototype.hideTileTooltip = function()
{
	// clear timer
	if (this.mShowTileTooltipTimer)
	{
		this.mShowTileTooltipTimer = clearTimeout(this.mShowTileTooltipTimer);
	}
	
	// only hide the Tile Tooltip if IT IS actually a Tile Tooltip
	var hideTooltip = false;
	if (this.mCurrentData !== null && (this.mCurrentData.contentType === 'tile' || this.mCurrentData.contentType === 'tile-entity'))
	{
		//console.log('INFO: Trying to hide a Tile Tooltip! - Type: ' + this.mCurrentData.contentType);
		hideTooltip = true;
	}

	// hide the tooltip
	if (hideTooltip)
	{
		this.mContainer.removeClass('display-block').addClass('display-none');
		this.mIsVisible      = false;
		this.mCurrentData    = null;
		this.mCurrentElement = null;
	}
};

TooltipModule.prototype.reloadTileTooltip = function()
{
	if (!this.mIsVisible)
	{
		return;
	}

	var currentData = this.mCurrentData;
	if (currentData === null)
	{
		currentData = { contentType: 'tile' };
	}

	// get tooltip data
	var self = this;
	this.notifyBackendQueryTooltipData(currentData, function(tooltipData)
	{
	    if (tooltipData === null)
	    {
	        //console.log('ERROR: Failed to query Tooltip data. Reason: Data is not valid.');
	        return;
	    }

	    // do we need to update the contentType as an entity could have moved on to the hovered tile
	    // while we had our hands in our pants :L
	    var newContentType = self.updateContentType(tooltipData);
	    if (newContentType !== null)
	    {
	        //console.log('Content Typed updated to: ' + newContentType.contentType);
	        self.mCurrentData = newContentType;
	    }
	    /*else
	    {
	    	return;
	    }*/

	    if (self.mCurrentData == null)
	    	return;

	    // setup tooltip div
	    self.buildFromData(tooltipData, true, currentData.contentType);
	    self.setupTileTooltip();
	});
};

TooltipModule.prototype.setupTileTooltip = function()
{
	var wnd = this.mParent; // $(window);
	
	var containerWidth = this.mContainer.outerWidth(true);
	var containerHeight = this.mContainer.outerHeight(true);
	
	var posLeft = this.mLastMouseX + (this.mCursorXOffset === 0 ? (this.mCursorWidth / 2) : (this.mCursorWidth - ((this.mCursorWidth / 2) - this.mCursorXOffset)) );
	var posTop = this.mLastMouseY + (this.mCursorYOffset === 0 ? (this.mCursorHeight / 2) : (this.mCursorHeight - ((this.mCursorHeight / 2) - this.mCursorYOffset)));
	
	if (posLeft < 0)
	{
		posLeft = 10;
	}
	
	if (posLeft + containerWidth > wnd.width())
	{
		posLeft = wnd.width() - containerWidth - 10;
	}
	
	if ((posTop + containerHeight) > wnd.height())
	{
		if (containerHeight > wnd.height())
		{
			posTop = 10;
		}
		else
		{
			posTop = this.mLastMouseY - (this.mCursorYOffset === 0 ? ((this.mCursorHeight / 2) + containerHeight) : (this.mCursorYOffset + containerHeight));
		}
	}
	var posTop = Math.max(posTop, 10);

	// TODO: Remove
	//console.log('DEBUG: setupTileTooltip:(top: ' + posTop + ' left:' + posLeft + ')');
	
	// show & position tooltip & animate
	
	this.mContainer.removeClass('display-none').addClass('display-block');
	this.mContainer.css({ left: posLeft, top: posTop });
	this.mContainer.css({ 'background-size' : (containerWidth*0.1) + 'rem ' + Math.max((containerHeight*0.1), 55) + 'rem' });
	this.mContainer.velocity("finish", true).velocity({ opacity: 0.99 }, { duration: this.mFadeInTime }); // Anti Alias Fix
	if (containerHeight > wnd.height())
	{
		var scrollingdur = 30 * (containerHeight - wnd.height());
		var finaltop = ((wnd.height() - containerHeight)*0.1) + "rem";
		this.mContainer.velocity("finish", true).velocity({ top:  finaltop}, { duration: scrollingdur });
	}
	else
	{
		this.mContainer.velocity("finish", true).velocity({ top:  posTop}, { duration: 10 });
	}
};


TooltipModule.prototype.reloadTooltip = function()
{
	if (!this.mIsVisible)
	{
		return;
	}

	if (this.mCurrentData !== null && this.mCurrentElement !== null)
	{
		this.reloadUITooltip();
	}
	else
	{
		this.reloadTileTooltip();
	}
};


TooltipModule.prototype.updateContentType = function(_data)
{
	if (typeof(_data) === null || !jQuery.isArray(_data))
	{
		return;
	}

	for (var i = 0; i < _data.length; ++i)
	{
		if ('contentType' in _data[i])
		{
			switch(_data[i].contentType)
			{
				case 'tile-entity':
				{
					if ('entityId' in _data[i])
					{
						return { contentType: 'tile-entity', entityId: _data[i].entityId };
					}
				} break;
                case 'roster-entity':
				case 'entity':
				{
					if ('entityId' in _data[i])
					{
						return { contentType: 'entity', entityId: _data[i].entityId };
					}
				} break;
			}
		}
	}

	return null;
};


TooltipModule.prototype.buildFromData = function(_data, _shouldBeUpdated, _contentType)
{
	if (typeof(_data) === null || !jQuery.isArray(_data))
	{
		console.error('ERROR: Failed to build Tooltip. Reason: Tooltip data is invalid.');
		return;
	}
	
	// should the tooltip content be updated?
	var shouldBeUpdated = false;//(_shouldBeUpdated !== undefined && _shouldBeUpdated !== false);

	// container handle
	var headerContainer       = null;
	var contentContainer      = null;
	var leftContentContainer  = null;
	var rightContentContainer = null;
	var footerContainer       = null;
	var hintContainer         = null;

	if (!shouldBeUpdated)
	{
		// clear tooltip
		this.mContainer.removeClass('is-full-width is-tile-content is-entity-content is-skill-content is-status-effect-content is-ui-element-content is-ui-item-content');
		this.mContainer.empty();
		this.resetInternal();
		
		var ornament = $('<div class="top-ornament"></div>');
		this.mContainer.append(ornament);

		// create: container
		headerContainer = $('<div class="header-container"></div>');
		this.mContainer.append(headerContainer);

		contentContainer = $('<div class="content-container"></div>');
		this.mContainer.append(contentContainer);

		leftContentContainer = $('<div class="left-content-container"></div>');
		contentContainer.append(leftContentContainer);
		rightContentContainer = $('<div class="right-content-container"></div>');
		contentContainer.append(rightContentContainer);

		footerContainer = $('<div class="footer-container"></div>');
		this.mContainer.append(footerContainer);

		hintContainer= $('<div class="hint-container"></div>');
		this.mContainer.append(hintContainer);
	}
	else
	{
		// accquire: container
		headerContainer       = this.mContainer.find('.header-container:first');
		contentContainer      = this.mContainer.find('.content-container:first');
		leftContentContainer  = contentContainer.find('.left-content-container:first');
		rightContentContainer = contentContainer.find('.right-content-container:first');
		footerContainer       = this.mContainer.find('.footer-container:first');
		hintContainer         = this.mContainer.find('.hint-container:first');

		// sanity check
		if (headerContainer.length === 0 ||
			contentContainer.length === 0 ||
			leftContentContainer.length === 0 ||
			rightContentContainer.length === 0 ||
			footerContainer.length === 0 ||
			hintContainer.length === 0)
		{
			console.error('ERROR: Failed to update Tooltip. Reason: Tooltip container not found.');
			return;
		}
	}

	// vars
	var headerWidth  = 0;
	var tooltipWidth = 0;
	
	var hasHeader		= false;
	var hasHeaderText	= false;
	var hasContent		= false;
	var hasFooter		= false;
	var hasHint			= false;

	var headerTitle       = null;
	var headerDescription = null;
	var headerLastText    = null;
	var atmosphericImageContainer = null;

	// fill container
	for (var i = 0; i < _data.length; ++i)
	{
		var data = _data[i];

		// ignore this entry
		if ('contentType' in data)
		{
			continue;
		}

		if (typeof(data) != 'object' || !('type' in data))
		{
			console.error('ERROR: Failed to find "type" field while interpreting tooltip entry. Index: ' + i);
			continue;
		}

		if (!('id' in data))
		{
			console.error('ERROR: Failed to find "id" field while interpreting tooltip entry. Index: ' + i);
			continue;
		}
	
		switch(data.type)
		{
			// Header
			case 'title':
			{
				if (!shouldBeUpdated)
				{
					headerTitle = this.addHeaderTitleDiv(headerContainer, data);
				}
				else
				{
					headerTitle = this.updateHeaderTitleDiv(headerContainer, data);
				}
				hasHeader = true;
			} break;

			case 'description':
			{
				if (!shouldBeUpdated)
				{
					headerDescription = this.addHeaderDescriptionDiv(headerContainer, data);
				}
				else
				{
					headerDescription = this.updateHeaderDescriptionDiv(headerContainer, data);
				}
				
				hasHeader = true;
			} break;

            case 'header':
			{
                var element = null;

                if (!shouldBeUpdated)
				{
                    element = this.addHeaderContentTextDiv(rightContentContainer, data, false, false);
				}
				else
				{
                    element = this.updateHeaderContentTextDiv(rightContentContainer, data, false, false);
                }

                if (element !== null)
				{
					hasContent = true;
				}
			} break;

			case 'headerText':
			{
				if (!shouldBeUpdated)
				{
					headerLastText = this.addHeaderTextDiv(headerContainer, data, false, false);
				}
				else
				{
					headerLastText = this.updateHeaderTextDiv(headerContainer, data, false, false);
				}

				hasHeader = true;
				hasHeaderText = true;
			} break;
						
			// Atmospheric image
			case 'image':
			{
				if (!shouldBeUpdated)
				{
					atmosphericImageContainer = this.addAtmosphericImageDiv(leftContentContainer, data);
				}
				else
				{
					atmosphericImageContainer = this.updateAtmosphericImageDiv(leftContentContainer, data);
				}

				if (atmosphericImageContainer !== null)
				{
					hasContent = true;
				}
			} break;

			// Content
			case 'text':
			{
				var element = null;
				if (!shouldBeUpdated)
				{
					element = this.addContentTextDiv(rightContentContainer, data);
				}
				else
				{
					element = this.updateContentTextDiv(rightContentContainer, data);
				}

				if (element !== null)
				{
					hasContent = true;
				}
			} break;

			case 'progressbar':
			{
				if (!shouldBeUpdated)
				{
					this.addContentProgressbarDiv(rightContentContainer, data);
				}
				else
				{
					this.updateContentProgressbarDiv(rightContentContainer, data);
				}

				hasContent = true;
			} break;

			// Footer
			case 'icons':
			{
				if (!shouldBeUpdated)
				{
					this.addFooterIconDiv(footerContainer, data);
				}
				else
				{
					this.updateFooterIconDiv(footerContainer, data);
				}

				hasFooter = true;
			} break;
			
			case 'hint':
			{
				if (!shouldBeUpdated)
				{
					this.addHintDiv(hintContainer, data);
				}
				else
				{
					hintContainer.remove();
					hintContainer.empty();
					hintContainer = $('<div class="hint-container"></div>');
					this.mContainer.append(hintContainer);
					this.addHintDiv(hintContainer, data);
					
					//this.updateHintDiv(hintContainer, data);
				}

				hasHint = true;
			} break;

			// TODO: More Types?!
		}
	}

	// remove container
	if (!hasHeader && !hasHeaderText)
	{
		headerContainer.addClass('display-none');
	}

	if (!hasContent)
	{
		contentContainer.addClass('display-none');
	}

	if (!hasFooter)
	{
		footerContainer.addClass('display-none');
	}

	if (!hasHint)
	{
		hintContainer.addClass('display-none');
	}
	
	// add size flags
	//console.log('TOOLTIP: Content Type: ' + _contentType);
	switch(_contentType)
	{
		case 'tile':
		{
			this.mContainer.addClass('is-full-width is-tile-content');
		} break;
	    case 'tile-entity':
		case 'entity':
		{
			this.mContainer.addClass('is-entity-content');
		} break;
	    case 'roster-entity':
	    {
	        this.mContainer.addClass('is-full-width is-entity-content');
	    } break;
	    case 'skill':
		{
			this.mContainer.addClass('is-full-width is-skill-content');
		} break;
		case 'status-effect':
		{
			this.mContainer.addClass('is-full-width is-status-effect-content');
		} break;
		case 'settlement-status-effect':
		{
			this.mContainer.addClass('is-full-width is-status-effect-content');
		} break;
        case 'ui-element':
        case 'verbatim':
        case 'company-perk':
		{
			this.mContainer.addClass('is-full-width is-ui-element-content');
		} break;
		case 'ui-item':
		{
			this.mContainer.addClass('is-full-width is-ui-item-content');
		} break;
        case 'follower':
        {
            this.mContainer.addClass('is-full-width is-ui-element-content');
        } break;
	}

	/*
	if (atmosphericImageContainer !== null || (headerDescription !== null && !hasContent && !hasFooter))
	{
		this.mContainer.removeClass('is-full-width').addClass('is-full-width');
		//leftContentContainer.addClass('ui-control-tooltip-module-right-devider');
	}
	else
	{
		this.mContainer.removeClass('is-full-width');
		//leftContentContainer.addClass('ui-control-tooltip-module-right-devider');
	}
	*/

	// add dividers
	if (hasContent || headerLastText !== null)
	{
		if (headerDescription !== null)
		{
			headerDescription.addClass('ui-control-tooltip-module-bottom-devider');
		}
		else if (headerTitle !== null)
		{
			headerTitle.addClass('ui-control-tooltip-module-bottom-devider');
		}
	}

	if (hasContent && headerLastText !== null)
	{
		headerLastText.addClass('ui-control-tooltip-module-bottom-devider');
	}
	
	if ((hasHeader || hasContent) && hasFooter)
	{
		footerContainer.addClass('ui-control-tooltip-module-top-devider');
	}

	if ((hasHeader || hasContent) && hasHint)
	{
		hintContainer.addClass('ui-control-tooltip-module-top-devider');
	}
};


TooltipModule.prototype.extractDataFlags = function(_data)
{
	if ('flags' in _data && jQuery.isArray(_data.flags))
	{
		return _data.flags;
	}
	return null;
};

TooltipModule.prototype.flagsContain = function(_flags, _contain)
{
	if (_flags !== null && jQuery.isArray(_flags))
	{
		for (var i = 0; i < _flags.length; ++i)
		{
			if (_flags[i] === _contain)
			{
				return true;
			}
		}
	}
	return false;
};


TooltipModule.prototype.addHeaderTitleDiv = function(_parentDIV, _data)
{
	if (!('text' in _data))
	{
		return null;
	}

	var container = $('<div class="row title-container"></div>');
	container.attr('id', 'tooltip-module-title-container-' + _data.id);
	_parentDIV.append(container);
	
	var title = $('<div class="title title-font-normal font-bold font-color-ink"></div>');
	title.attr('id', 'tooltip-module-title-' + _data.id);
	
    var parsedText = XBBCODE.process(
    {
		text: _data.text,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});
	
	title.html(parsedText.html);
	container.append(title);
	
	if ('icon' in _data && _data.icon !== null && typeof(_data.icon) === 'string' && _data.icon.length > 0)
	{
		var titleImageContainer = $('<div class="title-image"></div>');
		title.before(titleImageContainer);

		var titleImage = $('<img/>');
		titleImage.attr('src', Path.GFX + _data.icon);
		titleImage.attr('id', 'tooltip-module-title-image-' + _data.id);
		titleImageContainer.append(titleImage);
	}

	return container;
};

TooltipModule.prototype.updateHeaderTitleDiv = function(_parentDIV, _data)
{
	var container = _parentDIV.find('#tooltip-module-title-container-' + _data.id + ':first');
	
	var flags = this.extractDataFlags(_data);
	if (this.flagsContain(flags, 'remove'))
	{
		if (container.length > 0)
		{
			container.remove();
		}
		return null;
	}
	else
	{
		if (container.length === 0)
		{
			return this.addHeaderDescriptionDiv(_parentDIV, _data);
		}

		// TODO: update - if needed by the game

		return container;
	}
};


TooltipModule.prototype.addHeaderDescriptionDiv = function(_parentDIV, _data)
{
	if (!('text' in _data))
	{
		return null;
	}

	var container = $('<div class="row description-container"></div>');
	container.attr('id', 'tooltip-module-title-description-container-' + _data.id);
	_parentDIV.append(container);

	var description = $('<div class="description description-font-small font-color-ink"></div>');
	description.attr('id', 'tooltip-module-title-description-' + _data.id);
	container.append(description);
	
    var parsedText = XBBCODE.process(
    {
		text: _data.text,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});
	
	description.html(parsedText.html);

	return container;
};

TooltipModule.prototype.updateHeaderDescriptionDiv = function(_parentDIV, _data)
{
	var container = _parentDIV.find('#tooltip-module-title-description-container-' + _data.id + ':first');
	
	var flags = this.extractDataFlags(_data);
	if (this.flagsContain(flags, 'remove'))
	{
		if (container.length > 0)
		{
			container.remove();
		}
		return null;
	}
	else
	{
		if (container.length === 0)
		{
			return this.addHeaderDescriptionDiv(_parentDIV, _data);
		}

		// TODO: update  - if needed by the game

		return container;
	}
};


TooltipModule.prototype.addHeaderContentTextDiv = function(_parentDIV, _data, _isChildRow, _isParentFullWidth)
{
	if (!('text' in _data) || typeof(_data.text) !== 'string' || _data.text.length === 0)
	{
		return null;
	}

	var container = null;
	if (!_isChildRow)
	{
		container = $('<div class="row content-container"></div>');
		container.attr('id', 'tooltip-module-content-text-container-' + _data.id);
	}
	else
	{
		container = $('<div class="row content-child-container"></div>');
		container.attr('id', 'tooltip-module-content-child-container-' + _data.id);
		if (_isParentFullWidth)
		{
			container.addClass('is-full-width');
		}
	}
	_parentDIV.append(container);

	var useFullWidth = true;

	// add text
	var rightColumn = $('<div class="l-right-column"></div>');
	container.append(rightColumn);
	
	// full with?
	if (useFullWidth || (_isChildRow && _isParentFullWidth))
	{
		rightColumn.addClass('is-full-width');
	}

    var text = $('<div class="title title-font-normal font-bold font-color-ink"></div>');
	text.attr('id', 'tooltip-module-content-text-' + _data.id);
	rightColumn.append(text);

	if (typeof(_data.text) == 'string')
	{
		var parsedText = XBBCODE.process({
			text: _data.text,
			removeMisalignedTags: false,
			addInLineBreaks: true
		});
	
		text.html(parsedText.html);
	}

    container.addClass('ui-control-tooltip-module-bottom-devider');

	return container;
};

TooltipModule.prototype.updateHeaderContentTextDiv = function(_parentDIV, _data, _isChildRow)
{
	var container = _parentDIV.find('#tooltip-module-content-text-container-' + _data.id + ':first');
	
	var flags = this.extractDataFlags(_data);
	if (this.flagsContain(flags, 'remove'))
	{
		if (container.length > 0)
		{
			container.remove();
		}
		return null;
	}
	else
	{
		if (container.length === 0)
		{
			return this.addContentTextDiv(_parentDIV, _data, _isChildRow);
		}


		// TODO: update label - if needed by the game

		// update text
		if ('text' in _data)
		{
			var text = container.find('#tooltip-module-content-text-' + _data.id + ':first');
			if (text.length === 0)
			{
				console.error('ERROR: Failed to find "tooltip-module-content-text-' + _data.id + '" element while interpreting tooltip data.');
				return null;
			}

			if (typeof(_data.text) == 'string')
			{
				var parsedText = XBBCODE.process({
					text: _data.text,
					removeMisalignedTags: false,
					addInLineBreaks: true
				});
			
				text.html(parsedText.html);
			}
		}

		return container;
	}
};


TooltipModule.prototype.addHeaderTextDiv = function(_parentDIV, _data, _isChildRow, _isParentFullWidth)
{
	if (!('text' in _data))
	{
		return null;
	}

	var container = null;
	if (!_isChildRow)
	{
		container = $('<div class="row title-text-container"></div>');
		container.attr('id', 'tooltip-module-title-text-container-' + _data.id);
	}
	else
	{
		container = $('<div class="row title-child-text-container"></div>');
		container.attr('id', 'tooltip-module-title-child-text-container-' + _data.id);
		if (_isParentFullWidth)
		{
			container.addClass('is-full-width');
		}
	}
	_parentDIV.append(container);
	
	// check if we have a label
	var useFullWidth = true;
	var hasIcon = ('icon' in _data);
	var hasLabel = ('label' in _data);
	var leftColumn = null;

	if (hasIcon || hasLabel)
	{
		useFullWidth = false;

		leftColumn = $('<div class="l-left-column"></div>');
		container.append(leftColumn);

		var label = $('<div class="label text-font-small font-color-ink"></div>');
		label.attr('id', 'tooltip-module-title-text-label-' + _data.id);
		leftColumn.append(label);

		// prefer icon over label
		if (hasIcon)
		{
			var image = $('<img/>');
			image.attr('src', Path.GFX + _data.icon);
			label.append(image);
		}
		else if (hasLabel)
		{
			if (typeof(_data.label) == 'string')
			{
				var parsedLabel = XBBCODE.process({
					text: _data.label,
					removeMisalignedTags: false,
					addInLineBreaks: true
				});
			
				label.html(parsedLabel.html);
			}
		}
	}

	// add text
	var rightColumn = $('<div class="l-right-column"></div>');
	container.append(rightColumn);
	
	// full width?
	if (useFullWidth || (_isChildRow && _isParentFullWidth))
	{
		rightColumn.addClass('is-full-width');
	}

	var text = $('<div class="text text-font-small font-color-ink"></div>');
	text.attr('id', 'tooltip-module-title-text-text-' + _data.id);
	rightColumn.append(text);

	if (typeof(_data.text) == 'string')
	{
		var parsedText = XBBCODE.process({
			text: _data.text,
			removeMisalignedTags: false,
			addInLineBreaks: true
		});
	
		text.html(parsedText.html);
	}

	// add children rows
	if ('children' in _data)
	{
		for (var i = 0; i < _data.children.length; ++i)
		{
			this.addHeaderTextDiv(container, _data.children[i], true, useFullWidth);
		}
	}

	return container;
};

TooltipModule.prototype.updateHeaderTextDiv = function(_parentDIV, _data, _isChildRow, _isParentFullWidth)
{
	var container = _parentDIV.find('#tooltip-module-title-text-container-' + _data.id + ':first');
	
	var flags = this.extractDataFlags(_data);
	if (this.flagsContain(flags, 'remove'))
	{
		if (container.length > 0)
		{
			container.remove();
		}
		return null;
	}
	else
	{
		if (container.length === 0)
		{
			return this.addHeaderTextDiv(_parentDIV, _data, _isChildRow);
		}

		// TODO: update label - if needed by the game

		// update text
		if ('text' in _data)
		{
			var text = container.find('#tooltip-module-title-text-text-' + _data.id + ':first');
			if (text.length === 0)
			{
				console.error('ERROR: Failed to find "title-text-text-' + _data.id + '" element while interpreting tooltip data.');
				return null;
			}

			if (typeof(_data.text) == 'string')
			{
				var parsedText = XBBCODE.process({
					text: _data.text,
					removeMisalignedTags: false,
					addInLineBreaks: true
				});
			
				text.html(parsedText.html);
			}
		}

		// TODO: update children - if needed by the game

		return container;
	}
};


TooltipModule.prototype.addAtmosphericImageDiv = function(_parentDIV, _data)
{
	if (!('image' in _data) || typeof(_data.image) !== 'string' || _data.image.length === 0)
	{
		return null;
	}

	var container = $('<div class="l-image-container is-small"></div>');
	_parentDIV.append(container);
	container.attr('id', 'tooltip-module-atmospheric-image-' + _data.id);
	
	if ('isLarge' in _data && _data.isLarge === true)
	{
		container.removeClass('is-small').addClass('is-large');
	}

	var image = $('<img/>');
	image.attr('src', Path.ITEMS + _data.image);
	container.append(image);

	return container;
};

TooltipModule.prototype.updateAtmosphericImageDiv = function(_parentDIV, _data)
{
	var container = _parentDIV.find('#tooltip-module-atmospheric-image-' + _data.id + ':first');
	
	var flags = this.extractDataFlags(_data);
	if (this.flagsContain(flags, 'remove'))
	{
		if (container.length > 0)
		{
			container.remove();
		}
		return null;
	}
	else
	{
		if (container.length === 0)
		{
			return this.addAtmosphericImageDiv(_parentDIV, _data);
		}

		// TODO: update image - if needed by the game
	}

	return container;
};


TooltipModule.prototype.addContentTextDiv = function(_parentDIV, _data, _isChildRow, _isParentFullWidth)
{
	if (!('text' in _data) || typeof(_data.text) !== 'string' || _data.text.length === 0)
	{
		return null;
	}

	var container = null;
	if (!_isChildRow)
	{
		container = $('<div class="row content-container"></div>');
		container.attr('id', 'tooltip-module-content-text-container-' + _data.id);
	}
	else
	{
		container = $('<div class="row content-child-container"></div>');
		container.attr('id', 'tooltip-module-content-child-container-' + _data.id);
		if (_isParentFullWidth)
		{
			container.addClass('is-full-width');
		}
	}
	_parentDIV.append(container);

	var useFullWidth = true;
	var hasIcon = ('icon' in _data);
	var hasLabel = ('label' in _data);
	var leftColumn = null;

	if (hasIcon || hasLabel)
	{
		useFullWidth = false;

		leftColumn = $('<div class="l-left-column"></div>');
		container.append(leftColumn);

		var label = $('<div class="label text-font-small font-color-ink"></div>');
		label.attr('id', 'tooltip-module-content-label-' + _data.id);
		leftColumn.append(label);

		// prefer icon over label
		if (hasIcon)
		{
			var image = $('<img/>');
			image.attr('src', Path.GFX + _data.icon);
			label.append(image);
		}
		else if (hasLabel)
		{
			if (typeof(_data.label) == 'string')
			{
				var parsedLabel = XBBCODE.process({
					text: _data.label,
					removeMisalignedTags: false,
					addInLineBreaks: true
				});
			
				label.html(parsedLabel.html);
			}
		}
	}

	// add text
	var rightColumn = $('<div class="l-right-column"></div>');
	container.append(rightColumn);
	
	// full with?
	if (useFullWidth || (_isChildRow && _isParentFullWidth))
	{
		rightColumn.addClass('is-full-width');
	}

	var text = $('<div class="text text-font-small font-color-ink"></div>');
	text.attr('id', 'tooltip-module-content-text-' + _data.id);
	rightColumn.append(text);

	if (typeof(_data.text) == 'string')
	{
		var parsedText = XBBCODE.process({
			text: _data.text,
			removeMisalignedTags: false,
			addInLineBreaks: true
		});
	
		text.html(parsedText.html);
	}

	// add children rows
	if ('children' in _data)
	{
		for (var i = 0; i < _data.children.length; ++i)
		{
			this.addContentTextDiv(container, _data.children[i], true, useFullWidth);
		}
	}

	return container;
};

TooltipModule.prototype.updateContentTextDiv = function(_parentDIV, _data, _isChildRow)
{
	var container = _parentDIV.find('#tooltip-module-content-text-container-' + _data.id + ':first');
	
	var flags = this.extractDataFlags(_data);
	if (this.flagsContain(flags, 'remove'))
	{
		if (container.length > 0)
		{
			container.remove();
		}
		return null;
	}
	else
	{
		if (container.length === 0)
		{
			return this.addContentTextDiv(_parentDIV, _data, _isChildRow);
		}


		// TODO: update label - if needed by the game

		// update text
		if ('text' in _data)
		{
			var text = container.find('#tooltip-module-content-text-' + _data.id + ':first');
			if (text.length === 0)
			{
				console.error('ERROR: Failed to find "tooltip-module-content-text-' + _data.id + '" element while interpreting tooltip data.');
				return null;
			}

			if (typeof(_data.text) == 'string')
			{
				var parsedText = XBBCODE.process({
					text: _data.text,
					removeMisalignedTags: false,
					addInLineBreaks: true
				});
			
				text.html(parsedText.html);
			}
		}

		// TODO: update children - if needed by the game

		return container;
	}
};


TooltipModule.prototype.addContentProgressbarDiv = function(_parentDIV, _data)
{
	var container = $('<div class="row content-container"></div>');
	container.attr('id', 'tooltip-module-content-progressbar-container-' + _data.id);
	_parentDIV.append(container);
	
	var leftColumn = $('<div class="l-left-column"></div>');
	container.append(leftColumn);

	var rightColumn = $('<div class="l-right-column"></div>');
	container.append(rightColumn);
	
	var label = $('<div class="label text-font-small font-color-label"></div>');
	label.attr('id', 'tooltip-module-content-label-' + _data.id);
	leftColumn.append(label);

	// prefer icon over label
	if ('icon' in _data)
	{
		var image = $('<img/>');
		image.attr('src', Path.GFX + _data.icon);
		label.append(image);
	}
	else if ('label' in _data)
	{
		if (typeof(_data.label) == 'string')
		{
			var parsedLabel = XBBCODE.process({
				text: _data.label,
				removeMisalignedTags: false,
				addInLineBreaks: true
			});
		
			label.html(parsedLabel.html);
		}
	}

	// add progressbar
	if ('value' in _data && 'valueMax' in _data && 'style' in _data)
	{
		var progressbarContainerLayout = $('<div class="l-progressbar-container"></div>');
		rightColumn.append(progressbarContainerLayout);
		var progressbarContainer = $('<div class="progressbar-container ui-control-stats-progressbar-container-slim"></div>');
		progressbarContainerLayout.append(progressbarContainer);

		var progressbar = $('<div class="progressbar ui-control-stats-progressbar ' + _data.style + '"></div>');
		progressbar.attr('id', 'tooltip-module-content-progressbar-' + _data.id);
		progressbarContainer.append(progressbar);
		//var progressbarPreview = $('<div class="progressbar-preview ui-control-stats-progressbar-preview ' + _data.style + '"></div>');
		//progressbarContainer.append(progressbarPreview);
		var progressbarText = $('<div class="progressbar-label text-font-small font-color-progressbar-label"></div>');
		progressbarText.attr('id', 'tooltip-module-content-progressbar-text-' + _data.id);
		progressbarContainer.append(progressbarText);

		var newWidth = 0;
		if (_data.valueMax > 0)
		{
			newWidth = (_data.value * 100) / _data.valueMax;
		}
		newWidth = Math.max(Math.min(newWidth, 100), 0);
		progressbar.css({ 'width' : newWidth.toString() + '%' });
		
		if ('text' in _data)
		{
			if (typeof(_data.text) == 'string')
			{
				var parsedText = XBBCODE.process({
					text: _data.text,
					removeMisalignedTags: false,
					addInLineBreaks: true
				});
			
				progressbarText.html(parsedText.html);
			}
		}
	}

	return container;
};

TooltipModule.prototype.updateContentProgressbarDiv = function(_parentDIV, _data)
{
	var container = _parentDIV.find('#tooltip-module-content-progressbar-container-' + _data.id + ':first');
	
	var flags = this.extractDataFlags(_data);
	if (this.flagsContain(flags, 'remove'))
	{
		if (container.length > 0)
		{
			container.remove();
		}
		return null;
	}
	else
	{
		if (container.length === 0)
		{
			return this.addContentProgressbarDiv(_parentDIV, _data);
		}

		// TODO: update label - if needed by the game

		// update value
		if ('value' in _data && 'valueMax' in _data)
		{
			var progressbar = container.find('#tooltip-module-content-progressbar-' + _data.id + ':first');
			if (progressbar.length > 0)
			{
				var newWidth = 0;
				if (_data.valueMax > 0)
				{
					newWidth = (_data.value * 100) / _data.valueMax;
				}
				newWidth = Math.max(Math.min(newWidth, 100), 0);
				progressbar.velocity("finish", true).velocity({ 'width' : newWidth.toString() + '%' }, { duration: this.mProgressbarMovementDuration });
			}
		}

		return container;
	}
};


TooltipModule.prototype.addFooterIconDiv = function(_parentDIV, _data)
{
	if (!('icons' in _data) || !jQuery.isArray(_data.icons) || _data.icons.length === 0)
	{
		return null;
	}

	var container = $('<div class="row section-container"></div>');
	container.attr('id', 'tooltip-module-section-container-' + _data.id);
	_parentDIV.append(container);

	// add title
	if ('title' in _data && typeof(_data.title) == 'string' && _data.title.length > 0)
	{
		var sectionTitle = $('<div class="section-title text-font-small font-bold font-color-ink"></div>');
		sectionTitle.attr('id', 'tooltip-module-section-title-' + _data.id);
		container.append(sectionTitle);
		if (typeof(_data.title) == 'string')
		{
			var parsedText = XBBCODE.process({
				text: _data.title,
				removeMisalignedTags: false,
				addInLineBreaks: true
			});
		
			sectionTitle.html(parsedText.html);
		}
	}

	// add icons
	var gfxPath = Path.GFX;
	if ('useItemPath' in _data && _data.useItemPath === true)
	{
	    gfxPath = Path.ITEMS;
	}

	var sectionIconContainerLayout = $('<div class="l-section-icon-container"></div>');
	container.append(sectionIconContainerLayout);
	var sectionIconContainer = $('<div class="section-icon-container"></div>');
	sectionIconContainer.attr('id', 'tooltip-module-section-icon-container-' + _data.id);
	sectionIconContainerLayout.append(sectionIconContainer);

	for (var i = 0; i < _data.icons.length; ++i)
	{
		var iconPath = _data.icons[i];
		if (typeof(iconPath) === 'string' && iconPath.length > 0)
		{
			var icon = $('<div class="icon"></div>');
			var image = $('<img/>');
			image.attr('src', gfxPath + iconPath);
			icon.append(image);
			sectionIconContainer.append(icon);
		}
		else
		{
			console.error('ERROR: Footer icon has no image path.');
		}
	}

	// adjust center div
	var centerWidth = (_data.icons.length >= this.mMaxIconsPerRow ? this.mMaxIconsPerRow : _data.icons.length);
	centerWidth = centerWidth * 3.4; // see .tooltip-module .section-icon-container .icon
	sectionIconContainer.css({ 'width' : centerWidth + 'rem' });

	return container;
};

TooltipModule.prototype.updateFooterIconDiv = function(_parentDIV, _data)
{
	var container = _parentDIV.find('#tooltip-module-section-container-' + _data.id + ':first');
	
	var flags = this.extractDataFlags(_data);
	if (this.flagsContain(flags, 'remove'))
	{
		if (container.length > 0)
		{
			container.remove();
		}
		return null;
	}
	else
	{
		if (container.length === 0)
		{
			return this.addFooterIconDiv(_parentDIV, _data);
		}

		// TODO: update - if needed by the game

		return container;
	}
};


TooltipModule.prototype.addHintDiv = function(_parentDIV, _data, _isChildRow, _isParentFullWidth)
{
	if (!('text' in _data))
	{
		return null;
	}

	var container = null;
	if (!_isChildRow)
	{
		container = $('<div class="row hint-text-container"></div>');
		container.attr('id', 'tooltip-module-hint-text-container-' + _data.id);
	}
	else
	{
		container = $('<div class="row hint-child-text-container"></div>');
		container.attr('id', 'tooltip-module-hint-child-text-container-' + _data.id);
		if (_isParentFullWidth)
		{
			container.addClass('is-full-width');
		}
	}
	_parentDIV.append(container);
	
	// check if we have a label
	var useFullWidth = true;
	var hasIcon = ('icon' in _data);
	var hasLabel = ('label' in _data);
	var leftColumn = null;

	if (hasIcon || hasLabel)
	{
		useFullWidth = false;

		leftColumn = $('<div class="l-left-column"></div>');
		container.append(leftColumn);

		var label = $('<div class="label text-font-small font-color-ink"></div>');
		label.attr('id', 'tooltip-module-hint-text-label-' + _data.id);
		leftColumn.append(label);

		// prefer icon over label
		if (hasIcon)
		{
			var image = $('<img/>');
			image.attr('src', Path.GFX + _data.icon);
			label.append(image);
		}
		else if (hasLabel)
		{
			if (typeof(_data.label) == 'string')
			{
                var parsedLabel = XBBCODE.process(
                {
					text: _data.label,
					removeMisalignedTags: false,
					addInLineBreaks: true
				});
			
				label.html(parsedLabel.html);
			}
		}
	}

	// add text
	var rightColumn = $('<div class="l-right-column"></div>');
	container.append(rightColumn);
	
	// full with?
	if (useFullWidth || (_isChildRow && _isParentFullWidth))
	{
		rightColumn.addClass('is-full-width');
	}

	var text = $('<div class="text text-font-small font-color-ink"></div>');
	text.attr('id', 'tooltip-module-hint-text-text-' + _data.id);
	rightColumn.append(text);

	if (typeof(_data.text) == 'string')
	{
        var parsedText = XBBCODE.process(
        {
			text: _data.text,
			removeMisalignedTags: false,
			addInLineBreaks: true
		});
	
		text.html(parsedText.html);
	}

	// add children rows
	if ('children' in _data)
	{
		for (var i = 0; i < _data.children.length; ++i)
		{
			this.addHintDiv(container, _data.children[i], true, useFullWidth);
		}
	}

	// add optional dividers
	if ('divider' in _data)
	{
		switch(_data.divider)
		{
			case 'top':
			{			
				container.addClass('ui-control-tooltip-module-top-devider');
			} break;
			case 'bottom':
			{			
				container.addClass('ui-control-tooltip-module-bottom-devider');
			} break;
			case 'both':
			{			
				container.addClass('ui-control-tooltip-module-top-devider');
				container.addClass('ui-control-tooltip-module-bottom-devider');
			} break;
		}
	}

	return container;
};

/**
 * Adjust row content to get aligned in colums
**/
/*
TooltipModule.prototype.adjustRowContent = function(_container, _prefix)
{
	// selector
	var rowSelector = _prefix !== null ? '.' + _prefix + '_row' : '.row';
	var labelSelector = _prefix !== null ? '.' + _prefix + '_label' : '.label';
	var textSelector = _prefix !== null ? '.' + _prefix + '_text' : '.text';

	// #1 get the widest label
	var widestLabelWidth = 0;
	var widestRowWidth = 0;
	var rows = _container.children(rowSelector);
	rows.each(function(index, element) {
		var row = $(element);
		var rowOuterWidth = row.outerWidth(true);
		// find associated label
		var label = row.children(labelSelector + ':first');
		if (label.length > 0)
		{
			var labelOuterWidth = label.outerWidth(true);
			if (labelOuterWidth > widestLabelWidth)
			{
				widestLabelWidth = labelOuterWidth;
			}
			if (rowOuterWidth > widestRowWidth)
			{
				widestRowWidth = rowOuterWidth;
			}
		}
	});

	// #2 adjust every label accordingly
	var contentWidth = widestRowWidth - widestLabelWidth;
	rows.each(function(index, element) {
		var row = $(element);
		// find associated label
		var label = row.children(labelSelector + ':first');
		if (label.length > 0)
		{
			var margin = label.outerWidth(true) - label.width();
			label.width((widestLabelWidth - margin) + 'px');

			// find text content
			var textContent = row.children(textSelector + ':first');
			if (textContent.length > 0)
			{
				textContent.width(contentWidth + 'px');
			}
		}
	});
};
*/


TooltipModule.prototype.notifyBackendQueryTooltipData = function (_data, _callback)
{
	if (this.mSQHandle === null)
	{
		return;
	}

	if (_data === null)
	{
		console.error('ERROR: Failed to query data from backend. Reason: Data was null.');
		return;
	}

	if ('contentType' in _data)
	{
		switch(_data.contentType)
		{
			case 'tile':
			{
				SQ.call(this.mSQHandle, 'onQueryTileTooltipData', null, _callback);
			} break;
			case 'tile-entity':
			{
				if ('entityId' in _data)
				{
					SQ.call(this.mSQHandle, 'onQueryEntityTooltipData', [_data.entityId, true], _callback);
				}
			} break;
			case 'entity':
			{
				if ('entityId' in _data)
				{
				    SQ.call(this.mSQHandle, 'onQueryEntityTooltipData', [_data.entityId, false], _callback);
				}
			} break;
		    case 'roster-entity':
		    {
		        if ('entityId' in _data)
		        {
		            SQ.call(this.mSQHandle, 'onQueryRosterEntityTooltipData', _data.entityId, _callback);
		        }
		    } break;
			case 'skill':
			{
				if ('entityId' in _data && 'skillId' in _data)
				{
				    SQ.call(this.mSQHandle, 'onQuerySkillTooltipData', [_data.entityId, _data.skillId], _callback);
				}
			} break;
			case 'status-effect':
			{
				if ('entityId' in _data && 'statusEffectId' in _data)
				{
				    SQ.call(this.mSQHandle, 'onQueryStatusEffectTooltipData', [_data.entityId, _data.statusEffectId], _callback);
				}
			} break;
			case 'settlement-status-effect':
			{
				if ('statusEffectId' in _data)
				{
				    SQ.call(this.mSQHandle, 'onQuerySettlementStatusEffectTooltipData', [_data.statusEffectId], _callback);
				}
			} break;
			case 'ui-element':
			{
				if ('elementId' in _data)
				{
				    SQ.call(this.mSQHandle, 'onQueryUIElementTooltipData', [('entityId' in _data ? _data.entityId : null), _data.elementId, ('elementOwner' in _data ? _data.elementOwner : null)], _callback);
				}
			} break;
			case 'ui-item':
			{
				if ('itemId' in _data && 'itemOwner' in _data)
				{
				    SQ.call(this.mSQHandle, 'onQueryUIItemTooltipData', [_data.entityId === undefined ? null : _data.entityId, _data.itemId, _data.itemOwner], _callback);
				}
			} break;
            case 'ui-perk':
            {
                if ('entityId' in _data && 'perkId' in _data)
                {
                    SQ.call(this.mSQHandle, 'onQueryUIPerkTooltipData', [_data.entityId, _data.perkId], _callback);
                }
            } break;
            case 'follower':
            {
                if ('followerId' in _data)
                {
                    SQ.call(this.mSQHandle, 'onQueryFollowerTooltipData', _data.followerId, _callback);
                }
            } break;
            case 'verbatim':
			{
                _callback(_data.tooltip);
			} break;
		}
	}
};


/**
 * jQuery extension
**/
$.fn.bindTooltip = function (_data)
{
    if (Screens.Tooltip === null || !Screens.Tooltip.isConnected())
	{
		return;
	}

	var tooltip = Screens.Tooltip.getModule('TooltipModule');
	if (tooltip !== null)
	{
		tooltip.bindToElement(this, _data);
	}
};

$.fn.unbindTooltip = function ()
{
    if (Screens.Tooltip === null || !Screens.Tooltip.isConnected())
    {
        return;
    }

    var tooltip = Screens.Tooltip.getModule('TooltipModule');
    if (tooltip !== null)
    {
        tooltip.unbindFromElement(this);
	}
};

$.fn.updateTooltip = function ()
{
    if (Screens.Tooltip === null || !Screens.Tooltip.isConnected())
    {
        return;
    }

    var tooltip = Screens.Tooltip.getModule('TooltipModule');
    if (tooltip !== null)
    {
        tooltip.reloadUITooltip();
	}
};

$.fn.showTooltip = function (_data)
{
    if (Screens.Tooltip === null || !Screens.Tooltip.isConnected())
    {
        return;
    }

    var tooltip = Screens.Tooltip.getModule('TooltipModule');
    if (tooltip !== null)
    {
        tooltip.showUITooltip(this, _data);
	}
};

$.fn.hideTooltip = function ()
{
    if (Screens.Tooltip === null || !Screens.Tooltip.isConnected())
    {
        return;
    }

    var tooltip = Screens.Tooltip.getModule('TooltipModule');
    if (tooltip !== null)
    {
        if (tooltip.isVisibleForElement(this) === true)
		{
			tooltip.hideUITooltip();
		}
	}
};

$.fn.setTooltipEnabled = function (_value)
{
    if (Screens.Tooltip === null || !Screens.Tooltip.isConnected())
    {
        return;
    }

    var tooltip = Screens.Tooltip.getModule('TooltipModule');
    if (tooltip !== null)
    {
        this.data('is-enabled', _value === true);
    }
};




/*
{ type: 'title', text: '[p=c][b][color=#ffcc00]Reinhard von Helsing zu Barthausen[/color][/b][/p][p=l]' },
{ type: 'description', text: '[p=l]#1 Test New Line Bullshit[/p]' },
{ type: 'line' },
{ type: 'progressbar', label: 'AP', value: 50, valueMax: 100, color: '#D68233' },
{ type: 'progressbar', icon: '../gfx/skills/passive_01.png', value: 70, maxValue: 100, color: '#D92E2E' },
{ type: 'text', label: 'Armor', text: 30 },
{ type: 'text', icon: '../gfx/skills/passive_02.png', text: 10 },
{ type: 'icons', title: 'Skills', icons: [ '../gfx/skills/active_01.png', '../gfx/skills/active_02.png', '../gfx/skills/active_03.png' ] },
{ type: 'icons', title: 'Status Effects', icons: [ '../gfx/skills/passive_01.png', '../gfx/skills/passive_02.png', '../gfx/skills/passive_03.png' ] },
*/

