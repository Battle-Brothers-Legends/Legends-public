::mods_hookDescendants("skills/skill", function(o) {
	if ("create" in o)
	{
		local create = o.create;
		o.create = function()
		{
			create();
			if (this.m.IsAttack && this.m.DamageType.len() == 0)
			{
				switch (this.m.InjuriesOnBody)
				{
					case null:
						this.m.DamageType.add(::Const.Damage.DamageType.None);
						break;

					case ::Const.Injury.BluntBody:
						this.m.DamageType.add(::Const.Damage.DamageType.Blunt);
						break;

					case ::Const.Injury.PiercingBody:
						this.m.DamageType.add(::Const.Damage.DamageType.Piercing);
						break;

					case ::Const.Injury.CuttingBody:
						this.m.DamageType.add(::Const.Damage.DamageType.Cutting);
						break;

					case ::Const.Injury.BurningBody:
						this.m.DamageType.add(::Const.Damage.DamageType.Burning);
						break;

					case ::Const.Injury.BluntAndPiercingBody:
						this.m.DamageType.add(::Const.Damage.DamageType.Blunt, 55);
						this.m.DamageType.add(::Const.Damage.DamageType.Piercing, 45);
						break;

					case ::Const.Injury.BurningAndPiercingBody:
						this.m.DamageType.add(::Const.Damage.DamageType.Burning, 25);
						this.m.DamageType.add(::Const.Damage.DamageType.Piercing, 75);
						break;

					case ::Const.Injury.CuttingAndPiercingBody:
						this.m.DamageType.add(::Const.Damage.DamageType.Cutting);
						this.m.DamageType.add(::Const.Damage.DamageType.Piercing);
						break;

					default:
						this.m.DamageType.add(::Const.Damage.DamageType.Unknown);
				}
			}
		}
	}
});

