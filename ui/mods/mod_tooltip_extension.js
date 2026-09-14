TooltipModule.prototype.setupUITooltip = function(_targetDIV, _data)
{
	if(_targetDIV === null || _targetDIV === undefined)
		return;

	var wnd = this.mParent; // $(window);
	var windowHeight = wnd.height();
	var maxHeight = Math.floor(windowHeight * 0.85);
    this.mScrollWrapper.css('max-height', maxHeight + 'px');

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

	// calculate tooltip position
	var targetOffset    = _targetDIV.offset();
	var elementWidth    = _targetDIV.outerWidth(true);
	var elementHeight   = _targetDIV.outerHeight(true);
	var containerWidth  = this.mContainer.outerWidth(true);
	var containerHeight = this.mContainer.outerHeight(true);

	var posLeft = (targetOffset.left + (elementWidth / 2)) - (containerWidth / 2);
	var posTop  = targetOffset.top - containerHeight - offsetY;

	if (posLeft < 0)
	{
		posLeft = targetOffset.left;
	}

	if (posLeft + containerWidth > wnd.width())
	{
		posLeft = targetOffset.left + elementWidth - containerWidth;
	}

	if (posTop < 0)
	{
		posTop = targetOffset.top + elementHeight + offsetY;
	}

	if ((posLeft - (containerWidth / 2) - (elementWidth / 2)) > 10) {
		posLeft = posLeft - (containerWidth / 2) - (elementWidth / 2);
	} else {
		posLeft = posLeft + (containerWidth / 2) + (elementWidth / 2);
	}	
	
	// MOD_TOOLTIP_EXTENSION: attempts to prevent the tooltip from extending outside of the screen
	var posTopPrimary = targetOffset.top - containerHeight - offsetY;
	var posTopSecondary = targetOffset.top + elementHeight + offsetY;
	if (posTopPrimary < 0 && posTopSecondary + containerHeight > windowHeight)
	{
		posTop = (windowHeight - containerHeight) / 2;
	}
	else if (posTopPrimary >= 0)
	{
		posTop = posTopPrimary;
	}
	else if (posTopSecondary + containerHeight <= windowHeight)
	{
		posTop = posTopSecondary;
	}


	// show & position tooltip & animate
	this.mContainer.removeClass('display-none').addClass('display-block');
	this.mContainer.css({ left: posLeft, top: posTop });
	this.mContainer.velocity("finish", true).velocity({ opacity: 0.99 }, { duration: this.mFadeInTime }); // Anti Alias Fix

	var self = this;
	if (self.mScrollWrapper[0].scrollHeight > self.mScrollWrapper.height()) {
		self.mScrollHint.removeClass('display-none').addClass('display-block');
	} else {
		self.mScrollHint.removeClass('display-block').addClass('display-none');
	}
};

TooltipModule.prototype.setupTileTooltip = function()
{
	var wnd = this.mParent; // $(window);
	var windowHeight = wnd.height();
	var windowWidth = wnd.width();

	var maxHeight = Math.floor(windowHeight * 0.9);
    this.mScrollWrapper.css('max-height', maxHeight + 'px');

	var containerWidth = this.mContainer.outerWidth(true);
	var containerHeight = this.mContainer.outerHeight(true);

	var posLeft = this.mLastMouseX + (this.mCursorXOffset === 0 ? (this.mCursorWidth / 2) : (this.mCursorWidth - ((this.mCursorWidth / 2) - this.mCursorXOffset)) );
	var posTop = this.mLastMouseY + (this.mCursorYOffset === 0 ? (this.mCursorHeight / 2) : (this.mCursorHeight - ((this.mCursorHeight / 2) - this.mCursorYOffset)) );

	if (posLeft < 0)
	{
		posLeft = 10;
	}

	if (posLeft + containerWidth > windowWidth)
	{
		posLeft = windowWidth - containerWidth - 10;
	}
	if ((posTop + containerHeight) > windowHeight)
	{
		posTop = this.mLastMouseY - (this.mCursorYOffset === 0 ? ((this.mCursorHeight / 2) + containerHeight) : (this.mCursorYOffset + containerHeight));
	}


	// MOD_TOOLTIP_EXTENSION: attempts to prevent the tooltip from extending outside of the screen
	var posTopPrimary = this.mLastMouseY + (this.mCursorYOffset === 0 ? (this.mCursorHeight / 2) : (this.mCursorHeight - ((this.mCursorHeight / 2) - this.mCursorYOffset)));
	var posTopSecondary = this.mLastMouseY - (this.mCursorYOffset === 0 ? ((this.mCursorHeight / 2) + containerHeight) : (this.mCursorYOffset + containerHeight));
	if (posTopPrimary + containerHeight > windowHeight && posTopSecondary < 0)
	{
		posTop = (windowHeight - containerHeight) / 2;
	}
	else if (posTopPrimary + containerHeight <= windowHeight)
	{
		posTop = posTopPrimary;
	}
	else if (posTopSecondary >= 0)
	{
		posTop = posTopSecondary;
	}


	// show & position tooltip & animate
	this.mContainer.removeClass('display-none').addClass('display-block');
	this.mContainer.css({ left: posLeft, top: posTop });
	this.mContainer.velocity("finish", true).velocity({ opacity: 0.99 }, { duration: this.mFadeInTime }); // Anti Alias Fix

	var self = this;
	if (self.mScrollWrapper[0].scrollHeight > self.mScrollWrapper.height()) {
		self.mScrollHint.removeClass('display-none').addClass('display-block');
	} else {
		self.mScrollHint.removeClass('display-block').addClass('display-none');
	}
};
