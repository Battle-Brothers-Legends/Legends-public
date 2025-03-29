var MSUPopup = function ()
{
	this.mSQHandle = null
	this.mContainer = null;
	this.mID = "MSUPopup";

	this.mHeaderContainer = null;
	this.mTextContainer = null;
	this.mFooterContainer = null;
}

MSUPopup.prototype.onConnection = function (_handle)
{
	this.register($('.root-screen'));
	this.mSQHandle = _handle;
}

MSUPopup.prototype.createDIV = function (_parentDiv)
{
	var self = this;
	this.mContainer = $('<div class="msu-popup ui-control dialog display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);

	this.mHeaderContainer = $('<div class="header"/>');
	this.mContainer.append(this.mHeaderContainer);

	var title = '<div class="title title-font-very-big font-bold font-bottom-shadow font-color-title">Mod Error</div>'
	this.mHeaderContainer.append(title);

	this.mTextContainer = $('<div class="text-container"/>');
	this.mContainer.append(this.mTextContainer);

	this.mFooterContainer = $('<div class="footer"/>')
	this.mContainer.append(this.mFooterContainer);

	this.mFooterContainer.createTextButton("Ok", function()
	{
		self.hide();
	}, "ok-button", 1);

	this.mFooterContainer.find(".ok-button:first").on("force-quit", function()
	{
		$(this).findButtonText().html("Quit Game");
		$(this).on("click", function()
		{
			self.quitGame();
		})
	})
}

MSUPopup.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
};

MSUPopup.prototype.destroy = function ()
{
	this.destroyDIV();
}

MSUPopup.prototype.show = function ()
{
	var self = this;

	// MSUUIScreen.show
	var moveTo = { opacity: 1, right: '10.0rem' };
	var offset = -this.mContainer.width();
	if (self.mContainer.hasClass('is-center') === true)
	{
		moveTo = { opacity: 1, left: '0', right: '0' };
		offset = -(this.mContainer.parent().width() + this.mContainer.width());
		this.mContainer.css({ 'left': '0' });
	}

	this.mContainer.css({ 'right': offset });
	this.mContainer.velocity("finish", true).velocity(moveTo,
	{
		duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function ()
		{
			$(this).removeClass('display-none').addClass('display-block');
		},
		complete: function ()
		{
		}
	});
}

MSUPopup.prototype.isVisible = function ()
{
	return this.mContainer.hasClass('display-block');
}

MSUPopup.prototype.showRawText = function (_data)
{
	if (_data.forceQuit)
	{
		this.mFooterContainer.find(".ok-button:first").trigger('force-quit')
	}
	if (this.isVisible())
	{
		this.mTextContainer.html(this.mTextContainer.html() + "<br>" + _data.text);
	}
	else
	{
		this.mTextContainer.html(_data.text);
		this.show();
	}
}

MSUPopup.prototype.hide = function ()
{
	this.mTextContainer.html("");
	var self = this;

	//MSUUIScreen.hide
	this.mContainer.velocity("finish", true).velocity({ opacity: 0 },
	{
		duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function()
		{
		},
		complete: function()
		{
			$(this).css({ opacity: 0 });
			$(this).removeClass('display-block').addClass('display-none');
		}
	});
}

MSUPopup.prototype.register = function (_parentDiv)
{
	console.log('MSUPopup::REGISTER');
	this.create(_parentDiv);
}

MSUPopup.prototype.unregister = function ()
{
	console.log('MSUPopup::UNREGISTER');
	this.destroy();
}

MSUPopup.prototype.quitGame = function ()
{
	SQ.call(this.mSQHandle, "quitGame");
}

registerScreen("MSUPopup", new MSUPopup());
