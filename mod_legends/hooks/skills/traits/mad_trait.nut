::mods_hookExactClass("skills/traits/mad_trait", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "This character has gazed into the abyss, and the abyss has gazed right back at them, turning them quite mad. This character often rambles unintelligibly, and their cryptic mind has become inaccessible both to peers and to the enemy."
	}
});
