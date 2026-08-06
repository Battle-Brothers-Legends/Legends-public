this.healer_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		MedsUsed = 0,
		Rate = 0,
		PointsNeeded = 0,
		Queue = null,
		InjuriesHealed = [],
		InjurySounds = []
	},
	function create() {
		this.camp_building.create();
		this.m.ID = ::Const.World.CampBuildings.Healer;
		this.m.BaseCraft = 1.0;
		this.m.ModName = "Healing";
		this.m.Escorting = true;
		this.m.Slot = "heal";
		this.m.Name = "Healing";
		this.m.Description = "Place brothers in reserves in order to heal from wounds.";
		this.m.BannerImage = "ui/buttons/banner_heal.png";
		local sounds = getCampSounds(3, "healer");
		this.m.Sounds = sounds;
		this.m.SoundsAtNight = sounds;
		this.m.InjurySounds = getCampSounds(1, "healer_treatment_bandage");
	}

	function isHidden() {
		if (::Legends.Settings.skipCamp())
			return false;
		return !::World.Flags.get(::Legends.Camp.Flag.Healer);
	}

	function getRate() {
		return ::Const.World.Assets.HitpointsPerHour * (1 + this.m.Rate) * (this.getUpgraded() ? 1.66 : 1.1);
	}

	function getTitle() {
		return this.m.Name + (this.getUpgraded() ? " *Upgraded*" : " *Not Upgraded*");
	}

	function getDescription() {
		// "The healing tent can be upgraded by purchasing a crafting cart from a settlement merchant. An upgraded tent provides a 66% increase in hitpoint recovery speed, 33% increase in wound treatment speed and a 25% decrease in medicine cost for each injury.";
		return "Injuries are a daily occurrence in a life of a mercenary. Assign brothers to patch up injuries and recover wounds of anyone in the company. Treating an injury costs extra medicine.";
	}

	function getModifierTooltip() {
		this.init();
		local ret = [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "There are [color=%positive%]" + this.m.Queue.len() + "[/color] injuries queued to be treated."
			},
			{
				id = 4,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take [color=%positive%]" + this.getRequiredTime() + "[/color] hours to treat all queued injuries."
			},
			{
				id = 5,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take [color=%positive%]" + this.Math.ceil(this.m.PointsNeeded / this.getRate()) + "[/color] hours to heal all healthpoints."
			},
			{
				id = 6,
				type = "text",
				icon = "ui/buttons/asset_medicine_up.png",
				text = "Total healing modifier is [color=%positive%]" + this.m.Rate * 100.0 + "%[/color]."
			}
		];
		local id = 7;
		foreach (bro in this.getModifiers().Modifiers) {
			ret.push({
				id = id++,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]" + bro[0] * 100.0 + "%[/color] " + bro[1] + " (" + bro[2] + ")"
			});
		}
		return ret;
	}

	function getUpgraded() {
		return ::Stash.hasItem(::Legends.Camp.Tent.Healer);
	}

	function getLevel()	{
		return (this.getUpgraded() ? "tent" : "dude") + "_" + (this.getAssignedBros() > 0 ? "full" : "empty");
	}

	function getCost(_injury) {
		local cost = _injury.getCost();
		return this.getUpgraded() ? ::Math.floor(cost * 0.75) : cost;
	}

	function init()	{
		this.m.MedsUsed = 0;
		this.m.InjuriesHealed = [];
		this.m.PointsNeeded = 0;

		foreach(bro in ::World.getPlayerRoster().getAll()) {
			bro.setCampHealing(0);
			this.m.PointsNeeded = ::Math.max(this.m.PointsNeeded, (bro.getHitpointsMax() - bro.getHitpoints()));
		}
		this.m.Rate = this.getModifiers().Craft;
		this.onInit();
	}

	function onInit() {
		local q = [];
		if (this.m.Queue == null) {
			foreach (b in ::World.getPlayerRoster().getAll()) {
				local injuries = b.getSkills().query(::Const.SkillType.TemporaryInjury).filter(@(_, _i) (!_i.isTreated() && _i.isTreatable() && _i.getQueue() != 0));
				foreach(i in injuries) {
					q.push({
						Injury = i,
						Bro = b.weakref()
					});
				}
			}
			q.sort(@(_a, _b) _a.Injury.getQueue() - _b.Injury.getQueue());
		}
		else {
			foreach (queueEntry in this.m.Queue) {
				if (queueEntry == null || queueEntry.Injury == null) { //Darxo's possible fix for injuries that heal automatically before they are tended in the tent
                	continue;
            	}
				local bro = queueEntry.Bro;
				if (bro == null || !this.isBroInRoster(bro)) {
                	continue;
            	}
				if (("isNull" in queueEntry.Injury && queueEntry.Injury.isNull()) || queueEntry.Injury.getQueue() == 0) {
					continue;
				}

				q.push(queueEntry);
			}
		}

		this.m.Queue = q;
	}

	function getResults()
	{
		local id = 30;
		local res = [];
		if (this.m.MedsUsed > 0) {
			res.push({
				id = id++,
				icon = "ui/buttons/asset_medicine_down.png",
				text = "You used [color=" + this.Const.UI.Color.NegativeEventValue + "]" + ::Math.floor(this.m.MedsUsed) + "[/color] units of medicine and treated [color=" + ::Const.UI.Color.PositiveEventValue + "]" + this.m.InjuriesHealed.len() + "[/color] injuries."
			});
		}

		local injuries = this.m.InjuriesHealed.filter(@(_, _i) (_i != null && _i.getIcon() != null && _i.getName() != null));
		foreach (i in injuries) {
			res.push({
				id = id++,
				icon = i.getIcon(),
				text = i.getName()
			});
		}

		local brosHealed = ::World.getPlayerRoster().getAll().filter(@(_, _b) (_b.getCampHealing() > 0));
		foreach(bro in brosHealed) {
			res.push({
				id = id++,
				icon = "ui/icons/health.png",
				text = bro.getName() + " healed [color=" + ::Const.UI.Color.PositiveEventValue + "]" + ::Math.floor(bro.getCampHealing()) + "[/color] points."
			});
		}
		return res;
	}

	function getModifiers() {
		local ret = this.camp_building.getModifiers();
		if (ret.Assigned == 0) {
			ret.Craft = this.m.BaseCraft *  ::Const.Difficulty.HealMult[::World.Assets.getEconomicDifficulty()];
		}
		return ret;
	}


	function getUpdateText() {
		local remainingInjuries = 0;
    	local activeInjury = null;

		local untreatedInjuries = this.m.Queue.filter(@(_, _i) (_i != null && _i.Injury != null && !_i.Injury.isTreated()));
		foreach (i in untreatedInjuries) {
			remainingInjuries++;
			if (activeInjury == null) {
				activeInjury = i;
			}
		}

		local healedTotal = this.m.InjuriesHealed.len();
		local injTotal = healedTotal + remainingInjuries;

		if (injTotal <= 0) {
			return "";
		}

		if (::World.Assets.getMedicine() <= 0) {
			return "No injuries being treated (Out of medicine!)";
		}

		local ret = "Injuries Treated ... " + healedTotal + " of " + injTotal;
		if (remainingInjuries == 0) {
			return ret;
		}

		ret += "\n" +  ::Math.floor(activeInjury.Injury.getTreatedPercentage() * 10000) / 100.0 + "% of " + activeInjury.Injury.getName() + " healed";
		return ret;
	}

	function update() {
		// Injury block
		if (this.m.Queue == null) {
			this.init();
		}

		local modifiers = this.getModifiers();
		for (local i = this.m.Queue.len() - 1; i >= 0; --i)	{
			local obj = this.m.Queue[i];
			if (obj == null || obj.Injury == null || ("isNull" in obj.Injury && obj.Injury.isNull()) || ("isGarbage" in obj.Injury && obj.Injury.isGarbage())) {
				this.m.Queue.remove(i);
				continue;
			}

			local bro = obj.Bro;
        	if (bro == null || !this.isBroInRoster(bro)) {
            	this.m.Queue.remove(i);
            	continue;
        	}
		}

		if(modifiers.Assigned > 0) {
			foreach (i, obj in this.m.Queue) {
				local r = obj.Injury;

				if (!r.isTreatable()) {
					this.logError(r.getName() + " in healer tent queue");
					continue;
				}
				if (r.isTreated()) {
					this.healInjury(i);
					continue;
				}

				if (::World.Assets.getMedicine() <= 0) {
					continue;
				}

				local needed = this.getCost(r) - r.getPoints();
				if (modifiers.Craft < needed) {
					needed = modifiers.Craft;
				}

				r.setPoints(r.getPoints() + needed);
				modifiers.Craft -= needed;

				::World.Assets.addMedicine(-needed);
				this.m.MedsUsed += needed;

				if (r.getPoints() >= this.getCost(r)) {
					this.healInjury(i);
				}

				if (modifiers.Craft <= 0) {
					break;
				}
			}
		}

		local injuryText = this.getUpdateText();
		if (injuryText != "") {
			injuryText += "</br>";
		}

		// Hitpoints block
		local currentMissingHP = 0.0;
		local healText = "Health points ... ";
		local rate = this.getRate();

		local brothersToHeal = ::World.getPlayerRoster().getAll().filter(@(_, _b) (_b.getHitpointsMax() - _b.getHitpoints() > 0));
		foreach (bro in brothersToHeal) {
			bro.setCampHealing(bro.getCampHealing() + rate);
			local newHitpoints = ::Math.minf(bro.getHitpointsMax(), bro.getHitpoints() + rate);
			bro.setHitpoints(newHitpoints);
			local missing = bro.getHitpointsMax().tofloat() - newHitpoints;
			if (missing > 0) {
				currentMissingHP += missing;
			}
		}

		if (::Math.abs(currentMissingHP) < 0.01) {
			healText += "100";
		} else {
			if (currentMissingHP > this.m.PointsNeeded) {
				this.m.PointsNeeded = currentMissingHP;
			}
			healText += ::Math.floor(((this.m.PointsNeeded - currentMissingHP) / this.m.PointsNeeded) * 100.0);
		}
		return injuryText + healText + "%";
	}

	function healInjury( _idx ) {
		local table = this.m.Queue[_idx];
		table.Injury.setTreated(true);
		table.Injury.setQueue(0);
		this.m.InjuriesHealed.push(table.Injury);
		local bro = table.Bro;
		if (bro != null) {
			if (this.isBroInRoster(bro)) {
				bro.updateInjuryVisuals();
			}
		}
		this.m.Queue[_idx] = null;
	}

	function getQueue() {
		local ret = [];
		local injuries = this.m.Queue.filter(@(_, _i) (_i != null));
		foreach(i in injuries) {
			local b = i.Injury;
			local r = {
				ID = b.getID(),
				Name = b.getName(),
				Description = b.getDescription(),
				ImagePath = b.getIcon(),
				Percentage = b.getTreatedPercentage() * 100
			};
			ret.push(r);
		}
		return ret;
	}

	function getRoster() {
		local roster = [];
		foreach(b in ::World.getPlayerRoster().getAll()) {
			local injuries = [];
			local untreatedInjuries = b.getSkills().query(::Const.SkillType.TemporaryInjury).filter(@(_, _i) (!_i.isTreated()));
			foreach (i in untreatedInjuries){
				injuries.push({
					id = i.getID(),
					icon = i.getIconColored(),
					name = i.getNameOnly(),
					price = this.getCost(i),
					treatable = i.isTreatable() && i.getQueue() == 0,
					points = i.getPoints()
				});
			}
			

			if (injuries.len() == 0) {
				continue;
			}

			local background = b.getBackground();
			local e = {
				ID = b.getID(),
				Name = b.getName(),
				ImagePath = b.getImagePath(),
				ImageOffsetX = b.getImageOffsetX(),
				ImageOffsetY = b.getImageOffsetY(),
				BackgroundImagePath = background.getIconColored(),
				BackgroundText = background.getDescription(),
				Injuries = injuries
			};
			roster.push(e);
		}
		return roster;
	}

	function isBroInRoster(_bro) {
		return ::World.getPlayerRoster().getAll().filter(@(_, _b) (_b.getID() == _bro.getID())).len() > 0 ? true : false;
	}

	function getRequiredMeds() {
		local points = 0;
		local injuries = this.m.Queue.filter(@(_, _i) (_i != null));
		foreach (i in injuries)	{
			points += this.getCost(i.Injury);
		}
		return points;
	}

	function getRequiredTime(){
		local craft = this.getModifiers().Craft;
        return (this.m.Queue != null && craft > 0) ? ::Math.ceil(this.getRequiredMeds() / craft) : 0;
	}

	function getAssignedBros() {
		return this.getModifiers().Assigned;
	}


	function getResourceImage()	{
		return "ui/buttons/icon_time.png";
	}

	function getResourceCount()	{
		this.init();
		return ::Math.max(this.getRequiredTime(), ::Math.ceil(this.m.PointsNeeded / this.getRate()));
	}

	function onAdd(_entityID, _injuryID)	{
		local entity = ::Tactical.getEntityByID(_entityID);
		local injury = entity.getSkills().getSkillByID(_injuryID);
		this.m.Queue.push({
			Injury = injury,
			Bro = entity.weakref()
		});
		injury.setQueue(this.m.Queue.len());
		this.playTreatmentSound();
	}

	function onRemove( _idx ) {
		this.m.Queue.remove(_idx).Injury.setQueue(0);
	}

	function onSwap( _source, _target) {
		local item = this.m.Queue[_source];
		item.Injury.setQueue(_target + 1);
		this.m.Queue[_target].Injury.setQueue(_source + 1);
		this.m.Queue[_source] = this.m.Queue[_target];
		this.m.Queue[_target] = item;
		this.playTreatmentSound();
	}

	function onBroLeave( _bro )	{
		foreach (i in _bro.getSkills().query(::Const.SkillType.TemporaryInjury)) {
			i.setQueue(0);
		}
	}

	function playTreatmentSound() {
		local sound = this.m.InjurySounds[::Math.rand(0, this.m.InjurySounds.len() - 1)];
		::Sound.play("sounds/" + sound.File, sound.Volume);
	}
});
