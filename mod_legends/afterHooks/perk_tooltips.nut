// refresh perk tooltips after all mods are loaded
::Legends.updatePerkGroupTooltips <- function(_perkDef = null, _groups = []) {
	local map = {};

	foreach (group in ::Const.Perks) {
		if (!("Name" in group))
			continue;

		foreach (row in group.Tree) {
			foreach (perkDef in row) {
				if (_perkDef != null && perkDef != _perkDef)
					continue;

				if (!(perkDef in map))
					map[perkDef] <- {
						Groups = [],
						Const = perkDef
					};
				map[perkDef].Groups.push(group.Name);
			}
		}
	}

	foreach (perk, table in map) {
		local desc = ::Legends.tooltip(::Const.Strings.PerkDescription[::Const.Perks.PerkDefObjects[perk].Const]);

		local pre = "[color=#0b0084]From the ";
		local mid = "";
		local ap = "perk group[/color]";
		local array = _groups.len() == 0 ? table.Groups : _groups;
		if (array.len() == 1) {
			mid += array[0] + " ";
		} else {
			for (local i = 0; i < array.len() - 2; i++) {
				mid += array[i] + ", ";
			}
			mid += array[array.len() - 2] + " or ";
			mid += array[array.len() - 1] + " ";
			ap = "perk groups[/color]";
		}

		if (desc.find(pre) == null) {
			local text = "\n" + pre + mid + ap;
			::Const.Strings.PerkDescription[::Const.Perks.PerkDefObjects[perk].Const] = desc + text;
			::Const.Perks.PerkDefObjects[table.Const].Tooltip = desc + text;
		} else {
			local strArray = split(desc, "[");

			strArray.pop();
			strArray.apply(@(a) a += "[");

			strArray[strArray.len() - 1] = "color=#0b0084]From the " + mid + ap;

			if (strArray[0].find("color=") != null) {
				strArray[0] = "[" + strArray[0];
			}

			local ret = "";
			foreach (s in strArray) {
				ret += s;
			}

			if (ret.find("\n\n" + pre) == null) {
				local prefix = ret.find("\n" + pre) == null ? "\n\n" : "\n";
				ret = this.MSU.String.replace(ret, pre, prefix + pre);
			}

			::logInfo("saving " + ret);

			::Const.Strings.PerkDescription[::Const.Perks.PerkDefObjects[perk].Const] = ret;
			::Const.Perks.PerkDefObjects[table.Const].Tooltip = ret;
		}
	}
}

::Legends.updatePerkGroupTooltips();
