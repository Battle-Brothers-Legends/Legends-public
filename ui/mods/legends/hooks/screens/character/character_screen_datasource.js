mod_legends.Hooks.CharacterScreenDatasource_getSelectedBrother = CharacterScreenDatasource.prototype.getSelectedBrother;
CharacterScreenDatasource.prototype.getSelectedBrother = function ()
{
	var brother = mod_legends.Hooks.CharacterScreenDatasource_getSelectedBrother.call(this);
	if (brother == null) {
		this.notifyBackendBrotherSelected(null);
	} else {
		this.notifyBackendBrotherSelected(brother[CharacterScreenIdentifier.Entity.Id]);
	}
	return brother;
};

CharacterScreenDatasource.prototype.notifyBackendBrotherSelected = function (_brotherID) {
	if (this.mSQHandle !== null) {
		SQ.call(this.mSQHandle, 'onBrotherSelected', _brotherID);
	}
};
