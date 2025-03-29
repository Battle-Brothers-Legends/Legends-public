
"use strict";

var WorldCampfireScreenMainDialogModule = function(_parent)
{
	this.mSQHandle = null;
	this.mParent = _parent;

	// event listener
	this.mEventListener = null;

	// assets
	this.mAssets = new WorldCampfireScreenAssets(_parent);

	// generic containers
	this.mContainer = null;
	this.mDialogContainer = null;

	// buttons
	this.mLeaveButton = null;

	// generics
	this.mIsVisible = false;
};


WorldCampfireScreenMainDialogModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

WorldCampfireScreenMainDialogModule.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;

	// notify listener
	if(this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

WorldCampfireScreenMainDialogModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if(this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};

WorldCampfireScreenMainDialogModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: containers (init hidden!)
	this.mContainer = $('<div class="l-main-dialog-container display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
	this.mDialogContainer = this.mContainer.createDialog('', '', '', true, 'dialog-1024-768');

// 	this.mContractContainer = $('<div class="display-block"/>');
// 	this.mDialogContainer.findDialogContentContainer().append(this.mContractContainer);

	// create tabs
	var tabButtonsContainer = $('<div class="l-tab-container"/>');
	this.mDialogContainer.findDialogTabContainer().append(tabButtonsContainer);

	// adjust content container
	this.mDialogContainer.findDialogContentContainer().addClass('is-nudged-top');

	// create assets
	this.mAssets.createDIV(tabButtonsContainer);

	// create content
//	 this.mDialogContainer.findDialogContentContainer().createImage(null, function(_image)
// 	{
//		 _image.removeClass('display-none').addClass('display-block');
//		 _image.fitImageToParent();
//	 }, null, 'display-none');

	// create footer button bar
	var footerButtonBar = $('<div class="l-button-bar"/>');
	this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

	// create: buttons
	var layout = $('<div class="l-leave-button"/>');
	footerButtonBar.append(layout);
	this.mLeaveButton = layout.createTextButton("Leave", function()
	{
		self.notifyBackendLeaveButtonPressed();
	}, '', 1);

	this.mIsVisible = false;
};

WorldCampfireScreenMainDialogModule.prototype.destroyDIV = function ()
{
	this.mAssets.destroyDIV();

	this.mLeaveButton.remove();
	this.mLeaveButton = null;

	this.mDialogContainer.empty();
	this.mDialogContainer.remove();
	this.mDialogContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};

WorldCampfireScreenMainDialogModule.prototype.bindTooltips = function ()
{
	this.mAssets.bindTooltips();
	this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.MainDialogModule.LeaveButton });
};

WorldCampfireScreenMainDialogModule.prototype.unbindTooltips = function ()
{
	this.mAssets.unbindTooltips();
	this.mLeaveButton.unbindTooltip();
};


WorldCampfireScreenMainDialogModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

WorldCampfireScreenMainDialogModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


WorldCampfireScreenMainDialogModule.prototype.register = function (_parentDiv)
{
	console.log('WorldCampfireScreenMainDialogModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register World Campfire Screen Main Dialog Module. Reason: World Campfire Screen Main Dialog Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

WorldCampfireScreenMainDialogModule.prototype.unregister = function ()
{
	console.log('WorldCampfireScreenMainDialogModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister World Campfire Screen Main Dialog Module. Reason: World Campfire Screen Main Dialog Module is not initialized.');
		return;
	}

	this.destroy();
};

WorldCampfireScreenMainDialogModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};

WorldCampfireScreenMainDialogModule.prototype.show = function (_withSlideAnimation)
{
	var self = this;

	var withAnimation = (_withSlideAnimation !== undefined && _withSlideAnimation !== null) ? _withSlideAnimation : true;
	if (withAnimation === true)
	{
		var offset = this.mContainer.parent().width() + this.mContainer.width();
		this.mContainer.css({ 'translateX': offset });
		this.mContainer.velocity("finish", true).velocity({ opacity: 1, translateX: 0 },
		{
			duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
			easing: 'swing',
			begin: function ()
			{
				$(this).removeClass('display-none').addClass('display-block');
				self.notifyBackendModuleAnimating();
			},
			complete: function ()
			{
				self.mIsVisible = true;
				self.notifyBackendModuleShown();
			}
		});
	}
	else
	{
		this.mContainer.css({ opacity: 0 });
		this.mContainer.velocity("finish", true).velocity({ opacity: 1 },
		{
			duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
			easing: 'swing',
			begin: function ()
			{
				$(this).removeClass('display-none').addClass('display-block');
				self.notifyBackendModuleAnimating();
			},
			complete: function ()
			{
				self.mIsVisible = true;
				self.notifyBackendModuleShown();
			}
		});
	}
};

WorldCampfireScreenMainDialogModule.prototype.hide = function ()
{
	var self = this;

	var offset = this.mContainer.parent().width() + this.mContainer.width();
	this.mContainer.velocity("finish", true).velocity({ opacity: 0, translateX: offset },
	{
		duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function ()
		{
			$(this).removeClass('is-center');
			self.notifyBackendModuleAnimating();
		},
		complete: function ()
		{
			self.mIsVisible = false;
			$(this).removeClass('display-block').addClass('display-none');
			self.notifyBackendModuleHidden();
		}
	});
};

WorldCampfireScreenMainDialogModule.prototype.isVisible = function ()
{
	return this.mIsVisible;
};

