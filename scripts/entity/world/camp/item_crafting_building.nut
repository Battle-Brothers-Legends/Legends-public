this.item_crafting_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		ItemsCrafted = [],
		Queue = [],
		CurrentProgress = 0,
		CurrentCraft = null,
		NumBros = 0
	},

	function init() {
		this.onInit();
		this.m.ItemsCrafted = [];
		this.m.CurrentProgress = 0;
		this.m.CurrentCraft = null;
		local mod = this.getModifiers();
		this.m.NumBros = mod.Assigned;
	}

	function onInit() {
		local q = [];
		for (local i = 0; i < this.m.Queue.len(); i = ++i) {
			if (this.m.Queue[i] == null) {
				continue;
			}
			if (this.m.Queue[i].Blueprint == null) {
				continue;
			}
			q.push(this.m.Queue[i]);
		}
		this.m.Queue = q;
	}

	function getTitle() {
		return this.m.Name + (this.getUpgraded() ? " *Upgraded*" : " *Not Upgraded*");
	}

	function getModifierTooltip() {
		this.init();
		local mod = this.getModifiers();
		local ret = [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "There are " + ::Legends.S.colorizeAndPluralize(this.m.Queue.len(), "positive", "item") + " in the queue."
			},
			{
				id = 4,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take " + ::Legends.S.colorizeAndPluralize(this.getRequiredTime(), "positive", "hour") + " to finish."
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/repair_item.png",
				text = "Total " + this.m.ActivityName.tolower() + "ing modifier is " + ::Legends.S.colorizeAndPluralize(mod.Craft, "positive", "unit") + " per hour."
			}
		];
		local id = 6;
		foreach (bro in mod.Modifiers) {
			ret.push({
				id = id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = ::Legends.S.colorizeAndPluralize(bro[0], "positive", "unit") + " / hour " + bro[1] + " (" + bro[2] + ")"
			});
			++id;
		}
		return ret;
	}

	function getResults() {
		local res = [];
		local id = 20;
		foreach (b in this.m.ItemsCrafted) {
			res.push({
				id = id,
				icon = "ui/items/" + b.getIcon(),
				text = "Crafting completed: " + ::Legends.S.colorizeAndPluralize(b.getName(), "positiveEvent") + "."
			});
			++id;
		}
		return res;
	}

	function getLevel() {
		return (this.getUpgraded() ? "tent" : "dude") + "_" + (this.getAssignedBros() > 0 ? "full" : "empty");
	}

	function getUpdateText() {
		if (this.m.Queue.len() <= 0) {
			return null;
		}

		if (this.m.NumBros == 0) {
			return "No one assigned to " + this.m.ActivityName.tolower();
		}

		local crafted = this.m.ItemsCrafted.len();
		local craftableQueue = this.getCraftableQueue();
		local numToCraft = craftableQueue.len() + crafted;
		local progress = ::Math.floor(10000 * this.m.CurrentProgress) / 100.0;

		local ret = this.m.ActivityName + "ed ... " + crafted + " / ";
		if (craftableQueue.len() == 0) {
			return ret + crafted;
		}

		return ret + numToCraft + " ... " + progress + "%" + (this.m.CurrentCraft != null ? " of " + this.m.CurrentCraft : "");
	}

	function getCraftableQueue() {
		local itemsMap = ::World.Assets.getStash().getNumItemsMap(true);

		local craftable = [];
		for (local i = 0; i < this.m.Queue.len(); ++i) {
			local r = this.m.Queue[i];
			if (r == null) {
				continue;
			}

			local currentCosts = {};
			local canCraft = true;

			foreach (c in r.Blueprint.m.PreviewComponents) {
				if (c.Instance.getID() in itemsMap && c.Num <= itemsMap[c.Instance.getID()]) {
					currentCosts[c.Instance.getID()] <- c.Num;
				} else {
					canCraft = false;
					break;
				}
			}

			if (!canCraft) {
				continue;
			}

			foreach (id, num in currentCosts) itemsMap[id] -= num;

			craftable.push(i);
			if (r.Forever) {
				i--;
			}
		}
		return craftable;
	}

	function getQueue() {
		local ret = [];
		foreach (b in this.m.Queue) {
			if (b != null) {
				local r = b.Blueprint.getUIData();
				r.Percentage <- (b.Points / (b.Blueprint.getCostForCraft() * 1.0)) * 100;
				r.Forever <- b.Forever;
				ret.push(r);
			}
		}
		return ret;
	}

	function getResourceImage() {
		return "ui/buttons/icon_time.png";
	}

	function getResourceCount() {
		return this.getRequiredTime();
	}

	function getRequiredTime() {
		local points = 0;
		this.init();
		if (this.m.Queue == null) {
			return 0;
		}

		foreach (i in this.getCraftableQueue()) {
			local r = this.m.Queue[i];
			if (r == null) {
				continue;
			}

			points += (r.Blueprint.getCostForCraft() - r.Points);
		}
		local modifiers = this.getModifiers();
		if (modifiers.Craft <= 0) {
			return 0;
		}
		return ::Math.ceil(points / modifiers.Craft);
	}

	function getAssignedBros() {
		return this.getModifiers().Assigned;
	}

	function update() {
		local modifiers = this.getModifiers();
		foreach (i, r in this.m.Queue) {
			if (r == null || r.Blueprint == null || !r.Blueprint.isCraftable()) {
				continue;
			}

			local needed = r.Blueprint.getCostForCraft() - r.Points;

			if (modifiers.Craft < needed) {
				needed = modifiers.Craft;
			}
			r.Points += needed;
			modifiers.Craft -= needed;

			if (r.Points >= r.Blueprint.getCostForCraft()) {
				r.Blueprint.craft();
				r.Blueprint.onEnchant(this.getUpgraded()); // will do nothing if not a rune
				this.m.ItemsCrafted.push(r.Blueprint);
				if (r.Forever) {
					r.Points = 0;
					i -= 1;
				} else {
					this.m.Queue[i] = null;
				}

				::World.Statistics.getFlags().increment("ItemsCrafted");
			}

			if (modifiers.Craft <= 0) {
				this.m.CurrentProgress = r.Points / r.Blueprint.getCostForCraft();
				this.m.CurrentCraft = r.Blueprint.getName();
				break;
			}
		}

		return this.getUpdateText();
	}

	function onAdd(_blueprintID) {
		local blueprint = ::World.Crafting.getBlueprint(_blueprintID);
		this.m.Queue.push({
			Points = 0.0,
			Blueprint = blueprint,
			Forever = false
		});
		if (blueprint.getSounds().len() != 0) {
			::Sound.play(blueprint.getSounds()[::Math.rand(0, blueprint.getSounds().len() - 1)], 1.0);
		}
	}

	function onCraftForever(_blueprintID) {
		foreach (i in this.m.Queue) {
			if (i.Blueprint.getID() == _blueprintID && i.Forever) {
				return false;
			}
		}
		this.onAdd(_blueprintID);
		this.m.Queue[this.m.Queue.len() - 1].Forever = true;
		return true;
	}

	function onRemove(_idx) {
		this.m.Queue.remove(_idx);
	}

	function onSwap(_source, _target) {
		local item = this.m.Queue[_source];
		this.m.Queue[_source] = this.m.Queue[_target];
		this.m.Queue[_target] = item;
		if (item.Blueprint.getSounds().len() != 0) {
			::Sound.play(item.Blueprint.getSounds()[::Math.rand(0, item.Blueprint.getSounds().len() - 1)], 1.0);
		}
	}

	function onSerialize( _out ) {
		this.onInit(); //clear out null queue items
		this.camp_building.onSerialize(_out);
		_out.writeU16(this.m.Queue.len());
		foreach( b in this.m.Queue )
		{
			_out.writeString(b.Blueprint.getID());
			_out.writeF32(b.Points);
			_out.writeBool(b.Forever);
		}
	}

	function onDeserialize( _in ) {
		this.m.Queue = [];
		this.camp_building.onDeserialize(_in);
		local num = _in.readU16();
		for( local i = 0; i < num; ++i ) {
			this.m.Queue.push({
				Blueprint =  this.World.Crafting.getBlueprint(_in.readString()),
				Points = _in.readF32(),
				Forever = _in.readBool()
			});
		}
	}
});
