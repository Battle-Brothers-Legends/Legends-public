// Adds from the *** profession tree to the profession tooltip
(function () {
	local professionToTreeMap = {};
	local trees = [];
	if ("ProfessionTrees" in ::Legends.Professions && "Tree" in ::Legends.Professions.ProfessionTrees) {
        trees.extend(::Legends.Professions.ProfessionTrees.Tree);
    }
	if ("DefaultProfessionTree" in ::Legends.Professions) {
        trees.push({
            Name = "Core",
            Tree = ::Legends.Professions.DefaultProfessionTree
        });
    }

	foreach (treeDefinition in trees) {
        local treeName = "Name" in treeDefinition ? treeDefinition.Name : "Default";
        foreach (row in treeDefinition.Tree) {
            foreach (professionDef in row) {
                if (!(professionDef in professionToTreeMap)) {
                    professionToTreeMap[professionDef] <- [];
                }

                if (professionToTreeMap[professionDef].find(treeName) == null) {
                    professionToTreeMap[professionDef].push(treeName);
                }
            }
        }
    }

	local pre = "[color=#0b0084]From the ";

    foreach (professionDef, treeNames in professionToTreeMap) {
        if (treeNames.len() == 0) continue;

        local defObject = ::Legends.Professions.ProfessionDefObjects[professionDef];

        if (!(defObject.Const in ::Const.Strings.ProfessionDescription)) {
            ::Const.Strings.ProfessionDescription[defObject.Const] <- defObject.Tooltip;
        }

        local desc = ::Const.Strings.ProfessionDescription[defObject.Const];

        local mid = "";
        local ap = "profession tree[/color]";

        if (treeNames.len() == 1) {
            mid += treeNames[0] + " ";
        } else {
            for (local i = 0; i < treeNames.len() - 2; i++) {
                mid += treeNames[i] + ", ";
            }
            mid += treeNames[treeNames.len() - 2] + " or ";
            mid += treeNames[treeNames.len() - 1] + " ";
            ap = "profession trees[/color]";
        }

        local start = desc.find(pre);
        if (start != null) {
            desc = desc.slice(0, start);
        }

        local description = ::strip(desc + "\n" + pre + mid + ap);
        ::Const.Strings.ProfessionDescription[defObject.Const] = description;
        defObject.Tooltip = description;

        local profID = "ID" in defObject ? defObject.ID : professionDef;
        if (profID in ::Legends.Professions.ProfessionsTreeTemplate.Map) {
            ::Legends.Professions.ProfessionsTreeTemplate.Map[profID].Tooltip = description;
        }
    }
})();
