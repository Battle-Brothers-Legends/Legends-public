::mods_hookExactClass("ui/screens/tactical/modules/turn_sequence_bar/turn_sequence_bar", function (o) {
	local _convertEntitySkillsToUIData = o.convertEntitySkillsToUIData;
	o.convertEntitySkillsToUIData = function (_entity) {
		if (!_entity.isPlayerControlled()) {
			return null;
		}

		local result = _convertEntitySkillsToUIData(_entity);

		foreach (item in _entity.querySwitchableItems()) {
			result.push({
				id = item.getInstanceID(),
				imagePath = "ui/items/" + item.getIcon(),
				isUsable = true,
				isAffordable = true
			});
		}

		return result;
	}

	o.updateEntity = function (_entityId) {
		if (this.m.CurrentEntities.len() == 0) {
			return;
		}

		local result = this.findEntityByID(this.m.AllEntities, _entityId);

		if (result != null
			&& !::Legends.S.isEntityNullOrDead(result.entity)
			&& result.entity.isPlacedOnMap())
		{
			this.Tooltip.reloadDataIfEqual(_entityId);
			this.Time.scheduleEvent(this.TimeUnit.Real, 10, function (_tag) {

				if (_tag.bar == null || _tag.bar.m.CurrentEntities.len() == 0) {
					return;
				}

				local resultUpdated = _tag.bar.findEntityByID(_tag.bar.m.CurrentEntities, _tag.EntityID);

				if (resultUpdated != null && !::Legends.S.isEntityNullOrDead(resultUpdated.entity) && resultUpdated.index < this.m.MaxVisibleEntities) {
					_tag.bar.m.JSHandle.call("updateEntity", _tag.bar.convertEntityToUIData(resultUpdated.entity));
				}

			}.bindenv(this), { bar = this, EntityID = _entityId });
		}
	}

	// this should clean up an invalid entity and allow the game flow to continue if JS is stuck on a null entity; called by js through selectFirstEntity
	o.onForceRemoveInvalidEntity <- function (_entityID) {
		for (local i = 0; i < this.m.CurrentEntities.len(); i++) {
			local entity = this.m.CurrentEntities[i];
			if (::Legends.S.isEntityNullOrDead(entity) && entity.getID() == _entityID) {
				this.m.IsLocked = false;
				this.removeEntity(entity);
				return;
			}
		}
	}

	// normally TSB checks on the entity's turn if that entity is the last one on the bar but the tail is behind the head
	// slight delay to allow the tsb to clean up and recheck the next round init
	o.ForceRecheckNextTurnCondition <- function () {
		if (this.m.IsBattleEnded) {
			return;
		}

		if (this.m.OnNextTurnListener != null) {
			if (!this.m.OnNextTurnListener()) {
				return;
			}
		}
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 10, function (_tag) {
			if (this.getCurrentEntities().len() == 0 && !this.m.IsInitNextRound) {
				this.m.IsLocked = false;
				//this.m.IsInitNextRound = true; //alternative fix, but setting isLocked to false allows the check to go on naturally
				//this.m.CheckEnemyRetreat = true;
			}
		}.bindenv(this), null);
	}
	
});
