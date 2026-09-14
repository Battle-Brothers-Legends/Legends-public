/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2015
 *
 *  @Author:		Overhype Studios
 *  @Date:			12.01.2015
 *  @Description:	Campaign List Control JS
 */
"use strict";

/**
 * Create List Campaign
 */
$.fn.createListCampaign = function(_campaignData, _classes)
{
	var result = $('<div class="ui-control campaign"/>');

	if (_classes !== undefined && _classes !== null && typeof(_classes) === 'string')
	{
		result.addClass(_classes);
	}

	var innerContainer = $('<div class="inner-container has-slot-frame"/>');
	result.append(innerContainer);


	var leftColumn = $('<div class="column is-left"/>');
	innerContainer.append(leftColumn);

	var rightColumn = $('<div class="column is-right"/>');
	innerContainer.append(rightColumn);

	// image layer
	leftColumn.createImage(Path.GFX + 'ui/banners/banner_01.png', function (_image) {
		_image.removeClass('display-none').addClass('display-block');

		if(_campaignData != null && _campaignData["isIncompatibleVersion"] === true)
			  _image.addClass('is-grayscale');

	}, null, 'display-none is-image');

	if(_campaignData != null && _campaignData["isIncompatibleVersion"] === true)
	{
		// campaign name
		var campaignName = $('<div class="label is-campaign-name title-font-big font-color-disabled font-bold font-bottom-shadow"/>');
		rightColumn.append(campaignName);

		// group name
		var groupName = $('<div class="label is-group-name text-font-normal font-color-disabled font-bottom-shadow"/>');
		rightColumn.append(groupName);

		// day name
		var dayName = $('<div class="label is-day-name text-font-normal font-color-disabled font-bottom-shadow"/>');
		rightColumn.append(dayName);

		// Legends version
		var legendsVersion = $('<div class="label is-legends-version text-font-small font-color-description font-bottom-shadow"/>');
		rightColumn.append(legendsVersion);

		// date time
		var dateTime = $('<div class="label is-date-time text-font-small font-color-disabled font-bottom-shadow"/>');
		rightColumn.append(dateTime);
	}
	else
	{
		 // campaign name
		var campaignName = $('<div class="label is-campaign-name title-font-big font-color-subtitle font-bold font-bottom-shadow"/>');
		rightColumn.append(campaignName);

		// group name
		var groupName = $('<div class="label is-group-name text-font-normal font-color-description font-bottom-shadow"/>');
		rightColumn.append(groupName);

		// day name
		var dayName = $('<div class="label is-day-name text-font-normal font-color-description font-bottom-shadow"/>');
		rightColumn.append(dayName);

		// Legends version
		var legendsVersion = $('<div class="label is-legends-version text-font-small font-color-description font-bottom-shadow"/>');
		rightColumn.append(legendsVersion);

		// date time
		var dateTime = $('<div class="label is-date-time text-font-small font-color-description font-bottom-shadow"/>');
		rightColumn.append(dateTime);
	}

	// add data
	result.data('campaign', _campaignData);

	this.append(result);

	return result;
};

$.fn.assignListCampaignClickHandler = function(_callback)
{
	if (_callback !== undefined && _callback !== null && typeof(_callback) === 'function')
	{
		this.on('click', null, this, function (event) {
			_callback($(this), event);
			return false;
		});
	}
	else
	{
		this.off('click');
	}
};

$.fn.assignListCampaignDoubleClickHandler = function(_callback)
{
	if (_callback !== undefined && _callback !== null && typeof(_callback) === 'function')
	{
		this.on('dblclick', null, this, function (event) {
			_callback($(this), event);
			return false;
		});
	}
	else
	{
		this.off('dblclick');
	}
};

$.fn.assignListImage = function(_value)
{
	var img = this.find('.is-image:first');
	if (img !== undefined && img !== null)
	{
		if(_value !== null && _value != '')
			img.attr('src', Path.GFX + _value);
		else
			img.attr('src', '');
	}
};

$.fn.assignListCampaignName = function(_value)
{
	var label = this.find('.label.is-campaign-name:first');
	if (label.length > 0 && _value !== undefined && _value !== null)
	{
		label.html(_value);
	}
};

$.fn.assignListCampaignGroupName = function(_value)
{
	var label = this.find('.label.is-group-name:first');
	if (label.length > 0 && _value !== undefined && _value !== null)
	{
		label.html(_value);
	}
};

$.fn.assignListCampaignDayName = function(_value)
{
	var label = this.find('.label.is-day-name:first');
	if (label.length > 0 && _value !== undefined && _value !== null)
	{
		label.html(_value);
	}
};

$.fn.assignListCampaignLegendsVersion = function(_value)
{
	var label = this.find('.label.is-legends-version:first');
	if (label.length > 0 && _value !== undefined && _value !== null)
	{
		label.html(_value);
	}
}

$.fn.assignListCampaignDateTime = function(_value)
{
	var label = this.find('.label.is-date-time:first');
	if (label.length > 0 && _value !== undefined && _value !== null)
	{
		label.html(_value);
	}
};


/*
$.fn.assignListBrotherImage = function(_imagePath, _imageOffsetX, _imageOffsetY, _imageScale)
{
	var imageLayer = this.find('.image-layer:first');
	if (imageLayer.length > 0 && _imagePath !== null)
	{
		var image = imageLayer.find('img:first');

		// update data
		var data = this.data('brother') || {};
		data.imageOffsetX = _imageOffsetX || data.imageOffsetX;
		data.imageOffsetY = _imageOffsetY || data.imageOffsetY;
		data.imageScale = _imageScale || data.imageScale;
		this.data('brother', data);

		image.attr('src', _imagePath);
	}
};
*/