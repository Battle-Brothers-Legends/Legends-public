WorldScreen.prototype.mCurrentPopupDialog = null;
WorldScreen.prototype.mIsPopupOpen = false;

WorldScreen.prototype.notifyBackendDevConsoleIsVisible = function (_visible)
{
	this.mIsPopupOpen = _visible;
	SQ.call(this.mSQHandle, 'onDevConsoleIsVisible', [_visible]);
};

WorldScreen.prototype.showDevConsole = function (_immediately)
{
	var self = this;
	self.notifyBackendDevConsoleIsVisible(true);
	self.mCurrentPopupDialog = $('.dialog-container').createPopupDialog('Dev Input', null, null, 'dev-input-popup');

	self.mCurrentPopupDialog.addPopupDialogOkButton(function (_dialog)
	{
		var contentContainer = _dialog.findPopupDialogContentContainer();
		var inputFields = contentContainer.find('input');
		SQ.call(self.mSQHandle, 'onDevConsoleCommand', [ $(inputFields[0]).getInputText(),  $(inputFields[1]).getInputText()]);

		self.mCurrentPopupDialog = null;
		_dialog.destroyPopupDialog();
		self.notifyBackendDevConsoleIsVisible(false);
	});

	self.mCurrentPopupDialog.addPopupDialogCancelButton(function (_dialog)
	{
		self.mCurrentPopupDialog = null;
		_dialog.destroyPopupDialog();
		self.notifyBackendDevConsoleIsVisible(false);
	});

	self.mCurrentPopupDialog.addPopupDialogContent(self.createDevConsoleContent(self.mCurrentPopupDialog));

	// focus!
	var inputFields = self.mCurrentPopupDialog.findPopupDialogContentContainer().find('input');
	$(inputFields[0]).focus();

};


WorldScreen.prototype.hideDevConsole = function (_immediately)
{
	if (this.mCurrentPopupDialog)
	{
		this.mCurrentPopupDialog.destroyPopupDialog();
		this.mCurrentPopupDialog = null;
		this.notifyBackendDevConsoleIsVisible(false);
	}
};

WorldScreen.prototype.createDevConsoleContent = function (_dialog)
{
	var result = $('<div class="dev-input-container"/>');

	// create & set name
	var row = $('<div class="row"/>');
	result.append(row);
	var label = $('<div class="label text-font-normal font-color-label font-bottom-shadow">Command</div>');
	row.append(label);

	var inputLayout = $('<div class="l-input"/>');
	row.append(inputLayout);
	inputLayout.createInput('', 0, 1024, 1, null, 'title-font-big font-bold font-color-brother-name', function (_input)
	{
		var button = _dialog.findPopupDialogOkButton();
		button.click();
	});

	row = $('<div class="row"/>');
	result.append(row);
	label = $('<div class="label text-font-normal font-color-label font-bottom-shadow">Arguments</div>');
	row.append(label);

	inputLayout = $('<div class="l-input"/>');
	row.append(inputLayout);
	inputLayout.createInput('',0, 255, 2, null, 'title-font-big font-bold font-color-brother-name', function (_input)
	{
		var button = _dialog.findPopupDialogOkButton();
		button.click();
	});

	return result;
};
