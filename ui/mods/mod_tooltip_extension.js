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


	// MOD_TOOLTIP_EXTENSION: attempts to prevent the tooltip from extending outside of the screen
	var posTopPrimary = targetOffset.top - containerHeight - offsetY;
	var posTopSecondary = targetOffset.top + elementHeight + offsetY;
	if (posTopPrimary < 0 && posTopSecondary + containerHeight > wnd.height())
	{
		posTop = (wnd.height() - containerHeight) / 2;
	}
	else if (posTopPrimary >= 0)
	{
		posTop = posTopPrimary;
	}
	else if (posTopSecondary + containerHeight <= wnd.height())
	{
		posTop = posTopSecondary;
	}


	// show & position tooltip & animate
	this.mContainer.removeClass('display-none').addClass('display-block');
	this.mContainer.css({ left: posLeft, top: posTop });
	this.mContainer.velocity("finish", true).velocity({ opacity: 0.99 }, { duration: this.mFadeInTime }); // Anti Alias Fix
};

TooltipModule.prototype.setupTileTooltip = function()
{
	var wnd = this.mParent; // $(window);

	var containerWidth = this.mContainer.outerWidth(true);
	var containerHeight = this.mContainer.outerHeight(true);

	var posLeft = this.mLastMouseX + (this.mCursorXOffset === 0 ? (this.mCursorWidth / 2) : (this.mCursorWidth - ((this.mCursorWidth / 2) - this.mCursorXOffset)) );
	var posTop = this.mLastMouseY + (this.mCursorYOffset === 0 ? (this.mCursorHeight / 2) : (this.mCursorHeight - ((this.mCursorHeight / 2) - this.mCursorYOffset)) );

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
		posTop = this.mLastMouseY - (this.mCursorYOffset === 0 ? ((this.mCursorHeight / 2) + containerHeight) : (this.mCursorYOffset + containerHeight));
	}


	// MOD_TOOLTIP_EXTENSION: attempts to prevent the tooltip from extending outside of the screen
	var posTopPrimary = this.mLastMouseY + (this.mCursorYOffset === 0 ? (this.mCursorHeight / 2) : (this.mCursorHeight - ((this.mCursorHeight / 2) - this.mCursorYOffset)));
	var posTopSecondary = this.mLastMouseY - (this.mCursorYOffset === 0 ? ((this.mCursorHeight / 2) + containerHeight) : (this.mCursorYOffset + containerHeight));
	if (posTopPrimary + containerHeight > wnd.height() && posTopSecondary < 0)
	{
		posTop = (wnd.height() - containerHeight) / 2;
	}
	else if (posTopPrimary + containerHeight <= wnd.height())
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
};
