/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 *
 *  @Author:		Overhype Studios
 *  @Date:			15.10.2017
 *  @Description:	Tactical Combat Result Screen - Datasource JS
 */
"use strict";


var TacticalCombatResultScreenDatasourceIdentifier = {
    CombatInformation: {
        Loaded: 'combat-information.loaded'
    },

    Statistics: {
        Loaded: 'statistics.loaded'
    },

    Stash: {
        Loaded: 'stash.loaded',
        ItemUpdated: 'stash.item-updated'
    },

    FoundLoot: {
        Loaded: 'found-loot.loaded',
        ItemUpdated: 'found-loot.item-updated'
    },

    Item: {
        Flag: {
            Inserted: 'inserted',
            Removed: 'removed',
            Updated: 'updated'
        }
    }
};


var TacticalCombatResultScreenDatasource = function () {
    this.mSQHandle = null;

    // Event handling
    this.mEventListener = {};

    // Caches
    this.mCombatInformation = null;
    this.mStatistics = null;
    this.mStashList = null;
    this.mFoundLootList = null;

    // init the datasource
    this.init();
};


TacticalCombatResultScreenDatasource.prototype.onConnection = function (_handle) {
    //if (typeof(_handle) == 'string')
    {
        this.mSQHandle = _handle;
    }
};

TacticalCombatResultScreenDatasource.prototype.onDisconnection = function () {
    this.mSQHandle = null;
    this.reset();
};


TacticalCombatResultScreenDatasource.prototype.addListener = function (_chanel, _callback) {
    if (_chanel in this.mEventListener) {
        if (jQuery.inArray(_callback, this.mEventListener[_chanel]) === -1) {
            this.mEventListener[_chanel].push(_callback);
        }
    }
};

TacticalCombatResultScreenDatasource.prototype.removeListener = function (_chanel, _callback) {
    if (_chanel in this.mEventListener) {
        var idx = jQuery.inArray(_callback, this.mEventListener[_chanel]);
        if (idx !== -1) {
            this.mEventListener[_chanel].remove(idx);
        }
    }
};

TacticalCombatResultScreenDatasource.prototype.removeListeners = function () {
    this.createEventChannels();
};

TacticalCombatResultScreenDatasource.prototype.notifyEventListener = function (_chanel, _payload) {
    if (_chanel in this.mEventListener) {
        var listeners = this.mEventListener[_chanel];
        for (var i = 0; i < listeners.length; ++i) {
            listeners[i](this, _payload);
        }
    }
};


TacticalCombatResultScreenDatasource.prototype.createEventChannels = function () {
    this.mEventListener[ErrorCode.Key] = [];

    this.mEventListener[TacticalCombatResultScreenDatasourceIdentifier.CombatInformation.Loaded] = [];
    this.mEventListener[TacticalCombatResultScreenDatasourceIdentifier.Statistics.Loaded] = [];
    this.mEventListener[TacticalCombatResultScreenDatasourceIdentifier.Stash.Loaded] = [];
    this.mEventListener[TacticalCombatResultScreenDatasourceIdentifier.Stash.ItemUpdated] = [];
    this.mEventListener[TacticalCombatResultScreenDatasourceIdentifier.FoundLoot.Loaded] = [];
    this.mEventListener[TacticalCombatResultScreenDatasourceIdentifier.FoundLoot.ItemUpdated] = [];
};


TacticalCombatResultScreenDatasource.prototype.init = function () {
    this.createEventChannels();
};

TacticalCombatResultScreenDatasource.prototype.reset = function () {
    this.mCombatInformation = null;
    this.mStatistics = null;
    this.mStashList = null;
    this.mFoundLootList = null;
};


TacticalCombatResultScreenDatasource.prototype.loadFromData = function (_data, _withoutNotify) {
    if (_data === undefined || _data == null || typeof (_data) !== 'object') {
        console.error('ERROR: Failed to query combat result data. Reason: Invalid result.');
        return;
    }

    if (ErrorCode.Key in _data) {
        this.notifyEventListener(ErrorCode.Key, _data[ErrorCode.Key]);
        return;
    }

    if (TacticalCombatResultScreenIdentifier.QueryResult.CombatInformation in _data) {
        this.loadCombatInformation(_data[TacticalCombatResultScreenIdentifier.QueryResult.CombatInformation], _withoutNotify);
    }

    if (TacticalCombatResultScreenIdentifier.QueryResult.Statistics in _data) {
        this.loadStatistics(_data[TacticalCombatResultScreenIdentifier.QueryResult.Statistics], _withoutNotify);
    }

    if (TacticalCombatResultScreenIdentifier.QueryResult.Stash in _data) {
        this.loadStashList(_data[TacticalCombatResultScreenIdentifier.QueryResult.Stash], _withoutNotify);
    }

    if (TacticalCombatResultScreenIdentifier.QueryResult.FoundLoot in _data) {
        this.loadFoundLootList(_data[TacticalCombatResultScreenIdentifier.QueryResult.FoundLoot], _withoutNotify);
    }
};

