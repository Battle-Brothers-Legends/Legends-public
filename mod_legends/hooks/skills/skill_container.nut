::mods_hookNewObject("skills/skill_container", function (o) {
	local buildPropertiesForUse = o.buildPropertiesForUse;
	o.buildPropertiesForUse = function (_caller, _targetEntity) {
		local ret = buildPropertiesForUse(_caller, _targetEntity);

		// When dual wielding two weapons of the same type only one skill instance lives
		// in the container (because they are deduped by id), so the onAnySkillUsed of the
		// other weapon skill instance never fires. We need to call it manually to make sure
		// all skills get their bonuses applied (eg. thrust +20 melee skill).
		foreach (skill in this.m.Skills) {
			if (skill == _caller) {
				return ret;
			}
		}

		_caller.onAnySkillUsed(_caller, _targetEntity, ret);
		return ret;
	}

	// o.buildPropertiesForDefense = function( _attacker, _skill )
	// {
	// 	local superCurrent = this.m.Actor.getCurrentProperties().getClone();
	// 	local updating = this.m.IsUpdating;
	// 	this.m.IsUpdating = true;

	// 	foreach( i, skill in this.m.Skills )
	// 	{
	// 		skill.onBeingAttacked(_attacker, _skill, superCurrent);
	// 	}

	// 	this.m.IsUpdating = updating;
	// 	return superCurrent;
	// }

	// o.buildPropertiesForBeingHit = function( _attacker, _skill, _hitInfo )
	// {
	// 	local superCurrent = this.m.Actor.getCurrentProperties().getClone();
	// 	local updating = this.m.IsUpdating;
	// 	this.m.IsUpdating = true;

	// 	foreach( i, skill in this.m.Skills )
	// 	{
	// 		skill.onBeforeDamageReceived(_attacker, _skill, _hitInfo, superCurrent);
	// 	}

	// 	this.m.IsUpdating = updating;
	// 	return superCurrent;
	// }

	o.getSkillsSortedByItems <- function (_filter, _notFilter = 0) {
		local ret = [];

		for (local i = 0; i < this.Const.ItemSlot.COUNT; i = i) {
			ret.push([]);
			i = ++i;
		}

		foreach (skill in this.m.Skills) {
			if (!skill.isGarbage()
				&& skill.isType(_filter)
				&& !skill.isType(_notFilter)
				&& !skill.isHidden())
			{
				if (skill.getItem() != null) {
					local slotType = skill.getItem().getCurrentSlotType();
					if (slotType >= 0 && slotType < this.Const.ItemSlot.COUNT) {
						ret[slotType].push(skill);
					}
				} else {
					ret[this.Const.ItemSlot.Free].push(skill);
				}
			}
		}

		if (ret[this.Const.ItemSlot.Free].len() > 1) {
			ret[this.Const.ItemSlot.Free].sort(this.compareSkillsByOrder);
		}

		return ret;
	}

	o.hasActive <- function (_const) {
		return ::Legends.Actives.has(this, _const);
	}

	o.hasPerk <- function (_const) {
		return ::Legends.Perks.has(this, _const);
	}

	o.hasTrait <- function (_const) {
		return ::Legends.Traits.has(this, _const);
	}

	o.hasEffect <- function (_const) {
		return ::Legends.Effects.has(this, _const);
	}

	local onMovementFinished = o.onMovementFinished;
	o.onMovementFinished = function () {
		if (this.getActor() == null) {
			return;
		}
		onMovementFinished();
	}
});
