//region town screen
/**
 * Called on encounter click
 * @param _data
 */
WorldTownScreen.prototype.notifyBackendEncounterClicked = function (_data) {
    if(this.mSQHandle !== null) {
        SQ.call(this.mSQHandle, 'onEncounterClicked', _data);
    }
};

/**
 * Updates list of encounters
 * @param _data
 */
WorldTownScreenMainDialogModule.prototype.updateEncounters = function (_data)
{
    var content = this.mDialogContainer.findDialogContentContainer();

    for (var i = 0; i < 10; ++i) {
        for (var j = 0; j < 3; ++j) {
            var c = content.find('.encounter' + i + ':first');

            if (c !== undefined && c !== null) {
                c.unbindTooltip();
                c.remove();
            }
        }
    }

    if (_data.Encounters.length != 0) {
        for (var i = 0; i < _data.Encounters.length; ++i) {
            this.createEncounter(_data.Encounters[i], i, content);
        }
    }
};

/**
 * Creates single encounter
 * @param _data encounter ui mapping
 * @param _i index in array
 * @param _content html
 */
WorldTownScreenMainDialogModule.prototype.createEncounter = function (_data, _i, _content) {
    if (_data == null) {
        return;
    }

    var self = this;
    var classes = 'display-block is-status-effect encounter' + _i;
    var encounter = _content.createImage(Path.GFX + _data.Icon, null, null, classes);
    // var overlay = _content.createImage(Path.GFX + "ui/encounters/encounter_overlay.png", null, null, classes + ' opacity-none');

    encounter.click(function (_event) {
        self.mParent.notifyBackendEncounterClicked(_i);
    });

    encounter.bindTooltip({ contentType: 'msu-generic', modId: mod_legends.ID, elementId: "Encounters.Element", encounterType: _data.Type});
};
//endregion

//region town hooks
mod_legends.Hooks.encounters_town_loadEncountersFromData = WorldTownScreenMainDialogModule.prototype.loadFromData;
WorldTownScreenMainDialogModule.prototype.loadFromData = function (_data){
	mod_legends.Hooks.encounters_town_loadEncountersFromData.call(this, _data);
    if ('Encounters' in _data && _data['Encounters'] !== null) {
        this.updateEncounters(_data);
    }
};
//endregion

//region camp
/**
 * Called on encounter click
 * @param _data
 */
CampScreenMainDialogModule.prototype.notifyBackendEncounterClicked = function (_data) {
    SQ.call(this.mSQHandle, 'onEncounterClicked', _data);
};

/**
 * Creates single encounter
 * @param _data encounter ui mapping
 * @param _i index in array
 * @param _content html
 */
CampScreenMainDialogModule.prototype.createEncounter = function (_data, _i, _content) {
    if (_data == null) {
        return;
    }

    var self = this;
    var classes = 'display-block is-status-effect encounter' + _i;
    var encounter = _content.createImage(Path.GFX + _data.Icon, null, null, classes);

    encounter.click(function (_event) {
        self.notifyBackendEncounterClicked(_i);
    });

    encounter.bindTooltip({ contentType: 'msu-generic', modId: mod_legends.ID, elementId: "Encounters.Element", encounterType: _data.Type});
};

/**
 * Updates list of encounters
 * @param _data
 */
CampScreenMainDialogModule.prototype.updateEncounters = function (_data)
{
    var content = this.mDialogContainer.findDialogContentContainer();

    for (var i = 0; i < 10; ++i) {
        for (var j = 0; j < 3; ++j) {
            var c = content.find('.encounter' + i + ':first');

            if (c !== undefined && c !== null) {
                c.unbindTooltip();
                c.remove();
            }
        }
    }

    if (_data.Encounters.length !== 0) {
        for (var i = 0; i < _data.Encounters.length; ++i) {
            this.createEncounter(_data.Encounters[i], i, content);
        }
    }
};
//endregion

//region camp hooks
mod_legends.Hooks.encounters_camp_loadEncountersFromData = CampScreenMainDialogModule.prototype.loadFromData;
CampScreenMainDialogModule.prototype.loadFromData = function (_data){
	mod_legends.Hooks.encounters_camp_loadEncountersFromData.call(this, _data);
    if ('Encounters' in _data && _data['Encounters'] !== null) {
        this.updateEncounters(_data);
    }
};
//endregion
