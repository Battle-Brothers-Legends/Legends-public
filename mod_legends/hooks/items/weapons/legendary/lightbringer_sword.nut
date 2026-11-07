::mods_hookExactClass("items/weapons/legendary/lightbringer_sword", function (o) {
	o.m.SoundOnLightning <- ::Legends.S.setSounds("sounds/combat/dlc2/legendary_lightning", 2);
	local create = o.create;
	o.create = function () {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
	}

	o.getTooltip = function () {
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Any successful attack will spawn lightning, which inflicts an additional [color=%damage%]10[/color] - [color=%damage%]20[/color] damage that ignores armor and chains to up to three targets"
		});
		return result;
	}

	o.addSkill <- function (_skill) {
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.SlashLightning)) {
			::Legends.Actives.grant(this, ::Legends.Active.Slash);
			return;
		}
		this.weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHalfsword);
		::Legends.Actives.grant(this, ::Legends.Active.Hammer, function (_skill) {
			_skill.m.IsMordhau = true;
		}.bindenv(this));
	}

	o.applyEffect <- function (_data, _delay) {
		::Time.scheduleEvent(::TimeUnit.Virtual, _delay, function (_data) {
			for (local i = 0; i < ::Const.Tactical.LightningParticles.len(); i++) {
				::Tactical.spawnParticleEffect(true, ::Const.Tactical.LightningParticles[i].Brushes, _data.TargetTile, ::Const.Tactical.LightningParticles[i].Delay, ::Const.Tactical.LightningParticles[i].Quantity, ::Const.Tactical.LightningParticles[i].LifeTimeQuantity, ::Const.Tactical.LightningParticles[i].SpawnRate, ::Const.Tactical.LightningParticles[i].Stages);
			}
		}, _data);

		if (!::Legends.S.isEntityNullOrDead(_data.Target)) {
			::Time.scheduleEvent(::TimeUnit.Virtual, _delay + 200, function (_data) {
				local hitInfo = clone ::Const.Tactical.HitInfo;
				hitInfo.DamageRegular = ::Math.rand(10, 20);
				hitInfo.DamageDirect = 1.0;
				hitInfo.BodyPart = ::Const.BodyPart.Body;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;
				_data.Target.onDamageReceived(_data.User, _data.Skill, hitInfo);
			}, _data);
		}
	}

	o.findTargets <- function (_user, _targetTile, _selectedTargets) {
		local targets = {
			EntityTiles = [],
			Tiles = []
		}
		for (local i = 0; i < 6; i++) {
			if (_targetTile.hasNextTile(i)) {
				local tile = _targetTile.getNextTile(i);

				if (tile.ID != _user.getTile().ID) {
					targets.Tiles.push(tile);
				}

				if (tile.IsOccupiedByActor && tile.getEntity().isAttackable() && !tile.getEntity().isAlliedWith(_user) && _selectedTargets.find(tile.getEntity().getID()) == null) {
					targets.EntityTiles.push(tile);
				}
			}
		}
		return targets;
	}

	o.onDamageDealt <- function (_target, _skill, _hitInfo) {
		local targetTile = _hitInfo.Tile;
		this.weapon.onDamageDealt(_target, _skill, _hitInfo);
		if (_skill == null || _skill.isGarbage()) {
			return;
		}

		local item = _skill.getItem();
		if (item == null || _skill.getItem().getID() != this.getID()) {
			return;
		}

		local user = this.getContainer().getActor();
		if (this.m.SoundOnLightning.len() != 0) {
			::Sound.play(::Legends.Array.rand(this.m.SoundOnLightning), ::Const.Sound.Volume.Skill * 2.0, user.getPos());
		}

		local selectedTargets = [];
		local target = null;
		if (targetTile != null && !::Legends.S.isEntityNullOrDead(_target)) {
			target = targetTile.getEntity();
			selectedTargets.push(target.getID());
		}

		local data = {
			Skill = _skill,
			User = user,
			TargetTile = targetTile,
			Target = target
		};
		this.applyEffect(data, 100);

		local _delay = 350;
		for (local i = 0; i < 2; i++) {
			local targets = this.findTargets(user, targetTile, selectedTargets);
			if (targets.EntityTiles.len() != 0) {
				target = ::Legends.Array.rand(targets.EntityTiles).getEntity();
				selectedTargets.push(target.getID());
				targetTile = target.getTile();
			} else {
				target = null;
				targetTile = ::Legends.Array.rand(targets.Tiles);
			}

			local data = {
				Skill = _skill,
				User = user,
				TargetTile = targetTile,
				Target = target
			};
			this.applyEffect(data, _delay);
			_delay += 200;
		}
	}
});
