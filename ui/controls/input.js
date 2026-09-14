/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 *
 *  @Author:		Overhype Studios
 *  @Date:			01.10.2017
 *  @Description:	Input Control JS
 */
"use strict";


/**
 * Create Input Control
 */
 $.fn.createInput = function(_text, _minLength, _maxLength, _tabIndex, _inputUpdatedCallback, _classes, _acceptCallback, _inputid, _inputClickCallback)
 {
	var minLength = _minLength || 0;
	var maxLength = _maxLength || null;
	var tabIndex = _tabIndex || null;

	var result = $('<input type="text" class="ui-control"/>');
	var data = { minLength: _minLength || 0, maxLength: _maxLength || null, inputUpdatedCallback: null, acceptCallback: null, inputDenied: false };

	if (_inputid == 2)
	{
		result.css('background-image', 'url("coui://gfx/ui/skin/input_2_default.png")');
		result.css('background-size', '12.4rem 2.8rem');
		result.css('text-align', 'center');
	}
	else if (_inputid == 3)
	{
		result.css('background-image', 'url("coui://gfx/ui/skin/input_3_default.png")');
		result.css('background-size', '5.6rem 2.8rem');
		result.css('text-align', 'center');
	}
	else if (_inputid == 4)
	{
		result.css('background-image', 'url("coui://gfx/ui/skin/input_4_default.png")');
		result.css('background-size', '20.0rem 2.8rem');
		result.css('text-align', 'center');
	}
	else if (_inputid == 5)
	{
		result.css('background-image', 'url("coui://gfx/ui/skin/input_5_default.png")');
		result.css('background-size', '45.0rem 2.8rem');
		result.css('text-align', 'center');
	}

/* 	result.attr('style', 'background-size: 9.8rem 4.3rem")');
	result.attr('style', 'background-image: url("coui://gfx/ui/skin/button_02_hovered.png")'); */

	if (maxLength !== null)
	{
		result.attr('maxlength', maxLength);
	}

	if (tabIndex !== null)
	{
		result.attr('tabindex', tabIndex);
	}

	if (_classes !== undefined && _classes !== null && typeof(_classes) === 'string')
	{
		result.addClass(_classes);
	}

	if (_inputUpdatedCallback !== undefined && jQuery.isFunction(_inputUpdatedCallback))
	{
		data.inputUpdatedCallback = _inputUpdatedCallback;
	}

	if (_acceptCallback !== undefined && jQuery.isFunction(_acceptCallback))
	{
		data.acceptCallback = _acceptCallback;
	}

/* 	result.onmouseover = function ()
	{
		var imgstringa = 'url("coui://gfx/ui/skin/button_0'+2+'_inactive.png")';
		result.css('background-image', imgstringa);
		result.css('background-size', '9.8rem 4.3rem');
	};
	 */
	result.on('mouseover.input', null, result, function (_event)
	{
		if (_inputid == 2)
		{
			result.css('background-image', 'url("coui://gfx/ui/skin/input_2_active.png")');
		}
		else if (_inputid == 3)
		{
			result.css('background-image', 'url("coui://gfx/ui/skin/input_3_active.png")');
		}
		else if (_inputid == 4)
		{
			result.css('background-image', 'url("coui://gfx/ui/skin/input_4_active.png")');
		}
		else if (_inputid == 5)
		{
			result.css('background-image', 'url("coui://gfx/ui/skin/input_5_active.png")');
		}
	});

	result.on('mouseout.input', null, result, function (_event)
	{
		if (_inputid == 2)
		{
			result.css('background-image', 'url("coui://gfx/ui/skin/input_2_default.png")');
		}
		else if (_inputid == 3)
		{
			result.css('background-image', 'url("coui://gfx/ui/skin/input_3_default.png")');
		}
		else if (_inputid == 4)
		{
			result.css('background-image', 'url("coui://gfx/ui/skin/input_4_default.png")');
		}
		else if (_inputid == 5)
		{
			result.css('background-image', 'url("coui://gfx/ui/skin/input_5_default.png")');
		}
	});

	result.on('click.input', null, result, function (_event)
	{
		if(_inputClickCallback !== undefined && jQuery.isFunction(_inputClickCallback))
		{
			_inputClickCallback($(this));
		}
	});

	result.on('focusout.input', null, result, function (_event)
	{
		if (_inputid == 2 || _inputid == 3 || _inputid == 4 || _inputid == 5)
		{
 			if(_acceptCallback !== undefined && jQuery.isFunction(_acceptCallback))
 			{
				_acceptCallback($(this));
			}
		}
	});

	// input handler
	result.on('keydown.input', null, result, function (_event)
	{
		var code = _event.which || _event.keyCode;

		if (code === KeyConstants.Tabulator ||
			code === KeyConstants.ArrowLeft ||
			code === KeyConstants.ArrowRight ||
			code === KeyConstants.ArrowUp ||
			code === KeyConstants.ArrowDown
			)
		{
			return true;
		}

		// allow only special keys
		if (code < KeyConstants.Zero ||
			code > KeyConstants.Z)
		{
			if (code !== KeyConstants.Backspace &&
				code !== KeyConstants.Delete &&
				code !== KeyConstants.Space
				)
			{
				return false;
			}
		}

		var self = _event.data;
		var data = self.data('input');
		var textLength = self.getInputTextLength();
		var assumedTextLength = textLength;
		var inputDenied = false;
		if (code === KeyConstants.Backspace || code === KeyConstants.Delete)
		{
			if (minLength > 0)
			{
				inputDenied = ((textLength-1) < data.minLength);
			}

			if (inputDenied !== true)
			{
				assumedTextLength -= 1;
			}
		}
		else if (_event[KeyModiferConstants.CtrlKey] === true && (code === KeyConstants.A || code === KeyConstants.C))
		{
			// Do Nothing. Ctrl+A/C should never count as increasing the assumetTextLength
		}
		else
		{
			inputDenied = ((textLength+1) > data.maxLength);

			if (inputDenied === false)
			{
				assumedTextLength += 1;
			}
		}

		if (_event[KeyModiferConstants.CtrlKey] === true && code === KeyConstants.V && data.inputDenied === true)
		{
			inputDenied = true;
		}

		if (inputDenied === true)
		{
			var wasAlreadyDenied = data.inputDenied;
			if (wasAlreadyDenied === undefined || wasAlreadyDenied === false)
			{
				data.inputDenied = true;

				self.shakeLeftRight(3);
			}

			_event.preventDefault();
			_event.stopPropagation();
			//return false;
		}
		if (_event[KeyModiferConstants.CtrlKey] === true && code === KeyConstants.V)
		{
			data.inputDenied = true;
		}

		self.data('input', data);

		if (_inputUpdatedCallback !== undefined && jQuery.isFunction(_inputUpdatedCallback))
		{
			_inputUpdatedCallback($(this), assumedTextLength);
		}

		return !inputDenied;
	});

	result.on('keyup.input', null, result, function (_event)
	{
		var self = _event.data;
		var data = self.data('input');
		var code = _event.which || _event.keyCode;
		data.inputDenied = false;

		if(code === KeyConstants.Return || code === KeyConstants.Enter)
		{
 			if(_acceptCallback !== undefined && jQuery.isFunction(_acceptCallback))
 			{
				$(this).blur();
				_acceptCallback($(this));
			}

			return;
		}

		if(_inputUpdatedCallback !== undefined && jQuery.isFunction(_inputUpdatedCallback))
		{
			_inputUpdatedCallback($(this), self.getInputTextLength());
		}

		self.data('input', data);
	});

	result.data('input', data);

	this.append(result);

	return result;
};


