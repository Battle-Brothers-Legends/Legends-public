var ArenaBroSelectionUIHelper_createRowsDIV = ArenaBroSelectionUIHelper.prototype.createRowsDIV;
ArenaBroSelectionUIHelper.prototype.createRowsDIV = function(_definitions, _parentDiv) {
	if ('CrushingDamage' in _definitions) {
		_definitions.CrushingDamage.IconPath = Path.GFX + Asset.ICON_BLOCK;
		_definitions.CrushingDamage.TooltipId = TooltipIdentifier.CharacterStats.Block;
	}
	ArenaBroSelectionUIHelper_createRowsDIV.call(this, _definitions, _parentDiv);
};

var ArenaBroSelectionUIHelper_setProgressbarValues = ArenaBroSelectionUIHelper.prototype.setProgressbarValues;
ArenaBroSelectionUIHelper.prototype.setProgressbarValues = function(_data) {
	ArenaBroSelectionUIHelper_setProgressbarValues.call(this, _data);
	this.setProgressbarValue(this.mRightStatsRows.CrushingDamage.Progressbar, _data, 'block', 'blockMax', 'blockLabel');
};
