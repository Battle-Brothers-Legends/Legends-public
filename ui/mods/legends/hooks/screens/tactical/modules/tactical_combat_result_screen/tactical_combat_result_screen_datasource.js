/**
 * Adds new css class dynamically for sort button
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

TacticalCombatResultScreenDatasource.prototype.mStashData = null;

mod_legends.Hooks.TacticalCombatResultScreenDatasource_loadStashList = TacticalCombatResultScreenDatasource.prototype.loadStashList;
TacticalCombatResultScreenDatasource.prototype.loadStashList = function (_data, _withoutNotify)
{
	var ret = mod_legends.Hooks.TacticalCombatResultScreenDatasource_loadStashList.call(this, _data, _withoutNotify);
	this.getStashChangeData()
	return ret;
};

mod_legends.Hooks.TacticalCombatResultScreenDatasource_updateStashList = TacticalCombatResultScreenDatasource.prototype.updateStashList;
TacticalCombatResultScreenDatasource.prototype.updateStashList = function (_data)
{
	mod_legends.Hooks.TacticalCombatResultScreenDatasource_updateStashList.call(this, _data);
	this.getStashChangeData()
}

TacticalCombatResultScreenDatasource.prototype.getStashChangeData = function(_callback)
{
	var self = this;
	this.notifyBackendGetStashChangeData(function(res)
	{
		self.mStashData = res;
	});
};

TacticalCombatResultScreenDatasource.prototype.notifyBackendGetStashChangeData = function (_callback)
{
	SQ.call(this.mSQHandle, 'getStashChangeData', null, _callback);
};

/**
 * Adds connection to sort button
 */
TacticalCombatResultScreenDatasource.prototype.notifyBackendSortButtonClicked = function ()
{
	var self = this;
	SQ.call(this.mSQHandle, 'onSortButtonClicked', null, function(_data) {
		// i have no clue how to trigger ui update from here, but this seems to work
		self.swapItem(0, 'tactical-combat-result-screen.stash', 0, 'tactical-combat-result-screen.stash');
	});
};
