::mods_hookExactClass("entity/world/settlements/buildings/arena_building", function(o)
{
	o.m.Attempts <- [];

	o.getMaxAttempts <- @() ::World.Assets.m.IsArenaTooled ? 3 : 1;
	o.getCurrentAttempts <- @() this.m.Attempts.len();

	o.registerAttempt <- function() {
		this.m.Attempts.push(::World.getTime().Days)
	}

	o.refreshTooltip <- function () {
		this.m.Attempts = this.m.Attempts.filter(@(_, _it) _it == ::World.getTime().Days);
	}

	local refreshCooldown = o.refreshCooldown;
	o.refreshCooldown = function () {
		this.m.Attempts = this.m.Attempts.filter(@(_, _it) _it == ::World.getTime().Days);
		if (this.getCurrentAttempts() == this.getMaxAttempts())
			refreshCooldown();
	}

	o.getAttempts <- function () { // for tooltip
		local maxAttempts = this.getMaxAttempts();
		if(this.isClosed())
			return [0, maxAttempts];
		return [maxAttempts - this.getCurrentAttempts(), maxAttempts];
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out){
		onSerialize(_out);
		_out.writeU8(this.m.Attempts.len());
		foreach (a in this.m.Attempts) {
			_out.writeU32(a);
		}
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function (_in){
		onDeserialize(_in);
		local attempts = _in.readU8();
		this.m.Attempts = [];
		for (local i = 0; i < attempts; i++) {
			this.m.Attempts.push(_in.readU32());
		}
	}


	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list)
	{
		onUpdateDraftList(_list);
		_list.push("legend_gladiator_prizefighter_background");
		_list.push("legend_gladiator_prizefighter_background");
	}

});
