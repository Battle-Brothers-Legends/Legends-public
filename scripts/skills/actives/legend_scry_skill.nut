this.legend_scry_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null
	},
	function create()
	{
		this.m.ID = "actives.legend_scry";
		this.m.Name = "Scry";
		this.m.Description = "Gain vision of the surrounding 12 tiles for the duration of the current round.";
		this.m.Icon = "skills/scry_skill.png";
		this.m.IconDisabled = "skills/scry_skill_bw.png";
		this.m.Overlay = "scry";
		this.m.SoundOnUse = [
			"sounds/combat/scry_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 5;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsTargetingActor = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function getTooltip()
	{
		local ret = [
			{
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
			}
		];
		return ret;
	}




	function onUse( _user, _targetTile )
	{
		this.Tactical.queryTilesInRange(_user.getTile(), 1, 12, false, [], this.onQueryTile, _user.getFaction());
		return true;
	}

	function onQueryTile( _tile, _tag )
	{
		_tile.addVisibilityForFaction(_tag);

		if (_tile.IsOccupiedByActor)
		{
			_tile.getEntity().setDiscovered(true);
		}
	}

});
