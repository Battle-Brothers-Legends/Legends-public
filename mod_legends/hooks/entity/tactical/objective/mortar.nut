::mods_hookExactClass("entity/tactical/objective/donkey", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.TargetAttractionMult = 0.1;
	}
});
