var MSU_switchToPage = ModSettingsScreen.prototype.switchToPage;

ModSettingsScreen.prototype.switchToPage = function (_panel, _page) {
    MSU_switchToPage.call(this, _panel, _page);

    var dialogTitle = this.mDialogContainer.findDialogTitle();
    var saveButtonLabel = this.mDialogContainer.find('.main-save-button .label');
    var content = this.mContainer.findDialogContentContainer();
    var listContainer = content.find('.l-list-container');
    var pageContainer = content.find('.l-page-container');

    if (_page.name === "Campaign Options" || _page.name === "Map Options") {
        dialogTitle.text("New Campaign");
        saveButtonLabel.text("Start Campaign");
        listContainer.hide();
        pageContainer.css('left', '13rem');
    } else {
        dialogTitle.text("Mod Settings");
        saveButtonLabel.text("Save");
        listContainer.show();
        pageContainer.css('left', '26rem');
    }
};