::mods_hookBaseClass("skills/skill", function(o) {
	o = o[o.SuperName];

	o.m.AIBehaviorID <- null;
	o.m.DamageType <- ::FU.Class.WeightedContainer();
	o.m.ItemActionOrder <- ::Const.ItemActionOrder.Any;

	o.m.IsBaseValuesSaved <- false;
	o.m.ScheduledChanges <- [];

	o.m.IsApplyingPreview <- false;
	o.PreviewField <- {};

	o.scheduleChange <- function( _field, _change, _set = false )
	{
		this.m.ScheduledChanges.push({Field = _field, Change = _change, Set = _set});
		this.getContainer().m.ScheduledChangesSkills.push(this);
	}

	o.executeScheduledChanges <- function()
	{
		if (this.m.ScheduledChanges.len() == 0)
		{
			return;
		}

		foreach (c in this.m.ScheduledChanges)
		{
			switch (typeof c.Change)
			{
				case "integer":
				case "string":
					if (c.Set) this.m[c.Field] = c.Change;
					else this.m[c.Field] += c.Change;
					break;

				default:
					this.m[c.Field] = c.Change;
					break;
			}
		}

		this.m.ScheduledChanges.clear();
	}

	o.saveBaseValues <- function()
	{
		if (!this.m.IsBaseValuesSaved)
		{
			this.b <- clone this.skill.m;
			local obj = this;
			local tables = [];
			while (obj.ClassName != "skill")
			{
				tables.push(clone obj.m);
				obj = obj[obj.SuperName];
			}

			// Iterate in reverse so that the values of slots with the same name in a parent
			// are always taken from the bottom most child.
			for (local i = tables.len() - 1; i >= 0; i--)
			{
				foreach (key, value in tables[i])
				{
					this.b[key] <- value;
				}
			}

			this.m.IsBaseValuesSaved = true;
		}
	}

	o.getBaseValue <- function( _field )
	{
		return this.b[_field];
	}

	o.setBaseValue <- function( _field, _value )
	{
		if (this.m.IsBaseValuesSaved) this.b[_field] = _value;
	}

	o.softReset <- function()
	{
		if (!this.m.IsBaseValuesSaved)
		{
			::logWarning("FU Mod softReset() skill \"" + this.getID() + "\" does not have base values saved.");
			::FU.Log.printStackTrace();
			return false;
		}

		foreach (fieldName in ::FU.Skills.SoftResetFields)
		{
			this.m[fieldName] = this.b[fieldName]
		}

		return true;
	}

	o.hardReset <- function( _exclude = null )
	{
		if (!this.m.IsBaseValuesSaved)
		{
			::logWarning("FU Mod hardReset() skill \"" + this.getID() + "\" does not have base values saved.");
			::FU.Log.printStackTrace();
			return false;
		}

		if (_exclude == null) _exclude = [];
		::FU.requireArray(_exclude);

		local toExclude = ["IsNew", "Order", "Type"];
		toExclude.extend(_exclude);

		foreach (k, v in this.b)
		{
			if (toExclude.find(k) == null) this.m[k] = v;
		}

		return true;
	}

	o.resetField <- function( _field )
	{
		if (!this.m.IsBaseValuesSaved)
		{
			::logWarning("FU Mod resetField(\"" + _field + "\") skill \"" + this.getID() + "\" does not have base values saved.");
			::FU.Log.printStackTrace();
			return false;
		}

		this.m[_field] = this.b[_field];

		return true;
	}

	local setContainer = o.setContainer;
	o.setContainer = function( _c )
	{
		if (_c == null)
		{
			if (this.m.AIBehaviorID != null && !::FU.isNull(this.getContainer()))
			{
				local agent = this.getContainer().getActor().getAIAgent();
				local activeBehavior = agent.m.ActiveBehavior;
				if (activeBehavior != null && activeBehavior.getID() == this.m.AIBehaviorID) agent.m.FU_BehaviorToRemove = activeBehavior;
				else agent.removeBehaviorByStack(this.m.AIBehaviorID);
			}

			return setContainer(_c);
		}

		this.saveBaseValues();
		setContainer(_c);

		if (this.m.AIBehaviorID != null && !::FU.isNull(this.getContainer().getActor()))
		{
			local agent = this.getContainer().getActor().getAIAgent();
			if (!::FU.isNull(agent) && agent.getID() != ::Const.AI.Agent.ID.Player)
			{
				agent.addBehavior(::new(::FU.AI.getBehaviorScriptFromID(this.m.AIBehaviorID)));
				agent.finalizeBehaviors();
			}
		}
	}

	local setFatigueCost = o.setFatigueCost;
	o.setFatigueCost = function( _f )
	{
		this.setBaseValue("FatigueCost", _f);
		setFatigueCost(_f);
	}

	o.onMovementStarted <- function( _tile, _numTiles )
	{
	}

	o.onMovementFinished <- function( _tile )
	{
	}

	o.onMovementStep <- function( _tile, _levelDifference )
	{
	}

	o.onAfterDamageReceived <- function()
	{
	}

	o.onAnySkillExecuted <- function( _skill, _targetTile, _targetEntity, _forFree )
	{
	}

	o.onBeforeAnySkillExecuted <- function( _skill, _targetTile, _targetEntity, _forFree )
	{
	}

	o.onUpdateLevel <- function()
	{
	}

	o.getItemActionCost <- function( _items )
	{
	}

	o.getItemActionOrder <- function()
	{
		return this.m.ItemActionOrder;
	}

	o.onPayForItemAction <- function( _skill, _items )
	{
	}

	o.onNewMorning <- function()
	{
	}

	o.onGetHitFactors <- function( _skill, _targetTile, _tooltip ) 
	{
	}

	o.onGetHitFactorsAsTarget <- function( _skill, _targetTile, _tooltip )
	{
	}

	o.onQueryTileTooltip <- function( _tile, _tooltip )
	{
	}

	o.onQueryTooltip <- function( _skill, _tooltip )
	{
	}

	o.onDeathWithInfo <- function( _killer, _skill, _deathTile, _corpseTile, _fatalityType )
	{
	}

	o.onOtherActorDeath <- function( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{			
	}

	o.onEnterSettlement <- function( _settlement )
	{		
	}

	o.onEquip <- function( _item )
	{
	}

	o.onUnequip <- function( _item )
	{
	}

	o.onAffordablePreview <- function( _skill, _movementTile )
	{
	}

	o.modifyPreviewField <- function( _skill, _field, _newChange, _multiplicative )
	{
		::FU.Skills.modifyPreview(this, _skill, _field, _newChange, _multiplicative);
	}

	o.modifyPreviewProperty <- function( _skill, _field, _newChange, _multiplicative )
	{
		::FU.Skills.modifyPreview(this, null, _field, _newChange, _multiplicative);
	}

	local use = o.use;
	o.use = function( _targetTile, _forFree = false )
	{
		// Save the container as a local variable because some skills delete
		// themselves during use (e.g. Reload Bolt) causing this.m.Container
		// to point to null.
		local container = this.m.Container;
		local targetEntity = _targetTile.IsOccupiedByActor ? _targetTile.getEntity() : null;

		container.onBeforeAnySkillExecuted(this, _targetTile, targetEntity, _forFree);

		local ret = use(_targetTile, _forFree);

		container.onAnySkillExecuted(this, _targetTile, targetEntity, _forFree);

		return ret;
	}

	o.getDamageType <- function()
	{
		return this.m.DamageType;
	}

	o.getWeightedRandomDamageType <- function()
	{
		return this.m.DamageType.roll();
	}

	o.verifyTargetAndRange <- function( _targetTile, _origin = null )
	{
		if (_origin == null)
		{
			_origin = this.getContainer().getActor().getTile();	
		}
		
		return this.onVerifyTarget(_origin, _targetTile) && this.isInRange(_targetTile, _origin);
	}

	local getDescription = o.getDescription;
	o.getDescription = function()
	{
		if (this.m.DamageType.len() == 0 || !::FU.Mod.ModSettings.getSetting("ExpandedSkillTooltips").getValue())
		{
			return getDescription();
		}

		local ret = "[color=" + ::Const.UI.Color.NegativeValue + "]Inflicts ";

		foreach (d in this.m.DamageType.toArray())
		{
			local probability = ::Math.round(this.m.DamageType.getProbability(d) * 100);

			if (probability < 100)
			{
				ret += probability + "% ";
			}

			ret += ::Const.Damage.getDamageTypeName(d) + ", ";
		}

		ret = ret.slice(0, -2);

		ret += " Damage [/color]\n\n" + getDescription();

		return ret;
	}

	local getHitFactors = o.getHitFactors;
	o.getHitFactors = function( _targetTile )
	{
		local ret = getHitFactors(_targetTile);
		if (::FU.Mod.ModSettings.getSetting("ExpandedSkillTooltips").getValue() && ::FU.isIn("AdditionalAccuracy", this.m, true) && this.m.AdditionalAccuracy != 0)
		{
			local payload = {
				icon = this.m.AdditionalAccuracy > 0 ? "ui/tooltips/positive.png" : "ui/tooltips/negative.png",
				text = this.getName()
			};

			if (this.m.AdditionalAccuracy > 0) ret.insert(0, payload);
			else ret.push(payload);
		}
		this.getContainer().onGetHitFactors(this, _targetTile, ret);
		return ret;
	}

	o.getRangedTooltip <- function( _tooltip = null )
	{
		if (_tooltip == null) _tooltip = [];
		
		local rangeBonus = ", more";
		if (this.m.MaxRangeBonus == 0)
		{
			rangeBonus = " or"
		}
		else if (this.m.MaxRangeBonus < 0)
		{
			rangeBonus = ", less"
		}

		_tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=" + ::Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] tiles on even ground" + rangeBonus + " if shooting downhill"
		});

		local accuText = "";
		if (this.m.AdditionalAccuracy != 0)
		{
			local color = this.m.AdditionalAccuracy > 0 ? ::Const.UI.Color.PositiveValue : ::Const.UI.Color.NegativeValue;
			local sign = this.m.AdditionalAccuracy > 0 ? "+" : "";
			accuText = "Has [color=" + color + "]" + sign + this.m.AdditionalAccuracy + "%[/color] chance to hit";
		}

		if (this.m.AdditionalHitChance != 0)
		{
			accuText += this.m.AdditionalAccuracy == 0 ? "Has" : ", and";
			local additionalHitChance = this.m.AdditionalHitChance + this.getContainer().getActor().getCurrentProperties().HitChanceAdditionalWithEachTile;
			local sign = additionalHitChance > 0 ? "+" : "";
			accuText += " [color=" + (additionalHitChance > 0 ? ::Const.UI.Color.PositiveValue : ::Const.UI.Color.NegativeValue) + "]" + sign + additionalHitChance + "%[/color]";
			accuText += this.m.AdditionalAccuracy == 0 ? " chance to hit " : "";
			accuText += " per tile of distance";
		}

		if (accuText.len() != 0)
		{
			_tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = accuText
			});
		}

		return _tooltip;
	}
});

