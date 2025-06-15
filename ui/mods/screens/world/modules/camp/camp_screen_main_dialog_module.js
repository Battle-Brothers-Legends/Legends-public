
"use strict";

var CampScreenMainDialogModule = function(_parent)
{
	this.mSQHandle = null;
	this.mParent = _parent;

	// event listener
	this.mEventListener = null;

	// assets
	this.mAssets = new WorldTownScreenAssets(_parent, true);

	// generic containers
	this.mContainer = null;
	this.mDialogContainer = null;
	//this.mContractContainer = null;

	// buttons
	this.mLeaveButton = null;
	this.mCampButton = null;

	// generics
	this.mIsVisible = false;
};


CampScreenMainDialogModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

CampScreenMainDialogModule.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;

	// notify listener
	if(this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

CampScreenMainDialogModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if(this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};

CampScreenMainDialogModule.prototype.createDIV = function (_parentDiv)
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
	var layout = $('<div class="l-camp-button"/>');
	footerButtonBar.append(layout);
	this.mCampButton = layout.createTextButton("Camp", function()
	{
		self.notifyBackendCampButtonPressed();
	}, '', 1);

	var layout = $('<div class="l-leave-button"/>');
	footerButtonBar.append(layout);
	this.mLeaveButton = layout.createTextButton("Leave", function()
	{
		self.notifyBackendLeaveButtonPressed();
	}, '', 1);


	this.mIsVisible = false;
};

CampScreenMainDialogModule.prototype.destroyDIV = function ()
{
	this.mAssets.destroyDIV();

	this.mLeaveButton.remove();
	this.mLeaveButton = null;

	this.mCampButton.remove();
	this.mCampButton = null;

	this.mDialogContainer.empty();
	this.mDialogContainer.remove();
	this.mDialogContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};

CampScreenMainDialogModule.prototype.bindTooltips = function ()
{
	this.mAssets.bindTooltips();
	this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.MainDialogModule.LeaveButton });
	this.mCampButton.bindTooltip({ contentType: 'ui-element', elementId: 'camp-screen.main-dialog-module.CampButton' });
};

CampScreenMainDialogModule.prototype.unbindTooltips = function ()
{
	this.mAssets.unbindTooltips();
	this.mLeaveButton.unbindTooltip();
	this.mCampButton.unbindTooltip();
};


CampScreenMainDialogModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

CampScreenMainDialogModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


CampScreenMainDialogModule.prototype.register = function (_parentDiv)
{
	console.log('CampScreenMainDialogModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register World Town Screen Main Dialog Module. Reason: World Town Screen Main Dialog Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

CampScreenMainDialogModule.prototype.unregister = function ()
{
	console.log('CampScreenMainDialogModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister World Town Screen Main Dialog Module. Reason: World Town Screen Main Dialog Module is not initialized.');
		return;
	}

	this.destroy();
};

CampScreenMainDialogModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};

CampScreenMainDialogModule.prototype.show = function (_withSlideAnimation)
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

CampScreenMainDialogModule.prototype.hide = function ()
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

CampScreenMainDialogModule.prototype.isVisible = function ()
{
	return this.mIsVisible;
};

