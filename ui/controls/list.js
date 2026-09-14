/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 *
 *  @Author:		Overhype Studios
 *  @Date:			01.10.2017
 *  @Description:	Progressbar Control JS
 */

"use strict";


/**
 * Create List
 */
 $.fn.createList = function(_scrollDelta, _classes, _withoutFrame)
 {
	var result = $('<div class="ui-control list has-frame"/>');
	if (_withoutFrame !== undefined && _withoutFrame === true)
	{
		result.removeClass('has-frame');
	}

	if (_classes !== undefined && _classes !== null && typeof(_classes) === 'string')
	{
		result.addClass(_classes);
	}

	var scrollContainer = $('<div class="scroll-container"/>');
	result.append(scrollContainer);

	this.append(result);

	 // NOTE: create scrollbar (must be after the list was appended to the DOM!)
	 result.aciScrollBar({
		 delta: _scrollDelta || 8,
		 lineDelay: 0,
		 lineTimer: 0,
		 pageDelay: 0,
		 pageTimer: 0,
		 bindKeyboard: false,
		 resizable: false,
		 smoothScroll: false
	 });

	return result;
};

$.fn.destroyList = function()
{
	if (this.hasClass('aciScrollBar') !== false)
	{
		this.aciScrollBar('destroy');
	}
	return this;
};

$.fn.findListScrollContainer = function()
{
	var result = this.find('.scroll-container:first');
	if (result.length > 0)
	{
		return result;
	}
	return null;
};

$.fn.showListScrollbar = function(_value)
{
	var result = this.find('.aciSb_bar_v:first');
	if (result.length > 0)
	{
		result.css({ opacity: _value === true ? 1 : 0 });
	}
	return this;
};

$.fn.scrollListToElement = function(_element)
{
	var scrollContainer = this.findListScrollContainer();
	var self = this;

	var element = null;
	if (_element !== undefined)
	{
		element = _element;
	}
	else
	{
		element = scrollContainer.children(':last');
	}

	if (element !== null && element.length > 0)
	{
		// force the renderer to relayout his shit...
		/*var offsets = element[0].offsetTop;
		offsets = this[0].offsetTop;
		offsets = scrollContainer[0].offsetTop;*/
		var self = this;

		var timerHandle = this.data('scroll-timer');
		if (timerHandle !== null)
		{
			clearTimeout(timerHandle);
		}

		/*console.info("offset().top: " + element.offset().top);
		console.info("offsetTop: " + element[0].offsetTop);*/

		//self.trigger('scroll', { top: element[0].offsetTop, duration: 1, animate: 'linear', scrollTo: 'bottom' });
		//self.trigger('scroll', { top: element.offset().top, duration: 1, animate: 'linear', scrollTo: 'bottom' });
		self.trigger('scroll', { element: element, center: true, duration: 1, animate: 'linear', scrollTo: 'bottom' });
		self.trigger('update', true);

		/*timerHandle = setTimeout(function()
		{
			// force the renderer to relayout his shit...
			/*var offsets = element[0].offsetTop;
			offsets = self[0].offsetTop;
			offsets = scrollContainer[0].offsetTop;*/

			//scrollContainer.trigger('scroll', { top: element[0].offsetTop, duration: 0, animate: true, scrollTo: 'bottom' });
			//self.trigger('scroll', { top: element.offset().top, duration: 1, animate: 'linear', scrollTo: 'bottom' });
			/*self.trigger('scroll', { element: element, duration: 1, animate: 'linear', scrollTo: 'bottom' });
			self.trigger('update', true);
		}, 10);

		this.data('scroll-timer', timerHandle);*/
	}

	return this;
};

$.fn.scrollListToBottom = function ()
{
	var scrollContainer = this.findListScrollContainer();
	var element = scrollContainer.children(':last');

	// force the renderer to relayout his shit...
	var offsets = element[0].offsetTop;
	offsets = this[0].offsetTop;
	offsets = scrollContainer[0].offsetTop;
	var self = this;

	self.trigger('scroll', { top: element[0].offsetTop, duration: 1, animate: 'linear', scrollTo: 'bottom' });
	self.trigger('update', true);

	return this;
};

$.fn.deselectListEntries = function()
{
	var result = this.find('.scroll-container:first');
	if (result.length > 0)
	{
		result.find('.is-selected').each(function (index, element)
		{
			$(element).removeClass('is-selected');
		});
	}
	return this;
};

$.fn.findFirstSelectedListEntry = function()
{
	var result = null;
	var container = this.find('.scroll-container:first');
	if (container.length > 0)
	{
		container.find('.is-selected').each(function (index, element)
		{
			result = $(element);
			return false;
		});
	}
	return result;
};

$.fn.findListEntryByIndex = function(_index, _class)
{
	if (_class === undefined)
	{
		_class = '.list-entry';
	}
	var container = this.find('.scroll-container:first');
	if (container.length > 0)
	{
		var entries = container.find(_class);
		if (entries.length > 0 && _index >= 0 && _index < entries.length)
		{
			return $(entries[_index]);
		}
	}
	return null;
};

$.fn.removeListEntryByIndex = function(_index)
{
	var container = this.find('.scroll-container:first');
	if (container.length > 0)
	{
		var entries = container.find('.list-entry');
		if (entries.length > 0 && _index >= 0 && _index < entries.length)
		{
			var entry = $(entries[_index]);
			entry.remove();
			return entry;
		}
	}
	return null;
};

$.fn.getListEntryCount = function()
{
	var container = this.find('.scroll-container:first');
	if (container.length > 0)
	{
		var entries = container.find('.list-entry');
		return entries.length;
	}
	return 0;
};