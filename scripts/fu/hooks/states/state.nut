::mods_hookChildren("states/state", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		::FU.Utils.States[this.ClassName] <- ::WeakTableRef(this);
		return onInit();
	}
});