TacticalCombatResultScreenDatasource.prototype.loadCombatInformation = function (_data, _withoutNotify) {
    var data = null;
    if (_data !== undefined && _data !== null && typeof (_data) === 'object') {
        var data = _data;
    }
    else {
        data = this.notifyBackendQueryCombatInformation();
        if (data === null) {
            console.error('ERROR: Failed to query combat information data. Reason: Invalid result.');
            return;
        }
    }

    this.mCombatInformation = data;

    // notify every listener
    if (_withoutNotify === undefined || _withoutNotify !== true) {
        this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.CombatInformation.Loaded, this.mCombatInformation);
    }

    return this.mCombatInformation;
};

TacticalCombatResultScreenDatasource.prototype.getCombatInformation = function () {
    if (this.mCombatInformation === null) {
        this.mCombatInformation = this.loadCombatInformation(null, true);
    }

    return this.mCombatInformation;
};


TacticalCombatResultScreenDatasource.prototype.loadStatistics = function (_data, _withoutNotify) {
    var data = null;
    if (_data !== undefined && _data !== null && jQuery.isArray(_data)) {
        var data = _data;
    }
    else {
        data = this.notifyBackendQueryStatistics();
        if (data === null) {
            console.error('ERROR: Failed to query statistics data. Reason: Invalid result.');
            return;
        }
    }

    this.mStatistics = data;

    // notify every listener
    if (_withoutNotify === undefined || _withoutNotify !== true) {
        this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.Statistics.Loaded, this.mStatistics);
    }

    return this.mStatistics;
};

TacticalCombatResultScreenDatasource.prototype.getStatistics = function () {
    if (this.mStatistics === null) {
        this.mStatistics = this.loadStatistics(null, true);
    }

    return this.mStatistics;
};


TacticalCombatResultScreenDatasource.prototype.loadStashList = function (_data, _withoutNotify) {
    this.mStashList = _data;

    // notify every listener
    if (_withoutNotify === undefined || _withoutNotify !== true) {
        this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.Stash.Loaded, this.mStashList);
    }

    return this.mStashList;
};

TacticalCombatResultScreenDatasource.prototype.updateStashList = function (_data) {
    if (_data === null || !jQuery.isArray(_data)) {
        console.error('ERROR: Failed to update stash. Invalid data.');
        return;
    }

    if (this.mStashList === null || !jQuery.isArray(this.mStashList) || this.mStashList.length === 0) {
        this.mStashList = _data;
        this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.Stash.Loaded, this.mStashList);
        return;
    }

    // stash size changed .. shouldn't happen..
    if (this.mStashList.length !== _data.length) {
        console.error('ERROR: Failed to update stash. Stash changed in size.');
        return;
    }

    var forceUpdateSlot = -1;
    if (_data["forceUpdate"] != null) {
        forceUpdateSlot = _data["forceUpdate"]
    }

    // check stash for changes
    for (var i = 0; i < this.mStashList.length; ++i) {
        var sourceItem = this.mStashList[i];
        var targetItem = _data[i];

        // item added to stash slot
        if (sourceItem === null && targetItem !== null) {
            if (TacticalCombatResultScreenIdentifier.Item.Id in targetItem) {
                //console.info('STASH: Item inserted (Index: ' + i + ')');
                this.mStashList[i] = targetItem;
                this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.Stash.ItemUpdated, { item: targetItem, index: i, flag: TacticalCombatResultScreenDatasourceIdentifier.Item.Flag.Inserted });
            }
        }
        // item removed from stash slot
        else if (sourceItem !== null && targetItem === null) {
            //console.info('STASH: Item removed (Index: ' + i + ')');
            this.mStashList[i] = targetItem;
            this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.Stash.ItemUpdated, { item: sourceItem, index: i, flag: TacticalCombatResultScreenDatasourceIdentifier.Item.Flag.Removed });
        }
        else if (i == forceUpdateSlot) {
            this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.Stash.ItemUpdated, { item: targetItem, index: i, flag: TacticalCombatResultScreenDatasourceIdentifier.Item.Flag.Updated });
        }
        // item might have changed within stash slot
        else {
            if ((sourceItem !== null && targetItem !== null) &&
                (TacticalCombatResultScreenIdentifier.Item.Id in sourceItem && TacticalCombatResultScreenIdentifier.Item.Id in targetItem) &&
                (sourceItem[TacticalCombatResultScreenIdentifier.Item.Id] !== targetItem[TacticalCombatResultScreenIdentifier.Item.Id])
            ) {
                //console.info('STASH: Item updated (Index: ' + i + ')');
                this.mStashList[i] = targetItem;
                this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.Stash.ItemUpdated, { item: targetItem, index: i, flag: TacticalCombatResultScreenDatasourceIdentifier.Item.Flag.Updated });
            }
        }
    }
};