WorldCampfireScreenMainDialogModule.prototype.loadFromData = function (_data)
{
	var self = this;

	if('Assets' in _data && _data['Assets'] !== null)
	{
		this.updateAssets(_data['Assets']);
	}

	if('Title' in _data && _data['Title'] !== null)
	{
		this.mDialogContainer.findDialogTitle().html(_data['Title']);
	}

	if('SubTitle' in _data && _data['SubTitle'] !== null)
	{
		this.mDialogContainer.findDialogSubTitle().html(_data['SubTitle']);
	}

	if('HeaderImagePath' in _data && _data['HeaderImagePath'] !== null && _data['HeaderImagePath'] != '')
	{
		this.mDialogContainer.findDialogHeaderImage().attr('src', Path.GFX + _data['HeaderImagePath']);
	}

	var contentContainer = this.mDialogContainer.findDialogContentContainer();
	contentContainer.empty();

	var content = $('<div class="settlement-container" />');
	content.appendTo(contentContainer);

	if ('Background' in _data && _data['Background'] !== null && _data['Background'] != '')
	{
		content.createImage(Path.GFX + _data['Background'], null, null, 'display-block background');
	}

	if ('BackgroundCenter' in _data && _data['BackgroundCenter'] !== null && _data['BackgroundCenter'] != '')
	{
		content.createImage(Path.GFX + _data['BackgroundCenter'], null, null, 'display-block background-center');
	}

	if ('BackgroundLeft' in _data && _data['BackgroundLeft'] !== null && _data['BackgroundLeft'] != '')
	{
		content.createImage(Path.GFX + _data['BackgroundLeft'], null, null, 'display-block background-left');
	}

	if('BackgroundRight' in _data && _data['BackgroundRight'] !== null && _data['BackgroundRight'] != '')
	{
		content.createImage(Path.GFX + _data['BackgroundRight'], null, null, 'display-block background-right');
	}

	if ('Cart' in _data && _data['Cart'] !== null && _data['Cart'] != '')
	{
		var self = this;

		var placeholder = content.createImage(Path.GFX + _data['Cart'] + '_b.png', null, null, 'cart opacity-almost-none no-pointer-events');
		var cart = content.createImage(Path.GFX + _data['Cart'] + '.png', null, null, 'display-block cart');
		cart.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CampfireScreen.Cart });
		cart.click(function(_event)
		{
			self.notifyBackendCartClicked();
		});
		cart.mouseover(function()
		{
			this.classList.add('is-highlighted');

			//cart.attr('src', Path.GFX + _data['Cart'] + '_b.png');
			placeholder.removeClass('opacity-almost-none');
		});
		cart.mouseout(function()
		{
			this.classList.remove('is-highlighted');

			//cart.attr('src', Path.GFX + _data['Cart'] + '.png');
			placeholder.removeClass('opacity-almost-none');
		});
	}

	if('Slots' in _data && _data['Slots'] !== null)
	{
		for(var i=0; i < _data.Slots.length; ++i)
		{
			if (i == 2 && 'Fire' in _data && _data['Fire'] !== null && _data['Fire'] != '')
			{
				content.createImage(Path.GFX + _data['Fire'], null, null, 'display-block fire');
			}

			this.createSlot(_data.Slots[i], i, content);
		}
	}

	if('Mood' in _data && _data['Mood'] !== null && _data['Mood'] != '')
	{
		content.createImage(Path.GFX + _data['Mood'], null, null, 'display-block mood');
	}

	if('Foreground' in _data && _data['Foreground'] !== null && _data['Foreground'] != '')
	{
		content.createImage(Path.GFX + _data['Foreground'], null, null, 'display-block foreground');
	}
};

WorldCampfireScreenMainDialogModule.prototype.createSlot = function (_data, _i, _content)
{
	if(_data == null || _data.Image == null || _data.Image == '')
	{
		return;
	}
	
	var self = this;
	var isUsable = _data.ID != 'locked';

	var slot_placeholder =  _content.createImage(Path.GFX + _data.Image + '.png', null, null, 'slot' + _i + ' opacity-almost-none no-pointer-events is-highlighted');

	var slot = _content.createImage(Path.GFX + _data.Image + '.png', function (_image)
	{
		if (isUsable)
		{
			slot_placeholder.addClass('opacity-almost-none');
			slot_placeholder.removeClass('is-highlighted');
			slot_placeholder.attr('src', Path.GFX + _data.Image + '.png');
		}
	}, null, 'slot' + _i);

	slot.bindTooltip({ contentType: 'follower', followerId: isUsable ? _data.ID : _data.Slot });

	if(isUsable)
	{
		slot.click(function(_event)
		{
			self.mParent.notifyBackendSlotClicked(_i);
		});
	}

	slot.mouseover(function()
	{
		this.classList.add('is-highlighted');

		//slot.attr('src', Path.GFX + _data.Image + '_b.png');
		slot_placeholder.removeClass('opacity-almost-none');
	});
	slot.mouseout(function()
	{
		this.classList.remove('is-highlighted');

		//slot.attr('src', Path.GFX + _data.Image + '.png');
		slot_placeholder.removeClass('opacity-almost-none');
	});
}

WorldCampfireScreenMainDialogModule.prototype.updateAssets = function (_data)
{
	this.mAssets.loadFromData(_data);
}

WorldCampfireScreenMainDialogModule.prototype.notifyBackendModuleShown = function ()
{
	SQ.call(this.mSQHandle, 'onModuleShown');
};

WorldCampfireScreenMainDialogModule.prototype.notifyBackendModuleHidden = function ()
{
	SQ.call(this.mSQHandle, 'onModuleHidden');
};

WorldCampfireScreenMainDialogModule.prototype.notifyBackendModuleAnimating = function ()
{
	SQ.call(this.mSQHandle, 'onModuleAnimating');
};

WorldCampfireScreenMainDialogModule.prototype.notifyBackendLeaveButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onLeaveButtonPressed');
};

WorldCampfireScreenMainDialogModule.prototype.notifyBackendCartClicked = function ()
{
	SQ.call(this.mSQHandle, 'onCartClicked');
};