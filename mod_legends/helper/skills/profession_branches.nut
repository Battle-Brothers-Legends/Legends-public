// the profession def, the number used everywhere in ::Legends.Profession, for a profession ID
::Legends.Professions.Branches.getDef <- function (_id) {

	if (!(_id in ::Legends.Professions.LookupMap))
	{
		return null;
	}

	return ::Legends.Professions.ProfessionDefs[::Legends.Professions.LookupMap[_id].Const];
}

::Legends.Professions.Branches.getBackgroundList <- function (_bro, _list) {

	local background = _bro.getBackground();
	if (background == null)
	{
		return [];
	}

	local key = background.getID();
	if (key.len() > 11)
	{
		key = key.slice(11);
	}

	if (!(key in this.Backgrounds) || !(_list in this.Backgrounds[key]))
	{
		return [];
	}

	return this.Backgrounds[key][_list];
}

::Legends.Professions.Branches.isAllowed <- function (_bro, _profession) {

	if (!(_profession in this.Special) || this.getBackgroundList(_bro, "Special").find(_profession) != null)
	{
		return true;
	}

	// a special profession the bro rolled or was given is in his stored tree
	local background = _bro.getBackground();
	return background != null && background.m.ProfessionTreeMap != null && background.hasProfession(_profession);
}

::Legends.Professions.Branches.isLearned <- function (_bro, _profession) {

	return _bro.getSkills().hasSkill(::Legends.Professions.ProfessionDefObjects[_profession].ID);
}

// locked means it is shown but can not be learned yet, none of the professions leading to it has been learned
::Legends.Professions.Branches.isLocked <- function (_bro, _profession) {

	if (!this.isAllowed(_bro, _profession))
	{
		return true;
	}

	if (!(_profession in this.Requires))
	{
		return false;
	}

	foreach (required in this.Requires[_profession])
	{
		if (this.isLearned(_bro, required))
		{
			return false;
		}
	}

	return true;
}

::Legends.Professions.Branches.getVisible <- function (_bro) {

	local visible = {};
	local plan = _bro.getProfessionPlan();

	foreach (row in _bro.getBackground().getProfessionTree())
	{
		foreach (profession in row)
		{
			visible[::Legends.Professions.ProfessionDefs[profession.Const]] <- true;
		}
	}

	foreach (profession in this.getBackgroundList(_bro, "Roots"))
	{
		visible[profession] <- true;
	}

	foreach (profession in this.getBackgroundList(_bro, "Special"))
	{
		visible[profession] <- true;
	}

	foreach (profession, _ in ::Legends.Professions.ProfessionDefObjects)
	{
		if (this.isLearned(_bro, profession))
		{
			visible[profession] <- true;
		}
	}

	// a learned profession reveals what it leads to for the planned perk shit
	local added = true;
	while (added) {
		added = false;

		foreach (profession, _ in visible)
		{
			if (!(profession in this.LeadsTo))
			{
				continue;
			}

			local id = ::Legends.Professions.ProfessionDefObjects[profession].ID;
			local isPlanned = id in plan && (plan[id] == 1 || plan[id] == 2);
			if (!isPlanned && !this.isLearned(_bro, profession))
			{
				continue;
			}

			foreach (next in this.LeadsTo[profession])
			{
				if (!(next in visible) && this.isAllowed(_bro, next))
				{
					visible[next] <- true;
					added = true;
				}
			}

			if (added)
			{
				break; // Another one
			}
		}
	}

	return visible;
}

::Legends.Professions.Branches.getProfession <- function (_id) {

	local profession = this.getDef(_id);
	if (profession == null)
	{
		return null;
	}

	local ret = clone ::Legends.Professions.ProfessionDefObjects[profession];
	ret.Row <- profession in this.Depth ? this.Depth[profession] : 0;
	ret.Unlocks <- 0; // the row no longer gates anything, isLocked does
	return ret;
}

