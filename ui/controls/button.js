/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 *
 *  @Author:		Overhype Studios
 *  @Date:			01.10.2017
 *  @Description:	Button Control JS
 */
"use strict";


/**
 * Create Button with Text Label
 */
$.fn.createTextButton = function (_text, _callback, _classes, _size, _imagePath)
 {
	 var result;

	 if(_size === undefined)
		 result = $('<div class="ui-control button text-font-normal"/>');
	 else
		 result = $('<div class="ui-control button-' + _size + ' text-font-normal"/>');

	if (_classes !== undefined && _classes !== null && typeof(_classes) === 'string')
	{
		result.addClass(_classes);
	}

	if (_text !== undefined && _text !== null && typeof(_text) === 'string')
	{
		 var label = $('<span class="label">' + _text + '</span>');
		 result.append(label);
	}

	if (_imagePath !== undefined && _imagePath !== null && typeof (_imagePath) === 'string')
	{
		var image = $('<img/>');
		image.attr('src', _imagePath);
		result.append(image);
	}

	if (_callback !== undefined && _callback !== null && typeof(_callback) === 'function')
	{
		result.on("click", function (_event)
		{
			var disabled = $(this).attr('disabled');
			if (disabled !== null && disabled !== 'disabled')
			{
				_callback($(this), _event);
			}
		});
	}

	result.on("mousedown", function (_e)
	{
		var disabled = $(this).attr('disabled');
		if(disabled !== null && disabled !== 'disabled')
		{
			$(this).addClass('is-selected');
		}
		else
		{
			$(this).removeClass('is-selected');
		}
	});

	result.on("mouseup", function ()
	{
		$(this).removeClass('is-selected');
	});

	result.on("mouseenter", function ()
	{
		var disabled = $(this).attr('disabled');
		if (disabled !== null && disabled !== 'disabled')
		{
			$(this).addClass('is-selected');
		}
		else
		{
			$(this).removeClass('is-selected');
		}
	});

	result.on("mouseleave", function ()
	{
		$(this).removeClass('is-selected');
	});

	this.append(result);

	return result;
};


/**
 * Create Button with own Content
 */
$.fn.createCustomButton = function(_content, _callback, _classes, _size)
{
	var result;

	if (_size === undefined)
		result = $('<div class="ui-control button text-font-normal"/>');
	else
		result = $('<div class="ui-control button-' + _size + ' text-font-normal"/>');

	if (_classes !== undefined && _classes !== null && typeof(_classes) === 'string')
	{
		result.addClass(_classes);
	}

	if (_content !== undefined && _content !== null && typeof(_content) === 'object')
	{
		result.append(_content);
	}

	if (_callback !== undefined && _callback !== null && typeof(_callback) === 'function')
	{
		result.on("click", function ()
		{
			var disabled = $(this).attr('disabled');
			if (disabled !== null && disabled !== 'disabled')
			{
				_callback($(this));
			}
		});
	}

	result.on("mousedown", function ()
	{
		var disabled = $(this).attr('disabled');
		if(disabled !== null && disabled !== 'disabled')
		{
			$(this).addClass('is-selected');
		}
		else
		{
			$(this).removeClass('is-selected');
		}
	});

	result.on("mouseup", function ()
	{
		$(this).removeClass('is-selected');
	});

	result.on("mouseenter", function ()
	{
		var disabled = $(this).attr('disabled');
		if (disabled !== null && disabled !== 'disabled')
		{
			$(this).addClass('is-selected');
		}
		else
		{
			$(this).removeClass('is-selected');
		}
	});

	result.on("mouseleave", function ()
	{
		$(this).removeClass('is-selected');
	});

	this.append(result);

	return result;
};


/**
 * Create Tab-Button with Text Label
 */