TacticalCombatResultScreenDatasource.prototype.getStashList = function () {
    if (this.mStashList === null) {
        this.mStashList = this.loadStashList(null, true);
    }

    return this.mStashList;
};


TacticalCombatResultScreenDatasource.prototype.loadFoundLootList = function (_data, _withoutNotify) {
    this.mFoundLootList = _data;

    // notify every listener
    if (_withoutNotify === undefined || _withoutNotify !== true) {
        this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.FoundLoot.Loaded, this.mFoundLootList);
    }

    return this.mFoundLootList;
};

TacticalCombatResultScreenDatasource.prototype.updateFoundLootList = function (_data) {
    if (_data === null || !jQuery.isArray(_data)) {
        console.error('ERROR: Failed to update found loot. Invalid data.');
        return;
    }

    if (this.mFoundLootList === null || !jQuery.isArray(this.mFoundLootList) || this.mStashList.mFoundLootList === 0) {
        this.mFoundLootList = _data;
        this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.FoundLoot.Loaded, this.mFoundLootList);
        return;
    }

    // found loot list changed in length, this means we removed or added something to / from stash
    if (this.mFoundLootList.length !== _data.length) {
        this.mFoundLootList = _data;
        this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.FoundLoot.Loaded, this.mFoundLootList);
        return;
    }

    // check found loot for changes
    for (var i = 0; i < this.mFoundLootList.length; ++i) {
        var sourceItem = this.mFoundLootList[i];
        var targetItem = _data[i];

        // item added to stash slot
        if (sourceItem === null && targetItem !== null) {
            if (TacticalCombatResultScreenIdentifier.Item.Id in targetItem) {
                //console.info('FOUND LOOT: Item inserted (Index: ' + i + ')');
                this.mFoundLootList[i] = targetItem;
                this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.FoundLoot.ItemUpdated, { item: targetItem, index: i, flag: TacticalCombatResultScreenDatasourceIdentifier.Item.Flag.Inserted });
            }
        }
        // item removed from stash slot
        else if (sourceItem !== null && targetItem === null) {
            //console.info('FOUND LOOT: Item removed (Index: ' + i + ')');
            this.mFoundLootList[i] = targetItem;
            this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.FoundLoot.ItemUpdated, { item: sourceItem, index: i, flag: TacticalCombatResultScreenDatasourceIdentifier.Item.Flag.Removed });
        }
        // item might have changed within stash slot
        else {
            if ((sourceItem !== null && targetItem !== null) &&
                (TacticalCombatResultScreenIdentifier.Item.Id in sourceItem && TacticalCombatResultScreenIdentifier.Item.Id in targetItem) &&
                (sourceItem[TacticalCombatResultScreenIdentifier.Item.Id] !== targetItem[TacticalCombatResultScreenIdentifier.Item.Id])
            ) {
                //console.info('FOUND LOOT: Item updated (Index: ' + i + ')');
                this.mFoundLootList[i] = targetItem;
                this.notifyEventListener(TacticalCombatResultScreenDatasourceIdentifier.FoundLoot.ItemUpdated, { item: targetItem, index: i, flag: TacticalCombatResultScreenDatasourceIdentifier.Item.Flag.Updated });
            }
        }
    }
};

TacticalCombatResultScreenDatasource.prototype.getFoundLootList = function () {
    if (this.mFoundLootList === null) {
        this.mFoundLootList = this.loadFoundLootList(null, true);
    }

    return this.mFoundLootList;
};


