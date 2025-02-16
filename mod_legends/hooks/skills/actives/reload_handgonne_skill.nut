::mods_hookExactClass("skills/actives/reload_handgonne_skill", function(o)
{
	o.onUseByAlly <- function ( _user, _targetTile )
	{
		this.getItem().setLoaded(true);
		this.getContainer().remove(this);
		return true;
	}
});
