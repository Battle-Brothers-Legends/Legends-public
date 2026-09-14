
"use strict";

var WorldTownScreenAssets = function(_parent, showMax)
{
	// assets labels
	this.mMoneyAsset		= null;
	this.mFoodAsset			= null;
	this.mAmmoAsset			= null;
	this.mSuppliesAsset		= null;
	this.mMedicineAsset		= null;
	this.mBrothersAsset		= null;

	this.mParent			= _parent;
	this.mShowMax			= showMax;
};


WorldTownScreenAssets.prototype.getValues = function ()
{
	return this.mParent.mAssetValues;
};

WorldTownScreenAssets.prototype.createImageButton = function (_parentDiv, _imagePath, _callback)
{
	var layout = $('<div class="l-assets-container"/>');
	var image = $('<img/>');
	image.attr('src', _imagePath);
	layout.append(image);
	var text = $('<div class="label text-font-small font-bold font-bottom-shadow font-color-assets-positive-value"/>');
	layout.append(text);

	if (_callback === undefined)
	{
		_parentDiv.append(layout);
		return layout;
	}
	else
	{
		return _parentDiv.createCustomButton(layout, _callback, '', 2);
	}
};

WorldTownScreenAssets.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	this.mMoneyAsset = this.createAssetDIV(_parentDiv, Path.GFX + Asset.ICON_ASSET_MONEY, 'is-money');
	this.mFoodAsset = this.createAssetDIV(_parentDiv, Path.GFX + Asset.ICON_ASSET_FOOD, 'is-food');
	this.mAmmoAsset = this.createAssetDIV(_parentDiv, Path.GFX + Asset.ICON_ASSET_AMMO, 'is-ammo');
	this.mSuppliesAsset = this.createAssetDIV(_parentDiv, Path.GFX + Asset.ICON_ASSET_SUPPLIES, 'is-supplies');
	this.mMedicineAsset = this.createAssetDIV(_parentDiv, Path.GFX + Asset.ICON_ASSET_MEDICINE, 'is-medicine');

	var assetContainer = $('<div class="l-tab-asset is-brothers"></div>');
	this.mBrothersAsset = this.createImageButton(assetContainer, Path.GFX + Asset.ICON_ASSET_BROTHERS, function()
	{
		self.mParent.notifyBackendBrothersButtonPressed();
	});
	_parentDiv.append(assetContainer);
};

WorldTownScreenAssets.prototype.destroyDIV = function ()
{
	this.mMoneyAsset.remove();
	this.mMoneyAsset = null;
	this.mFoodAsset.remove();
	this.mFoodAsset = null;
	this.mAmmoAsset.remove();
	this.mAmmoAsset = null;
	this.mSuppliesAsset.remove();
	this.mSuppliesAsset = null;
	this.mMedicineAsset.remove();
	this.mMedicineAsset = null;
	this.mBrothersAsset.remove();
	this.mBrothersAsset = null;
};

WorldTownScreenAssets.prototype.createAssetDIV = function (_parentDiv, _imagePath, _classExtra)
{
	var layout = $('<div class="l-tab-asset"/>');
	layout.addClass(_classExtra);
	_parentDiv.append(layout);

	var image = $('<img/>');
	image.attr('src', _imagePath);
	layout.append(image);
	var text = $('<div class="label text-font-normal font-color-assets-positive-value"/>');
	layout.append(text);

	return layout;
};

WorldTownScreenAssets.prototype.bindTooltips = function ()
{
	this.mMoneyAsset.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.Money });
	this.mFoodAsset.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.Food });
	this.mAmmoAsset.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.Ammo });
	this.mSuppliesAsset.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.Supplies });
	this.mMedicineAsset.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.Medicine });
	this.mBrothersAsset.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.Brothers });
};

WorldTownScreenAssets.prototype.unbindTooltips = function ()
{
	this.mMoneyAsset.unbindTooltip();
	this.mFoodAsset.unbindTooltip();
	this.mAmmoAsset.unbindTooltip();
	this.mSuppliesAsset.unbindTooltip();
	this.mMedicineAsset.unbindTooltip();
	this.mBrothersAsset.unbindTooltip();
};

WorldTownScreenAssets.prototype.updateAssetValue = function (_container, _value, _valueMax, _valueDifference)
{
	var label = _container.find('.label:first');

	if(label.length > 0)
	{
		if(_valueMax !== undefined && _valueMax !== null)
		{
			label.html('' + Helper.numberWithCommas(_value) + '/' + Helper.numberWithCommas(_valueMax));
		}
		else
		{
			label.html(Helper.numberWithCommas(_value));
		}

		if(_valueDifference !== null && _valueDifference !== 0)
		{
			label.animateValueAndFadeOut(_valueDifference < 0, function (_element)
			{
				_element.html(_valueDifference);
			});
		}

		if(_value <= 0)
		{
			label.removeClass('font-color-assets-positive-value').addClass('font-color-assets-negative-value');
		}
		else
		{
			label.removeClass('font-color-assets-negative-value').addClass('font-color-assets-positive-value');
		}
	}
};

