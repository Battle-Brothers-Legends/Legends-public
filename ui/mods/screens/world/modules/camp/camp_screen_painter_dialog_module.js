
"use strict";

var CampScreenPainterDialogModule = function(_parent)
{
	this.mSQHandle = null;
	this.mParent = _parent;

	this.mRoster = null;

	// event listener
	this.mEventListener = null;

	// generic containers
	this.mContainer = null;
	this.mDialogContainer = null;
	this.mListContainer = null;
	this.mListScrollContainer = null;
	this.mDetailsPanel = {
		Container: null,
		ConfirmButton: null,
		TotalCostText: null
	};

	// controls
	this.mArmorLayers =
	[
		[{Row: null},{MasterKey: "BodyArmor", Key: "Cloth", Image: null, Value: null, Left: null, Right: null, Reset: null, Input: null, Combined: null}, {MasterKey: "Helmet", Key: "Hood", Image: null, Value: null, Left: null, Right: null, Reset: null, Input: null, Combined: null}, 
		{MasterKey: "Shield", Key: "Shield", Image: null, Value: null, Left: null, Right: null, Reset: null, Input: null, Combined: null}],
		[{Row: null},{MasterKey: "BodyArmor", Key: "Chain", Image: null, Value: null, Left: null, Right: null, Reset: null, Input: null, Combined: null}, {MasterKey: "Helmet", Key: "Helm", Image: null, Value: null, Left: null, Right: null, Reset: null, Input: null, Combined: null}],
		[{Row: null},{MasterKey: "BodyArmor", Key: "Plate", Image: null, Value: null, Left: null, Right: null, Reset: null, Input: null, Combined: null}, {MasterKey: "Helmet", Key: "Top", Image: null, Value: null, Left: null, Right: null, Reset: null, Input: null, Combined: null}],
		[{Row: null},{MasterKey: "BodyArmor", Key: "Tabard", Image: null, Value: null, Left: null, Right: null, Reset: null, Input: null, Combined: null}, {MasterKey: "Helmet", Key: "Vanity", Image: null, Value: null, Left: null, Right: null, Reset: null, Input: null, Combined: null}],
		[{Row: null},{MasterKey: "BodyArmor", Key: "Cloak", Image: null, Value: null, Left: null, Right: null, Reset: null, Input: null, Combined: null}, {MasterKey: "Helmet", Key: "ExtraVanity", Image: null, Value: null, Left: null, Right: null, Reset: null, Input: null, Combined: null}],
	];

	// assets labels
	this.mAssets = new WorldTownScreenAssets(_parent);

	// buttons
	this.mLeaveButton = null;

	// generics
	this.mIsVisible = false;

	// selected entry
	this.mSelectedEntry = null;
};


CampScreenPainterDialogModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

CampScreenPainterDialogModule.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

CampScreenPainterDialogModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};

CampScreenPainterDialogModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: containers (init hidden!)
	this.mContainer = $('<div class="l-painter-dialog-container display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
	this.mDialogContainer = this.mContainer.createDialog('Painter', '', '', true, 'dialog-1024-768');

	// create tabs
	var tabButtonsContainer = $('<div class="l-tab-container"/>');
	this.mDialogContainer.findDialogTabContainer().append(tabButtonsContainer);

	// create assets
	this.mAssets.createDIV(tabButtonsContainer);

	// create content
	var content = this.mDialogContainer.findDialogContentContainer();

	// left column
	var column = $('<div class="column is-left"/>');
	content.append(column);
	var listContainerLayout = $('<div class="l-list-container"/>');
	column.append(listContainerLayout);
	this.mListContainer = listContainerLayout.createList(1.77/*8.85*/);
	this.mListScrollContainer = this.mListContainer.findListScrollContainer();

	// right column
	column = $('<div class="column is-right"/>');
	content.append(column);

	// details container
	var detailsFrame = $('<div class="l-details-frame"/>');
	column.append(detailsFrame);
	this.mDetailsPanel.Container = $('<div class="details-container display-none"/>');
	detailsFrame.append(this.mDetailsPanel.Container);

	// details: character container
	var detailsRow = $('<div class="row is-character-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	var detailsColumn = $('<div class="column is-character-background-container"/>');
	detailsRow.append(detailsColumn);
 
	// details: background
	var backgroundRow = $('<div class="row is-top"/>');
	detailsColumn.append(backgroundRow);
	var headertext = $('<div class="armorname title-font-normal font-bold font-color-brother-name">Armor</div>');
	backgroundRow.append(headertext);
 	headertext = $('<div class="helmetname title-font-normal font-bold font-color-brother-name">Helmet</div>');
	backgroundRow.append(headertext); 
	
	// details: layers
	for (var r = 0; r < this.mArmorLayers.length; r++) 
	{
	  this.mArmorLayers[r][0].Row = $('<div class="layers-row"/>');
	  detailsColumn.append(this.mArmorLayers[r][0].Row);
	  //rrow.Row.css('background-image', 'url("coui://gfx/ui/skin/icon_trees.png")');
	}
	
	var container = null;
	$.each(this.mArmorLayers, function (r, _value)
	{
 		//FIRST COLUMN
		var row = self.mArmorLayers[r][0].Row;
		
		container = $('<div class="l-stats-row-icon"/>');
		row.append(container);
		self.mArmorLayers[r][1].Image = $('<img class="row-icon-img"/>');
		container.append(self.mArmorLayers[r][1].Image);
		
		container = $('<div class="value-container"/>');
		row.append(container);
		self.mArmorLayers[r][1].Value = $('<div class="label text-font-very-small font-color-value font-shadow-outline">1000</div>');
		container.append(self.mArmorLayers[r][1].Value);
		
		container = $('<div class="l-input"/>');
		row.append(container);
		self.mArmorLayers[r][1].Input = container.createInput('', 0, 2, null, null, 'title-font-medium font-bold font-color-brother-name', function (_input)
		{
			self.ProcessInputChange(1, _value[1].MasterKey, _value[1].Key, _input);
		}, 2, function (_input)
		{
 			var iText = _input.getInputText();
			var iTextInd = iText.indexOf('/');
			if (iTextInd > 0)
			{	iText = iText.slice(0, iTextInd);
				_input.setInputText(iText);} 
		});
		self.mArmorLayers[r][1].Input.css('width', '10.4rem');
		self.mArmorLayers[r][1].Input.css('background-size', '10.4rem 2.8rem');
		
		container = $('<div class="l-leftbutton"/>');
		row.append(container);
		self.mArmorLayers[r][1].Left = container.createImageButton(Path.GFX + Asset.BUTTON_ARROW_LEFT, function ()
		{
			self.ArrowClicked(1, _value[1].MasterKey, _value[1].Key, -1);
		}, '', 6);
		container = $('<div class="l-rightbutton"/>');
		row.append(container);
		self.mArmorLayers[r][1].Right = container.createImageButton(Path.GFX + Asset.BUTTON_ARROW_RIGHT, function ()
		{
			self.ArrowClicked(1, _value[1].MasterKey, _value[1].Key, 1);
		}, '', 6);
		container = $('<div class="l-resetbutton"/>');
		row.append(container);
		self.mArmorLayers[r][1].Reset = container.createImageButton(Path.GFX + Asset.BUTTON_QUIT, function ()
		{
			self.ResetVariant(1, _value[1].MasterKey, _value[1].Key);
		}, '', 6);
		
		//SECOND COLUMN
		container = $('<div class="l-stats-row-icon"/>');
		container.css('left', '41.0rem'); //21.0rem
		row.append(container);
		self.mArmorLayers[r][2].Image = $('<img class="row-icon-img"/>');
		container.append(self.mArmorLayers[r][2].Image);
		
		container = $('<div class="value-container"/>');
		container.css('left', '41.5rem'); //21.5rem
		row.append(container);
		self.mArmorLayers[r][2].Value = $('<div class="label text-font-very-small font-color-value font-shadow-outline">1000</div>');
		container.append(self.mArmorLayers[r][2].Value);
		
		container = $('<div class="l-input"/>');
		container.css('left', '30.4rem'); //27.8rem'
		row.append(container);
		self.mArmorLayers[r][2].Input = container.createInput('', 0, 2, null, null, 'title-font-medium font-bold font-color-brother-name', function (_input)
		{
			self.ProcessInputChange(2, _value[2].MasterKey, _value[2].Key, _input);
		}, 2, function (_input)
		{
 			var iText = _input.getInputText();
			var iTextInd = iText.indexOf('/');
			if (iTextInd > 0)
			{	iText = iText.slice(0, iTextInd);
				_input.setInputText(iText);} 
		});
		self.mArmorLayers[r][2].Input.css('width', '10.4rem');
		self.mArmorLayers[r][2].Input.css('background-size', '10.4rem 2.8rem');
		
		container = $('<div class="l-leftbutton"/>');
		container.css('left', '33.4rem'); //27.3rem
		row.append(container);
		self.mArmorLayers[r][2].Left = container.createImageButton(Path.GFX + Asset.BUTTON_ARROW_LEFT, function ()
		{
			self.ArrowClicked(2, _value[2].MasterKey, _value[2].Key, -1);
		}, '', 6);
		container = $('<div class="l-rightbutton"/>');
		container.css('left', '36.9rem'); //30.8rem
		row.append(container);
		self.mArmorLayers[r][2].Right = container.createImageButton(Path.GFX + Asset.BUTTON_ARROW_RIGHT, function ()
		{
			self.ArrowClicked(2, _value[2].MasterKey, _value[2].Key, 1);
		}, '', 6);
		container = $('<div class="l-resetbutton"/>');
		container.css('left', '29.9rem'); //34.3rem
		row.append(container);
		self.mArmorLayers[r][2].Reset = container.createImageButton(Path.GFX + Asset.BUTTON_QUIT, function ()
		{
			self.ResetVariant(2, _value[2].MasterKey, _value[2].Key);
		}, '', 6);
	});
	
	var armorcontainer = $('<div class="l-armor-icon"/>');
	detailsColumn.append(armorcontainer);
	var helmetcontainer = $('<div class="l-helmet-icon"/>');
	detailsColumn.append(helmetcontainer);
	for (var r = 0; r < this.mArmorLayers.length; r++) 
	{
		self.mArmorLayers[r][1].Combined = $('<img class="armor-icon-img"/>');
		armorcontainer.append(self.mArmorLayers[r][1].Combined);
		self.mArmorLayers[r][2].Combined = $('<img class="helmet-icon-img"/>');
		helmetcontainer.append(self.mArmorLayers[r][2].Combined);
	}
	
	//Shield
	var shieldrow = $('<div class="layers-row"/>');
	detailsColumn.append(shieldrow);
	var shieldcontainer = $('<div class="l-armor-icon"/>');
	shieldcontainer.css('top', '23.3rem');
	detailsColumn.append(shieldcontainer);
	self.mArmorLayers[0][3].Combined = $('<img class="armor-icon-img"/>');
	self.mArmorLayers[0][3].Image = self.mArmorLayers[0][3].Combined;
	shieldcontainer.append(self.mArmorLayers[0][3].Combined);
	
	container = $('<div class="value-container"/>');
	container.css('left', '24.2rem');
	container.css('top', '5.0rem');
	self.mArmorLayers[4][0].Row.append(container);
	self.mArmorLayers[0][3].Value = $('<div class="label text-font-very-small font-color-value font-shadow-outline">1000</div>');
	//self.mArmorLayers[0][3].Value.css('text-align', 'center');
	container.append(self.mArmorLayers[0][3].Value);
	
	container = $('<div class="l-input"/>');
	container.css('left', '19.7rem');
	container.css('top', '2.9rem');
	shieldrow.append(container);
	self.mArmorLayers[0][3].Input = container.createInput('', 0, 2, null, null, 'title-font-medium font-bold font-color-brother-name', function (_input)
	{
		self.ProcessInputChange(3, "Shield", "Shield", _input);
	}, 2, function (_input)
	{
		var iText = _input.getInputText();
		var iTextInd = iText.indexOf('/');
		if (iTextInd > 0)
		{	iText = iText.slice(0, iTextInd);
			_input.setInputText(iText);} 
	});
	self.mArmorLayers[0][3].Input.css('width', '10.4rem');
	self.mArmorLayers[0][3].Input.css('background-size', '10.4rem 2.8rem');
	
	container = $('<div class="l-leftbutton"/>');
	container.css('left', '19.2rem');
	container.css('top', '-0.6rem');
	shieldrow.append(container);
	self.mArmorLayers[0][3].Left = container.createImageButton(Path.GFX + Asset.BUTTON_ARROW_LEFT, function ()
	{
		self.ArrowClicked(3, "Shield", "Shield", -1);
	}, '', 6);
	container = $('<div class="l-rightbutton"/>');
	container.css('left', '26.2rem');
	container.css('top', '-0.6rem');
	shieldrow.append(container);
	self.mArmorLayers[0][3].Right = container.createImageButton(Path.GFX + Asset.BUTTON_ARROW_RIGHT, function ()
	{
		self.ArrowClicked(3, "Shield", "Shield", 1);
	}, '', 6);
	container = $('<div class="l-resetbutton"/>');
	container.css('left', '22.7rem');
	container.css('top', '-0.6rem');
	shieldrow.append(container);
	self.mArmorLayers[0][3].Reset = container.createImageButton(Path.GFX + Asset.BUTTON_QUIT, function ()
	{
		self.ResetVariant(3, "Shield", "Shield");
	}, '', 6);
		
	
	// details: buttons
	detailsRow = $('<div class="row is-button-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	var costsLabel = $('<div class="totalmoney title-font-normal font-bold font-bottom-shadow font-color-title">Total Cost:</div>');
	detailsRow.append(costsLabel);
	var costsImage = $('<img class="moneyimg"/>');
	detailsRow.append(costsImage);
	costsImage.attr('src', Path.GFX + Asset.ICON_ASSET_MONEY);
	this.mDetailsPanel.TotalCostText = $('<div class="totalmoneysum title-font-normal font-bold font-bottom-shadow font-color-title">0</div>');
	detailsRow.append(this.mDetailsPanel.TotalCostText);
	
	var ConfirmButtonLayout = $('<div class="l-confirm-button"/>');
	detailsRow.append(ConfirmButtonLayout);
	this.mDetailsPanel.ConfirmButton = ConfirmButtonLayout.createTextButton("Confirm", function()
	{
		if(self.mSelectedEntry !== null)
		{
			self.changeRosterEntry();
		}
	}, '', 1);

	// create footer button bar
	var footerButtonBar = $('<div class="l-button-bar"/>');
	this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

	// create: buttons
	var layout = $('<div class="l-leave-button"/>');
	footerButtonBar.append(layout);
	this.mLeaveButton = layout.createTextButton("Leave", function() {
		self.notifyBackendLeaveButtonPressed();
	}, '', 1);

	this.mIsVisible = false;
};

CampScreenPainterDialogModule.prototype.destroyDIV = function ()
{
	this.mAssets.destroyDIV();

	this.mSelectedEntry = null;

	this.mDetailsPanel.ConfirmButton.remove();
	this.mDetailsPanel.ConfirmButton = null;
	
/*	 this.mDetailsPanel.TotalCostText.remove();
	this.mDetailsPanel.TotalCostText = null; */

/*	 this.mDetailsPanel.CharacterImage.empty();
	this.mDetailsPanel.CharacterImage.remove();
	this.mDetailsPanel.CharacterImage = null; */

	this.mDetailsPanel.Container.empty();
	this.mDetailsPanel.Container.remove();
	this.mDetailsPanel.Container = null;

	this.mListScrollContainer.empty();
	this.mListScrollContainer = null;
	this.mListContainer.destroyList();
	this.mListContainer.remove();
	this.mListContainer = null;

	this.mLeaveButton.remove();
	this.mLeaveButton = null;

	this.mDialogContainer.empty();
	this.mDialogContainer.remove();
	this.mDialogContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};

CampScreenPainterDialogModule.prototype.addListEntry = function (_data)
{
	var result = $('<div class="l-row"/>');
	this.mListScrollContainer.append(result);

	var entry = $('<div class="ui-control list-entry"/>');
	result.append(entry);
	entry.data('entry', _data);
	entry.click(this, function(_event)
	{
		var self = _event.data;
		self.selectListEntry($(this));
	});

	// left column
	var column = $('<div class="column is-left"/>');
	entry.append(column);

	var imageOffsetX = ('ImageOffsetX' in _data ? _data['ImageOffsetX'] : 0);
	var imageOffsetY = ('ImageOffsetY' in _data ? _data['ImageOffsetY'] : 0);
	_data.BroImage = column.createImage(Path.PROCEDURAL + _data['ImagePath'], function (_image)
	{
		_image.centerImageWithinParent(imageOffsetX, imageOffsetY, 0.64);
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');

	// right column
	column = $('<div class="column is-right"/>');
	entry.append(column);

	// top row
	var row = $('<div class="row is-top"/>');
	column.append(row);

	var image = $('<img/>');
	image.attr('src', Path.GFX + _data['BackgroundImagePath']);
	row.append(image);

	// bind tooltip
	image.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterBackgrounds.Generic, elementOwner: TooltipIdentifier.ElementOwner.HireScreen, entityId: _data.ID });

	var name = $('<div class="name title-font-normal font-bold font-color-brother-name">' + _data[WorldTownScreenIdentifier.HireRosterEntry.Name] + '</div>');
	row.append(name);

	// bottom row
	row = $('<div class="row is-bottom"/>');
	column.append(row);
};

CampScreenPainterDialogModule.prototype.selectListEntry = function(_element, _scrollToEntry)
{
	if (_element !== null && _element.length > 0)
	{
		{
			this.mListContainer.deselectListEntries();
			_element.addClass('is-selected');

			if (_scrollToEntry !== undefined && _scrollToEntry === true)
			{
				this.mListContainer.scrollListToElement(_element);
			}

			this.mSelectedEntry = _element;
			this.updateDetailsPanel(this.mSelectedEntry);
		}
	}
	else
	{
		this.mSelectedEntry = null;
		this.updateDetailsPanel(this.mSelectedEntry);
	}
};

CampScreenPainterDialogModule.prototype.updateDetailsPanel = function(_element)
{
	if(_element !== null && _element.length > 0)
	{
		var data = _element.data('entry');
		var self = this;
		
		$.each(data.BodyArmor, function (_key, _value)
		{
			for (var r = 0; r < self.mArmorLayers.length; r++) 
			{
				if (self.mArmorLayers[r][1].Key == _key)
				{
					if (_value != null)
					{
						self.mArmorLayers[r][1].Image.attr('src', Path.ITEMS + data.BodyArmor[_key]['Icon']);
						self.mArmorLayers[r][1].Combined.attr('src', Path.ITEMS + data.BodyArmor[_key]['IconLarge']);
						if (data.BodyArmor[_key]['Variants'] > 1)
						{
							self.mArmorLayers[r][1].Value.html(""+data.BodyArmor[_key]['Value']);
							self.mArmorLayers[r][1].Value.css({opacity: 0.5});
							self.mArmorLayers[r][1].Input.setInputTextBP(data.BodyArmor[_key]['Variant']+"/"+data.BodyArmor[_key]['Variants']);
							self.mArmorLayers[r][1].Left.enableButton(true);
							self.mArmorLayers[r][1].Right.enableButton(true);
						}
					}
					else //no layer
					{
						self.mArmorLayers[r][1].Image.attr('src', Path.GFX+'ui/icons/talent_0.png');
						self.mArmorLayers[r][1].Combined.attr('src', Path.GFX+'ui/icons/talent_0.png');
					}
					
					if (_value == null || data.BodyArmor[_key]['Variants'] <= 1)
					{
						self.mArmorLayers[r][1].Value.html("");
						self.mArmorLayers[r][1].Input.setInputTextBP("");
						self.mArmorLayers[r][1].Left.enableButton(false);
						self.mArmorLayers[r][1].Right.enableButton(false);
					}
					self.mArmorLayers[r][1].Reset.enableButton(false);
					break;
				}
			}
		});

		$.each(data.Helmet, function (_key, _value)
		{
			for (var r = 0; r < self.mArmorLayers.length; r++) 
			{
				if (self.mArmorLayers[r][2].Key == _key)
				{
					if (_value != null)
					{
						self.mArmorLayers[r][2].Image.attr('src', Path.ITEMS + data.Helmet[_key]['Icon']);
						self.mArmorLayers[r][2].Combined.attr('src', Path.ITEMS + data.Helmet[_key]['IconLarge']);
						if (data.Helmet[_key]['Variants'] > 1)
						{
							self.mArmorLayers[r][2].Value.html(""+data.Helmet[_key]['Value']);
							self.mArmorLayers[r][2].Value.css({opacity: 0.5});
							self.mArmorLayers[r][2].Input.setInputTextBP(data.Helmet[_key]['Variant']+"/"+data.Helmet[_key]['Variants']);
							self.mArmorLayers[r][2].Left.enableButton(true);
							self.mArmorLayers[r][2].Right.enableButton(true);
						}
					}
					else //no layer
					{
						self.mArmorLayers[r][2].Image.attr('src', Path.GFX+'ui/icons/talent_0.png');
						self.mArmorLayers[r][2].Combined.attr('src', Path.GFX+'ui/icons/talent_0.png');
					}
					
					if (_value == null || data.Helmet[_key]['Variants'] <= 1)
					{
						self.mArmorLayers[r][2].Value.html("");
						self.mArmorLayers[r][2].Input.setInputTextBP("");
						self.mArmorLayers[r][2].Left.enableButton(false);
						self.mArmorLayers[r][2].Right.enableButton(false);
					}
					self.mArmorLayers[r][2].Reset.enableButton(false);
					break;
				}
			}
		});
		
		if (data.Shield.Shield != null)
		{
			self.mArmorLayers[0][3].Image.attr('src', Path.ITEMS + data.Shield.Shield['Icon']);
			self.mArmorLayers[0][3].Combined.attr('src', Path.ITEMS + data.Shield.Shield['IconLarge']);
			if (data.Shield.Shield['Variants'] > 1)
			{
				self.mArmorLayers[0][3].Value.html(""+data.Shield.Shield['Value']);
				self.mArmorLayers[0][3].Value.css({opacity: 0.5});
				self.mArmorLayers[0][3].Input.setInputTextBP(data.Shield.Shield['Variant']+"/"+data.Shield.Shield['Variants']);
				self.mArmorLayers[0][3].Left.enableButton(true);
				self.mArmorLayers[0][3].Right.enableButton(true);
			}
		}
		else //no layer
		{
			self.mArmorLayers[0][3].Image.attr('src', Path.GFX+'ui/icons/talent_0.png');
			self.mArmorLayers[0][3].Combined.attr('src', Path.GFX+'ui/icons/talent_0.png');
		}
		if (data.Shield.Shield == null || data.Shield.Shield['Variants'] <= 1)
		{
			self.mArmorLayers[0][3].Value.html("");
			self.mArmorLayers[0][3].Input.setInputTextBP("");
			self.mArmorLayers[0][3].Left.enableButton(false);
			self.mArmorLayers[0][3].Right.enableButton(false);
		}
		self.mArmorLayers[0][3].Reset.enableButton(false);
		
		
		self.mDetailsPanel.ConfirmButton.enableButton(false);
		self.mDetailsPanel.TotalCostText.html("0");
		
		self.mDetailsPanel.Container.removeClass('display-none').addClass('display-block');
	}
	else
	{
		this.mDetailsPanel.Container.removeClass('display-block').addClass('display-none');
	}
};

CampScreenPainterDialogModule.prototype.ProcessInputChange = function (_row, _mkey, _key, _input)
{
	var self = this;
	var data = self.mSelectedEntry.data('entry');
	var inputtext = parseInt(_input.getInputText(), 10);
	
	for (var r = 0; r < self.mArmorLayers.length; r++) 
	{
		if (self.mArmorLayers[r][_row].Key == _key)
		{
			if (data[_mkey][_key] == null || data[_mkey][_key]['Variants'] <= 1) //novariants or no layer
			{
				self.mArmorLayers[r][_row].Input.setInputTextBP("");
			}
			else if (isNaN(inputtext) || inputtext < 1 || inputtext > data[_mkey][_key]['Variants']) //badinput
			{
				self.mArmorLayers[r][_row].Input.setInputTextBP(data[_mkey][_key]['Variant']+"/"+data[_mkey][_key]['Variants']);
				self.mArmorLayers[r][_row].Reset.enableButton(false);
				self.mArmorLayers[r][_row].Value.css({opacity: 0.5});
				self.UpdateVisuals(r, _row, _mkey, _key, data[_mkey][_key]['Variant']);
			}
			else
			{
				self.mArmorLayers[r][_row].Input.setInputTextBP(inputtext+"/"+data[_mkey][_key]['Variants']);
				if (inputtext != data[_mkey][_key]['Variant'])
				{
					self.mArmorLayers[r][_row].Reset.enableButton(true);
					self.mArmorLayers[r][_row].Value.css({opacity: 1.0});
				}
				else
				{
					self.mArmorLayers[r][_row].Reset.enableButton(false);
					self.mArmorLayers[r][_row].Value.css({opacity: 0.5});
				}
				self.UpdateVisuals(r, _row, _mkey, _key, inputtext);
			}
			break;
		}
	}
};

CampScreenPainterDialogModule.prototype.ArrowClicked = function (_row, _mkey, _key, _change)
{
	var self = this;
	var data = self.mSelectedEntry.data('entry');
	var variants = data[_mkey][_key]['Variants'];
	if (variants > 1)
	{
		for (var r = 0; r < self.mArmorLayers.length; r++) 
		{
			if (self.mArmorLayers[r][_row].Key == _key)
			{
				var inputtext = self.mArmorLayers[r][_row].Input.getInputText();
				var iTextInd = inputtext.indexOf('/');
				inputtext = inputtext.slice(0, iTextInd);
				inputtext = parseInt(inputtext, 10);
				inputtext = inputtext + _change;
				if (inputtext == 0)
				{
					inputtext = variants;
				}
				else if (inputtext > variants)
				{
					inputtext = 1;
				}
				self.mArmorLayers[r][_row].Input.setInputTextBP(inputtext+"/"+variants);
				if (inputtext != data[_mkey][_key]['Variant'])
				{
					self.mArmorLayers[r][_row].Reset.enableButton(true);
					self.mArmorLayers[r][_row].Value.css({opacity: 1.0});
				}
				else
				{
					self.mArmorLayers[r][_row].Reset.enableButton(false);
					self.mArmorLayers[r][_row].Value.css({opacity: 0.5});
				}
				self.UpdateVisuals(r, _row, _mkey, _key, inputtext);
				break;
			}
		}
	}
};

CampScreenPainterDialogModule.prototype.ResetVariant = function (_row, _mkey, _key)
{
	var self = this;
	var data = self.mSelectedEntry.data('entry');
	var variants = data[_mkey][_key]['Variants'];
	if (variants > 1)
	{
		for (var r = 0; r < self.mArmorLayers.length; r++) 
		{
			if (self.mArmorLayers[r][_row].Key == _key)
			{
				self.mArmorLayers[r][_row].Input.setInputTextBP(data[_mkey][_key]['Variant']+"/"+variants);
				self.mArmorLayers[r][_row].Reset.enableButton(false);
				self.mArmorLayers[r][_row].Value.css({opacity: 0.5});
				self.UpdateVisuals(r, _row, _mkey, _key, data[_mkey][_key]['Variant']);
				break;
			}
		}
	}
};

CampScreenPainterDialogModule.prototype.UpdateVisuals = function (_row, _column, _mkey, _key, _variant)
{
	var self = this;
	var data = self.mSelectedEntry.data('entry');
	if (data[_mkey][_key]['Variant'] == _variant)
	{
		self.mArmorLayers[_row][_column].Image.attr('src', Path.ITEMS + data[_mkey][_key]['Icon']);
		self.mArmorLayers[_row][_column].Combined.attr('src', Path.ITEMS + data[_mkey][_key]['IconLarge']);
	}
	else
	{
		var result = {
				Link: data[_mkey][_key]['Link'],
				Variant: _variant,
		};
		
		if(self.mSQHandle !== null)
		{
			SQ.call(self.mSQHandle, 'SendPics', result, function(_result)
			{		   
				self.mArmorLayers[_row][_column].Image.attr('src', Path.ITEMS + _result['Icon']);
				self.mArmorLayers[_row][_column].Combined.attr('src', Path.ITEMS + _result['IconLarge']);
			}); 
		}
	}
	self.UpdateCost();
};

CampScreenPainterDialogModule.prototype.UpdateCost = function ()
{
	var self = this;
	var data = self.mSelectedEntry.data('entry');
	var totalcost = 0;
	$.each(data.BodyArmor, function (_key, _value)
	{
		for (var r = 0; r < self.mArmorLayers.length; r++) 
		{
			if (self.mArmorLayers[r][1].Key == _key)
			{
				if (_value != null && self.mArmorLayers[r][1].Reset.isEnabled())
				{
					totalcost = totalcost + data.BodyArmor[_key]['Value'];
				}
				break;
			}
		}
	});
	$.each(data.Helmet, function (_key, _value)
	{
		for (var r = 0; r < self.mArmorLayers.length; r++) 
		{
			if (self.mArmorLayers[r][2].Key == _key)
			{
				if (_value != null && self.mArmorLayers[r][2].Reset.isEnabled())
				{
					totalcost = totalcost + data.Helmet[_key]['Value'];
				}
				break;
			}
		}
	});
	if (data.Shield.Shield != null && self.mArmorLayers[0][3].Reset.isEnabled())
	{
		totalcost = totalcost + data.Shield.Shield['Value'];
	}
	
	self.mDetailsPanel.TotalCostText.html(""+totalcost);
	var currentMoney = this.mAssets.getValues().Money;
	if (totalcost == 0 || totalcost > currentMoney)
	{
		self.mDetailsPanel.ConfirmButton.enableButton(false);
	}
	else
	{
		self.mDetailsPanel.ConfirmButton.enableButton(true);
	}
};


CampScreenPainterDialogModule.prototype.bindTooltips = function ()
{
	this.mAssets.bindTooltips();
	this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.LeaveButton });
};

