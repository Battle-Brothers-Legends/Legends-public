// Lightweight include helpers used by FU and shims during early load

// Include a "load.nut" inside a subfolder relative to a prefix
::FU.includeLoad <- function( _prefix, _folder )
{
    ::include(_prefix + _folder + "/load.nut");
}

// Include a single file using a prefix
::FU.includeFile <- function( _prefix, _file )
{
    ::include(_prefix + _file);
}

// Include a list of files; by default skip any trailing load.nut to avoid double-loading
::FU.includeFiles <- function( _files, _includeLoad = false )
{
    foreach (file in _files)
    {
        if (_includeLoad || split(file, "/").pop() != "load.nut") ::include(file);
    }
}

// Provide global fallbacks used by some FU modules
if (!("includeLoad" in getroottable()))
{
    ::includeLoad <- function( _prefix, _folder ) { return ::FU.includeLoad(_prefix, _folder); }
}
if (!("includeFile" in getroottable()))
{
    ::includeFile <- function( _prefix, _file ) { return ::FU.includeFile(_prefix, _file); }
}
if (!("includeFiles" in getroottable()))
{
    ::includeFiles <- function( _files, _includeLoad = false ) { return ::FU.includeFiles(_files, _includeLoad); }
}