WorldTownScreenAssets.prototype.loadFromData = function (_data)
{
	if(_data === undefined || _data === null || !(typeof(_data) === 'object'))
	{
		return;
	}

	var value = null;
	var previousValue = null;
	var valueDifference = null;
	var currentAssetInformation = _data;
	var previousAssetInformation = this.getValues();

	if('Money' in currentAssetInformation && currentAssetInformation['Money'] !== null)
	{
		value = currentAssetInformation['Money'];
		valueDifference = null;
		if(previousAssetInformation !== null && 'Money' in previousAssetInformation && previousAssetInformation['Money'] !== null)
		{
			previousValue = previousAssetInformation['Money'];
			valueDifference = value - previousValue;
		}

		this.updateAssetValue(this.mMoneyAsset, value, null, valueDifference);
	}

	if('Food' in currentAssetInformation && currentAssetInformation['Food'] !== null)
	{
		value = currentAssetInformation['Food'];
		valueDifference = null;
		if(previousAssetInformation !== null && 'Food' in previousAssetInformation && previousAssetInformation['Food'] !== null)
		{
			previousValue = previousAssetInformation['Food'];
			valueDifference = value - previousValue;
		}

		this.updateAssetValue(this.mFoodAsset, value, null, valueDifference);
	}

	if('Ammo' in currentAssetInformation && currentAssetInformation['Ammo'] !== null)
	{
		value = currentAssetInformation['Ammo'];
		valueDifference = null;
		if(previousAssetInformation !== null && 'Ammo' in previousAssetInformation && previousAssetInformation['Ammo'] !== null)
		{
			previousValue = previousAssetInformation['Ammo'];
			valueDifference = value - previousValue;
		}

		var max = null;
		if (this.mShowMax && 'AmmoMax' in currentAssetInformation && currentAssetInformation['AmmoMax'] !== null)
		{
			max =  currentAssetInformation['AmmoMax'];
		}

		this.updateAssetValue(this.mAmmoAsset, value, max, valueDifference);
	}
	
	if('Supplies' in currentAssetInformation && currentAssetInformation['Supplies'] !== null)
	{
		value = currentAssetInformation['Supplies'];
		valueDifference = null;
		if(previousAssetInformation !== null && 'Supplies' in previousAssetInformation && previousAssetInformation['Supplies'] !== null)
		{
			previousValue = previousAssetInformation['Supplies'];
			valueDifference = value - previousValue;
		}

		var max = null;
		if (this.mShowMax && 'SuppliesMax' in currentAssetInformation && currentAssetInformation['SuppliesMax'] !== null)
		{
			max =  currentAssetInformation['SuppliesMax'];
		}

		this.updateAssetValue(this.mSuppliesAsset, value, max, valueDifference);
	}
	
	if('Medicine' in currentAssetInformation && currentAssetInformation['Medicine'] !== null)
	{
		value = currentAssetInformation['Medicine'];
		valueDifference = null;
		if(previousAssetInformation !== null && 'Medicine' in previousAssetInformation && previousAssetInformation['Medicine'] !== null)
		{
			previousValue = previousAssetInformation['Medicine'];
			valueDifference = value - previousValue;
		}

		var max = null;
		if (this.mShowMax && 'MedicineMax' in currentAssetInformation && currentAssetInformation['MedicineMax'] !== null)
		{
			max =  currentAssetInformation['MedicineMax'];
		}

		this.updateAssetValue(this.mMedicineAsset, value, max, valueDifference);
	}
	
	if('Brothers' in currentAssetInformation && 'BrothersMax' in currentAssetInformation &&
		currentAssetInformation['Brothers'] !== null && currentAssetInformation['BrothersMax'] !== null)
	{

		value = currentAssetInformation['Brothers'];
		var maxValue = currentAssetInformation['BrothersMax'];
		valueDifference = null;
		if(previousAssetInformation !== null && 'Brothers' in previousAssetInformation && previousAssetInformation['Brothers'] !== null)
		{
			previousValue = previousAssetInformation['Brothers'];
			valueDifference = value - previousValue;
		}

		this.updateAssetValue(this.mBrothersAsset, value, maxValue, valueDifference);
	}

	this.mParent.mAssetValues = currentAssetInformation;
};