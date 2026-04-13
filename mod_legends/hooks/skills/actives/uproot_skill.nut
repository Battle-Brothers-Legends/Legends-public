::mods_hookExactClass("skills/actives/uproot_skill", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Send out roots to hold and damage an enemy";
		this.m.IconDisabled = "skills/active_122_bw.png";
	}

	o.getTooltip <- function ()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		return [
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
				type = "text",
				icon = "ui/icons/health.png",
				text = "Inflicts [color=%damage%]" + p.DamageRegularMin + "[/color] - [color=%damage%]" + p.DamageRegularMax + "[/color] damage"
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Uproot can target the ground and hits up to 3 tiles in a line"
			}
		];
	}

	o.onUse = function ( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local dir = myTile.getDirectionTo(_targetTile);
		this.Tactical.spawnAttackEffect("uproot", _targetTile, 0, -50, 100, 300, 100, this.createVec(0, 90), 200, this.createVec(0, -90), true);

		for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = i )
		{
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, _targetTile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages, this.createVec(0, -30));
			i = ++i;
		}

		if (_targetTile.IsOccupiedByActor && _targetTile.getEntity().isAttackable() && !(_targetTile.getEntity().getType() == this.Const.EntityType.Schrat || _targetTile.getEntity().getType() == this.Const.EntityType.SchratSmall || _targetTile.getEntity().getType() == this.Const.EntityType.LegendGreenwoodSchrat || _targetTile.getEntity().getType() == this.Const.EntityType.LegendGreenwoodSchratSmall))
		{
			if (_targetTile.getEntity().m.IsShakingOnHit)
			{
				this.Tactical.getShaker().shake(_targetTile.getEntity(), _targetTile, 7);
				_user.playSound(this.Const.Sound.ActorEvent.Move, 2.0);
			}

			this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, function ( _tag )
			{
				if (this.attackEntity(_user, _targetTile.getEntity()) && !_targetTile.IsEmpty)
				{
					this.applyEffectToTarget(_user, _targetTile.getEntity(), _targetTile);
				}
			}.bindenv(this), null);
		}

		if (_targetTile.hasNextTile(dir))
		{
			local forwardTile = _targetTile.getNextTile(dir);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, function ( _tag )
			{
				this.Tactical.spawnAttackEffect("uproot", forwardTile, 0, -50, 100, 300, 100, this.createVec(0, 90), 200, this.createVec(0, -90), true);

				for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, forwardTile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages, this.createVec(0, -30));
					i = ++i;
				}

				if (forwardTile.IsOccupiedByActor && forwardTile.getEntity().m.IsShakingOnHit)
				{
					this.Tactical.getShaker().shake(forwardTile.getEntity(), forwardTile, 7);
					_user.playSound(this.Const.Sound.ActorEvent.Move, 2.0);
				}
			}.bindenv(this), null);

			if (forwardTile.IsOccupiedByActor && forwardTile.getEntity().isAttackable() && this.Math.abs(forwardTile.Level - myTile.Level) <= 1 && !(forwardTile.getEntity().getType() == this.Const.EntityType.Schrat || forwardTile.getEntity().getType() == this.Const.EntityType.SchratSmall || forwardTile.getEntity().getType() == this.Const.EntityType.LegendGreenwoodSchrat || forwardTile.getEntity().getType() == this.Const.EntityType.LegendGreenwoodSchratSmall))
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 400, function ( _tag )
				{
					if (this.attackEntity(_user, forwardTile.getEntity()) && !forwardTile.IsEmpty)
					{
						this.applyEffectToTarget(_user, forwardTile.getEntity(), forwardTile);
					}
				}.bindenv(this), null);
			}

			if (forwardTile.hasNextTile(dir))
			{
				local furtherForwardTile = forwardTile.getNextTile(dir);
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 400, function ( _tag )
				{
					this.Tactical.spawnAttackEffect("uproot", furtherForwardTile, 0, -50, 100, 300, 100, this.createVec(0, 90), 200, this.createVec(0, -90), true);

					for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = i )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, furtherForwardTile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages, this.createVec(0, -30));
						i = ++i;
					}

					if (furtherForwardTile.IsOccupiedByActor && furtherForwardTile.getEntity().m.IsShakingOnHit)
					{
						this.Tactical.getShaker().shake(furtherForwardTile.getEntity(), furtherForwardTile, 7);
						_user.playSound(this.Const.Sound.ActorEvent.Move, 2.0);
					}
				}.bindenv(this), null);

				if (furtherForwardTile.IsOccupiedByActor && furtherForwardTile.getEntity().isAttackable() && !(furtherForwardTile.getEntity().getType() == this.Const.EntityType.Schrat || furtherForwardTile.getEntity().getType() == this.Const.EntityType.SchratSmall || furtherForwardTile.getEntity().getType() == this.Const.EntityType.LegendGreenwoodSchrat || furtherForwardTile.getEntity().getType() == this.Const.EntityType.LegendGreenwoodSchratSmall))
				{
					this.Time.scheduleEvent(this.TimeUnit.Virtual, 600, function ( _tag )
					{
						if (this.attackEntity(_user, furtherForwardTile.getEntity()) && !furtherForwardTile.IsEmpty)
						{
							this.applyEffectToTarget(_user, furtherForwardTile.getEntity(), furtherForwardTile);
						}
					}.bindenv(this), null);
				}

				  // [325]  OP_CLOSE          0      6    0    0
			}

			  // [326]  OP_CLOSE          0      5    0    0
		}

		return true;
	}
});
