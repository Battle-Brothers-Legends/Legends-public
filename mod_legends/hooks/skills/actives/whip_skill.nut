::mods_hookExactClass("skills/actives/whip_skill", function(o)
{
	local create = o.create;
	o.create = function() {
		create();
		this.m.ActionPointCost = 3;
	}

	o.onUse = function ( _user, _targetTile ) {
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (::Legends.S.isEntityNullOrDead(_user))
			return success;

		if (success) {
			::Legends.S.applyBleed(target, _user, hp, this.m.SoundsA, this.m.SoundsB);
			::Legends.S.applyBleed(target, _user, hp, this.m.SoundsA, this.m.SoundsB);
		}

		return success;
	}
});