$.fn.createTabTextButton = function(_text, _callback, _classes, _groupName, _size)
{
	// find other within same group
	var nextId = null;
	if (_groupName !== undefined && _groupName !== null && typeof(_groupName) === 'string')
	{
		var nextNum = 1;
		var siblings = this.parent().find('div[id^=' + _groupName + '_]');
		if (siblings.length > 0) {
			siblings.each(function(index, element) {
				var sibling = $(element);
				var id = sibling.attr('id').split('_');
				if (id !== null && id.length == 2)
				{
					nextNum = parseInt(id[1]) + 1;
				}
			});
		}

		nextId = _groupName + '_' + nextNum;
	}

	var result;
	if (_size === undefined)
		result = $('<div class="ui-control button text-font-normal"/>');
	else
		result = $('<div class="ui-control button-' + _size + ' text-font-normal"/>');

	if (nextId !== null)
	{
		result.attr('id', nextId);
		result.data('group', _groupName);
	}

	if (_classes !== undefined && _classes !== null && typeof(_classes) === 'string')
	{
		result.addClass(_classes);
	}

	if (_text !== undefined && _text !== null && typeof(_text) === 'string')
	{
		var label = $('<span class="label">' + _text + '</span>');
		result.append(label);
	}

	if (_callback !== undefined && _callback !== null && typeof(_callback) === 'function')
	{
		result.click(function (_event)
		{
			var disabled = $(this).attr('disabled');
			if (disabled !== null && disabled !== 'disabled') {

				// remove selected from all others
				var groupName = $(this).data('group');
				if (groupName !== null && typeof(groupName) === 'string')
				{
					var siblings = $(this).parent().parent().find('div[id^=' + groupName + '_]');
					if (siblings.length > 0) {
						siblings.each(function(index, element) {
							var sibling = $(element);
							sibling.removeClass('is-selected');
						});
					}
				}

				$(this).addClass('is-selected');

				_callback($(this));
			}
		});
	}

	this.append(result);

	return result;
};


$.fn.createImageButton = function(_imagePath, _callback, _classes, _size)
{
	var result;

	if (_size === undefined)
		result = $('<div class="ui-control button"/>');
	else
		result = $('<div class="ui-control button-' + _size + '"/>');

	if (_classes !== undefined && _classes !== null && typeof(_classes) === 'string')
	{
		result.addClass(_classes);
	}

	if (_imagePath !== undefined && _imagePath !== null && typeof(_imagePath) === 'string')
	{
		var image = $('<img/>');
		image.attr('src', _imagePath);
		result.append(image);
	}

	if (_callback !== undefined && _callback !== null && typeof(_callback) === 'function')
	{
		result.click(function (_event)
		{
			var disabled = $(this).attr('disabled');
			if (disabled !== null && disabled !== 'disabled')
			{
				_callback($(this));
			}
		});
	}

	result.on("mousedown", function ()
	{
		var disabled = $(this).attr('disabled');
		if (disabled !== null && disabled !== 'disabled')
		{
			$(this).addClass('is-selected');
		}
		else
		{
			$(this).removeClass('is-selected');
		}
	});

	result.on("mouseup", function ()
	{
		$(this).removeClass('is-selected');
	});

	result.on("mouseenter", function ()
	{
		var disabled = $(this).attr('disabled');
		if (disabled !== null && disabled !== 'disabled')
		{
			$(this).addClass('is-selected');
		}
		else
		{
			$(this).removeClass('is-selected');
		}
	});

	result.on("mouseleave", function ()
	{
		$(this).removeClass('is-selected');
	});

	this.append(result);

	return result;
};


$.fn.findButtonText = function()
{
	var result = this.find('.label:first');
	if (result.length > 0)
	{
		return result;
	}
	return null;
};

$.fn.changeButtonText = function(_text)
{
	var result = this.find('.label:first');
	if (result.length > 0)
	{
		result.html(_text);
	}
	return null;
};

$.fn.findButtonImage = function()
{
	var result = this.find('img:first');
	if (result.length > 0)
	{
		return result;
	}
	return null;
};

$.fn.changeButtonImage = function(_imagePath)
{
	var result = this.find('img:first');
	if (result.length > 0)
	{
		result.attr('src', _imagePath);
	}
	return this;
};


$.fn.selectTabTextButton = function(_value)
{
	var disabled = $(this).attr('disabled');

	if (disabled !== null && disabled !== 'disabled')
	{
		// remove selected from all others
		if (_value === true)
		{
			var groupName = $(this).data('group');
			if (groupName !== null && typeof(groupName) === 'string')
			{
				var siblings = $(this).parent().parent().find('div[id^=' + groupName + '_]');
				if (siblings.length > 0)
				{
					siblings.each(function (index, element)
					{
						var sibling = $(element);
						sibling.removeClass('is-selected');
					});
				}
			}
			this.addClass('is-selected');
			this.trigger('click');
		}
		else
		{
			this.removeClass('is-selected');
		}
	}
	else
	{
		this.removeClass('is-selected');
	}

	return this;
};

$.fn.enableButton = function(_value)
{
	if (_value === true)
	{
		this.removeAttr('disabled');
	}
	else
	{
		this.attr('disabled', 'disabled');
	}
	return this;
};

$.fn.showButton = function(_value)
{
	if (_value === true)
	{
		this.removeClass('display-none');
	}
	else
	{
		this.addClass('display-none');
	}
	return this;
};

$.fn.isEnabled = function()
{
	return typeof($(this).attr('disabled')) == 'undefined' || $(this).attr('disabled') == false;
};
