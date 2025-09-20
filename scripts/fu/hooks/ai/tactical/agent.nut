::mods_hookBaseClass("ai/tactical/agent", function(o) {
	o = o[o.SuperName];

	o.m.FU_BehaviorStacks <- {};
	o.m.FU_BehaviorToRemove <- null;

	local addBehavior = o.addBehavior;
	o.addBehavior = function( _behavior )
	{
		if (_behavior.getID() in this.m.FU_BehaviorStacks)
		{
			++this.m.FU_BehaviorStacks[_behavior.getID()];
			return;
		}

		this.m.FU_BehaviorStacks[_behavior.getID()] <- 1;
		return addBehavior(_behavior);
	}

	local removeBehavior = o.removeBehavior;
	o.removeBehavior = function( _id )
	{
		if (_id in this.m.FU_BehaviorStacks) delete this.m.FU_BehaviorStacks[_id];
		return removeBehavior(_id);
	}

	// TODO: This function's name is temporary and is currently undocumented while we search for a better name
	// Once we find a better name we will change it and add it to documentation
	o.removeBehaviorByStack <- function( _id )
	{
		if (!(_id in this.m.FU_BehaviorStacks) || --this.m.FU_BehaviorStacks[_id] == 0)
			return this.removeBehavior(_id);
	}
});

::FU.EndQueue.add(function() {
	::mods_hookBaseClass("ai/tactical/agent", function(o) {
		o = o[o.SuperName];

		local execute = o.execute;
		o.execute = function( _entity )
		{
			local ret = execute(_entity);
			if (this.m.FU_BehaviorToRemove != null)
			{
				this.removeBehaviorByStack(this.m.FU_BehaviorToRemove.getID());
				this.m.FU_BehaviorToRemove = null;
			}
			return ret;
		}
	});
});
