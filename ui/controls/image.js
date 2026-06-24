/*
 *  @Project:		Untitled Project
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 *
 *  @Author:		Overhype Studios
 *  @Date:			01.10.2017
 *  @Description:	jquery extensions: Image
 */
"use strict";


/**
 * Create Fullscreen Image which resizes with Screen
 */
/*
 $.fn.createFullscreenImage = function(_imagePath, _loadCallback, _classes)
 {
    var result = $('<img/>');

    if (_classes !== undefined && _classes !== null && typeof(_classes) === 'string')
    {
        result.addClass(_classes);
    }

    result.load(function() {
        result.centerToParent();
        if (jQuery.isFunction(_loadCallback))
        {
             _loadCallback(result);
        }
    });

    if (_imagePath !== undefined && _imagePath !== null && typeof(_imagePath) === 'string')
    {
        result.attr('src', _imagePath);
    }

    $(window).resize(function() {
        result.centerToParent();
    });

    this.append(result);

    return result;
};
*/

/**
 * Create Image
 */
$.fn.createImage = function (_imagePath, _loadCallback, _resizeCallback, _classes) {
    var result = $('<img/>');

    if (_classes !== undefined && _classes !== null && typeof (_classes) === 'string') {
        result.addClass(_classes);
    }

    if (_loadCallback !== undefined && _loadCallback !== null && jQuery.isFunction(_loadCallback)) {
        result.load(function () {
            _loadCallback(result);
        });
    }

    if (_imagePath !== undefined && _imagePath !== null && typeof (_imagePath) === 'string') {
        result.attr('src', _imagePath);
    }

    if (_resizeCallback !== undefined && _resizeCallback !== null && jQuery.isFunction(_resizeCallback)) {
        $(window).resize(function () {
            _resizeCallback(result);
        });
    }

    this.append(result);

    return result;
};

/**
 * Center Image within its parent
 */
$.fn.centerImageWithinParent = function (_offsetX, _offsetY, _scale, _fitImage) {
    var offsetX = _offsetX || 0;
    var offsetY = _offsetY || 0;
    var scale = _scale || 1.0;
    var fitImage = _fitImage === undefined || _fitImage === true;

    var parent = this.parent();
    var newWidth = this[0].naturalWidth * scale;
    var newHeight = this[0].naturalHeight * scale;

    // fit image so it doesn't get distorted
    if (fitImage && (newWidth > parent.innerWidth() || newHeight > parent.innerHeight())) {
        if (parent.innerWidth() / newWidth < parent.innerHeight() / newHeight) {
            newHeight *= parent.innerWidth() / newWidth;
            newWidth = parent.innerWidth();
        }
        else if (parent.innerWidth() / newWidth > parent.innerHeight() / newHeight) {
            newWidth *= parent.innerHeight() / newHeight;
            newHeight = parent.innerHeight();
        }
        else {
            newWidth = parent.innerWidth();
            newHeight = parent.innerHeight();
        }
    }

    var marginLeft = (parent.innerWidth() - newWidth + offsetX) / 2;
    var marginTop = (parent.innerHeight() - newHeight + offsetY) / 2;

    this.css({ 'width': newWidth, 'height': newHeight, 'margin-left': marginLeft, 'margin-top': marginTop });

    return this;
};

/**
 *	Fits Image within its parent while keeping the aspect ratio
 **/
$.fn.fitImageToParent = function (_offsetX, _offsetY) {
    var offsetX = _offsetX || 0;
    var offsetY = _offsetY || 0;
    var scale = 1.0;

    var parent = this.parent();
    var parentWidth = parent.innerWidth();
    var parentHeight = parent.innerHeight();
    var imageWidth = this[0].naturalWidth;
    var imageHeight = this[0].naturalHeight;

    if (parentWidth >= parentHeight) {
        scale = parentWidth / imageWidth;
    }
    else {
        scale = parentHeight / imageHeight;
    }

    imageWidth = imageWidth * scale;
    imageHeight = imageHeight * scale;
    var marginLeft = (parentWidth - imageWidth + offsetX) / 2;
    var marginTop = (parentHeight - imageHeight + offsetY) / 2;

    this.css({ 'width': imageWidth, 'height': imageHeight, 'margin-left': marginLeft, 'margin-top': marginTop });

    return this;
};


/* bla */
$.fn.scaleImage = function (_scale, _offsetX, _offsetY) {
    var offsetX = _offsetX || 0;
    var offsetY = _offsetY || 0;
    var scale = _scale || 1.0;

    var newWidth = this[0].naturalWidth * scale;
    var newHeight = this[0].naturalHeight * scale;

    var marginLeft = offsetX;
    var marginTop = offsetY;

    this.css({ 'width': newWidth, 'height': newHeight, 'margin-left': marginLeft, 'margin-top': marginTop });

    return this;
};