this.legend_spawn_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Items = [],
		SpawnItem =  "",
		Script = "",
		IsControlledByPlayer = true,
		HPCost = 5,
		APStartMult = 1.0,
		Range = 2
	},

	function setItem( _i )
	{
		this.m.Items.push(this.WeakTableRef(_i));
	}

	function create()
	{
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsHidden = false;
		this.m.IsRanged = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.MaxLevelDifference = 4;
	}

	function onAfterUpdate( _properties )
	{
		this.m.MaxRange = this.m.Range - 1 + (_properties.IsSpecializedInSummons ? 1 : 0);
	}

	function getMaxRange()
	{
		return this.m.MaxRange;
	}

	function getFatigueCost()
	{

		if (this.m.Container == null)
		{
			return this.Math.ceil(this.m.FatigueCost * this.m.Container.getActor().getCurrentProperties().FatigueEffectMult);
		}

		local perkMult = 1.0;
		local skill = ::Legends.Perks.get(this, ::Legends.Perk.LegendChanneledPower);
		if (skill != null)
		{
			perkMult = skill.m.FatigueMult;
		}
		return this.Math.round(this.Math.ceil(this.m.FatigueCost * perkMult * this.m.FatigueCostMult * this.m.Container.getActor().getCurrentProperties().FatigueEffectMult) + this.m.Container.getActor().getCurrentProperties().FatigueOnSkillUse);
	}

	function getCostString()
	{
		return "[i]Costs " + (this.isAffordableBasedOnAPPreview() ? "[b][color=%positive%]" + this.getActionPointCost() : "[b][color=%negative%]" + this.getActionPointCost()) + " AP[/color][/b] and [b][color=%negative%]" + this.m.HPCost + " HP[/color][/b] to use and builds up " + (this.isAffordableBasedOnFatiguePreview() ? "[b][color=%positive%]" + this.getFatigueCost() : "[b][color=%negative%]" + this.getFatigueCost()) + " Fatigue[/color][/b][/i]\n";
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
			},
			{
				id = 4,
				type = "hint",
				text = "There are " + this.getNumberOfSpawnsAvailable() + " spawns available in your inventory"
			}
		];
		return ret;
	}

	function getScript()
	{
		return this.m.Script;
	}

	function getNumberOfSpawnsAvailable()
	{
		local num = 0;
		local items = this.World.Assets.getStash().getItems();
		foreach( item in items )
		{
			if (item == null)
			{
				continue;
			}

			if (item.getID() != this.m.SpawnItem)
			{
				continue;
			}

			if (item.isUnleashed())
			{
				continue;
			}

			++num;
		}
		return num;
	}

	function isUsable()
	{
		if (this.getNumberOfSpawnsAvailable() == 0 || !this.skill.isUsable())
		{
			return false;
		}


		if (this.getContainer().getActor().getHitpoints() <= this.m.HPCost)
		{
			return false;
		}

		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsEmpty)
		{
			return false
		}

		if (this.m.IsTargetingActor && (_targetTile.IsEmpty || !_targetTile.getEntity().isAttackable() || !_targetTile.getEntity().isAlive() || _targetTile.getEntity().isDying()))
		{
			return false;
		}

		if (this.m.IsAttack && this.m.IsTargetingActor && this.m.Container.getActor().isAlliedWith(_targetTile.getEntity()))
		{
			return false;
		}

		if (this.Math.abs(_targetTile.Level - _originTile.Level) > this.m.MaxLevelDifference)
		{
			return false;
		}

		if (!this.m.IsRanged && this.m.IsVisibleTileNeeded && this.getMaxRange() > 1 && _originTile.getDistanceTo(_targetTile) > 1)
		{
			local myPos = _originTile.Pos;
			local targetPos = _targetTile.Pos;
			local Dx = (targetPos.X - myPos.X) / 2;
			local Dy = (targetPos.Y - myPos.Y) / 2;
			local x = myPos.X + Dx;
			local y = myPos.Y + Dy;
			local tileCoords = this.Tactical.worldToTile(this.createVec(x, y));
			local tile = this.Tactical.getTile(tileCoords);

			if (tile.Level > _originTile.Level && (_originTile.Level - tile.Level < -1 || _targetTile.Level - tile.Level < -1))
			{
				return false;
			}
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local spawnItem = null;
		local items = this.World.Assets.getStash().getItems();
		foreach( item in items )
		{
			if (item == null)
			{
				continue;
			}

			if (item.getID() != this.m.SpawnItem)
			{
				continue;
			}

			if (item.isUnleashed())
			{
				continue;
			}

			spawnItem = item;
			this.World.Assets.getStash().remove(item);
			break;
		}

		if (spawnItem == null)
		{
			return false
		}

		local entity = this.Tactical.spawnEntity(this.getScript(), _targetTile.Coords.X, _targetTile.Coords.Y);
		if (this.m.IsControlledByPlayer)
		{
			entity.setFaction(this.Const.Faction.Player);
		} else {
			entity.setFaction(this.Const.Faction.PlayerAnimals);
		}
		entity.setItem(spawnItem);
		entity.setName(spawnItem.getName());
		entity.assignRandomEquipment();
		entity.riseFromGround();
		entity.getFlags().add("IsSummoned", true);
		entity.getFlags().add("Summoner", _user);
		entity.setActionPoints(this.Math.round(this.m.APStartMult * entity.getActionPoints()));
		spawnItem.setEntity(entity);
		this.m.Items.push(spawnItem);

		this.spawnIcon("status_effect_01", this.getContainer().getActor().getTile());
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.max(actor.getHitpoints() - this.m.HPCost, 1));

		return true;
	}

	function onCombatFinished()
	{
		foreach(item in this.m.Items)
		{
			if (item == null)
			{
				continue;
			}

			item.onCombatFinished();
		}
		this.m.Items = [];
	}
});
