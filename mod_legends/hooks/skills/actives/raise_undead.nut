::mods_hookExactClass("skills/actives/raise_undead", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Chant a forbidden ritual and add a fresh corpse to do your bidding."
		this.m.Icon = "skills/raisedead2.png",
		this.m.IconDisabled = "skills/raisedead2_bw.png",
		this.m.Order = this.Const.SkillOrder.Any;
	}

	o.getTooltip <- function ()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		return [{
			id = 1,
			type = "title",
			text = this.getName()
		},
		{
			id = 2,
			type = "description",
			text = this.getDescription()
		},
		{
			id = 3,
			type = "text",
			text = this.getCostString()
		},
		{
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Raise a corpse to fight for you"
		}];
	}

	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (!this.MSU.Tile.canResurrectOnTile(_targetTile))
		{
			return false;
		}

		if (!_targetTile.IsEmpty)
		{
			return false;
		}

		return true;
	}

	o.spawnUndead = function ( _user, _tile )
	{
		local p = _tile.Properties.get("Corpse");
		p.Faction = _user.getFaction();
		if (p.Faction == this.Const.Faction.Player)
		{
			p.Faction = this.Const.Faction.PlayerAnimals;
		}
		local e = this.Tactical.Entities.onResurrect(p, true);

		if (e != null)
		{
			e.getSprite("socket").setBrush(_user.getSprite("socket").getBrush().Name);
		}
	}
});