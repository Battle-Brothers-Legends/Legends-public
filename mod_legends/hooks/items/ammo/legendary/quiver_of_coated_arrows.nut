::mods_hookExactClass("items/ammo/legendary/quiver_of_coated_arrows", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.AddGenericSkill = true;
	}

	o.onDamageDealt = function ( _target, _skill, _hitInfo )
	{
		local item = _skill.getItem();
		if (_skill.isAttack() && item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && item.isWeaponType(this.Const.Items.WeaponType.Bow))
		{
			if (!_target.isAlive() || _target.isDying())
			{
				if (this.isKindOf(_target, "lindwurm_tail") || !_target.getCurrentProperties().IsImmuneToBleeding)
				{
					this.Sound.play(this.m.BleedSounds[this.Math.rand(0, this.m.BleedSounds.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
				}
			}
			else if (!_target.getCurrentProperties().IsImmuneToBleeding && _hitInfo.DamageInflictedHitpoints >= this.Const.Combat.MinDamageToApplyBleeding)
			{
				::Legends.Effects.grant(_target, ::Legends.Effect.Bleeding, function(_effect) {
					if (this.getContainer().getActor().getFaction() == this.Const.Faction.Player )
						_effect.setActor(this.getContainer().getActor());
					_effect.setDamage(this.m.BleedDamage);
				}.bindenv(this));
				this.Sound.play(this.m.BleedSounds[this.Math.rand(0, this.m.BleedSounds.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			}
		}
	}
});
