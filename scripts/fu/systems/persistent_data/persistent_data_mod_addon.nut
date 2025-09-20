::FU.Class.PersistentDataModAddon <- class extends ::FU.Class.SystemModAddon
{
	function loadFile( _fileID )
	{
		::FU.System.PersistentData.loadFileForMod(this.Mod.getID(), _fileID);
	}

	function loadAllFiles()
	{
		::FU.System.PersistentData.loadAllFilesForMod(this.Mod.getID());
	}

	function writeToLog( _fileID, _payload )
	{
		::FU.System.PersistentData.writeToLog(_fileID, this.Mod.getID(), _payload);
	}
}