CampScreenPainterDialogModule.prototype.unbindTooltips = function ()
{
	this.mAssets.unbindTooltips();
	this.mLeaveButton.unbindTooltip();
};


CampScreenPainterDialogModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

CampScreenPainterDialogModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


CampScreenPainterDialogModule.prototype.register = function (_parentDiv)
{
	console.log('CampScreenPainterDialogModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register World Town Screen Hire Dialog Module. Reason: World Town Screen Hire Dialog Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

CampScreenPainterDialogModule.prototype.unregister = function ()
{
	console.log('CampScreenPainterDialogModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister World Town Screen Hire Dialog Module. Reason: World Town Screen Hire Dialog Module is not initialized.');
		return;
	}

	this.destroy();
};

CampScreenPainterDialogModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


CampScreenPainterDialogModule.prototype.registerEventListener = function(_listener)
{
	this.mEventListener = _listener;
};


CampScreenPainterDialogModule.prototype.show = function (_withSlideAnimation)
{
	var self = this;

	var withAnimation = (_withSlideAnimation !== undefined && _withSlideAnimation !== null) ? _withSlideAnimation : true;
	if (withAnimation === true)
	{
		var offset = -(this.mContainer.parent().width() + this.mContainer.width());
		this.mContainer.css({ 'left': offset });
		this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' }, {
			duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
			easing: 'swing',
			begin: function () {
				$(this).removeClass('display-none').addClass('display-block');
				self.notifyBackendModuleAnimating();
			},
			complete: function () {
				self.mIsVisible = true;
				self.notifyBackendModuleShown();
			}
		});
	}
	else
	{
		this.mContainer.css({ opacity: 0 });
		this.mContainer.velocity("finish", true).velocity({ opacity: 1 }, {
			duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
			easing: 'swing',
			begin: function() {
				$(this).removeClass('display-none').addClass('display-block');
				self.notifyBackendModuleAnimating();
			},
			complete: function() {
				self.mIsVisible = true;
				self.notifyBackendModuleShown();
			}
		});
	}
};

