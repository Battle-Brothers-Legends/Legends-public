this.legend_protect_target_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Pet = [],
		LastTarget = null
	},

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendProtectTarget);
		this.m.Description = "Order your pets to protect a target.";
		this.m.Icon = "skills/houndeffend.png";
		this.m.IconDisabled = "skills/houndeffend_bw.png";
		this.m.Overlay = "active_175";
		this.m.SoundOnUse = [
			"sounds/enemies/wardog_idle_01.wav",
			"sounds/enemies/wardog_idle_02.wav",
			"sounds/enemies/wardog_idle_03.wav",
			"sounds/enemies/wardog_idle_04.wav",
			"sounds/enemies/wardog_idle_05.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any + 2;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 3;
		this.m.MinRange = 1;
		this.m.MaxRange = 9;
		this.m.MaxLevelDifference = 4;
		this.m.IsRemovedAfterBattle = true;
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
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Give your pet an order to prioritize protecting target"
			}
		];

		if (this.m.Pet.len() == 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]This character does not have any unleashed pets[/color]"
			});
		}

		return ret;
	}

	function addPet( _petID )
	{
		this.m.Pet.push(_petID);
	}

	function removePet( _petID )
	{
		local i = this.m.Pet.find(_petID);

		if (i != null)
		{
			this.m.Pet.remove(_petID);
		}
	}

	function onUpdate( _properties )
	{
		if (this.m.Pet.len() != 0)
		{
			local pets = [];

			foreach (id in this.m.Pet)
			{
				local e = this.Tactical.getEntityByID(id);

				if (e != null)
				{
					pets.push(id);
				}
			}

			this.m.Pet = pets;
		}
	}

	function isUsable()
	{
		return this.m.Pet.len() != 0 && this.skill.isUsable();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{

		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getID() == _originTile.getEntity().getID())
		{
			return true;
		}

		local target = _targetTile.getEntity();
		if (!this.m.Container.getActor().isAlliedWith(target))
		{
			return false;
		}

		if (target.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return false;
		}

		return true;
	}

	function setTarget(_t)
	{
		if (this.m.LastTarget != null)
		{
			local e = this.Tactical.getEntityByID(this.m.LastTarget);
			if (e != null)
			{
				::Legends.Effects.remove(e, ::Legends.Effect.LegendGuardedEffect);
			}
		}
		this.m.LastTarget = null;


		foreach (id in this.m.Pet)
		{
			local pet = this.Tactical.getEntityByID(id);
			if (pet == null)
			{
				continue;
			}

			local skill = ::Legends.Effects.get(pet, ::Legends.Effect.LegendGuard);

			if (_t == null)
			{
				if (skill != null)
				{
					skill.setTarget(null)
				}
				continue;
			}

			if (skill == null) {
				skill = ::Legends.Effects.grant(pet, ::Legends.Effect.LegendGuard);
			}

			skill.setTarget(_t);
			this.spawnIcon("status_effect_103", pet.getTile());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(pet) + " is now protecting " + this.Const.UI.getColorizedEntityName(_t));
		}

		if (_t == null)
		{
			return;
		}
		::Legends.Effects.grant(_t, ::Legends.Effect.LegendGuardedEffect);
		this.m.LastTarget = _t.getID();
	}

	function onUse( _user, _targetTile )
	{
		if (_user.getSkills().hasActive(::Legends.Active.LegendAttackTarget))
		{
			local skill = ::Legends.Actives.get(_user, ::Legends.Active.LegendAttackTarget);
			skill.setTarget(null);
		}

		local target = _targetTile.getEntity();
		this.setTarget(target);
		return true;

	}

});

