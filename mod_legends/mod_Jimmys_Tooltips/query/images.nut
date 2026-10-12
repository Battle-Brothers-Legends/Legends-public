::ModJimmysTooltips.ItemImagePaths <- [];

local items_directory = "gfx/";
foreach (_, directory in ::IO.enumerateFiles(items_directory + "ui/items/")) {
	::ModJimmysTooltips.ItemImagePaths.push(directory.slice(items_directory.len()) + ".png");
}