CampScreenPainterDialogModule.prototype.hide = function ()
{
	var self = this;

	var offset = -(this.mContainer.parent().width() + this.mContainer.width());
	this.mContainer.velocity("finish", true).velocity({ opacity: 0, left: offset },
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
			self.mListScrollContainer.empty();
			$(this).removeClass('display-block').addClass('display-none');
			self.notifyBackendModuleHidden();
		}
	});
};

CampScreenPainterDialogModule.prototype.isVisible = function ()
{
	return this.mIsVisible;
};

CampScreenPainterDialogModule.prototype.updateAssets = function (_data)
{
	this.mAssets.loadFromData(_data);
}

CampScreenPainterDialogModule.prototype.loadFromData = function (_data)
{
	if(_data === undefined || _data === null)
	{
		return;
	}

	if('Title' in _data && _data.Title !== null)
	{
		 this.mDialogContainer.findDialogTitle().html(_data.Title);
	}

	if('SubTitle' in _data && _data.SubTitle !== null)
	{
		 this.mDialogContainer.findDialogSubTitle().html(_data.SubTitle);
	}

	this.mRoster = _data.Roster;

	this.mListScrollContainer.empty();

	for(var i = 0; i < _data.Roster.length; ++i)
	{
		var entry = _data.Roster[i];
		this.addListEntry(entry);
	}

	this.selectListEntry(this.mListContainer.findListEntryByIndex(0), true);
};