::FU.EndQueue.add(function() {
	::mods_hookBaseClass("skills/skill", function(o) {
		o = o[o.SuperName];
		foreach (func in ::FU.Skills.PreviewApplicableFunctions)
		{
			local oldFunc = o[func];
			o[func] = function()
			{
				if (!this.m.IsApplyingPreview) return oldFunc();

				local temp = {};
				foreach (field, change in this.PreviewField)
				{
					temp[field] <- this.m[field];
					if (change.Multiplicative)
					{
						this.m[field] *= change.Change;
					}
					else if (typeof change.Change == "boolean")
					{
						this.m[field] = change.Change;
					}
					else
					{
						this.m[field] += change.Change;
					}
				}

				local properties = this.getContainer().getActor().getCurrentProperties();
				foreach (field, change in this.getContainer().PreviewProperty)
				{
					temp[field] <- properties[field];
					if (change.Multiplicative)
					{
						properties[field] *= change.Change;
					}
					else if (typeof change.Change == "boolean")
					{
						properties[field] = change.Change;
					}
					else
					{
						properties[field] += change.Change;
					}
				}

				local ret = oldFunc();

				if (temp.len() > 0)
				{
					foreach (field, change in this.PreviewField)
					{
						this.m[field] = temp[field];
					}

					foreach (field, change in this.getContainer().PreviewProperty)
					{
						properties[field] = temp[field];
					}
				}

				return ret;
			}
		}

		local isAffordablePreview = o.isAffordablePreview;
		o.isAffordablePreview = function()
		{
			if (!this.getContainer().m.IsPreviewing) return isAffordablePreview();
			this.m.IsApplyingPreview = true;
			local ret = isAffordablePreview();
			this.m.IsApplyingPreview = false;
			return ret;
		}

		local getCostString = o.getCostString;
		o.getCostString = function()
		{
			if (!this.getContainer().m.IsPreviewing) return getCostString();
			local preview = ::Tactical.TurnSequenceBar.m.ActiveEntityCostsPreview;
			if (preview != null && preview.id == this.getContainer().getActor().getID())
			{
				this.m.IsApplyingPreview = true;
				local ret = getCostString();
				this.m.IsApplyingPreview = false;
				local skillID = this.getContainer().getActor().getPreviewSkillID();
				local str = " after " + (skillID == "" ? "moving" : "using " + this.getContainer().getSkillByID(skillID).getName());
				ret = ::FU.String.replace(ret, "Fatigue[/color]", "Fatigue[/color]" + str);
				return ret;
			}

			return getCostString();
		}
	});
});
