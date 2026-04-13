// Company data upload - gathers roster data and sends to the Legends API
::FU.UploadCompany <- {
	// Set this to your API server base URL
	BaseURL = "http://localhost:3000/api",

	function getDifficultyName()
	{
		switch (::World.Assets.getCombatDifficulty())
		{
			case ::Const.Difficulty.Easy: return "Easy";
			case ::Const.Difficulty.Normal: return "Normal";
			case ::Const.Difficulty.Hard: return "Hard";
			case ::Const.Difficulty.Legendary: return "Legendary";
			default: return "Unknown";
		}
	}

	function gatherCompanyData()
	{
		local roster = ::World.getPlayerRoster().getAll();
		local player = ::World.State.getPlayer();
		local assets = ::World.Assets;

		player.updateStrength();
		local powerLevel = player.getStrength();

		local brothers = [];
		foreach (bro in roster)
		{
			local broData = {
				name = bro.getName(),
				background = bro.getBackground() != null ? bro.getBackground().getNameOnly() : null,
				level = bro.getLevel(),
				daysWithCompany = bro.getDaysWithCompany(),
				battles = bro.m.LifetimeStats.Battles,
				kills = bro.m.LifetimeStats.Kills,
				mostPowerfulVanquished = bro.m.LifetimeStats.MostPowerfulVanquished,
				isCommander = ("IsCommander" in bro.m) ? bro.m.IsCommander : false,
				veteranPerks = ("VeteranPerks" in bro.m) ? bro.m.VeteranPerks : 0,
				gender = ("Gender" in bro.m) ? bro.m.Gender : null,
				hitpoints = bro.m.BaseProperties.Hitpoints,
				bravery = bro.m.BaseProperties.Bravery,
				fatigue = bro.m.BaseProperties.Stamina,
				initiative = bro.m.BaseProperties.Initiative,
				meleeSkill = bro.m.BaseProperties.MeleeSkill,
				meleeDefense = bro.m.BaseProperties.MeleeDefense,
				rangedSkill = bro.m.BaseProperties.RangedSkill,
				rangedDefense = bro.m.BaseProperties.RangedDefense,
				perks = [],
				equipment = []
			};

			// gather perks
			local skills = bro.getSkills().m.Skills;
			foreach (skill in skills)
			{
				if (skill.isType(::Const.SkillType.Perk))
				{
					broData.perks.push({
						id = skill.getID(),
						name = skill.getName(),
						wasAvailable = true,
						wasSelected = true
					});
				}
			}

			// gather equipment
			local items = bro.getItems();
			local slots = [
				{ key = ::Const.ItemSlot.Mainhand, name = "mainhand" },
				{ key = ::Const.ItemSlot.Offhand, name = "offhand" },
				{ key = ::Const.ItemSlot.Head, name = "head" },
				{ key = ::Const.ItemSlot.Body, name = "body" }
			];

			foreach (slot in slots)
			{
				local item = items.getItemAtSlot(slot.key);
				if (item != null)
				{
					local equipData = {
						slot = slot.name,
						id = item.getID(),
						name = item.getName(),
						script = item.ClassNameHash != null ? "" + item.ClassNameHash : null,
						value = item.getValue(),
						condition = item.getCondition(),
						weaponType = null
					};

					if ("getWeaponType" in item)
					{
						equipData.weaponType = "" + item.getWeaponType();
					}

					broData.equipment.push(equipData);
				}
			}

			// bag items
			local bagItems = items.getAllItemsAtSlot(::Const.ItemSlot.Bag);
			foreach (item in bagItems)
			{
				if (item != null)
				{
					local equipData = {
						slot = "bag",
						id = item.getID(),
						name = item.getName(),
						script = item.ClassNameHash != null ? "" + item.ClassNameHash : null,
						value = item.getValue(),
						condition = item.getCondition(),
						weaponType = null
					};
					broData.equipment.push(equipData);
				}
			}

			brothers.push(broData);
		}

		local companyData = {
			name = assets.getName(),
			powerLevel = powerLevel,
			daysSurvived = ::World.getTime().Days,
			difficulty = this.getDifficultyName(),
			origin = assets.getOrigin() != null ? assets.getOrigin().getID() : null,
			gameVersion = ::Legends.Version,
			brothers = brothers
		};

		return companyData;
	}

	function upload()
	{
		local companyData = this.gatherCompanyData();
		::FU.UI.JSConnection.uploadCompanyData({
			url = this.BaseURL + "/company",
			company = companyData
		});
	}

	function onResult( _result )
	{
		if (_result.success)
		{
			::logInfo("Company uploaded successfully. ID: " + _result.companyId);
			::FU.Popup.showRawText("Upload Successful", "Your company has been uploaded!\n\nCompany ID: " + _result.companyId + "\n\nUse this ID in Discord with /company " + _result.companyId);
		}
		else
		{
			::logError("Company upload failed: " + _result.message);
			::FU.Popup.showRawText("Upload Failed", "Could not upload company data.\n\n" + _result.message);
		}
	}

	// --- Fetching and spawning player companies ---

	// Callback mode: "worldmap" spawns a roaming party, "scenario" sets up for scenario battle
	FetchMode = null,

	function getMinorVersion()
	{
		local parts = split(::Legends.Version, ".");
		if (parts.len() >= 2) return parts[0] + "." + parts[1];
		return ::Legends.Version;
	}

	function fetchByPowerLevel( _minPower, _maxPower )
	{
		this.FetchMode = "worldmap";
		::FU.UI.JSConnection.fetchRandomCompany({
			url = this.BaseURL,
			minPower = _minPower,
			maxPower = _maxPower,
			version = this.getMinorVersion()
		});
	}

	function fetchById( _companyId )
	{
		this.FetchMode = "scenario";
		::FU.UI.JSConnection.fetchCompanyById({
			url = this.BaseURL,
			companyId = _companyId
		});
	}

	function onFetchResult( _result )
	{
		if (!_result.success)
		{
			::logError("Company fetch failed: " + _result.message);
			::FU.Popup.showRawText("Fetch Failed", _result.message);
			return;
		}

		local company = _result.company;
		::logInfo("Fetched company: " + company.name + " (power: " + company.power_level + ", brothers: " + company.brothers.len() + ")");

		if (this.FetchMode == "worldmap")
		{
			this.spawnAsWorldParty(company);
		}
		else if (this.FetchMode == "scenario")
		{
			this.spawnedCompanyData = company;
			::FU.Popup.showRawText("Company Loaded", company.name + "\nPower: " + company.power_level + "\nBrothers: " + company.brothers.len() + "\n\nReady for scenario battle.");
		}
	}

	// Store fetched company for scenario use
	spawnedCompanyData = null,

	function spawnAsWorldParty( _company )
	{
		local playerPos = ::World.State.getPlayer().getPos();
		local tile = ::World.getTileSquare(playerPos.X, playerPos.Y);

		// find a nearby valid tile to spawn on
		local spawnTile = null;
		for (local i = 1; i <= 6; i++)
		{
			if (tile.hasNextTile(i))
			{
				local next = tile.getNextTile(i);
				if (next.IsOccupied == false)
				{
					spawnTile = next;
					break;
				}
			}
		}

		if (spawnTile == null)
		{
			::logError("Could not find valid tile to spawn player company");
			::FU.Popup.showRawText("Spawn Failed", "No valid tile nearby to spawn the company.");
			return;
		}

		local party = ::World.spawnEntity("scripts/entity/world/party", spawnTile.Coords);
		party.setDescription("A player-submitted mercenary company: " + _company.name);
		party.setFootprintType(::Const.World.FootprintsType.Mercenaries);
		party.getFlags().set("IsFreeCompany", true);
		party.getFlags().set("IsPlayerCompany", true);
		party.getFlags().set("PlayerCompanyId", _company.id);
		party.setFaction(::World.FactionManager.getFactionOfType(::Const.FactionType.FreeCompany).getID());

		// build troops from the submitted brother data
		this.populatePartyFromCompanyData(party, _company);

		party.getLoot().Money = ::Math.rand(200, 600);
		party.getLoot().ArmorParts = ::Math.rand(5, 20);

		party.getSprite("base").setBrush("world_base_07");
		party.getSprite("body").setBrush("figure_mercenary_0" + ::Math.rand(1, 2));
		party.setName(_company.name);
		party.setMovementSpeed(::Const.World.MovementSettings.Speed * 0.95);
		party.setVisibilityMult(1.0);
		party.setAttackableByAI(true);

		::logInfo("Spawned player company: " + _company.name + " near player");
	}

	function populatePartyFromCompanyData( _party, _company )
	{
		// Map each brother into a free company troop
		// Use the standard free company unit types based on brother level/role
		foreach (i, bro in _company.brothers)
		{
			local troopScript;
			local troopStrength;

			// pick unit type based on level and role
			if (bro.is_commander || bro.level >= 10)
			{
				troopScript = "scripts/entity/tactical/humans/free_company_leader";
				troopStrength = 80;
			}
			else if (bro.ranged_skill > bro.melee_skill)
			{
				troopScript = "scripts/entity/tactical/humans/free_company_ranged";
				troopStrength = 40;
			}
			else if (bro.level >= 7)
			{
				troopScript = "scripts/entity/tactical/humans/free_company_veteran";
				troopStrength = 55;
			}
			else
			{
				troopScript = "scripts/entity/tactical/humans/free_company_fighter";
				troopStrength = 30;
			}

			local troop = clone ::Const.World.Common.TroopTemplate;
			troop.Script = troopScript;
			troop.Strength = troopStrength;
			troop.Variant = 0;
			troop.Name <- ("name" in bro) ? bro.name : "";
			troop.Faction <- _party.getFaction();
			troop.Party <- ::WeakTableRef(_party);

			_party.getTroops().push(troop);
		}

		_party.updateStrength();
	}
};