CampScreenPainterDialogModule.prototype.changeRosterEntry = function ()
{
	var self = this;
	var data = self.mSelectedEntry.data('entry');
	
	var result = {
		ID: data['ID'],
		Cost: 0,
		BodyArmor: {Cloth: {}, Chain: {}, Plate: {}, Tabard: {}, Cloak: {}},
		Helmet: {Hood: {}, Helm: {}, Top: {}, Vanity: {}, ExtraVanity: {}},
		Shield: {Shield: {}}
	};
	
 	var totalcost = 0;
	$.each(data.BodyArmor, function (_key, _value)
	{
		for (var r = 0; r < self.mArmorLayers.length; r++) 
		{
			if (self.mArmorLayers[r][1].Key == _key)
			{
				if (_value != null && self.mArmorLayers[r][1].Reset.isEnabled())
				{
					totalcost = totalcost + data.BodyArmor[_key]['Value'];
					var curvariant = self.mArmorLayers[r][1].Input.getInputText();
					var iTextInd = curvariant.indexOf('/');
					curvariant = curvariant.slice(0, iTextInd);
					curvariant = parseInt(curvariant, 10);
					result.BodyArmor[_key]['ID'] = data.BodyArmor[_key].ID;
					result.BodyArmor[_key]['Variant'] = curvariant;
				}
				else
				{
					result.BodyArmor[_key] = null;
				}
				break;
			}
		}
	});
	$.each(data.Helmet, function (_key, _value)
	{
		for (var r = 0; r < self.mArmorLayers.length; r++) 
		{
			if (self.mArmorLayers[r][2].Key == _key)
			{
				if (_value != null && self.mArmorLayers[r][2].Reset.isEnabled())
				{
					totalcost = totalcost + data.Helmet[_key]['Value'];
					var curvariant = self.mArmorLayers[r][2].Input.getInputText();
					var iTextInd = curvariant.indexOf('/');
					curvariant = curvariant.slice(0, iTextInd);
					curvariant = parseInt(curvariant, 10);
					result.Helmet[_key]['ID'] = data.Helmet[_key].ID;
					result.Helmet[_key]['Variant'] = curvariant;
				}
				else
				{
					result.Helmet[_key] = null;
				}
				break;
			}
		}
	});
	
	if (data.Shield.Shield != null && self.mArmorLayers[0][3].Reset.isEnabled())
	{
		totalcost = totalcost + data.Shield.Shield['Value'];
		var curvariant = self.mArmorLayers[0][3].Input.getInputText();
		var iTextInd = curvariant.indexOf('/');
		curvariant = curvariant.slice(0, iTextInd);
		curvariant = parseInt(curvariant, 10);
		result.Shield['Shield']['ID'] = data.Shield.Shield.ID;
		result.Shield['Shield']['Variant'] = curvariant;
	}
	else
	{
		result.Shield['Shield'] = null;
	}
	
	result.Cost = totalcost;
	
	this.notifyBackendChangeAppearance(result, function(_data)
	{
		if (_data != null)
		{
			self.mRoster = _data.Roster;

			var container = self.mListContainer.findListScrollContainer();
			container.find('.list-entry').each(function (index, element)
			{
				var entry = $(element);
				var savebroimage = entry.data('entry').BroImage;
				entry.data('entry', self.mRoster[index]);
				entry.data('entry').BroImage = savebroimage;
				entry.data('entry').BroImage.attr('src', Path.PROCEDURAL + entry.data('entry')['ImagePath']);
			});

			self.mParent.loadAssetData(_data.Assets);
			var data = self.mSelectedEntry.data('entry');
			self.updateDetailsPanel(self.mSelectedEntry);
		}
	}); 
};

CampScreenPainterDialogModule.prototype.notifyBackendModuleShown = function ()
{
	SQ.call(this.mSQHandle, 'onModuleShown');
};

CampScreenPainterDialogModule.prototype.notifyBackendModuleHidden = function ()
{
	SQ.call(this.mSQHandle, 'onModuleHidden');
};

CampScreenPainterDialogModule.prototype.notifyBackendModuleAnimating = function ()
{
	SQ.call(this.mSQHandle, 'onModuleAnimating');
};

CampScreenPainterDialogModule.prototype.notifyBackendLeaveButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onLeaveButtonPressed');
};

CampScreenPainterDialogModule.prototype.notifyBackendBrothersButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onBrothersButtonPressed');
};

CampScreenPainterDialogModule.prototype.notifyBackendChangeAppearance = function (_result, _callback)
{
	SQ.call(this.mSQHandle, 'onChangeAppearance', _result, _callback);
};