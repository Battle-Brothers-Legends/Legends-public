::mods_hookNewObjectOnce("ui/global/data_helper", function(o) {

	o.convertCampaignStorageToUIData = function ( _meta )
	{
		local d;
		d = " (" + this.Const.Strings.Difficulty[_meta.getInt("difficulty2")] + "/" + this.Const.Strings.Difficulty[_meta.getInt("difficulty")];

		if (_meta.getInt("ironman") == 1)
		{
			d = d + " Ironman";
		}

		d = d + ")";

		local legendsVersionText = "";
		if (_meta.getString("legendsVersion") == "")
		{
			legendsVersionText = "";
		}
		else
		{
			legendsVersionText = "Legends Version: " + _meta.getString("legendsVersion");
		}

		return {
			fileName = _meta.getFileName(),
			name = _meta.getName(),
			groupName = _meta.getString("groupname"),
			banner = _meta.getString("banner"),
			dayName = "Day " + _meta.getInt("days") + d,
			creationDate = _meta.getCreationDate(),
			isIncompatibleVersion = _meta.getVersion() < 33 || _meta.getVersion() > this.Const.Serialization.Version || !this.Const.DLC.isCompatible(_meta),
			isIronman = _meta.getInt("ironman") == 1,
			legendsVersion = legendsVersionText,
		};
	}

	o.convertHireRosterToUIData = function ( _rosterID )
	{
		local result = [];
		local roster = this.World.getRoster(_rosterID);

		if (roster == null)
			return null;

		local entities = roster.getAll();

		if (entities != null)
		{
			local result = [];

			foreach( entity in entities )
			{
				if (entity.isStabled())
				{
					continue;
				}
				result.push(this.convertEntityHireInformationToUIData(entity));
			}

			return result;
		}

		return null;
	}

	o.convertStablesRosterToUIData <- function ( _rosterID )
	{
		local result = [];
		local roster = this.World.getRoster(_rosterID);

		if (roster == null)
		{
			return null;
		}

		local entities = roster.getAll();

		if (entities != null)
		{
			local result = [];

			foreach( entity in entities )
			{
				if (!entity.isStabled())
				{
					continue;
				}
				result.push(this.convertEntityHireInformationToUIData(entity));
			}

			return result;
		}

		return null;
	}

	local convertAssetsInformationToUIData = o.convertAssetsInformationToUIData;
	o.convertAssetsInformationToUIData = function ()
	{
		local result = convertAssetsInformationToUIData();
		result.SuppliesMax <- this.World.Assets.getMaxArmorParts();
		result.AmmoMax <- this.World.Assets.getMaxAmmo();
		result.MedicineMax <- this.World.Assets.getMaxMedicine();

		return result;
	}

	local convertEntityToUIData = o.convertEntityToUIData;
	o.convertEntityToUIData = function ( _entity, _activeEntity )
	{
		local result = convertEntityToUIData(_entity, _activeEntity);
		result.perkTree <- [];

		local bg = _entity.getBackground();
		if (bg != null)
		{
			result.perkTree = _entity.getBackground().getPerkTree();
		}

		return result;
	}

	local convertEntityHireInformationToUIData = o.convertEntityHireInformationToUIData;
	o.convertEntityHireInformationToUIData = function ( _entity )
	{
		local result = convertEntityHireInformationToUIData(_entity);
		result.Talents <- _entity.getHiringTalents();
		return result;
	}

	local addCharacterToUIData = o.addCharacterToUIData;
	o.addCharacterToUIData = function ( _entity, _target )
	{
		addCharacterToUIData(_entity, _target);
		if (_entity.getBackground() != null)
		{
			_target.background <- _entity.getBackground().getID();
		}
		else
		{
			_target.background <- "";
		}
		_target.inReserves <- _entity.isInReserves();
		_target.stabled <- _entity.isStabled();
		_target.riderID <- _entity.getRiderID();
	}

	o.addStatsToUIData = function ( _entity, _target )
	{
		local properties = _entity.getCurrentProperties();
		_target.hitpoints <- _entity.getHitpoints();
		_target.hitpointsMax <- _entity.getHitpointsMax();
		_target.hitpointsTalent <- _entity.getTalents()[this.Const.Attributes.Hitpoints];
		_target.fatigue <- _entity.getFatigue();
		_target.fatigueMax <- _entity.getFatigueMax();
		_target.fatigueTalent <- _entity.getTalents()[this.Const.Attributes.Fatigue];
		_target.initiative <- _entity.getInitiative();
		_target.initiativeMax <- this.Const.CharacterMaxValue.Initiative;
		_target.initiativeTalent <- _entity.getTalents()[this.Const.Attributes.Initiative];
		_target.bravery <- _entity.getBravery();
		_target.braveryMax <- this.Const.CharacterMaxValue.Bravery;
		_target.braveryTalent <- _entity.getTalents()[this.Const.Attributes.Bravery];
		_target.meleeSkill <- properties.getMeleeSkill();
		_target.meleeSkillMax <- this.Const.CharacterMaxValue.MeleeSkill;
		_target.meleeSkillTalent <- _entity.getTalents()[this.Const.Attributes.MeleeSkill];
		_target.rangeSkill <- properties.getRangedSkill();
		_target.rangeSkillMax <- this.Const.CharacterMaxValue.RangedSkill;
		_target.rangeSkillTalent <- _entity.getTalents()[this.Const.Attributes.RangedSkill];
		_target.meleeDefense <- properties.getMeleeDefense();
		_target.meleeDefenseMax <- this.Const.CharacterMaxValue.MeleeDefense;
		_target.meleeDefenseTalent <- _entity.getTalents()[this.Const.Attributes.MeleeDefense];
		_target.rangeDefense <- properties.getRangedDefense();
		_target.rangeDefenseMax <- this.Const.CharacterMaxValue.RangedDefense;
		_target.rangeDefenseTalent <- _entity.getTalents()[this.Const.Attributes.RangedDefense];
		_target.actionPoints <- _entity.getActionPoints();
		_target.actionPointsMax <- _entity.getActionPointsMax();
		_target.morale <- _entity.getMoraleState();
		_target.moraleMax <- this.Const.MoraleState.COUNT - 1;
		_target.moraleLabel <- this.Const.MoraleStateName[_entity.getMoraleState()];

		local dm = 1.0;
		dm *= (_entity.isArmedWithMeleeWeapon() || _entity.getSkills().hasSkill("actives.hand_to_hand")) ? properties.MeleeDamageMult : 1.0;
		dm *= (_entity.isArmedWithMeleeWeapon() || _entity.getSkills().hasSkill("actives.hand_to_hand")) ? properties.RangedDamageMult : 1.0;

		local damageMin = properties.getRegularDamageAverage() * dm;
		local damageMax = this.Const.CharacterMaxValue.RegularDamage;

		local shouldbreak = false;
		foreach (slot in _entity.getSkills().getSkillsSortedByItems(this.Const.SkillType.Active))
		{
			foreach (active in slot)
			{
				if (active.isAttack() && !active.isHidden())
				{
					local p = _entity.getSkills().buildPropertiesForUse(active, null);
					damageMin = this.Math.floor(p.DamageRegularMin * p.DamageRegularMult * p.DamageTotalMult * (active.isRanged() ? p.RangedDamageMult : p.MeleeDamageMult) * p.DamageTooltipMinMult);
					damageMax = this.Math.floor(p.DamageRegularMax * p.DamageRegularMult * p.DamageTotalMult * (active.isRanged() ? p.RangedDamageMult : p.MeleeDamageMult) * p.DamageTooltipMaxMult);
					this.Math.floor(p.DamageRegularMin * p.DamageRegularMult * p.DamageTotalMult * p.MeleeDamageMult);
					shouldbreak = true;
					break;
				}
			}
			if (shouldbreak)
			{
				break;
			}
		}


		_target.regularDamage <- damageMin;
		_target.regularDamageMax <- damageMax;
		_target.regularDamageLabel <- damageMin + " - " + damageMax;
		_target.armorHead <- _entity.getArmor(this.Const.BodyPart.Head);
		_target.armorHeadMax <- _entity.getArmorMax(this.Const.BodyPart.Head);
		_target.armorHeadTalent <- 0;
		_target.armorBody <- _entity.getArmor(this.Const.BodyPart.Body);
		_target.armorBodyMax <- _entity.getArmorMax(this.Const.BodyPart.Body);
		_target.armorBodyTalent <- 0;
		_target.crushingDamage <- this.Math.floor(properties.getDamageArmorMult() * 100);
		_target.crushingDamageMax <- this.Const.CharacterMaxValue.ArmorDamage;
		_target.crushingDamageLabel <- this.Math.floor(properties.getDamageArmorMult() * 100) + "%";
		_target.chanceToHitHead <- properties.getHitchance(this.Const.BodyPart.Head);
		_target.chanceToHitHeadMax <- this.Const.CharacterMaxValue.Hitchance;
		_target.chanceToHitHeadLabel <- properties.getHitchance(this.Const.BodyPart.Head) + "%";
		_target.sightDistance <- properties.getVision();
		_target.sightDistanceMax <- this.Const.CharacterMaxValue.Vision;
	}


	o.convertPerksToUIData = function ()
	{
		return this.Const.Perks.PerksTreeTemplate;
	}

	local convertItemToUIData = o.convertItemToUIData;
	o.convertItemToUIData = function ( _item, _forceSmallIcon, _owner = null)
	{
		if (_item == null)
			return null;

		local result = convertItemToUIData(_item, _forceSmallIcon, _owner);
		if (result == null)
			return null;

		result.isChangeableInBattle = _item.isChangeableInBattle(null);
		result.isAllowedInBag = _item.isAllowedInBag();

		result.salvage <- _item.isToBeSalvaged();
		result.upgrades <- _item.getUpgrades();

		return result;
	}

	o.convertRepairItemsToUIData <- function ( _items, _target, _owner = null, _filter = 0 )
	{
		if (_filter == 0)
		{
			_filter = this.Const.Items.ItemFilter.All;
		}

		if (_items == null || _items.len() == 0)
		{
			return;
		}

		for( local i = 0; i < _items.len(); i = ++i )
		{
			if (_items[i] != null && _filter == 99 && _items[i].Bro != null)
			{
				local r = this.convertItemToUIData(_items[i].Item, true, _owner);
				r.bro <- _items[i].Bro;
				_target.push(r);
			}
			else if (_items[i] != null && (_items[i].Item.getItemType() & _filter) != 0)
			{
				local r = this.convertItemToUIData(_items[i].Item, true, _owner);
				r.bro <- _items[i].Bro;
				_target.push(r);
			}
			else
			{
				_target.push(null);
			}
		}
	}
});
