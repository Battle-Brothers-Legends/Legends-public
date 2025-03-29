::mods_hookExactClass("items/weapons/greatsword", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Name = "Zweihander";
		this.m.Description = "A massive two-handed blade as good for carving swathes through the enemy as for battering them into submission."; //Let's get this working
	}
});