CampScreenMainDialogModule.prototype.loadFromData = function (_data)
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

	if('Ramp' in _data && _data['Ramp'] !== null && _data['Ramp'] != '')
	{
		content.createImage(Path.GFX + _data['Ramp'], null, null, 'display-block ramp');
	}

	if('RampPathway' in _data && _data['RampPathway'] !== null && _data['RampPathway'] != '')
	{
		content.createImage(Path.GFX + _data['RampPathway'], null, null, 'display-block ramp-pathway');
	}

	if('Water' in _data && _data['Water'] !== null && _data['Water'] != '')
	{
		content.createImage(Path.GFX + _data['Water'], null, null, 'display-block water');
	}

	if('Slots' in _data && _data['Slots'] !== null)
	{
		for(var i=0; i < _data.Slots.length; ++i)
		{
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

	if('Contracts' in _data && _data['Contracts'] !== null)
	{
		this.updateContracts(_data);
	}
};

CampScreenMainDialogModule.prototype.createSlot = function (_data, _i, _content)
{
	if(_data == null || _data.Image == null || _data.Image == '')
	{
		return;
	}

	var self = this;
	var isUsable = 'CanEnter' in _data && _data.CanEnter == true;
	var slot_placeholder = null;

	if (isUsable)
		slot_placeholder = _content.createImage(Path.GFX + _data.Image + '_b.png', null, null, 'slot-' + _data.Slot + ' opacity-almost-none no-pointer-events');

	var slot = _content.createImage(Path.GFX + _data.Image + '.png', function (_image)
	{
		if (isUsable)
		{
			slot_placeholder.addClass('opacity-almost-none');
			slot_placeholder.attr('src', Path.GFX + _data.Image + '.png');
		}
	}, null, 'slot-' + _data.Slot);

	slot.bindTooltip({ contentType: 'ui-element', elementId: _data.Tooltip });

	if(isUsable)
	{
		slot.click(function(_event)
		{
			self.mParent.notifyBackendSlotClicked(_data.Tooltip);
		});
		slot.mouseover(function()
		{
			this.classList.add('is-highlighted');

			slot.attr('src', Path.GFX + _data.Image + '_b.png');
			slot_placeholder.removeClass('opacity-almost-none');
		});
		slot.mouseout(function()
		{
			this.classList.remove('is-highlighted');

			slot.attr('src', Path.GFX + _data.Image + '.png');
			slot_placeholder.removeClass('opacity-almost-none');
		});
	}
}

CampScreenMainDialogModule.prototype.updateContracts = function (_data)
{
	var content = this.mDialogContainer.findDialogContentContainer();

	for(var i=0; i < 10; ++i)
	{
		for(var j=0; j<4; ++j)
		{
			var c = content.find('.contract' + i + ':first');

			if (c !== undefined && c !== null)
			{
				c.unbindTooltip();
				c.remove();
			}
		}
	}

	if(_data.Contracts.length != 0)
	{
		for (var i = 0; i < _data.Contracts.length; ++i)
		{
			this.createContract(_data.Contracts[i], i, _data.IsContractActive, content);
		}
	}
	else if(_data.IsContractsLocked === true)
	{
		var contract = content.createImage(Path.GFX + Asset.ICON_CONTRACT_LOCKED, null, null, 'display-block is-contract contract0');
		contract.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.MainDialogModule.ContractLocked });
	}
}

