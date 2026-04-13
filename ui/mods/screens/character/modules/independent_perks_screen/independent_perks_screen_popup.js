/**
 *	Uses independent_perks_screen_module to provide an out-of-the-box popup of the independent perks screen
 *
 *	Does not indicate which perks are active/learnt
 */
"use strict";

/**
 * @param {jQuery}	_parent 	- The jQuery object of the parent div
 * @param {Object}	_perkTree	- Perk Tree data of a character
 * @param {number}	_brotherID	- ID of the character to display the perks of
 */
var IndependentPerksScreenPopup = function(_parent, _perkTree, _brotherID)
{
	this.mParent = _parent;
	this.mPerkTree = _perkTree;
	this.mBrotherID = _brotherID;

	this.mPerksModule = null;
	this.mPopupDialog = null;
}

/**
 *	Create and return a popup containing the independent perks module
 *	
 * 	@param {jQuery} 	_parentDiv 		- The jQuery object of the parent div to append the popup div to
 * 	@param {Function}	_popupVisibleFn - A function that will be called when the popup is visible; meant for the parent div's module to signal to backend that a popup is visible, as seen in other direct uses of popup dialogs
 * 	@param {Function}	_popupHiddenFn	- A function that will be called when the popup is hidden; meant for the parent div's module to signal to backend that a popup is hidden, as seen in other direct uses of popup dialogs
 * 	@returns {jQuery}	A jQuery object of the popup dialog; The popup will appear in-game in the process
 */
IndependentPerksScreenPopup.prototype.createPopupDialog = function(_parentDiv, _popupVisibleFn, _popupHiddenFn)
{
	_popupVisibleFn();
	
	var self = this;
	var popup = _parentDiv.createPopupDialog('Perks', null, null, 'independent-perks-popup-800x720-dialog');
	
	popup.addPopupDialogCancelButton(function (_dialog) {
    	self.mPerksModule.unregister();
    	self.mPerksModule = null;
    	self.mPopupDialog = null;
    	_dialog.destroyPopupDialog();
    	_popupHiddenFn();
    }, false);

    var cancelButton = popup.findPopupDialogCancelButton();
    cancelButton.changeButtonText('Close');

    var perksDiv = $('<div class="independent-perks-popup-800x720-dialog-content-container"/>');
    popup.addPopupDialogContent(perksDiv);

	// Populate Perks
    this.mPerksModule = new IndependentPerksScreenModule(perksDiv);
    this.mPerksModule.register(perksDiv);
    this.mPerksModule.loadPerkTreesWithPerkTreeAndBrotherID(this.mPerkTree, this.mBrotherID); // this function does not indicate which perks are active/learnt

    this.mPopupDialog = popup;
    return popup;
}