TacticalCombatResultScreenDatasource.prototype.swapItem = function (_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _tryToUpgrade) {
    var self = this;
    this.notifyBackendSwapItem(_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _tryToUpgrade, function (data) {
        if (data === undefined || data == null || typeof (data) !== 'object') {
            console.error('ERROR: Failed to swap item. Invalid data result #1.');
            return;
        }

        // check if we have an error
        if (ErrorCode.Key in data) {
            //console.error('ERROR: Failed to swap item. Reason: ' + data[ErrorCode.Key]);
            self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
        }
        else {
            if (!(TacticalCombatResultScreenIdentifier.QueryResult.Stash in data) &&
                !(TacticalCombatResultScreenIdentifier.QueryResult.FoundLoot in data)) {
                console.error('ERROR: Failed to swap item. Invalid data result #2.');
            }
            else {
                if (TacticalCombatResultScreenIdentifier.QueryResult.Stash in data) {
                    if (_tryToUpgrade === true) {
                        data[TacticalCombatResultScreenIdentifier.QueryResult.Stash].forceUpdate = _targetItemIdx;
                    }
                    self.updateStashList(data[TacticalCombatResultScreenIdentifier.QueryResult.Stash]);
                }

                if (TacticalCombatResultScreenIdentifier.QueryResult.FoundLoot in data) {
                    self.updateFoundLootList(data[TacticalCombatResultScreenIdentifier.QueryResult.FoundLoot]);
                }
            }
        }
    });
};

TacticalCombatResultScreenDatasource.prototype.destroyItem = function (_itemIdx, _itemOwner) {
    var data = this.notifyBackendDestroyItem(_itemIdx, _itemOwner);
    if (data === undefined || data == null || typeof (data) !== 'object') {
        console.error('ERROR: Failed to destroy item. Invalid data result #1.');
        return;
    }

    // check if we have an error
    if (ErrorCode.Key in data) {
        //console.error('ERROR: Failed to destroy item. Reason: ' + data[ErrorCode.Key]);
        this.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
    }
    else {
        if (!(TacticalCombatResultScreenIdentifier.QueryResult.Stash in data) &&
            !(TacticalCombatResultScreenIdentifier.QueryResult.FoundLoot in data)) {
            console.error('ERROR: Failed to destroy item. Invalid data result #2.');
        }
        else {
            if (TacticalCombatResultScreenIdentifier.QueryResult.Stash in data) {
                this.updateStashList(data[TacticalCombatResultScreenIdentifier.QueryResult.Stash]);
            }

            if (TacticalCombatResultScreenIdentifier.QueryResult.FoundLoot in data) {
                this.updateFoundLootList(data[TacticalCombatResultScreenIdentifier.QueryResult.FoundLoot]);
            }
        }
    }
};

TacticalCombatResultScreenDatasource.prototype.isStashSpaceLeft = function () {
    for (var i = 0; i < this.mStashList.length; ++i) {
        if (this.mStashList[i] === null) {
            return true;
        }
    }
    return false;
};

TacticalCombatResultScreenDatasource.prototype.getStashStatistics = function () {
    var usedSpace = 0;
    for (var i = 0; i < this.mStashList.length; ++i) {
        if (this.mStashList[i] !== null) {
            ++usedSpace;
        }
    }
    return { size: this.mStashList.length, used: usedSpace };
};

TacticalCombatResultScreenDatasource.prototype.notifyBackendSwapItem = function (_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _tryToUpgrade, _callback) {
    SQ.call(this.mSQHandle, 'onSwapItem', [_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _tryToUpgrade], _callback);
};

/*TacticalCombatResultScreenDatasource.prototype.notifyBackendDestroyItem = function (_itemIdx, _itemOwner)
{
    if (this.mSQHandle !== null)
    {
        return SQ.call(this.mSQHandle, 'onDestroyItem', [_itemIdx, _itemOwner]);
    }
    return null;
};*/

TacticalCombatResultScreenDatasource.prototype.notifyBackendLootAllItemsButtonPressed = function () {
    var self = this;
    SQ.call(this.mSQHandle, 'onLootAllItemsButtonPressed', null, function (_data) {
        self.loadFromData(_data);
    });
};

TacticalCombatResultScreenDatasource.prototype.notifyBackendRemoveInventoryItemUpgrades = function (_slot) {
    var self = this;
    SQ.call(this.mSQHandle, 'removeInventoryItemUpgrades', [_slot], function (data) {
        if (data === undefined || data == null || typeof (data) !== 'object') {
            console.error('ERROR: Failed to drop paperdoll item into bag. Invalid data result.');
            return;
        }

        self.getStashStatistics();

        if (data !== null && jQuery.isArray(data)) {
            data.forceUpdate = _slot;
            self.updateStashList(data);
        }

    });
};