CampScreenMainDialogModule.prototype.createContract = function (_data, _i, _isDisabled, _content)
{
	if(_data == null)
	{
		return;
	}

	var self = this;
	var classes = 'display-block is-contract contract' + _i + (_data.IsNegotiated ? ' is-negotiated' : '');

	if(_isDisabled === true)
		classes += ' is-disabled';

	var contract = _content.createImage(Path.GFX + _data.Icon + (_isDisabled ? 'w.png' : '.png'), null, null, classes);
	var scroll;
	var category;

	if(_data.IsNegotiated)
	{
		contract.bindTooltip({ elementOwner: _data.ID, contentType: 'ui-element', elementId: _isDisabled ? TooltipIdentifier.WorldTownScreen.MainDialogModule.ContractDisabled : TooltipIdentifier.WorldTownScreen.MainDialogModule.ContractNegotiated });
		scroll = _content.createImage(Path.GFX + 'ui/icons/scroll_01' + (_isDisabled ? '_sw.png' : '.png'), null, null, 'display-block is-scroll contract' + _i + (_isDisabled ? ' is-disabled' : ''));
	}
	else
	{
		contract.bindTooltip({ elementOwner: _data.ID, contentType: 'ui-element', elementId: _isDisabled ? TooltipIdentifier.WorldTownScreen.MainDialogModule.ContractDisabled : TooltipIdentifier.WorldTownScreen.MainDialogModule.Contract });
		scroll = _content.createImage(Path.GFX + 'ui/icons/scroll_02' + (_isDisabled ? '_sw.png' : '.png'), null, null, 'display-block is-scroll contract' + _i + (_isDisabled ? ' is-disabled' : ''));
	}

	// category = _content.createImage(Path.GFX + _data.CategoryIcon, null, null, 'display-block is-contract-category contract-category-alignment-' + _data.Alignment + ' contract'  + _i);
	// category = _content.createImage(Path.GFX + _data.CategoryIcon, null, null, 'display-block is-contract-category contract-category-alignment-middle' + ' contract'  + _i);

	if(_data.CategoryIcon)
	{
		category = _content.createImage(Path.GFX + _data.CategoryIcon + (_isDisabled ? '_sw.png' : '.png'), null, null, 'display-block is-contract-category-' + _data.Alignment + ' contract' + _i);
	}


	// if(_data.CategoryIcon)
	// {
	// 	category = _content.createImage(Path.GFX + _data.CategoryIcon, null, null, 'display-block is-contract-category contract' + _i);
	// }

	var difficulty = _content.createImage(Path.GFX + _data.DifficultyIcon + (_isDisabled ? '_sw.png' : '.png'), null, null, 'display-block is-difficulty contract' + _i + (_isDisabled ? ' is-disabled' : ''));

	if(!_isDisabled)
	{
		var img1 = new Image();
		img1.src = Path.GFX + _data.Icon + 'b.png';
		var img2 = new Image();
		img2.src = Path.GFX + 'ui/icons/scroll_' + (_data.IsNegotiated ? '01' : '02') + '_b.png';
		if(_data.CategoryIcon)
		{
			var img3 = new Image();
			img3.src = Path.GFX + _data.CategoryIcon + '_b.png';
		}


		contract.click(function (_event)
		{
			self.mParent.notifyBackendContractClicked(_data.ID);
		});

		contract.mouseover(function()
		{
			this.classList.add('is-highlighted');
			scroll.addClass('is-highlighted');
			difficulty.addClass('is-highlighted');

			scroll.attr('src', Path.GFX + 'ui/icons/scroll_' + (_data.IsNegotiated ? '01' : '02') + '_b.png');
			contract.attr('src', Path.GFX + _data.Icon + 'b.png');
			if(_data.CategoryIcon)
			{
				category.attr('src', Path.GFX + _data.CategoryIcon + '_b.png')
			}
		});

		contract.mouseout(function()
		{
			this.classList.remove('is-highlighted');
			scroll.removeClass('is-highlighted');
			difficulty.removeClass('is-highlighted');

			scroll.attr('src', Path.GFX + 'ui/icons/scroll_' + (_data.IsNegotiated ? '01' : '02') + '.png');
			contract.attr('src', Path.GFX + _data.Icon + '.png');
			if(_data.CategoryIcon)
			{
				category.attr('src', Path.GFX + _data.CategoryIcon + '.png');
			}
		});
	}
}

CampScreenMainDialogModule.prototype.updateAssets = function (_data)
{
	this.mAssets.loadFromData(_data);
}

CampScreenMainDialogModule.prototype.notifyBackendModuleShown = function ()
{
	SQ.call(this.mSQHandle, 'onModuleShown');
};

CampScreenMainDialogModule.prototype.notifyBackendModuleHidden = function ()
{
	SQ.call(this.mSQHandle, 'onModuleHidden');
};

CampScreenMainDialogModule.prototype.notifyBackendModuleAnimating = function ()
{
	SQ.call(this.mSQHandle, 'onModuleAnimating');
};

CampScreenMainDialogModule.prototype.notifyBackendLeaveButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onLeaveButtonPressed');
};

CampScreenMainDialogModule.prototype.notifyBackendCampButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onCampButtonPressed');
};
