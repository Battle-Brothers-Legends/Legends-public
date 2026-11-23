::mods_hookExactClass("skills/effects/possessed_undead_effect", function(o) {
	o.m.IsControlledByPlayer <- false;

	o.setPlayerControlled <- function ( _v )
	{
		this.m.IsControlledByPlayer = _v;
	}
});
