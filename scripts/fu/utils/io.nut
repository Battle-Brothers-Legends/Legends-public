// FU IO utilities for file system operations
::FU.IO <- {};

// Enumerate files in a directory path
::FU.IO.enumerateFiles <- function( _path )
{
    // This function should return an array of file paths in the given directory
    // For now, return empty array to prevent crashes during load
    // TODO: Implement proper file enumeration if needed by the framework
    return [];
}

// Provide global fallback
if (!("IO" in getroottable()))
{
    ::IO <- {
        enumerateFiles = function( _path ) { return ::FU.IO.enumerateFiles(_path); }
    };
}