::Legends.Professions.Branches.getTree <- function (_bro) {

	local visible = this.getVisible(_bro);
	local rows = {};

	foreach (profession, _ in visible)
	{
		local isBelow = false;

		if (profession in this.Requires)
		{
			foreach (required in this.Requires[profession])
			{
				if (required in visible)
				{
					isBelow = true;
					break;
				}
			}
		}

		if (!isBelow)
		{
			rows[profession] <- profession in this.Depth ? this.Depth[profession] : 0;
		}
	}

	local changed = true;
	while (changed)
	{
		changed = false;

		foreach (profession, _ in visible)
		{
			if (!(profession in this.Requires))
			{
				continue;
			}

			foreach (required in this.Requires[profession])
			{
				if (!(required in rows) || !(required in visible))
				{
					continue;
				}

				if (!(profession in rows) || rows[profession] > rows[required] + 1)
				{
					rows[profession] <- rows[required] + 1;
					changed = true;
				}
			}
		}
	}

	local tree = [];
	foreach (profession, row in rows)
	{
		local entry = this.getProfession(::Legends.Professions.ProfessionDefObjects[profession].ID);
		entry.IsLocked <- this.isLocked(_bro, profession);
		entry.Sort <- "";

		while (tree.len() <= row)
		{
			tree.push([]);
		}
		tree[row].push(entry);
	}

	tree = tree.filter(@(_, _row) _row.len() != 0);

	foreach (i, row in tree)
	{
		foreach (entry in row)
		{
			local place = 99;
			local profession = this.getDef(entry.ID);

			if (i > 0 && profession in this.Requires)
			{
				foreach (j, above in tree[i - 1])
				{
					if (this.Requires[profession].find(this.getDef(above.ID)) != null)
					{
						place = j;
						break;
					}
				}
			}

			entry.Row = i;
			entry.Sort = ::format("%02d", place) + entry.Name;
		}

		row.sort(@(_a, _b) _a.Sort <=> _b.Sort);
	}

	return tree;
}

::Legends.Professions.Branches.prunePlan <- function (_bro) {

	local plan = _bro.getProfessionPlan();
	local removed = true;

	while (removed)
	{
		removed = false;
		local visible = this.getVisible(_bro);

		foreach (id, _ in plan)
		{
			local profession = this.getDef(id);
			if (profession == null || !(profession in visible))
			{
				delete plan[id];
				removed = true;
				break;
			}
		}
	}
}

::Legends.Professions.Branches.setupBro <- function (_bro) {

	local background = _bro.getBackground();
	if (background == null || !("Assets" in ::World) || ::World.Assets == null)
	{
		return;
	}

	foreach (profession in this.getBackgroundList(_bro, "Known"))
	{
		::Legends.Professions.grant(_bro, profession);
	}

	// any bro can chance into a root he would not have from his background
	local candidates = [];
	foreach (profession in this.ExtraRoots)
	{
		if (!this.isLearned(_bro, profession) && this.getBackgroundList(_bro, "Roots").find(profession) == null)
		{
			candidates.push(profession);
		}
	}

	local tree = [];
	foreach (row in background.m.CustomProfessionTree)
	{
		tree.push(clone row);
	}

	if (tree.len() == 0)
	{
		tree.push([]);
	}

	for (local i = 0; i < this.RandomRoots && candidates.len() != 0; ++i)
	{
		tree[0].push(candidates.remove(::Math.rand(0, candidates.len() - 1)));
	}

	// and now and then into a favoured enemy his background does not give
	if (::Math.rand(1, 100) <= this.RandomFavouredEnemyChance)
	{
		local special = this.getBackgroundList(_bro, "Special");
		local enemies = this.FavouredEnemies.filter(@(_, _p) special.find(_p) == null);

		if (enemies.len() != 0)
		{
			tree[0].push(enemies[::Math.rand(0, enemies.len() - 1)]);
		}
	}

	background.rebuildProfessionTree(tree);
}

::Legends.Professions.Branches.getNames <- function (_professions, _last) {
	local text = "";

	foreach (i, profession in _professions)
	{
		if (i != 0)
		{
			text += i == _professions.len() - 1 ? _last : ", ";
		}
		text += ::Legends.Professions.ProfessionDefObjects[profession].Name;
	}

	return text;
}

::Legends.Professions.Branches.getTooltip <- function (_bro, _id) {
	local ret = [];
	local profession = this.getDef(_id);
	if (profession == null) {
		return ret;
	}

	if (profession in this.Special) {
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Only some backgrounds can learn this"
		});
	}

	if (profession in this.LeadsTo) {
		local next = this.LeadsTo[profession].filter(@(_, _p) ::Legends.Professions.Branches.isAllowed(_bro, _p));
		if (next.len() != 0) {
			ret.push({
				id = 21,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Leads to " + this.getNames(next, " and ")
			});
		}
	}

	if (!this.isLearned(_bro, profession) && this.isLocked(_bro, profession) && profession in this.Requires) {
		ret.push({
			id = 22,
			type = "hint",
			icon = "ui/icons/icon_locked.png",
			text = "Locked until " + this.getNames(this.Requires[profession], " or ") + " is learned"
		});
	}

	return ret;
}
