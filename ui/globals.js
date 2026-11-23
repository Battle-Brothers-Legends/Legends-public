/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 *
 *  @Author:		Overhype Studios
 *  @Date:			15.02.2017
 *  @Description:	Global UI JS Stuff
 */


/*
	Constants
 */
var Constants =
{
	BROWSER_MODE: false, // true if the UI is running within a Browser

    SCREEN_FADE_IN_OUT_DELAY: 300,
    SCREEN_SLIDE_IN_OUT_DELAY: 400,
    MODULE_FADE_IN_OUT_DELAY: 400,
    CONTENT_ROLL_IN_OUT_DELAY: 200,

    SHAKE_LEFT_RIGHT_DELAY: 80,
    MOVE_VALUE_UP_DOWN_AND_FADE_OUT_DELAY: 600,

    PROGRESSBAR_CHANGE_DELAY: 400,


    /* Game Related Constants */
	Game:
	{
        MIN_ACTION_POINTS_NEEDED_TO_SWAP_ITEMS: 4,

        MAX_BACKPACK_SLOTS: 4,

        MIN_BROTHER_NAME_LENGTH: 1,
        MAX_BROTHER_NAME_LENGTH: 16,
        MIN_BROTHER_TITLE_LENGTH: 0,
        MAX_BROTHER_TITLE_LENGTH: 16,

        MAX_STATS_INCREASE_COUNT: 3,

		MAX_CAMPING_PRESET_NAME_LENGTH: 70
    }
};


/*
	Game Information
 */
var GameInformation = {
	websiteURL: 'www.battlebrothersgame.com'
};


/*
    Helper to get the JS Callstack
    TODO: console überschreiben und Callstack an/ab schaltbar machen!
 */
var queryStackTrace = function() {
    /*
    var obj = {};
    Error.captureStackTrace(obj, queryStackTrace);
    return obj.stack;
    */
    return Error().stack;
};

var ResponseCode =
{
    // Global UI Response Codes
    CanSwap: 0,
    ConfirmReplaceSwap: 1,
    ConfirmNoReplaceSwap: 2,
    DoNotSwap: 3
};
