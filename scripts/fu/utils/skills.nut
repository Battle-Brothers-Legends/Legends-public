::FU.Skills <- {
	EventsToAdd = [],
	PreviewApplicableFunctions = [
		"getActionPointCost",
		"getFatigueCost"
	],
	QueuedPreviewChanges = {},
	SoftResetFields = [
		"ActionPointCost",
		"FatigueCost",
		"FatigueCostMult",
		"MinRange",
		"MaxRange"
	],

	function addEvent( _name, _function = null, _update = true, _aliveOnly = false )
	{
		this.EventsToAdd.push({
			Name = _name,
			Update = _update,
			AliveOnly = _aliveOnly
		});

		::mods_hookBaseClass("skills/skill", function(o) {
			o = o[o.SuperName];
			o[_name] <- _function == null ? function() {} : _function;
		});
	}

	function addPreviewApplicableFunction( _name )
	{
		::FU.requireString(_name);
		if (this.PreviewApplicableFunctions.find(_name) == null) this.PreviewApplicableFunctions.push(_name);
	}

	function addToSoftReset( _field )
	{
		if (this.SoftResetFields.find(_field) == null) this.SoftResetFields.push(_field);
	}

	function removeFromSoftReset( _field )
	{
		local idx = this.SoftResetFields.find(_field);
		if (idx != null) this.SoftResetFields.remove(idx); 
	}

	// Private
	function modifyPreview( _caller, _targetSkill, _field, _newChange, _multiplicative )
	{
		if (!(_caller in this.QueuedPreviewChanges)) this.QueuedPreviewChanges[_caller] <- [];
		this.QueuedPreviewChanges[_caller].push({
			TargetSkill = _targetSkill,
			Field = _field,
			ValueBefore = 0,
			CurrChange = _multiplicative ? 1 : 0,
			NewChange = _newChange,
			Multiplicative = _multiplicative
		});
	}
}