$.fn.setInputText = function(_text)
{
	var data = this.data('input');
	var newText = _text;
	var textUpdated = false;
	if (newText !== undefined && newText !== null)
	{
		var newTextLength = newText.length;
		if (newTextLength >= data.minLength)
		{
			if (data.maxLength !== null && newTextLength > data.maxLength)
			{
				newText = _text.substring(0, data.maxLength);
				textUpdated = true;
				this.val(newText);
			}
			else
			{
				textUpdated = true;
				this.val(newText);
			}
		}
	}

	if (data.inputUpdatedCallback !== null && textUpdated == true)
	{
		data.inputUpdatedCallback($(this), newText.length);
	}

	return this;
};

$.fn.setInputTextBP = function(_text)
{
	var data = this.data('input');
	var newText = _text;
	var textUpdated = false;
	if (newText !== undefined && newText !== null)
	{
		var newTextLength = newText.length;
		if (newTextLength >= data.minLength)
		{
			textUpdated = true;
			this.val(newText);
		}
	}

	if (data.inputUpdatedCallback !== null && textUpdated == true)
	{
		data.inputUpdatedCallback($(this), newText.length);
	}

	return this;
};

$.fn.getInputText = function()
{
	return this.val();
};

$.fn.getInputTextLength = function()
{
	var value = this.val();
	return value !== undefined && value !== null ? value.length : 0;
};
