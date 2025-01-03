/**
 * Adds new css class dynamically
 */
$('head').append($('<style>').html([
	'.tactical-combat-result-screen .loot-panel .row .l-button.is-sort {',
	'    top: 12rem;',
	'    left: 0;',
	'    bottom: 0;',
	'    right: 0;',
	'    width: 5.2rem;',
	'    height: 4.1rem;',
	'    position: absolute;',
	'    margin: auto;',
	'}'
].join('\n')));

/**
 * Adds sort button below 'loot all button'
 */
mod_legends.Hooks.TacticalCombatResultScreenLootPanel_createDIV = TacticalCombatResultScreenLootPanel.prototype.createDIV;
TacticalCombatResultScreenLootPanel.prototype.createDIV = function (_parentDiv) {
	mod_legends.Hooks.TacticalCombatResultScreenLootPanel_createDIV.call(this, _parentDiv);
	var self = this;
	var contentRow = $('.column.is-middle .row.is-content');
	var layout = $('<div class="l-button is-sort"/>');
	contentRow.append(layout);
	this.mSortInventoryButton = layout.createImageButton(Path.GFX + Asset.BUTTON_SORT, function() {
		self.mDataSource.notifyBackendSortButtonClicked();
	}, '', 3);
	this.mSortInventoryButton.bindTooltip({ contentType: 'msu-generic', modId: "mod_legends", elementId: "CombatResult.Sort"});
}

/**
 * Adds connection to sort button
 */
TacticalCombatResultScreenDatasource.prototype.notifyBackendSortButtonClicked = function () {
	var self = this;
	SQ.call(this.mSQHandle, 'onSortButtonClicked', null, function(_data) {
		// i have no clue how to trigger ui update from here, but this seems to work
		self.swapItem(0, 'tactical-combat-result-screen.stash', 0, 'tactical-combat-result-screen.stash');
	});
};
