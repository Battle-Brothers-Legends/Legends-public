var FUPopup = function ()
{
	this.mSQHandle = null
	this.mContainer = null;
	this.mID = "FUPopup";

	this.mHeaderContainer = null;
	this.mContentContainer = null;
	this.mListScrollContainer = null;
	this.mFooterContainer = null;
	this.mTitle = null;
}

FUPopup.prototype.onConnection = function (_handle)
{
	this.register($('.root-screen'));
	this.mSQHandle = _handle;
}

FUPopup.prototype.createDIV = function (_parentDiv)
{
	var self = this;
	this.mContainer = $('<div class="FU-popup ui-control dialog display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);

	this.mHeaderContainer = $('<div class="header"/>');
	this.mContainer.append(this.mHeaderContainer);

	this.mTitle = $('<div class="title title-font-very-big font-bold font-bottom-shadow font-color-title">Mod Error</div>');
	this.mHeaderContainer.append(this.mTitle);

	this.mListContainer = this.mContainer.createList(1, 'content-container');
	this.mListScrollContainer = this.mListContainer.findListScrollContainer();
	this.mContainer.append(this.mContentContainer);


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

FUPopup.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
};

FUPopup.prototype.destroy = function ()
{
	this.destroyDIV();
}

FUPopup.prototype.show = function ()
{
	var self = this;

	// FUUIScreen.show
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
			self.notifyBackendOnAnimating();
			$(this).removeClass('display-none').addClass('display-block');
		},
		complete: function ()
		{
			self.notifyBackendOnShown();
		}
	});
}

FUPopup.prototype.isVisible = function ()
{
	return this.mContainer.hasClass('display-block');
}

FUPopup.prototype.showRawText = function (_data)
{
	if (_data.forceQuit)
	{
		this.mTitle.text("Fatal Mod Error");
		this.mFooterContainer.find(".ok-button:first").trigger('force-quit')
	}
	else
	{
		this.mTitle.text("Mod Error");
	}
	this.mListScrollContainer.append($('<div class="mod-raw-text">' + _data.text + '</div>'));
	if (!this.isVisible())
	{
		this.show();
	}
}

FUPopup.prototype.showModUpdates = function (_mods)
{
	this.mTitle.text("Mod Updates Available");
	var self = this;
	$.each(_mods, function (_key, _modInfo)
	{
		var modInfoContainer = $('<div class="FU-mod-info-container"/>');
		self.mListScrollContainer.append(modInfoContainer)
		modInfoContainer.append($('<div class="mod-name title title-font-big font-bold font-color-title">' + _modInfo.name + '</div>'));

		if ("GitHub" in _modInfo.sources)
		{
			var githubContainer = $('<div class="l-github-button"/>');
			modInfoContainer.append(githubContainer);
			var githubButton = githubContainer.createImageButton(Path.GFX + "mods/fu/logos/github-32.png", function ()
			{
				openURL(_modInfo.sources.GitHub);
			});
		}
		if ("NexusMods" in _modInfo.sources)
		{
			var nexusModsContainer = $('<div class="l-nexusmods-button"/>');
			modInfoContainer.append(nexusModsContainer);
			nexusModsContainer.createImageButton(Path.GFX + "mods/fu/logos/nexusmods-32.png", function ()
			{
				openURL(_modInfo.sources.NexusMods);
			});
		}

		var colorFromIdx = 0;
		if (_modInfo.updateType != "MAJOR")
		{
			colorFromIdx = _modInfo.availableVersion.indexOf('.') + 1;
		}
		if (_modInfo.updateType == "PATCH")
		{
			colorFromIdx = _modInfo.availableVersion.indexOf('.', colorFromIdx + 1) + 1;
		}
		var start = _modInfo.availableVersion.slice(0, colorFromIdx);
		var coloredSpan = '<span style="color:red;">' + _modInfo.availableVersion.slice(colorFromIdx) + '</span>';
		modInfoContainer.append($('<div class="version-info text-font-normal">' + _modInfo.currentVersion + ' => ' + start + coloredSpan + ' (Update Available)</div>'));
	});
	if (!this.isVisible()) this.show();
}

FUPopup.prototype.hide = function ()
{
	var self = this;
	this.mContainer.velocity("finish", true).velocity({ opacity: 0 },
	{
		duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function()
		{
			self.notifyBackendOnAnimating();
		},
		complete: function()
		{
			self.notifyBackendOnHidden();
			$(this).css({ opacity: 0 });
			$(this).removeClass('display-block').addClass('display-none');
		}
	});
}

FUPopup.prototype.register = function (_parentDiv)
{
	console.log('FUPopup::REGISTER');
	this.create(_parentDiv);
}

FUPopup.prototype.unregister = function ()
{
	console.log('FUPopup::UNREGISTER');
	this.destroy();
}

FUPopup.prototype.quitGame = function ()
{
	SQ.call(this.mSQHandle, "quitGame");
}

FUPopup.prototype.notifyBackendOnShown = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenShown');
	}
};

FUPopup.prototype.notifyBackendOnHidden = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenHidden');
	}
};

FUPopup.prototype.notifyBackendOnAnimating = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenAnimating');
	}
};

registerScreen("FUPopup", new FUPopup());
