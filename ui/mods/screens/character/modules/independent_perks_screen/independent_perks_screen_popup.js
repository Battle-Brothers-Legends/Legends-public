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
var IndependentPerksScreenPopup = function(_parent, _perkTree, _professionTree, _brotherID)
{
	this.mParent = _parent;
	this.mPerkTree = _perkTree;
	this.mProfessionTree = _professionTree;
	this.mBrotherID = _brotherID;

	this.mHeaderModule = null;
	this.mPerksModule = null;
	this.mProfessionModule = null;
	this.mPopupDialog = null;

	this.mSwitchToPerksButton = null;
	this.mSwitchToProfessionsButton = null;
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
	var popup = _parentDiv.createPopupDialog('Perks and Professions', null, null, 'independent-perks-popup-800x720-dialog');
	
	popup.addPopupDialogCancelButton(function (_dialog) {
    	self.mPerksModule.unregister();
    	self.mPerksModule = null;
    	self.mProfessionModule.unregister();
    	self.mProfessionModule = null;
    	self.mPopupDialog = null;
    	_dialog.destroyPopupDialog();
    	_popupHiddenFn();
    }, false);

    var cancelButton = popup.findPopupDialogCancelButton();
    cancelButton.changeButtonText('Close');

    var perksDiv = $('<div class="independent-perks-popup-800x720-dialog-content-container"/>');
    popup.addPopupDialogContent(perksDiv);

    // Prepare Header to switch between Perks and Professions
    this.mHeaderModule = $('<div class="independent-perks-popup-header-module"/>');
    perksDiv.append(this.mHeaderModule);

    var self = this;

    var perksBtn = $('<div class="button-container"/>');
    this.mHeaderModule.append(perksBtn);
    this.mSwitchToPerksButton = perksBtn.createTabTextButton("Perks", function () {
        self.mProfessionModule.hide();
        self.mPerksModule.show();
    }, null, "perks-popup", 1);
    
    var professionsBtn = $('<div class="button-container"/>');
    this.mHeaderModule.append(professionsBtn);
    this.mSwitchToProfessionsButton = professionsBtn.createTabTextButton("Professions", function () {
        self.mPerksModule.hide();
        self.mProfessionModule.show();
    }, null, "perks-popup", 1);
 
	// Populate Perks
    this.mPerksModule = new IndependentPerksScreenModule(perksDiv);
    this.mPerksModule.register(perksDiv);
    this.mPerksModule.loadPerkTreesWithPerkTreeAndBrotherID(this.mPerkTree, this.mBrotherID); // this function does not indicate which perks are active/learnt

    // Populate Profession Perks
    this.mProfessionModule = new CharacterScreenProfessionModule(perksDiv, null);
    this.mProfessionModule.register(perksDiv, true);
    this.mProfessionModule.loadProfessionTreesWithProfessionTreeAndBrotherID(this.mProfessionTree, this.mBrotherID);

    this.mPopupDialog = popup;

    this.mPerksModule.show();
    this.mProfessionModule.hide();
    this.mSwitchToPerksButton.addClass('is-selected');

    return popup;
}