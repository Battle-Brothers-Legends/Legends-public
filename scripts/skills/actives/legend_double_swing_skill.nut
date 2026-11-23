this.legend_double_swing_skill <- this.inherit("scripts/skills/skill", {
	m = {
		BothHitMiddle = false,
		TilesLeft = 1,
		TilesRight = 1
	},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDoubleSwing);
		this.m.Description = "Swing both weapons in a wide arc. The right tile is hit by the main hand, the left tile by the off hand, and the middle tile by both weapons.";
		this.m.Icon = "skills/legend_double_swing.png";
		this.m.IconDisabled = "skills/legend_double_swing_sw.png";
		this.m.Overlay = "legend_double_swing";
		this.m.SoundOnUse = [
			"sounds/combat/swing_01.wav",
			"sounds/combat/swing_02.wav",
			"sounds/combat/swing_03.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/swing_hit_01.wav",
			"sounds/combat/swing_hit_02.wav",
			"sounds/combat/swing_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.BeforeLast;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAOE = true;
		this.m.IsWeaponSkill = false;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip() {
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
		];

		local actor = this.getContainer().getActor();
		local items = actor.getItems();
		local mh = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local oh = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

		local mhSkill = ::Legends.Weapons.findPrimaryAttackSkill(actor, mh);
		if (mhSkill == null) {
			::logWarning("legend_double_swing: no valid attack skill found for mainhand");
		} else {
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Mainhand attack: [color=%skill%]" + mhSkill.getName() + "[/color]"
			});
		}

		local ohSkill = ::Legends.Weapons.findPrimaryAttackSkill(actor, oh);
		if (ohSkill == null) {
			::logWarning("legend_double_swing: no valid attack skill found for offhand");
		} else {
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Offhand attack: [color=%skill%]" + ohSkill.getName() + "[/color]"
			});
		}

		return ret;
	}

	function onAfterUpdate (_properties) {
		local items = this.getContainer().getActor().getItems();
		local mh = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local oh = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (mh != null && mh.isWeaponType(this.Const.Items.WeaponType.Dagger) && _properties.IsSpecializedInDaggers) {
			this.m.ActionPointCost -= 1;
		}
		if (oh != null && oh.isWeaponType(this.Const.Items.WeaponType.Dagger) && _properties.IsSpecializedInDaggers) {
			this.m.ActionPointCost -= 1;
		}
	}

	function isUsable() {
		if (!this.skill.isUsable()) {
			return false;
		}
		return ::Legends.Weapons.isDualWielding(this.getContainer().getActor());
	}

	function getFatigueCost() {
        local actor = this.getContainer().getActor();
        
        if (actor == null || !::Legends.Weapons.isDualWielding(actor)) {
            return this.skill.getFatigueCost(); 
        }

        local items = actor.getItems();
        local mh = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
        local oh = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

        local mhSkill = ::Legends.Weapons.findPrimaryAttackSkill(actor, mh);
        local ohSkill = ::Legends.Weapons.findPrimaryAttackSkill(actor, oh);
        
        if (mhSkill != null && ohSkill != null) {
            return this.Math.max(this.m.FatigueCost, mhSkill.getFatigueCost() + ohSkill.getFatigueCost());
        }

        return this.skill.getFatigueCost();
    }

	function onUse(_user, _targetTile) {
		this.m.BothHitMiddle = false;
		//this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSwing); // removed as the attacks spawn effects individually in onUse

		local ret = false;

		local items = _user.getItems();
		local mh = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local oh = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

		local mhSkill = ::Legends.Weapons.findPrimaryAttackSkill(_user, mh);
		local ohSkill = ::Legends.Weapons.findPrimaryAttackSkill(_user, oh);
		if (mhSkill == null) {
			::logWarning("legend_double_swing: no valid attack skill found for mainhand");
			return ret;
		}
		if (ohSkill == null) {
			::logWarning("legend_double_swing: no valid attack skill found for offhand");
			return ret;
		}

		// Clockwise (right) = mainhand, Counter-clockwise (left) = offhand
		local tile = _user.getTile();
		local dir = tile.getDirectionTo(_targetTile);
		local cwDir = (dir + 1) % this.Const.Direction.COUNT;
		local ccwDir = dir - 1 >= 0 ? dir - 1 : this.Const.Direction.COUNT - 1;

		// Clockwise tile (right) with mainhand
		if (tile.hasNextTile(cwDir)) {
			local cwTile = tile.getNextTile(cwDir);
			if (cwTile.IsOccupiedByActor
				&& cwTile.getEntity().isAttackable()
				&& this.Math.abs(cwTile.Level - tile.Level) <= 1)
			{
				ret = mhSkill.onUse(_user, cwTile) || ret;
				if (::Legends.S.isEntityNullOrDead(_user)) {
					return ret;
				}
			}
		}

		// Counter-clockwise tile (left) with offhand
		if (tile.hasNextTile(ccwDir)) {
			local ccwTile = tile.getNextTile(ccwDir);
			if (ccwTile.IsOccupiedByActor
				&& ccwTile.getEntity().isAttackable()
				&& this.Math.abs(ccwTile.Level - tile.Level) <= 1)
			{
				ret = ohSkill.onUse(_user, ccwTile) || ret;
				if (::Legends.S.isEntityNullOrDead(_user)) {
					return ret;
				}
			}
		}

		// Target tile (middle) with mainhand
		if (_targetTile.IsOccupiedByActor && _targetTile.getEntity().isAttackable()) {
			ret = mhSkill.onUse(_user, _targetTile) || ret;

			if (::Legends.S.isEntityNullOrDead(_user, _targetTile.getEntity())) {
				return ret;
			}

			// Target tile (middle) with offhand
			local ohHit = ohSkill.onUse(_user, _targetTile);
			ret = ohHit || ret;
			if (ohHit) {
				this.m.BothHitMiddle = true;
			}
		}

		return ret;
	}

	function onTargetSelected(_targetTile) {
		local tile = this.m.Container.getActor().getTile();
		local dir = tile.getDirectionTo(_targetTile);

		// Highlight target tile (middle)
		this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, _targetTile, _targetTile.Pos.X, _targetTile.Pos.Y);

		// Clockwise (right)
		local cwDir = (dir + 1) % this.Const.Direction.COUNT;
		if (tile.hasNextTile(cwDir)) {
			local cwTile = tile.getNextTile(cwDir);
			if (this.Math.abs(cwTile.Level - tile.Level) <= 1) {
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, cwTile, cwTile.Pos.X, cwTile.Pos.Y);
			}
		}

		// Counter-clockwise (left)
		local ccwDir = dir - 1 >= 0 ? dir - 1 : this.Const.Direction.COUNT - 1;
		if (tile.hasNextTile(ccwDir)) {
			local ccwTile = tile.getNextTile(ccwDir);
			if (this.Math.abs(ccwTile.Level - tile.Level) <= 1) {
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, ccwTile, ccwTile.Pos.X, ccwTile.Pos.Y);
			}
		}
	}

	function didBothHitMiddle() {
		return this.m.BothHitMiddle;
	}
});
