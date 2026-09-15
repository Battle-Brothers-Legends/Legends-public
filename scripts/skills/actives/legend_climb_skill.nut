this.legend_climb_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendClimb);
		this.m.Description = "Allows you to move up or down levels. Does not trigger attacks of opportunity. Can not be used on flat ground.";
		this.m.SoundOnUse = ["sounds/combat/footwork_01.wav"];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDisengagement = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 5;
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


		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used while rooted[/color]"
			});
		}

		return ret;
	}

	function isUsable() {
		if (::Tactical.isActive() && ::Tactical.State.getStrategicProperties() != null && ::Tactical.State.getStrategicProperties().IsArenaMode) {
			return false;
		}

		local actor = this.getContainer().getActor();
		if (this.skill.isUsable() && !actor.getCurrentProperties().IsRooted) {
			local myTile = actor.getTile();
			for (local i = 0; i < 6; i = ++i) {
				if (!myTile.hasNextTile(i)) {
				} else {
					local nextTile = myTile.getNextTile(i);

					if (::Math.abs(nextTile.Level - myTile.Level) < 1) {
					} else {
						return true;
					}
				}
			}
		} else {
			return false;
		}
	}

	function onAfterUpdate( _properties )
	{
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendBackflip))
		{
			this.m.MaxRange = 2;
		}

		this.m.FatigueCostMult = _properties.IsFleetfooted ? 0.5 : 1.0;

		if (this.getContainer().getActor().getSkills().hasEffect(::Legends.Effect.GoblinGruntPotion))
		{
			this.m.ActionPointCost = 2;
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{

		if (_targetTile.IsOccupiedByActor)
		{
			return false;
		}

		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (!_targetTile.IsEmpty)
		{
			return false;
		}

		if (::Math.abs(_targetTile.Level - _originTile.Level) == 0)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		::Tactical.getNavigator().teleport(_user, _targetTile, null, null, false);
		return true;
	}

});

