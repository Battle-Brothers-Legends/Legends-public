this.legend_safeguarding_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Ward = null,
		IsActivated = false
	},

	function activate()
	{
		this.m.IsActivated = true;
	}

	function setWard( _p )
	{
		if (_p == null)
		{
			this.m.Ward = null;
		}
		else if (typeof _p == "instance")
		{
			this.m.Ward = _p;
		}
		else
		{
			this.m.Ward = this.WeakTableRef(_p);
		}
	}

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSafeguarding);
		this.m.Description = "This character is neglecting their own defense to safeguard another.";
		this.m.KilledString = "Died while safeguarding another";
		this.m.Icon = "ui/perks/safegaurd_circle.png";
		this.m.IconMini = "mini_safegaurd_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = 
		[
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		if (this.m.Protector)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "All damage done to this character will be transfered to " + this.m.Protector.getName()
			});
		}
		local tooltip = [
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
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Ranged Defense"
			}
		];
		if (this.m.Ward)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "All damage done to " + this.m.Ward.getName() + " will be transfered to this character"
			});
		}
	}

	function applyDamage( _damage, _attacker )
	{
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = _damage;
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		this.getContainer().getActor().onDamageReceived(_attacker, this, hitInfo);
		this.removeSelf();
	}

	function onRemoved()
	{
		if (this.m.Ward != null && !this.m.Ward.isNull() && !this.m.Ward.getContainer().isNull())
		{
			local ward = this.m.Ward;
			this.m.Ward = null;
			ward.setProtector(null);
			ward.removeSelf();
			ward.getContainer().update();
		}
		local item = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(this.Const.Items.ItemType.Shield))
		{
			item.onShieldDown();
		}
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense -= 10;
		_properties.RangedDefense -= 10;
		if (this.m.IsActivated && (this.m.Ward == null || this.m.Ward.isNull() || !this.m.Ward.isAlive()))
		{
			this.removeSelf();
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

	function onAdded()
	{
		local item = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(this.Const.Items.ItemType.Shield))
		{
			item.onShieldUp();
		}
	}
});
