# Generated from grammars/SquirrelParser.g4 by ANTLR 4.13.2
# encoding: utf-8
from antlr4 import *
from io import StringIO
import sys
if sys.version_info[1] > 5:
	from typing import TextIO
else:
	from typing.io import TextIO

def serializedATN():
    return [
        4,1,88,610,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,
        6,2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,
        2,14,7,14,2,15,7,15,2,16,7,16,2,17,7,17,2,18,7,18,2,19,7,19,2,20,
        7,20,2,21,7,21,2,22,7,22,2,23,7,23,2,24,7,24,2,25,7,25,2,26,7,26,
        2,27,7,27,2,28,7,28,2,29,7,29,2,30,7,30,2,31,7,31,2,32,7,32,2,33,
        7,33,2,34,7,34,2,35,7,35,2,36,7,36,2,37,7,37,2,38,7,38,2,39,7,39,
        2,40,7,40,2,41,7,41,2,42,7,42,2,43,7,43,1,0,1,0,1,0,1,1,5,1,93,8,
        1,10,1,12,1,96,9,1,1,2,1,2,5,2,100,8,2,10,2,12,2,103,9,2,1,3,1,3,
        1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3,
        1,3,3,3,124,8,3,1,4,1,4,1,4,1,4,1,5,1,5,1,5,1,5,1,5,1,5,1,5,3,5,
        137,8,5,1,6,1,6,1,6,1,6,1,6,1,6,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,8,
        1,8,1,8,1,8,1,8,1,8,5,8,158,8,8,10,8,12,8,161,9,8,1,8,3,8,164,8,
        8,1,8,1,8,1,9,1,9,1,9,1,9,1,9,1,10,1,10,1,10,1,10,1,11,1,11,1,11,
        3,11,180,8,11,1,11,1,11,3,11,184,8,11,1,11,1,11,3,11,188,8,11,1,
        11,1,11,1,11,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,13,1,13,1,
        13,1,13,3,13,205,8,13,1,14,1,14,1,15,1,15,1,16,1,16,3,16,213,8,16,
        1,17,1,17,3,17,217,8,17,1,18,1,18,1,18,1,18,1,18,1,18,1,18,3,18,
        226,8,18,1,19,1,19,1,19,1,19,3,19,232,8,19,1,19,1,19,5,19,236,8,
        19,10,19,12,19,239,9,19,1,19,1,19,1,20,1,20,1,20,3,20,246,8,20,1,
        20,1,20,1,20,5,20,251,8,20,10,20,12,20,254,9,20,1,21,1,21,1,21,1,
        21,1,21,1,21,3,21,262,8,21,1,21,1,21,1,22,1,22,1,22,1,23,1,23,1,
        23,1,23,1,23,1,24,1,24,1,25,3,25,277,8,25,1,25,1,25,1,25,3,25,282,
        8,25,1,26,1,26,1,26,1,26,1,26,1,26,1,26,1,27,1,27,1,27,1,27,5,27,
        295,8,27,10,27,12,27,298,9,27,1,27,1,27,1,28,1,28,1,28,1,28,3,28,
        306,8,28,1,29,3,29,309,8,29,1,29,1,29,1,29,1,29,3,29,315,8,29,1,
        29,1,29,1,29,1,29,1,29,1,29,3,29,323,8,29,1,29,1,29,1,29,1,29,1,
        29,1,29,3,29,331,8,29,1,30,1,30,1,30,5,30,336,8,30,10,30,12,30,339,
        9,30,1,31,1,31,1,31,3,31,344,8,31,1,32,1,32,1,32,5,32,349,8,32,10,
        32,12,32,352,9,32,1,32,1,32,3,32,356,8,32,1,32,3,32,359,8,32,1,33,
        1,33,1,33,3,33,364,8,33,1,34,1,34,1,34,5,34,369,8,34,10,34,12,34,
        372,9,34,1,35,1,35,1,35,1,35,1,35,1,35,3,35,380,8,35,1,36,1,36,1,
        36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,3,36,392,8,36,1,36,3,36,395,
        8,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,3,36,407,
        8,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,3,36,416,8,36,1,36,1,36,
        1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,
        1,36,1,36,1,36,1,36,1,36,1,36,3,36,439,8,36,1,36,1,36,1,36,1,36,
        1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,
        1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,
        1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,
        1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,
        1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,
        1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,
        1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,
        1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,1,36,3,36,545,8,36,1,36,
        1,36,1,36,1,36,1,36,5,36,552,8,36,10,36,12,36,555,9,36,1,37,1,37,
        3,37,559,8,37,1,37,1,37,1,37,1,38,1,38,5,38,566,8,38,10,38,12,38,
        569,9,38,1,38,1,38,1,39,1,39,1,39,1,39,1,39,1,39,1,39,3,39,580,8,
        39,1,39,3,39,583,8,39,1,40,1,40,1,40,1,40,1,41,1,41,1,41,1,41,1,
        41,1,41,1,42,1,42,1,42,1,42,1,43,1,43,1,43,5,43,602,8,43,10,43,12,
        43,605,9,43,1,43,3,43,608,8,43,1,43,0,1,72,44,0,2,4,6,8,10,12,14,
        16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,
        60,62,64,66,68,70,72,74,76,78,80,82,84,86,0,3,2,0,1,1,43,43,1,0,
        44,45,2,0,17,17,39,39,690,0,88,1,0,0,0,2,94,1,0,0,0,4,97,1,0,0,0,
        6,123,1,0,0,0,8,125,1,0,0,0,10,129,1,0,0,0,12,138,1,0,0,0,14,144,
        1,0,0,0,16,151,1,0,0,0,18,167,1,0,0,0,20,172,1,0,0,0,22,176,1,0,
        0,0,24,192,1,0,0,0,26,204,1,0,0,0,28,206,1,0,0,0,30,208,1,0,0,0,
        32,210,1,0,0,0,34,214,1,0,0,0,36,225,1,0,0,0,38,227,1,0,0,0,40,245,
        1,0,0,0,42,255,1,0,0,0,44,265,1,0,0,0,46,268,1,0,0,0,48,273,1,0,
        0,0,50,281,1,0,0,0,52,283,1,0,0,0,54,290,1,0,0,0,56,301,1,0,0,0,
        58,330,1,0,0,0,60,332,1,0,0,0,62,340,1,0,0,0,64,358,1,0,0,0,66,360,
        1,0,0,0,68,365,1,0,0,0,70,379,1,0,0,0,72,438,1,0,0,0,74,556,1,0,
        0,0,76,563,1,0,0,0,78,579,1,0,0,0,80,584,1,0,0,0,82,588,1,0,0,0,
        84,594,1,0,0,0,86,598,1,0,0,0,88,89,3,2,1,0,89,90,5,0,0,1,90,1,1,
        0,0,0,91,93,3,4,2,0,92,91,1,0,0,0,93,96,1,0,0,0,94,92,1,0,0,0,94,
        95,1,0,0,0,95,3,1,0,0,0,96,94,1,0,0,0,97,101,3,6,3,0,98,100,5,38,
        0,0,99,98,1,0,0,0,100,103,1,0,0,0,101,99,1,0,0,0,101,102,1,0,0,0,
        102,5,1,0,0,0,103,101,1,0,0,0,104,124,3,8,4,0,105,124,3,10,5,0,106,
        124,3,12,6,0,107,124,3,14,7,0,108,124,3,16,8,0,109,124,3,22,11,0,
        110,124,3,24,12,0,111,124,3,28,14,0,112,124,3,30,15,0,113,124,3,
        32,16,0,114,124,3,34,17,0,115,124,3,38,19,0,116,124,3,42,21,0,117,
        124,3,44,22,0,118,124,3,46,23,0,119,124,3,54,27,0,120,124,3,52,26,
        0,121,124,3,36,18,0,122,124,3,72,36,0,123,104,1,0,0,0,123,105,1,
        0,0,0,123,106,1,0,0,0,123,107,1,0,0,0,123,108,1,0,0,0,123,109,1,
        0,0,0,123,110,1,0,0,0,123,111,1,0,0,0,123,112,1,0,0,0,123,113,1,
        0,0,0,123,114,1,0,0,0,123,115,1,0,0,0,123,116,1,0,0,0,123,117,1,
        0,0,0,123,118,1,0,0,0,123,119,1,0,0,0,123,120,1,0,0,0,123,121,1,
        0,0,0,123,122,1,0,0,0,124,7,1,0,0,0,125,126,5,34,0,0,126,127,3,2,
        1,0,127,128,5,35,0,0,128,9,1,0,0,0,129,130,5,50,0,0,130,131,5,32,
        0,0,131,132,3,72,36,0,132,133,5,33,0,0,133,136,3,4,2,0,134,135,5,
        51,0,0,135,137,3,4,2,0,136,134,1,0,0,0,136,137,1,0,0,0,137,11,1,
        0,0,0,138,139,5,48,0,0,139,140,5,32,0,0,140,141,3,72,36,0,141,142,
        5,33,0,0,142,143,3,4,2,0,143,13,1,0,0,0,144,145,5,49,0,0,145,146,
        3,4,2,0,146,147,5,48,0,0,147,148,5,32,0,0,148,149,3,72,36,0,149,
        150,5,33,0,0,150,15,1,0,0,0,151,152,5,70,0,0,152,153,5,32,0,0,153,
        154,3,72,36,0,154,155,5,33,0,0,155,159,5,34,0,0,156,158,3,18,9,0,
        157,156,1,0,0,0,158,161,1,0,0,0,159,157,1,0,0,0,159,160,1,0,0,0,
        160,163,1,0,0,0,161,159,1,0,0,0,162,164,3,20,10,0,163,162,1,0,0,
        0,163,164,1,0,0,0,164,165,1,0,0,0,165,166,5,35,0,0,166,17,1,0,0,
        0,167,168,5,71,0,0,168,169,3,72,36,0,169,170,5,39,0,0,170,171,3,
        2,1,0,171,19,1,0,0,0,172,173,5,72,0,0,173,174,5,39,0,0,174,175,3,
        2,1,0,175,21,1,0,0,0,176,177,5,58,0,0,177,179,5,32,0,0,178,180,3,
        4,2,0,179,178,1,0,0,0,179,180,1,0,0,0,180,181,1,0,0,0,181,183,5,
        38,0,0,182,184,3,4,2,0,183,182,1,0,0,0,183,184,1,0,0,0,184,185,1,
        0,0,0,185,187,5,38,0,0,186,188,3,4,2,0,187,186,1,0,0,0,187,188,1,
        0,0,0,188,189,1,0,0,0,189,190,5,33,0,0,190,191,3,4,2,0,191,23,1,
        0,0,0,192,193,5,59,0,0,193,194,5,32,0,0,194,195,3,26,13,0,195,196,
        5,60,0,0,196,197,3,72,36,0,197,198,5,33,0,0,198,199,3,4,2,0,199,
        25,1,0,0,0,200,205,5,87,0,0,201,202,5,87,0,0,202,203,5,40,0,0,203,
        205,5,87,0,0,204,200,1,0,0,0,204,201,1,0,0,0,205,27,1,0,0,0,206,
        207,5,52,0,0,207,29,1,0,0,0,208,209,5,53,0,0,209,31,1,0,0,0,210,
        212,5,54,0,0,211,213,3,72,36,0,212,211,1,0,0,0,212,213,1,0,0,0,213,
        33,1,0,0,0,214,216,5,68,0,0,215,217,3,72,36,0,216,215,1,0,0,0,216,
        217,1,0,0,0,217,35,1,0,0,0,218,219,5,57,0,0,219,226,3,60,30,0,220,
        221,5,57,0,0,221,222,5,56,0,0,222,223,3,68,34,0,223,224,3,74,37,
        0,224,226,1,0,0,0,225,218,1,0,0,0,225,220,1,0,0,0,226,37,1,0,0,0,
        227,228,5,74,0,0,228,231,3,40,20,0,229,230,5,75,0,0,230,232,3,40,
        20,0,231,229,1,0,0,0,231,232,1,0,0,0,232,233,1,0,0,0,233,237,5,34,
        0,0,234,236,3,58,29,0,235,234,1,0,0,0,236,239,1,0,0,0,237,235,1,
        0,0,0,237,238,1,0,0,0,238,240,1,0,0,0,239,237,1,0,0,0,240,241,5,
        35,0,0,241,39,1,0,0,0,242,243,5,73,0,0,243,246,5,43,0,0,244,246,
        5,1,0,0,245,242,1,0,0,0,245,244,1,0,0,0,245,246,1,0,0,0,246,247,
        1,0,0,0,247,252,5,87,0,0,248,249,7,0,0,0,249,251,5,87,0,0,250,248,
        1,0,0,0,251,254,1,0,0,0,252,250,1,0,0,0,252,253,1,0,0,0,253,41,1,
        0,0,0,254,252,1,0,0,0,255,256,5,64,0,0,256,257,3,4,2,0,257,261,5,
        65,0,0,258,259,5,32,0,0,259,260,5,87,0,0,260,262,5,33,0,0,261,258,
        1,0,0,0,261,262,1,0,0,0,262,263,1,0,0,0,263,264,3,4,2,0,264,43,1,
        0,0,0,265,266,5,66,0,0,266,267,3,72,36,0,267,45,1,0,0,0,268,269,
        5,80,0,0,269,270,5,87,0,0,270,271,5,17,0,0,271,272,3,50,25,0,272,
        47,1,0,0,0,273,274,5,83,0,0,274,49,1,0,0,0,275,277,7,1,0,0,276,275,
        1,0,0,0,276,277,1,0,0,0,277,278,1,0,0,0,278,282,5,81,0,0,279,282,
        5,82,0,0,280,282,3,48,24,0,281,276,1,0,0,0,281,279,1,0,0,0,281,280,
        1,0,0,0,282,51,1,0,0,0,283,284,3,72,36,0,284,285,5,36,0,0,285,286,
        3,72,36,0,286,287,5,37,0,0,287,288,5,17,0,0,288,289,3,72,36,0,289,
        53,1,0,0,0,290,291,5,79,0,0,291,292,5,87,0,0,292,296,5,34,0,0,293,
        295,3,56,28,0,294,293,1,0,0,0,295,298,1,0,0,0,296,294,1,0,0,0,296,
        297,1,0,0,0,297,299,1,0,0,0,298,296,1,0,0,0,299,300,5,35,0,0,300,
        55,1,0,0,0,301,302,5,87,0,0,302,303,5,17,0,0,303,305,3,50,25,0,304,
        306,5,40,0,0,305,304,1,0,0,0,305,306,1,0,0,0,306,57,1,0,0,0,307,
        309,5,78,0,0,308,307,1,0,0,0,308,309,1,0,0,0,309,310,1,0,0,0,310,
        311,5,87,0,0,311,312,5,17,0,0,312,314,3,72,36,0,313,315,5,38,0,0,
        314,313,1,0,0,0,314,315,1,0,0,0,315,331,1,0,0,0,316,317,5,36,0,0,
        317,318,3,72,36,0,318,319,5,37,0,0,319,320,5,17,0,0,320,322,3,72,
        36,0,321,323,5,38,0,0,322,321,1,0,0,0,322,323,1,0,0,0,323,331,1,
        0,0,0,324,325,5,56,0,0,325,326,3,68,34,0,326,327,3,74,37,0,327,331,
        1,0,0,0,328,329,5,76,0,0,329,331,3,74,37,0,330,308,1,0,0,0,330,316,
        1,0,0,0,330,324,1,0,0,0,330,328,1,0,0,0,331,59,1,0,0,0,332,337,3,
        62,31,0,333,334,5,40,0,0,334,336,3,62,31,0,335,333,1,0,0,0,336,339,
        1,0,0,0,337,335,1,0,0,0,337,338,1,0,0,0,338,61,1,0,0,0,339,337,1,
        0,0,0,340,343,5,87,0,0,341,342,5,17,0,0,342,344,3,72,36,0,343,341,
        1,0,0,0,343,344,1,0,0,0,344,63,1,0,0,0,345,350,3,66,33,0,346,347,
        5,40,0,0,347,349,3,66,33,0,348,346,1,0,0,0,349,352,1,0,0,0,350,348,
        1,0,0,0,350,351,1,0,0,0,351,355,1,0,0,0,352,350,1,0,0,0,353,354,
        5,40,0,0,354,356,5,2,0,0,355,353,1,0,0,0,355,356,1,0,0,0,356,359,
        1,0,0,0,357,359,5,2,0,0,358,345,1,0,0,0,358,357,1,0,0,0,359,65,1,
        0,0,0,360,363,5,87,0,0,361,362,5,17,0,0,362,364,3,72,36,0,363,361,
        1,0,0,0,363,364,1,0,0,0,364,67,1,0,0,0,365,370,5,87,0,0,366,367,
        5,1,0,0,367,369,5,87,0,0,368,366,1,0,0,0,369,372,1,0,0,0,370,368,
        1,0,0,0,370,371,1,0,0,0,371,69,1,0,0,0,372,370,1,0,0,0,373,380,5,
        81,0,0,374,380,5,82,0,0,375,380,5,86,0,0,376,380,3,48,24,0,377,380,
        5,55,0,0,378,380,5,73,0,0,379,373,1,0,0,0,379,374,1,0,0,0,379,375,
        1,0,0,0,379,376,1,0,0,0,379,377,1,0,0,0,379,378,1,0,0,0,380,71,1,
        0,0,0,381,382,6,36,-1,0,382,439,3,70,35,0,383,439,5,87,0,0,384,385,
        5,32,0,0,385,386,3,72,36,0,386,387,5,33,0,0,387,439,1,0,0,0,388,
        439,3,76,38,0,389,391,5,36,0,0,390,392,3,86,43,0,391,390,1,0,0,0,
        391,392,1,0,0,0,392,394,1,0,0,0,393,395,5,40,0,0,394,393,1,0,0,0,
        394,395,1,0,0,0,395,396,1,0,0,0,396,439,5,37,0,0,397,398,5,56,0,
        0,398,399,3,68,34,0,399,400,3,74,37,0,400,439,1,0,0,0,401,402,5,
        56,0,0,402,439,3,74,37,0,403,404,5,41,0,0,404,406,5,32,0,0,405,407,
        3,64,32,0,406,405,1,0,0,0,406,407,1,0,0,0,407,408,1,0,0,0,408,409,
        5,33,0,0,409,439,3,72,36,47,410,411,5,62,0,0,411,412,5,43,0,0,412,
        413,5,87,0,0,413,415,5,32,0,0,414,416,3,86,43,0,415,414,1,0,0,0,
        415,416,1,0,0,0,416,417,1,0,0,0,417,439,5,33,0,0,418,419,5,1,0,0,
        419,439,5,87,0,0,420,421,5,67,0,0,421,439,3,72,36,39,422,423,5,69,
        0,0,423,439,3,72,36,38,424,425,5,63,0,0,425,439,3,72,36,37,426,427,
        5,45,0,0,427,439,3,72,36,36,428,429,5,24,0,0,429,439,3,72,36,35,
        430,431,5,21,0,0,431,439,3,72,36,34,432,433,5,61,0,0,433,439,3,72,
        36,33,434,435,5,4,0,0,435,439,3,72,36,32,436,437,5,5,0,0,437,439,
        3,72,36,31,438,381,1,0,0,0,438,383,1,0,0,0,438,384,1,0,0,0,438,388,
        1,0,0,0,438,389,1,0,0,0,438,397,1,0,0,0,438,401,1,0,0,0,438,403,
        1,0,0,0,438,410,1,0,0,0,438,418,1,0,0,0,438,420,1,0,0,0,438,422,
        1,0,0,0,438,424,1,0,0,0,438,426,1,0,0,0,438,428,1,0,0,0,438,430,
        1,0,0,0,438,432,1,0,0,0,438,434,1,0,0,0,438,436,1,0,0,0,439,553,
        1,0,0,0,440,441,10,30,0,0,441,442,5,20,0,0,442,552,3,72,36,31,443,
        444,10,29,0,0,444,445,5,19,0,0,445,552,3,72,36,30,446,447,10,28,
        0,0,447,448,5,18,0,0,448,552,3,72,36,29,449,450,10,27,0,0,450,451,
        5,44,0,0,451,552,3,72,36,28,452,453,10,26,0,0,453,454,5,45,0,0,454,
        552,3,72,36,27,455,456,10,25,0,0,456,457,5,29,0,0,457,552,3,72,36,
        26,458,459,10,24,0,0,459,460,5,30,0,0,460,552,3,72,36,25,461,462,
        10,23,0,0,462,463,5,31,0,0,463,552,3,72,36,24,464,465,10,22,0,0,
        465,466,5,6,0,0,466,552,3,72,36,23,467,468,10,21,0,0,468,469,5,7,
        0,0,469,552,3,72,36,22,470,471,10,20,0,0,471,472,5,10,0,0,472,552,
        3,72,36,21,473,474,10,19,0,0,474,475,5,11,0,0,475,552,3,72,36,20,
        476,477,10,18,0,0,477,478,5,8,0,0,478,552,3,72,36,19,479,480,10,
        17,0,0,480,481,5,9,0,0,481,552,3,72,36,18,482,483,10,16,0,0,483,
        484,5,28,0,0,484,552,3,72,36,17,485,486,10,15,0,0,486,487,5,26,0,
        0,487,552,3,72,36,16,488,489,10,14,0,0,489,490,5,25,0,0,490,552,
        3,72,36,15,491,492,10,13,0,0,492,493,5,27,0,0,493,552,3,72,36,14,
        494,495,10,12,0,0,495,496,5,22,0,0,496,552,3,72,36,13,497,498,10,
        11,0,0,498,499,5,60,0,0,499,552,3,72,36,12,500,501,10,10,0,0,501,
        502,5,23,0,0,502,552,3,72,36,11,503,504,10,9,0,0,504,505,5,77,0,
        0,505,552,3,72,36,10,506,507,10,8,0,0,507,508,5,42,0,0,508,509,3,
        72,36,0,509,510,5,39,0,0,510,511,3,72,36,9,511,552,1,0,0,0,512,513,
        10,7,0,0,513,514,5,3,0,0,514,552,3,72,36,8,515,516,10,6,0,0,516,
        517,5,15,0,0,517,552,3,72,36,7,518,519,10,5,0,0,519,520,5,14,0,0,
        520,552,3,72,36,6,521,522,10,4,0,0,522,523,5,16,0,0,523,552,3,72,
        36,5,524,525,10,3,0,0,525,526,5,12,0,0,526,552,3,72,36,4,527,528,
        10,2,0,0,528,529,5,17,0,0,529,552,3,72,36,3,530,531,10,1,0,0,531,
        532,5,13,0,0,532,552,3,72,36,2,533,534,10,44,0,0,534,535,5,43,0,
        0,535,552,5,87,0,0,536,537,10,43,0,0,537,538,5,36,0,0,538,539,3,
        72,36,0,539,540,5,37,0,0,540,552,1,0,0,0,541,542,10,42,0,0,542,544,
        5,32,0,0,543,545,3,86,43,0,544,543,1,0,0,0,544,545,1,0,0,0,545,546,
        1,0,0,0,546,552,5,33,0,0,547,548,10,41,0,0,548,552,5,4,0,0,549,550,
        10,40,0,0,550,552,5,5,0,0,551,440,1,0,0,0,551,443,1,0,0,0,551,446,
        1,0,0,0,551,449,1,0,0,0,551,452,1,0,0,0,551,455,1,0,0,0,551,458,
        1,0,0,0,551,461,1,0,0,0,551,464,1,0,0,0,551,467,1,0,0,0,551,470,
        1,0,0,0,551,473,1,0,0,0,551,476,1,0,0,0,551,479,1,0,0,0,551,482,
        1,0,0,0,551,485,1,0,0,0,551,488,1,0,0,0,551,491,1,0,0,0,551,494,
        1,0,0,0,551,497,1,0,0,0,551,500,1,0,0,0,551,503,1,0,0,0,551,506,
        1,0,0,0,551,512,1,0,0,0,551,515,1,0,0,0,551,518,1,0,0,0,551,521,
        1,0,0,0,551,524,1,0,0,0,551,527,1,0,0,0,551,530,1,0,0,0,551,533,
        1,0,0,0,551,536,1,0,0,0,551,541,1,0,0,0,551,547,1,0,0,0,551,549,
        1,0,0,0,552,555,1,0,0,0,553,551,1,0,0,0,553,554,1,0,0,0,554,73,1,
        0,0,0,555,553,1,0,0,0,556,558,5,32,0,0,557,559,3,64,32,0,558,557,
        1,0,0,0,558,559,1,0,0,0,559,560,1,0,0,0,560,561,5,33,0,0,561,562,
        3,4,2,0,562,75,1,0,0,0,563,567,5,34,0,0,564,566,3,78,39,0,565,564,
        1,0,0,0,566,569,1,0,0,0,567,565,1,0,0,0,567,568,1,0,0,0,568,570,
        1,0,0,0,569,567,1,0,0,0,570,571,5,35,0,0,571,77,1,0,0,0,572,580,
        3,80,40,0,573,580,3,82,41,0,574,580,3,84,42,0,575,576,5,56,0,0,576,
        577,3,68,34,0,577,578,3,74,37,0,578,580,1,0,0,0,579,572,1,0,0,0,
        579,573,1,0,0,0,579,574,1,0,0,0,579,575,1,0,0,0,580,582,1,0,0,0,
        581,583,5,40,0,0,582,581,1,0,0,0,582,583,1,0,0,0,583,79,1,0,0,0,
        584,585,5,87,0,0,585,586,7,2,0,0,586,587,3,72,36,0,587,81,1,0,0,
        0,588,589,5,36,0,0,589,590,3,72,36,0,590,591,5,37,0,0,591,592,5,
        17,0,0,592,593,3,72,36,0,593,83,1,0,0,0,594,595,3,48,24,0,595,596,
        5,39,0,0,596,597,3,72,36,0,597,85,1,0,0,0,598,603,3,72,36,0,599,
        600,5,40,0,0,600,602,3,72,36,0,601,599,1,0,0,0,602,605,1,0,0,0,603,
        601,1,0,0,0,603,604,1,0,0,0,604,607,1,0,0,0,605,603,1,0,0,0,606,
        608,5,40,0,0,607,606,1,0,0,0,607,608,1,0,0,0,608,87,1,0,0,0,48,94,
        101,123,136,159,163,179,183,187,204,212,216,225,231,237,245,252,
        261,276,281,296,305,308,314,322,330,337,343,350,355,358,363,370,
        379,391,394,406,415,438,544,551,553,558,567,579,582,603,607
    ]

class SquirrelParser ( Parser ):

    grammarFileName = "SquirrelParser.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ "<INVALID>", "'::'", "'...'", "'<-'", "'++'", "'--'", 
                     "'<'", "'<='", "'=='", "'!='", "'>'", "'>='", "'+='", 
                     "'-='", "'/='", "'*='", "'%='", "'='", "'%'", "'*'", 
                     "'/'", "'!'", "'&&'", "'||'", "'~'", "'^'", "'&'", 
                     "'|'", "'<=>'", "'<<'", "'>>'", "'>>>'", "'('", "')'", 
                     "'{'", "'}'", "'['", "']'", "';'", "':'", "','", "'@'", 
                     "'?'", "'.'", "'+'", "'-'", "'\"'", "'''", "'while'", 
                     "'do'", "'if'", "'else'", "'break'", "'continue'", 
                     "'return'", "'null'", "'function'", "'local'", "'for'", 
                     "'foreach'", "'in'", "'typeof'", "'base'", "'delete'", 
                     "'try'", "'catch'", "'throw'", "'clone'", "'yield'", 
                     "'resume'", "'switch'", "'case'", "'default'", "'this'", 
                     "'class'", "'extends'", "'constructor'", "'instanceof'", 
                     "'static'", "'enum'", "'const'" ]

    symbolicNames = [ "<INVALID>", "SCOPE", "VARARGS", "NEWSLOT", "INCREMENT", 
                      "DECREMENT", "LESS_THAN", "LESS_OR_EQUAL", "EQUAL", 
                      "NOT_EQUAL", "GREATER_THAN", "GREATER_OR_EQUAL", "ASSIGN_ADD", 
                      "ASSIGN_SUB", "ASSIGN_DIV", "ASSIGN_MUL", "ASSIGN_MOD", 
                      "ASSIGN", "MODULO", "MULTIPLY", "DIVIDE", "LOGICAL_NOT", 
                      "LOGICAL_AND", "LOGICAL_OR", "BITWISE_NOT", "BITWISE_XOR", 
                      "BITWISE_AND", "BITWISE_OR", "COMPARE", "LEFT_SHIFT", 
                      "RIGHT_SHIFT", "RIGHT_UNSIGNED_SHIFT", "L_PAREN", 
                      "R_PAREN", "L_CURLY_BRACKET", "R_CURLY_BRACKET", "L_BRACKET", 
                      "R_BRACKET", "SEMICOLON", "COLON", "COMMA", "AT", 
                      "QUESTION", "DOT", "PLUS", "MINUS", "DOUBLE_QUOTE", 
                      "SINGLE_QUOTE", "WHILE", "DO", "IF", "ELSE", "BREAK", 
                      "CONTINUE", "RETURN", "NULL", "FUNCTION", "LOCAL", 
                      "FOR", "FOREACH", "IN", "TYPEOF", "BASE", "DELETE", 
                      "TRY", "CATCH", "THROW", "CLONE", "YIELD", "RESUME", 
                      "SWITCH", "CASE", "DEFAULT", "THIS", "CLASS", "EXTENDS", 
                      "CONSTRUCTOR", "INSTANCEOF", "STATIC", "ENUM", "CONST", 
                      "IntegerLiteral", "FloatLiteral", "StringLiteral", 
                      "Comment", "MultilineComment", "BooleanLiteral", "Identifier", 
                      "WS" ]

    RULE_program = 0
    RULE_statements = 1
    RULE_statement = 2
    RULE_statementBody = 3
    RULE_statementBlock = 4
    RULE_ifStatement = 5
    RULE_whileStatement = 6
    RULE_doWhileStatement = 7
    RULE_switchStatement = 8
    RULE_switchCase = 9
    RULE_defaultCase = 10
    RULE_forStatement = 11
    RULE_foreachStatement = 12
    RULE_foreachVar = 13
    RULE_breakStatement = 14
    RULE_continueStatement = 15
    RULE_returnStatement = 16
    RULE_yieldStatement = 17
    RULE_localDeclare = 18
    RULE_classDeclare = 19
    RULE_className = 20
    RULE_tryCatch = 21
    RULE_throwStatement = 22
    RULE_constStatement = 23
    RULE_stringLiteral = 24
    RULE_constValue = 25
    RULE_indexAssign = 26
    RULE_enumStatement = 27
    RULE_enumerations = 28
    RULE_memberDeclare = 29
    RULE_inits = 30
    RULE_init = 31
    RULE_args = 32
    RULE_arg = 33
    RULE_funcname = 34
    RULE_literal = 35
    RULE_expression = 36
    RULE_functionDeclareEnd = 37
    RULE_tableConstruction = 38
    RULE_tableSlot = 39
    RULE_basicTableSlot = 40
    RULE_arrayTableSlot = 41
    RULE_jsonTableSlot = 42
    RULE_expressionList = 43

    ruleNames =  [ "program", "statements", "statement", "statementBody", 
                   "statementBlock", "ifStatement", "whileStatement", "doWhileStatement", 
                   "switchStatement", "switchCase", "defaultCase", "forStatement", 
                   "foreachStatement", "foreachVar", "breakStatement", "continueStatement", 
                   "returnStatement", "yieldStatement", "localDeclare", 
                   "classDeclare", "className", "tryCatch", "throwStatement", 
                   "constStatement", "stringLiteral", "constValue", "indexAssign", 
                   "enumStatement", "enumerations", "memberDeclare", "inits", 
                   "init", "args", "arg", "funcname", "literal", "expression", 
                   "functionDeclareEnd", "tableConstruction", "tableSlot", 
                   "basicTableSlot", "arrayTableSlot", "jsonTableSlot", 
                   "expressionList" ]

    EOF = Token.EOF
    SCOPE=1
    VARARGS=2
    NEWSLOT=3
    INCREMENT=4
    DECREMENT=5
    LESS_THAN=6
    LESS_OR_EQUAL=7
    EQUAL=8
    NOT_EQUAL=9
    GREATER_THAN=10
    GREATER_OR_EQUAL=11
    ASSIGN_ADD=12
    ASSIGN_SUB=13
    ASSIGN_DIV=14
    ASSIGN_MUL=15
    ASSIGN_MOD=16
    ASSIGN=17
    MODULO=18
    MULTIPLY=19
    DIVIDE=20
    LOGICAL_NOT=21
    LOGICAL_AND=22
    LOGICAL_OR=23
    BITWISE_NOT=24
    BITWISE_XOR=25
    BITWISE_AND=26
    BITWISE_OR=27
    COMPARE=28
    LEFT_SHIFT=29
    RIGHT_SHIFT=30
    RIGHT_UNSIGNED_SHIFT=31
    L_PAREN=32
    R_PAREN=33
    L_CURLY_BRACKET=34
    R_CURLY_BRACKET=35
    L_BRACKET=36
    R_BRACKET=37
    SEMICOLON=38
    COLON=39
    COMMA=40
    AT=41
    QUESTION=42
    DOT=43
    PLUS=44
    MINUS=45
    DOUBLE_QUOTE=46
    SINGLE_QUOTE=47
    WHILE=48
    DO=49
    IF=50
    ELSE=51
    BREAK=52
    CONTINUE=53
    RETURN=54
    NULL=55
    FUNCTION=56
    LOCAL=57
    FOR=58
    FOREACH=59
    IN=60
    TYPEOF=61
    BASE=62
    DELETE=63
    TRY=64
    CATCH=65
    THROW=66
    CLONE=67
    YIELD=68
    RESUME=69
    SWITCH=70
    CASE=71
    DEFAULT=72
    THIS=73
    CLASS=74
    EXTENDS=75
    CONSTRUCTOR=76
    INSTANCEOF=77
    STATIC=78
    ENUM=79
    CONST=80
    IntegerLiteral=81
    FloatLiteral=82
    StringLiteral=83
    Comment=84
    MultilineComment=85
    BooleanLiteral=86
    Identifier=87
    WS=88

    def __init__(self, input:TokenStream, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.13.2")
        self._interp = ParserATNSimulator(self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None




    class ProgramContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def statements(self):
            return self.getTypedRuleContext(SquirrelParser.StatementsContext,0)


        def EOF(self):
            return self.getToken(SquirrelParser.EOF, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_program

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterProgram" ):
                listener.enterProgram(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitProgram" ):
                listener.exitProgram(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitProgram" ):
                return visitor.visitProgram(self)
            else:
                return visitor.visitChildren(self)




    def program(self):

        localctx = SquirrelParser.ProgramContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_program)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 88
            self.statements()
            self.state = 89
            self.match(SquirrelParser.EOF)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class StatementsContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def statement(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.StatementContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.StatementContext,i)


        def getRuleIndex(self):
            return SquirrelParser.RULE_statements

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterStatements" ):
                listener.enterStatements(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitStatements" ):
                listener.exitStatements(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitStatements" ):
                return visitor.visitStatements(self)
            else:
                return visitor.visitChildren(self)




    def statements(self):

        localctx = SquirrelParser.StatementsContext(self, self._ctx, self.state)
        self.enterRule(localctx, 2, self.RULE_statements)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 94
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & -1155417305788710862) != 0) or ((((_la - 64)) & ~0x3f) == 0 and ((1 << (_la - 64)) & 13600381) != 0):
                self.state = 91
                self.statement()
                self.state = 96
                self._errHandler.sync(self)
                _la = self._input.LA(1)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class StatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def statementBody(self):
            return self.getTypedRuleContext(SquirrelParser.StatementBodyContext,0)


        def SEMICOLON(self, i:int=None):
            if i is None:
                return self.getTokens(SquirrelParser.SEMICOLON)
            else:
                return self.getToken(SquirrelParser.SEMICOLON, i)

        def getRuleIndex(self):
            return SquirrelParser.RULE_statement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterStatement" ):
                listener.enterStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitStatement" ):
                listener.exitStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitStatement" ):
                return visitor.visitStatement(self)
            else:
                return visitor.visitChildren(self)




    def statement(self):

        localctx = SquirrelParser.StatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 4, self.RULE_statement)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 97
            self.statementBody()
            self.state = 101
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,1,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    self.state = 98
                    self.match(SquirrelParser.SEMICOLON) 
                self.state = 103
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,1,self._ctx)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class StatementBodyContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def statementBlock(self):
            return self.getTypedRuleContext(SquirrelParser.StatementBlockContext,0)


        def ifStatement(self):
            return self.getTypedRuleContext(SquirrelParser.IfStatementContext,0)


        def whileStatement(self):
            return self.getTypedRuleContext(SquirrelParser.WhileStatementContext,0)


        def doWhileStatement(self):
            return self.getTypedRuleContext(SquirrelParser.DoWhileStatementContext,0)


        def switchStatement(self):
            return self.getTypedRuleContext(SquirrelParser.SwitchStatementContext,0)


        def forStatement(self):
            return self.getTypedRuleContext(SquirrelParser.ForStatementContext,0)


        def foreachStatement(self):
            return self.getTypedRuleContext(SquirrelParser.ForeachStatementContext,0)


        def breakStatement(self):
            return self.getTypedRuleContext(SquirrelParser.BreakStatementContext,0)


        def continueStatement(self):
            return self.getTypedRuleContext(SquirrelParser.ContinueStatementContext,0)


        def returnStatement(self):
            return self.getTypedRuleContext(SquirrelParser.ReturnStatementContext,0)


        def yieldStatement(self):
            return self.getTypedRuleContext(SquirrelParser.YieldStatementContext,0)


        def classDeclare(self):
            return self.getTypedRuleContext(SquirrelParser.ClassDeclareContext,0)


        def tryCatch(self):
            return self.getTypedRuleContext(SquirrelParser.TryCatchContext,0)


        def throwStatement(self):
            return self.getTypedRuleContext(SquirrelParser.ThrowStatementContext,0)


        def constStatement(self):
            return self.getTypedRuleContext(SquirrelParser.ConstStatementContext,0)


        def enumStatement(self):
            return self.getTypedRuleContext(SquirrelParser.EnumStatementContext,0)


        def indexAssign(self):
            return self.getTypedRuleContext(SquirrelParser.IndexAssignContext,0)


        def localDeclare(self):
            return self.getTypedRuleContext(SquirrelParser.LocalDeclareContext,0)


        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_statementBody

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterStatementBody" ):
                listener.enterStatementBody(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitStatementBody" ):
                listener.exitStatementBody(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitStatementBody" ):
                return visitor.visitStatementBody(self)
            else:
                return visitor.visitChildren(self)




    def statementBody(self):

        localctx = SquirrelParser.StatementBodyContext(self, self._ctx, self.state)
        self.enterRule(localctx, 6, self.RULE_statementBody)
        try:
            self.state = 123
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,2,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 104
                self.statementBlock()
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 105
                self.ifStatement()
                pass

            elif la_ == 3:
                self.enterOuterAlt(localctx, 3)
                self.state = 106
                self.whileStatement()
                pass

            elif la_ == 4:
                self.enterOuterAlt(localctx, 4)
                self.state = 107
                self.doWhileStatement()
                pass

            elif la_ == 5:
                self.enterOuterAlt(localctx, 5)
                self.state = 108
                self.switchStatement()
                pass

            elif la_ == 6:
                self.enterOuterAlt(localctx, 6)
                self.state = 109
                self.forStatement()
                pass

            elif la_ == 7:
                self.enterOuterAlt(localctx, 7)
                self.state = 110
                self.foreachStatement()
                pass

            elif la_ == 8:
                self.enterOuterAlt(localctx, 8)
                self.state = 111
                self.breakStatement()
                pass

            elif la_ == 9:
                self.enterOuterAlt(localctx, 9)
                self.state = 112
                self.continueStatement()
                pass

            elif la_ == 10:
                self.enterOuterAlt(localctx, 10)
                self.state = 113
                self.returnStatement()
                pass

            elif la_ == 11:
                self.enterOuterAlt(localctx, 11)
                self.state = 114
                self.yieldStatement()
                pass

            elif la_ == 12:
                self.enterOuterAlt(localctx, 12)
                self.state = 115
                self.classDeclare()
                pass

            elif la_ == 13:
                self.enterOuterAlt(localctx, 13)
                self.state = 116
                self.tryCatch()
                pass

            elif la_ == 14:
                self.enterOuterAlt(localctx, 14)
                self.state = 117
                self.throwStatement()
                pass

            elif la_ == 15:
                self.enterOuterAlt(localctx, 15)
                self.state = 118
                self.constStatement()
                pass

            elif la_ == 16:
                self.enterOuterAlt(localctx, 16)
                self.state = 119
                self.enumStatement()
                pass

            elif la_ == 17:
                self.enterOuterAlt(localctx, 17)
                self.state = 120
                self.indexAssign()
                pass

            elif la_ == 18:
                self.enterOuterAlt(localctx, 18)
                self.state = 121
                self.localDeclare()
                pass

            elif la_ == 19:
                self.enterOuterAlt(localctx, 19)
                self.state = 122
                self.expression(0)
                pass


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class StatementBlockContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def L_CURLY_BRACKET(self):
            return self.getToken(SquirrelParser.L_CURLY_BRACKET, 0)

        def statements(self):
            return self.getTypedRuleContext(SquirrelParser.StatementsContext,0)


        def R_CURLY_BRACKET(self):
            return self.getToken(SquirrelParser.R_CURLY_BRACKET, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_statementBlock

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterStatementBlock" ):
                listener.enterStatementBlock(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitStatementBlock" ):
                listener.exitStatementBlock(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitStatementBlock" ):
                return visitor.visitStatementBlock(self)
            else:
                return visitor.visitChildren(self)




    def statementBlock(self):

        localctx = SquirrelParser.StatementBlockContext(self, self._ctx, self.state)
        self.enterRule(localctx, 8, self.RULE_statementBlock)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 125
            self.match(SquirrelParser.L_CURLY_BRACKET)
            self.state = 126
            self.statements()
            self.state = 127
            self.match(SquirrelParser.R_CURLY_BRACKET)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class IfStatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def IF(self):
            return self.getToken(SquirrelParser.IF, 0)

        def L_PAREN(self):
            return self.getToken(SquirrelParser.L_PAREN, 0)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def R_PAREN(self):
            return self.getToken(SquirrelParser.R_PAREN, 0)

        def statement(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.StatementContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.StatementContext,i)


        def ELSE(self):
            return self.getToken(SquirrelParser.ELSE, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_ifStatement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterIfStatement" ):
                listener.enterIfStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitIfStatement" ):
                listener.exitIfStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitIfStatement" ):
                return visitor.visitIfStatement(self)
            else:
                return visitor.visitChildren(self)




    def ifStatement(self):

        localctx = SquirrelParser.IfStatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 10, self.RULE_ifStatement)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 129
            self.match(SquirrelParser.IF)
            self.state = 130
            self.match(SquirrelParser.L_PAREN)
            self.state = 131
            self.expression(0)
            self.state = 132
            self.match(SquirrelParser.R_PAREN)
            self.state = 133
            self.statement()
            self.state = 136
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,3,self._ctx)
            if la_ == 1:
                self.state = 134
                self.match(SquirrelParser.ELSE)
                self.state = 135
                self.statement()


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class WhileStatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def WHILE(self):
            return self.getToken(SquirrelParser.WHILE, 0)

        def L_PAREN(self):
            return self.getToken(SquirrelParser.L_PAREN, 0)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def R_PAREN(self):
            return self.getToken(SquirrelParser.R_PAREN, 0)

        def statement(self):
            return self.getTypedRuleContext(SquirrelParser.StatementContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_whileStatement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterWhileStatement" ):
                listener.enterWhileStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitWhileStatement" ):
                listener.exitWhileStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitWhileStatement" ):
                return visitor.visitWhileStatement(self)
            else:
                return visitor.visitChildren(self)




    def whileStatement(self):

        localctx = SquirrelParser.WhileStatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 12, self.RULE_whileStatement)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 138
            self.match(SquirrelParser.WHILE)
            self.state = 139
            self.match(SquirrelParser.L_PAREN)
            self.state = 140
            self.expression(0)
            self.state = 141
            self.match(SquirrelParser.R_PAREN)
            self.state = 142
            self.statement()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class DoWhileStatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def DO(self):
            return self.getToken(SquirrelParser.DO, 0)

        def statement(self):
            return self.getTypedRuleContext(SquirrelParser.StatementContext,0)


        def WHILE(self):
            return self.getToken(SquirrelParser.WHILE, 0)

        def L_PAREN(self):
            return self.getToken(SquirrelParser.L_PAREN, 0)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def R_PAREN(self):
            return self.getToken(SquirrelParser.R_PAREN, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_doWhileStatement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterDoWhileStatement" ):
                listener.enterDoWhileStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitDoWhileStatement" ):
                listener.exitDoWhileStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitDoWhileStatement" ):
                return visitor.visitDoWhileStatement(self)
            else:
                return visitor.visitChildren(self)




    def doWhileStatement(self):

        localctx = SquirrelParser.DoWhileStatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 14, self.RULE_doWhileStatement)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 144
            self.match(SquirrelParser.DO)
            self.state = 145
            self.statement()
            self.state = 146
            self.match(SquirrelParser.WHILE)
            self.state = 147
            self.match(SquirrelParser.L_PAREN)
            self.state = 148
            self.expression(0)
            self.state = 149
            self.match(SquirrelParser.R_PAREN)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class SwitchStatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def SWITCH(self):
            return self.getToken(SquirrelParser.SWITCH, 0)

        def L_PAREN(self):
            return self.getToken(SquirrelParser.L_PAREN, 0)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def R_PAREN(self):
            return self.getToken(SquirrelParser.R_PAREN, 0)

        def L_CURLY_BRACKET(self):
            return self.getToken(SquirrelParser.L_CURLY_BRACKET, 0)

        def R_CURLY_BRACKET(self):
            return self.getToken(SquirrelParser.R_CURLY_BRACKET, 0)

        def switchCase(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.SwitchCaseContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.SwitchCaseContext,i)


        def defaultCase(self):
            return self.getTypedRuleContext(SquirrelParser.DefaultCaseContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_switchStatement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterSwitchStatement" ):
                listener.enterSwitchStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitSwitchStatement" ):
                listener.exitSwitchStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitSwitchStatement" ):
                return visitor.visitSwitchStatement(self)
            else:
                return visitor.visitChildren(self)




    def switchStatement(self):

        localctx = SquirrelParser.SwitchStatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 16, self.RULE_switchStatement)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 151
            self.match(SquirrelParser.SWITCH)
            self.state = 152
            self.match(SquirrelParser.L_PAREN)
            self.state = 153
            self.expression(0)
            self.state = 154
            self.match(SquirrelParser.R_PAREN)
            self.state = 155
            self.match(SquirrelParser.L_CURLY_BRACKET)
            self.state = 159
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==71:
                self.state = 156
                self.switchCase()
                self.state = 161
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 163
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            if _la==72:
                self.state = 162
                self.defaultCase()


            self.state = 165
            self.match(SquirrelParser.R_CURLY_BRACKET)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class SwitchCaseContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def CASE(self):
            return self.getToken(SquirrelParser.CASE, 0)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def COLON(self):
            return self.getToken(SquirrelParser.COLON, 0)

        def statements(self):
            return self.getTypedRuleContext(SquirrelParser.StatementsContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_switchCase

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterSwitchCase" ):
                listener.enterSwitchCase(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitSwitchCase" ):
                listener.exitSwitchCase(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitSwitchCase" ):
                return visitor.visitSwitchCase(self)
            else:
                return visitor.visitChildren(self)




    def switchCase(self):

        localctx = SquirrelParser.SwitchCaseContext(self, self._ctx, self.state)
        self.enterRule(localctx, 18, self.RULE_switchCase)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 167
            self.match(SquirrelParser.CASE)
            self.state = 168
            self.expression(0)
            self.state = 169
            self.match(SquirrelParser.COLON)
            self.state = 170
            self.statements()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class DefaultCaseContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def DEFAULT(self):
            return self.getToken(SquirrelParser.DEFAULT, 0)

        def COLON(self):
            return self.getToken(SquirrelParser.COLON, 0)

        def statements(self):
            return self.getTypedRuleContext(SquirrelParser.StatementsContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_defaultCase

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterDefaultCase" ):
                listener.enterDefaultCase(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitDefaultCase" ):
                listener.exitDefaultCase(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitDefaultCase" ):
                return visitor.visitDefaultCase(self)
            else:
                return visitor.visitChildren(self)




    def defaultCase(self):

        localctx = SquirrelParser.DefaultCaseContext(self, self._ctx, self.state)
        self.enterRule(localctx, 20, self.RULE_defaultCase)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 172
            self.match(SquirrelParser.DEFAULT)
            self.state = 173
            self.match(SquirrelParser.COLON)
            self.state = 174
            self.statements()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ForStatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser
            self.forInit = None # StatementContext
            self.forCondition = None # StatementContext
            self.forUpdate = None # StatementContext
            self.forStat = None # StatementContext

        def FOR(self):
            return self.getToken(SquirrelParser.FOR, 0)

        def L_PAREN(self):
            return self.getToken(SquirrelParser.L_PAREN, 0)

        def SEMICOLON(self, i:int=None):
            if i is None:
                return self.getTokens(SquirrelParser.SEMICOLON)
            else:
                return self.getToken(SquirrelParser.SEMICOLON, i)

        def R_PAREN(self):
            return self.getToken(SquirrelParser.R_PAREN, 0)

        def statement(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.StatementContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.StatementContext,i)


        def getRuleIndex(self):
            return SquirrelParser.RULE_forStatement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterForStatement" ):
                listener.enterForStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitForStatement" ):
                listener.exitForStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitForStatement" ):
                return visitor.visitForStatement(self)
            else:
                return visitor.visitChildren(self)




    def forStatement(self):

        localctx = SquirrelParser.ForStatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 22, self.RULE_forStatement)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 176
            self.match(SquirrelParser.FOR)
            self.state = 177
            self.match(SquirrelParser.L_PAREN)
            self.state = 179
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            if (((_la) & ~0x3f) == 0 and ((1 << _la) & -1155417305788710862) != 0) or ((((_la - 64)) & ~0x3f) == 0 and ((1 << (_la - 64)) & 13600381) != 0):
                self.state = 178
                localctx.forInit = self.statement()


            self.state = 181
            self.match(SquirrelParser.SEMICOLON)
            self.state = 183
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            if (((_la) & ~0x3f) == 0 and ((1 << _la) & -1155417305788710862) != 0) or ((((_la - 64)) & ~0x3f) == 0 and ((1 << (_la - 64)) & 13600381) != 0):
                self.state = 182
                localctx.forCondition = self.statement()


            self.state = 185
            self.match(SquirrelParser.SEMICOLON)
            self.state = 187
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            if (((_la) & ~0x3f) == 0 and ((1 << _la) & -1155417305788710862) != 0) or ((((_la - 64)) & ~0x3f) == 0 and ((1 << (_la - 64)) & 13600381) != 0):
                self.state = 186
                localctx.forUpdate = self.statement()


            self.state = 189
            self.match(SquirrelParser.R_PAREN)
            self.state = 190
            localctx.forStat = self.statement()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ForeachStatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def FOREACH(self):
            return self.getToken(SquirrelParser.FOREACH, 0)

        def L_PAREN(self):
            return self.getToken(SquirrelParser.L_PAREN, 0)

        def foreachVar(self):
            return self.getTypedRuleContext(SquirrelParser.ForeachVarContext,0)


        def IN(self):
            return self.getToken(SquirrelParser.IN, 0)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def R_PAREN(self):
            return self.getToken(SquirrelParser.R_PAREN, 0)

        def statement(self):
            return self.getTypedRuleContext(SquirrelParser.StatementContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_foreachStatement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterForeachStatement" ):
                listener.enterForeachStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitForeachStatement" ):
                listener.exitForeachStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitForeachStatement" ):
                return visitor.visitForeachStatement(self)
            else:
                return visitor.visitChildren(self)




    def foreachStatement(self):

        localctx = SquirrelParser.ForeachStatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 24, self.RULE_foreachStatement)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 192
            self.match(SquirrelParser.FOREACH)
            self.state = 193
            self.match(SquirrelParser.L_PAREN)
            self.state = 194
            self.foreachVar()
            self.state = 195
            self.match(SquirrelParser.IN)
            self.state = 196
            self.expression(0)
            self.state = 197
            self.match(SquirrelParser.R_PAREN)
            self.state = 198
            self.statement()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ForeachVarContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser


        def getRuleIndex(self):
            return SquirrelParser.RULE_foreachVar

     
        def copyFrom(self, ctx:ParserRuleContext):
            super().copyFrom(ctx)



    class KeyOnlyVarContext(ForeachVarContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ForeachVarContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def Identifier(self):
            return self.getToken(SquirrelParser.Identifier, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterKeyOnlyVar" ):
                listener.enterKeyOnlyVar(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitKeyOnlyVar" ):
                listener.exitKeyOnlyVar(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitKeyOnlyVar" ):
                return visitor.visitKeyOnlyVar(self)
            else:
                return visitor.visitChildren(self)


    class KeyValVarContext(ForeachVarContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ForeachVarContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def Identifier(self, i:int=None):
            if i is None:
                return self.getTokens(SquirrelParser.Identifier)
            else:
                return self.getToken(SquirrelParser.Identifier, i)
        def COMMA(self):
            return self.getToken(SquirrelParser.COMMA, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterKeyValVar" ):
                listener.enterKeyValVar(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitKeyValVar" ):
                listener.exitKeyValVar(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitKeyValVar" ):
                return visitor.visitKeyValVar(self)
            else:
                return visitor.visitChildren(self)



    def foreachVar(self):

        localctx = SquirrelParser.ForeachVarContext(self, self._ctx, self.state)
        self.enterRule(localctx, 26, self.RULE_foreachVar)
        try:
            self.state = 204
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,9,self._ctx)
            if la_ == 1:
                localctx = SquirrelParser.KeyOnlyVarContext(self, localctx)
                self.enterOuterAlt(localctx, 1)
                self.state = 200
                self.match(SquirrelParser.Identifier)
                pass

            elif la_ == 2:
                localctx = SquirrelParser.KeyValVarContext(self, localctx)
                self.enterOuterAlt(localctx, 2)
                self.state = 201
                self.match(SquirrelParser.Identifier)
                self.state = 202
                self.match(SquirrelParser.COMMA)
                self.state = 203
                self.match(SquirrelParser.Identifier)
                pass


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class BreakStatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def BREAK(self):
            return self.getToken(SquirrelParser.BREAK, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_breakStatement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterBreakStatement" ):
                listener.enterBreakStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitBreakStatement" ):
                listener.exitBreakStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitBreakStatement" ):
                return visitor.visitBreakStatement(self)
            else:
                return visitor.visitChildren(self)




    def breakStatement(self):

        localctx = SquirrelParser.BreakStatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 28, self.RULE_breakStatement)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 206
            self.match(SquirrelParser.BREAK)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ContinueStatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def CONTINUE(self):
            return self.getToken(SquirrelParser.CONTINUE, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_continueStatement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterContinueStatement" ):
                listener.enterContinueStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitContinueStatement" ):
                listener.exitContinueStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitContinueStatement" ):
                return visitor.visitContinueStatement(self)
            else:
                return visitor.visitChildren(self)




    def continueStatement(self):

        localctx = SquirrelParser.ContinueStatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 30, self.RULE_continueStatement)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 208
            self.match(SquirrelParser.CONTINUE)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ReturnStatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def RETURN(self):
            return self.getToken(SquirrelParser.RETURN, 0)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_returnStatement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterReturnStatement" ):
                listener.enterReturnStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitReturnStatement" ):
                listener.exitReturnStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitReturnStatement" ):
                return visitor.visitReturnStatement(self)
            else:
                return visitor.visitChildren(self)




    def returnStatement(self):

        localctx = SquirrelParser.ReturnStatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 32, self.RULE_returnStatement)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 210
            self.match(SquirrelParser.RETURN)
            self.state = 212
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,10,self._ctx)
            if la_ == 1:
                self.state = 211
                self.expression(0)


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class YieldStatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def YIELD(self):
            return self.getToken(SquirrelParser.YIELD, 0)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_yieldStatement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterYieldStatement" ):
                listener.enterYieldStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitYieldStatement" ):
                listener.exitYieldStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitYieldStatement" ):
                return visitor.visitYieldStatement(self)
            else:
                return visitor.visitChildren(self)




    def yieldStatement(self):

        localctx = SquirrelParser.YieldStatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 34, self.RULE_yieldStatement)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 214
            self.match(SquirrelParser.YIELD)
            self.state = 216
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,11,self._ctx)
            if la_ == 1:
                self.state = 215
                self.expression(0)


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class LocalDeclareContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def LOCAL(self):
            return self.getToken(SquirrelParser.LOCAL, 0)

        def inits(self):
            return self.getTypedRuleContext(SquirrelParser.InitsContext,0)


        def FUNCTION(self):
            return self.getToken(SquirrelParser.FUNCTION, 0)

        def funcname(self):
            return self.getTypedRuleContext(SquirrelParser.FuncnameContext,0)


        def functionDeclareEnd(self):
            return self.getTypedRuleContext(SquirrelParser.FunctionDeclareEndContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_localDeclare

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLocalDeclare" ):
                listener.enterLocalDeclare(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLocalDeclare" ):
                listener.exitLocalDeclare(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitLocalDeclare" ):
                return visitor.visitLocalDeclare(self)
            else:
                return visitor.visitChildren(self)




    def localDeclare(self):

        localctx = SquirrelParser.LocalDeclareContext(self, self._ctx, self.state)
        self.enterRule(localctx, 36, self.RULE_localDeclare)
        try:
            self.state = 225
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,12,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 218
                self.match(SquirrelParser.LOCAL)
                self.state = 219
                self.inits()
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 220
                self.match(SquirrelParser.LOCAL)
                self.state = 221
                self.match(SquirrelParser.FUNCTION)
                self.state = 222
                self.funcname()
                self.state = 223
                self.functionDeclareEnd()
                pass


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ClassDeclareContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def CLASS(self):
            return self.getToken(SquirrelParser.CLASS, 0)

        def className(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ClassNameContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ClassNameContext,i)


        def L_CURLY_BRACKET(self):
            return self.getToken(SquirrelParser.L_CURLY_BRACKET, 0)

        def R_CURLY_BRACKET(self):
            return self.getToken(SquirrelParser.R_CURLY_BRACKET, 0)

        def EXTENDS(self):
            return self.getToken(SquirrelParser.EXTENDS, 0)

        def memberDeclare(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.MemberDeclareContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.MemberDeclareContext,i)


        def getRuleIndex(self):
            return SquirrelParser.RULE_classDeclare

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterClassDeclare" ):
                listener.enterClassDeclare(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitClassDeclare" ):
                listener.exitClassDeclare(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitClassDeclare" ):
                return visitor.visitClassDeclare(self)
            else:
                return visitor.visitChildren(self)




    def classDeclare(self):

        localctx = SquirrelParser.ClassDeclareContext(self, self._ctx, self.state)
        self.enterRule(localctx, 38, self.RULE_classDeclare)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 227
            self.match(SquirrelParser.CLASS)
            self.state = 228
            self.className()
            self.state = 231
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            if _la==75:
                self.state = 229
                self.match(SquirrelParser.EXTENDS)
                self.state = 230
                self.className()


            self.state = 233
            self.match(SquirrelParser.L_CURLY_BRACKET)
            self.state = 237
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while ((((_la - 36)) & ~0x3f) == 0 and ((1 << (_la - 36)) & 2257297372872705) != 0):
                self.state = 234
                self.memberDeclare()
                self.state = 239
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 240
            self.match(SquirrelParser.R_CURLY_BRACKET)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ClassNameContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def Identifier(self, i:int=None):
            if i is None:
                return self.getTokens(SquirrelParser.Identifier)
            else:
                return self.getToken(SquirrelParser.Identifier, i)

        def THIS(self):
            return self.getToken(SquirrelParser.THIS, 0)

        def DOT(self, i:int=None):
            if i is None:
                return self.getTokens(SquirrelParser.DOT)
            else:
                return self.getToken(SquirrelParser.DOT, i)

        def SCOPE(self, i:int=None):
            if i is None:
                return self.getTokens(SquirrelParser.SCOPE)
            else:
                return self.getToken(SquirrelParser.SCOPE, i)

        def getRuleIndex(self):
            return SquirrelParser.RULE_className

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterClassName" ):
                listener.enterClassName(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitClassName" ):
                listener.exitClassName(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitClassName" ):
                return visitor.visitClassName(self)
            else:
                return visitor.visitChildren(self)




    def className(self):

        localctx = SquirrelParser.ClassNameContext(self, self._ctx, self.state)
        self.enterRule(localctx, 40, self.RULE_className)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 245
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [73]:
                self.state = 242
                self.match(SquirrelParser.THIS)
                self.state = 243
                self.match(SquirrelParser.DOT)
                pass
            elif token in [1]:
                self.state = 244
                self.match(SquirrelParser.SCOPE)
                pass
            elif token in [87]:
                pass
            else:
                pass
            self.state = 247
            self.match(SquirrelParser.Identifier)
            self.state = 252
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==1 or _la==43:
                self.state = 248
                _la = self._input.LA(1)
                if not(_la==1 or _la==43):
                    self._errHandler.recoverInline(self)
                else:
                    self._errHandler.reportMatch(self)
                    self.consume()
                self.state = 249
                self.match(SquirrelParser.Identifier)
                self.state = 254
                self._errHandler.sync(self)
                _la = self._input.LA(1)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class TryCatchContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def TRY(self):
            return self.getToken(SquirrelParser.TRY, 0)

        def statement(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.StatementContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.StatementContext,i)


        def CATCH(self):
            return self.getToken(SquirrelParser.CATCH, 0)

        def L_PAREN(self):
            return self.getToken(SquirrelParser.L_PAREN, 0)

        def Identifier(self):
            return self.getToken(SquirrelParser.Identifier, 0)

        def R_PAREN(self):
            return self.getToken(SquirrelParser.R_PAREN, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_tryCatch

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterTryCatch" ):
                listener.enterTryCatch(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitTryCatch" ):
                listener.exitTryCatch(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitTryCatch" ):
                return visitor.visitTryCatch(self)
            else:
                return visitor.visitChildren(self)




    def tryCatch(self):

        localctx = SquirrelParser.TryCatchContext(self, self._ctx, self.state)
        self.enterRule(localctx, 42, self.RULE_tryCatch)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 255
            self.match(SquirrelParser.TRY)
            self.state = 256
            self.statement()
            self.state = 257
            self.match(SquirrelParser.CATCH)
            self.state = 261
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,17,self._ctx)
            if la_ == 1:
                self.state = 258
                self.match(SquirrelParser.L_PAREN)
                self.state = 259
                self.match(SquirrelParser.Identifier)
                self.state = 260
                self.match(SquirrelParser.R_PAREN)


            self.state = 263
            self.statement()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ThrowStatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def THROW(self):
            return self.getToken(SquirrelParser.THROW, 0)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_throwStatement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterThrowStatement" ):
                listener.enterThrowStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitThrowStatement" ):
                listener.exitThrowStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitThrowStatement" ):
                return visitor.visitThrowStatement(self)
            else:
                return visitor.visitChildren(self)




    def throwStatement(self):

        localctx = SquirrelParser.ThrowStatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 44, self.RULE_throwStatement)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 265
            self.match(SquirrelParser.THROW)
            self.state = 266
            self.expression(0)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ConstStatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def CONST(self):
            return self.getToken(SquirrelParser.CONST, 0)

        def Identifier(self):
            return self.getToken(SquirrelParser.Identifier, 0)

        def ASSIGN(self):
            return self.getToken(SquirrelParser.ASSIGN, 0)

        def constValue(self):
            return self.getTypedRuleContext(SquirrelParser.ConstValueContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_constStatement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterConstStatement" ):
                listener.enterConstStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitConstStatement" ):
                listener.exitConstStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitConstStatement" ):
                return visitor.visitConstStatement(self)
            else:
                return visitor.visitChildren(self)




    def constStatement(self):

        localctx = SquirrelParser.ConstStatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 46, self.RULE_constStatement)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 268
            self.match(SquirrelParser.CONST)
            self.state = 269
            self.match(SquirrelParser.Identifier)
            self.state = 270
            self.match(SquirrelParser.ASSIGN)
            self.state = 271
            self.constValue()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class StringLiteralContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def StringLiteral(self):
            return self.getToken(SquirrelParser.StringLiteral, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_stringLiteral

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterStringLiteral" ):
                listener.enterStringLiteral(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitStringLiteral" ):
                listener.exitStringLiteral(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitStringLiteral" ):
                return visitor.visitStringLiteral(self)
            else:
                return visitor.visitChildren(self)




    def stringLiteral(self):

        localctx = SquirrelParser.StringLiteralContext(self, self._ctx, self.state)
        self.enterRule(localctx, 48, self.RULE_stringLiteral)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 273
            self.match(SquirrelParser.StringLiteral)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ConstValueContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def IntegerLiteral(self):
            return self.getToken(SquirrelParser.IntegerLiteral, 0)

        def PLUS(self):
            return self.getToken(SquirrelParser.PLUS, 0)

        def MINUS(self):
            return self.getToken(SquirrelParser.MINUS, 0)

        def FloatLiteral(self):
            return self.getToken(SquirrelParser.FloatLiteral, 0)

        def stringLiteral(self):
            return self.getTypedRuleContext(SquirrelParser.StringLiteralContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_constValue

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterConstValue" ):
                listener.enterConstValue(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitConstValue" ):
                listener.exitConstValue(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitConstValue" ):
                return visitor.visitConstValue(self)
            else:
                return visitor.visitChildren(self)




    def constValue(self):

        localctx = SquirrelParser.ConstValueContext(self, self._ctx, self.state)
        self.enterRule(localctx, 50, self.RULE_constValue)
        self._la = 0 # Token type
        try:
            self.state = 281
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [44, 45, 81]:
                self.enterOuterAlt(localctx, 1)
                self.state = 276
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if _la==44 or _la==45:
                    self.state = 275
                    _la = self._input.LA(1)
                    if not(_la==44 or _la==45):
                        self._errHandler.recoverInline(self)
                    else:
                        self._errHandler.reportMatch(self)
                        self.consume()


                self.state = 278
                self.match(SquirrelParser.IntegerLiteral)
                pass
            elif token in [82]:
                self.enterOuterAlt(localctx, 2)
                self.state = 279
                self.match(SquirrelParser.FloatLiteral)
                pass
            elif token in [83]:
                self.enterOuterAlt(localctx, 3)
                self.state = 280
                self.stringLiteral()
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class IndexAssignContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)


        def L_BRACKET(self):
            return self.getToken(SquirrelParser.L_BRACKET, 0)

        def R_BRACKET(self):
            return self.getToken(SquirrelParser.R_BRACKET, 0)

        def ASSIGN(self):
            return self.getToken(SquirrelParser.ASSIGN, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_indexAssign

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterIndexAssign" ):
                listener.enterIndexAssign(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitIndexAssign" ):
                listener.exitIndexAssign(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitIndexAssign" ):
                return visitor.visitIndexAssign(self)
            else:
                return visitor.visitChildren(self)




    def indexAssign(self):

        localctx = SquirrelParser.IndexAssignContext(self, self._ctx, self.state)
        self.enterRule(localctx, 52, self.RULE_indexAssign)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 283
            self.expression(0)
            self.state = 284
            self.match(SquirrelParser.L_BRACKET)
            self.state = 285
            self.expression(0)
            self.state = 286
            self.match(SquirrelParser.R_BRACKET)
            self.state = 287
            self.match(SquirrelParser.ASSIGN)
            self.state = 288
            self.expression(0)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class EnumStatementContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def ENUM(self):
            return self.getToken(SquirrelParser.ENUM, 0)

        def Identifier(self):
            return self.getToken(SquirrelParser.Identifier, 0)

        def L_CURLY_BRACKET(self):
            return self.getToken(SquirrelParser.L_CURLY_BRACKET, 0)

        def R_CURLY_BRACKET(self):
            return self.getToken(SquirrelParser.R_CURLY_BRACKET, 0)

        def enumerations(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.EnumerationsContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.EnumerationsContext,i)


        def getRuleIndex(self):
            return SquirrelParser.RULE_enumStatement

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterEnumStatement" ):
                listener.enterEnumStatement(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitEnumStatement" ):
                listener.exitEnumStatement(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitEnumStatement" ):
                return visitor.visitEnumStatement(self)
            else:
                return visitor.visitChildren(self)




    def enumStatement(self):

        localctx = SquirrelParser.EnumStatementContext(self, self._ctx, self.state)
        self.enterRule(localctx, 54, self.RULE_enumStatement)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 290
            self.match(SquirrelParser.ENUM)
            self.state = 291
            self.match(SquirrelParser.Identifier)
            self.state = 292
            self.match(SquirrelParser.L_CURLY_BRACKET)
            self.state = 296
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==87:
                self.state = 293
                self.enumerations()
                self.state = 298
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 299
            self.match(SquirrelParser.R_CURLY_BRACKET)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class EnumerationsContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def Identifier(self):
            return self.getToken(SquirrelParser.Identifier, 0)

        def ASSIGN(self):
            return self.getToken(SquirrelParser.ASSIGN, 0)

        def constValue(self):
            return self.getTypedRuleContext(SquirrelParser.ConstValueContext,0)


        def COMMA(self):
            return self.getToken(SquirrelParser.COMMA, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_enumerations

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterEnumerations" ):
                listener.enterEnumerations(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitEnumerations" ):
                listener.exitEnumerations(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitEnumerations" ):
                return visitor.visitEnumerations(self)
            else:
                return visitor.visitChildren(self)




    def enumerations(self):

        localctx = SquirrelParser.EnumerationsContext(self, self._ctx, self.state)
        self.enterRule(localctx, 56, self.RULE_enumerations)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 301
            self.match(SquirrelParser.Identifier)
            self.state = 302
            self.match(SquirrelParser.ASSIGN)
            self.state = 303
            self.constValue()
            self.state = 305
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            if _la==40:
                self.state = 304
                self.match(SquirrelParser.COMMA)


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class MemberDeclareContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser


        def getRuleIndex(self):
            return SquirrelParser.RULE_memberDeclare

     
        def copyFrom(self, ctx:ParserRuleContext):
            super().copyFrom(ctx)



    class MemberFunctionDeclareContext(MemberDeclareContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.MemberDeclareContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def FUNCTION(self):
            return self.getToken(SquirrelParser.FUNCTION, 0)
        def funcname(self):
            return self.getTypedRuleContext(SquirrelParser.FuncnameContext,0)

        def functionDeclareEnd(self):
            return self.getTypedRuleContext(SquirrelParser.FunctionDeclareEndContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMemberFunctionDeclare" ):
                listener.enterMemberFunctionDeclare(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMemberFunctionDeclare" ):
                listener.exitMemberFunctionDeclare(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMemberFunctionDeclare" ):
                return visitor.visitMemberFunctionDeclare(self)
            else:
                return visitor.visitChildren(self)


    class MemberArrayDeclareContext(MemberDeclareContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.MemberDeclareContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def L_BRACKET(self):
            return self.getToken(SquirrelParser.L_BRACKET, 0)
        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def R_BRACKET(self):
            return self.getToken(SquirrelParser.R_BRACKET, 0)
        def ASSIGN(self):
            return self.getToken(SquirrelParser.ASSIGN, 0)
        def SEMICOLON(self):
            return self.getToken(SquirrelParser.SEMICOLON, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMemberArrayDeclare" ):
                listener.enterMemberArrayDeclare(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMemberArrayDeclare" ):
                listener.exitMemberArrayDeclare(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMemberArrayDeclare" ):
                return visitor.visitMemberArrayDeclare(self)
            else:
                return visitor.visitChildren(self)


    class MemberConstructorDeclareContext(MemberDeclareContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.MemberDeclareContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def CONSTRUCTOR(self):
            return self.getToken(SquirrelParser.CONSTRUCTOR, 0)
        def functionDeclareEnd(self):
            return self.getTypedRuleContext(SquirrelParser.FunctionDeclareEndContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMemberConstructorDeclare" ):
                listener.enterMemberConstructorDeclare(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMemberConstructorDeclare" ):
                listener.exitMemberConstructorDeclare(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMemberConstructorDeclare" ):
                return visitor.visitMemberConstructorDeclare(self)
            else:
                return visitor.visitChildren(self)


    class MemberStaticDeclareContext(MemberDeclareContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.MemberDeclareContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def Identifier(self):
            return self.getToken(SquirrelParser.Identifier, 0)
        def ASSIGN(self):
            return self.getToken(SquirrelParser.ASSIGN, 0)
        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)

        def STATIC(self):
            return self.getToken(SquirrelParser.STATIC, 0)
        def SEMICOLON(self):
            return self.getToken(SquirrelParser.SEMICOLON, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMemberStaticDeclare" ):
                listener.enterMemberStaticDeclare(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMemberStaticDeclare" ):
                listener.exitMemberStaticDeclare(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMemberStaticDeclare" ):
                return visitor.visitMemberStaticDeclare(self)
            else:
                return visitor.visitChildren(self)



    def memberDeclare(self):

        localctx = SquirrelParser.MemberDeclareContext(self, self._ctx, self.state)
        self.enterRule(localctx, 58, self.RULE_memberDeclare)
        self._la = 0 # Token type
        try:
            self.state = 330
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [78, 87]:
                localctx = SquirrelParser.MemberStaticDeclareContext(self, localctx)
                self.enterOuterAlt(localctx, 1)
                self.state = 308
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if _la==78:
                    self.state = 307
                    self.match(SquirrelParser.STATIC)


                self.state = 310
                self.match(SquirrelParser.Identifier)
                self.state = 311
                self.match(SquirrelParser.ASSIGN)
                self.state = 312
                self.expression(0)
                self.state = 314
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if _la==38:
                    self.state = 313
                    self.match(SquirrelParser.SEMICOLON)


                pass
            elif token in [36]:
                localctx = SquirrelParser.MemberArrayDeclareContext(self, localctx)
                self.enterOuterAlt(localctx, 2)
                self.state = 316
                self.match(SquirrelParser.L_BRACKET)
                self.state = 317
                self.expression(0)
                self.state = 318
                self.match(SquirrelParser.R_BRACKET)
                self.state = 319
                self.match(SquirrelParser.ASSIGN)
                self.state = 320
                self.expression(0)
                self.state = 322
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if _la==38:
                    self.state = 321
                    self.match(SquirrelParser.SEMICOLON)


                pass
            elif token in [56]:
                localctx = SquirrelParser.MemberFunctionDeclareContext(self, localctx)
                self.enterOuterAlt(localctx, 3)
                self.state = 324
                self.match(SquirrelParser.FUNCTION)
                self.state = 325
                self.funcname()
                self.state = 326
                self.functionDeclareEnd()
                pass
            elif token in [76]:
                localctx = SquirrelParser.MemberConstructorDeclareContext(self, localctx)
                self.enterOuterAlt(localctx, 4)
                self.state = 328
                self.match(SquirrelParser.CONSTRUCTOR)
                self.state = 329
                self.functionDeclareEnd()
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class InitsContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def init(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.InitContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.InitContext,i)


        def COMMA(self, i:int=None):
            if i is None:
                return self.getTokens(SquirrelParser.COMMA)
            else:
                return self.getToken(SquirrelParser.COMMA, i)

        def getRuleIndex(self):
            return SquirrelParser.RULE_inits

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterInits" ):
                listener.enterInits(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitInits" ):
                listener.exitInits(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitInits" ):
                return visitor.visitInits(self)
            else:
                return visitor.visitChildren(self)




    def inits(self):

        localctx = SquirrelParser.InitsContext(self, self._ctx, self.state)
        self.enterRule(localctx, 60, self.RULE_inits)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 332
            self.init()
            self.state = 337
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,26,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    self.state = 333
                    self.match(SquirrelParser.COMMA)
                    self.state = 334
                    self.init() 
                self.state = 339
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,26,self._ctx)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class InitContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def Identifier(self):
            return self.getToken(SquirrelParser.Identifier, 0)

        def ASSIGN(self):
            return self.getToken(SquirrelParser.ASSIGN, 0)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_init

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterInit" ):
                listener.enterInit(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitInit" ):
                listener.exitInit(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitInit" ):
                return visitor.visitInit(self)
            else:
                return visitor.visitChildren(self)




    def init(self):

        localctx = SquirrelParser.InitContext(self, self._ctx, self.state)
        self.enterRule(localctx, 62, self.RULE_init)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 340
            self.match(SquirrelParser.Identifier)
            self.state = 343
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,27,self._ctx)
            if la_ == 1:
                self.state = 341
                self.match(SquirrelParser.ASSIGN)
                self.state = 342
                self.expression(0)


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ArgsContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def arg(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ArgContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ArgContext,i)


        def COMMA(self, i:int=None):
            if i is None:
                return self.getTokens(SquirrelParser.COMMA)
            else:
                return self.getToken(SquirrelParser.COMMA, i)

        def VARARGS(self):
            return self.getToken(SquirrelParser.VARARGS, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_args

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterArgs" ):
                listener.enterArgs(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitArgs" ):
                listener.exitArgs(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitArgs" ):
                return visitor.visitArgs(self)
            else:
                return visitor.visitChildren(self)




    def args(self):

        localctx = SquirrelParser.ArgsContext(self, self._ctx, self.state)
        self.enterRule(localctx, 64, self.RULE_args)
        self._la = 0 # Token type
        try:
            self.state = 358
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [87]:
                self.enterOuterAlt(localctx, 1)
                self.state = 345
                self.arg()
                self.state = 350
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,28,self._ctx)
                while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                    if _alt==1:
                        self.state = 346
                        self.match(SquirrelParser.COMMA)
                        self.state = 347
                        self.arg() 
                    self.state = 352
                    self._errHandler.sync(self)
                    _alt = self._interp.adaptivePredict(self._input,28,self._ctx)

                self.state = 355
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if _la==40:
                    self.state = 353
                    self.match(SquirrelParser.COMMA)
                    self.state = 354
                    self.match(SquirrelParser.VARARGS)


                pass
            elif token in [2]:
                self.enterOuterAlt(localctx, 2)
                self.state = 357
                self.match(SquirrelParser.VARARGS)
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ArgContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def Identifier(self):
            return self.getToken(SquirrelParser.Identifier, 0)

        def ASSIGN(self):
            return self.getToken(SquirrelParser.ASSIGN, 0)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_arg

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterArg" ):
                listener.enterArg(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitArg" ):
                listener.exitArg(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitArg" ):
                return visitor.visitArg(self)
            else:
                return visitor.visitChildren(self)




    def arg(self):

        localctx = SquirrelParser.ArgContext(self, self._ctx, self.state)
        self.enterRule(localctx, 66, self.RULE_arg)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 360
            self.match(SquirrelParser.Identifier)
            self.state = 363
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            if _la==17:
                self.state = 361
                self.match(SquirrelParser.ASSIGN)
                self.state = 362
                self.expression(0)


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class FuncnameContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def Identifier(self, i:int=None):
            if i is None:
                return self.getTokens(SquirrelParser.Identifier)
            else:
                return self.getToken(SquirrelParser.Identifier, i)

        def SCOPE(self, i:int=None):
            if i is None:
                return self.getTokens(SquirrelParser.SCOPE)
            else:
                return self.getToken(SquirrelParser.SCOPE, i)

        def getRuleIndex(self):
            return SquirrelParser.RULE_funcname

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFuncname" ):
                listener.enterFuncname(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFuncname" ):
                listener.exitFuncname(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFuncname" ):
                return visitor.visitFuncname(self)
            else:
                return visitor.visitChildren(self)




    def funcname(self):

        localctx = SquirrelParser.FuncnameContext(self, self._ctx, self.state)
        self.enterRule(localctx, 68, self.RULE_funcname)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 365
            self.match(SquirrelParser.Identifier)
            self.state = 370
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la==1:
                self.state = 366
                self.match(SquirrelParser.SCOPE)
                self.state = 367
                self.match(SquirrelParser.Identifier)
                self.state = 372
                self._errHandler.sync(self)
                _la = self._input.LA(1)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class LiteralContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def IntegerLiteral(self):
            return self.getToken(SquirrelParser.IntegerLiteral, 0)

        def FloatLiteral(self):
            return self.getToken(SquirrelParser.FloatLiteral, 0)

        def BooleanLiteral(self):
            return self.getToken(SquirrelParser.BooleanLiteral, 0)

        def stringLiteral(self):
            return self.getTypedRuleContext(SquirrelParser.StringLiteralContext,0)


        def NULL(self):
            return self.getToken(SquirrelParser.NULL, 0)

        def THIS(self):
            return self.getToken(SquirrelParser.THIS, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_literal

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLiteral" ):
                listener.enterLiteral(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLiteral" ):
                listener.exitLiteral(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitLiteral" ):
                return visitor.visitLiteral(self)
            else:
                return visitor.visitChildren(self)




    def literal(self):

        localctx = SquirrelParser.LiteralContext(self, self._ctx, self.state)
        self.enterRule(localctx, 70, self.RULE_literal)
        try:
            self.state = 379
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [81]:
                self.enterOuterAlt(localctx, 1)
                self.state = 373
                self.match(SquirrelParser.IntegerLiteral)
                pass
            elif token in [82]:
                self.enterOuterAlt(localctx, 2)
                self.state = 374
                self.match(SquirrelParser.FloatLiteral)
                pass
            elif token in [86]:
                self.enterOuterAlt(localctx, 3)
                self.state = 375
                self.match(SquirrelParser.BooleanLiteral)
                pass
            elif token in [83]:
                self.enterOuterAlt(localctx, 4)
                self.state = 376
                self.stringLiteral()
                pass
            elif token in [55]:
                self.enterOuterAlt(localctx, 5)
                self.state = 377
                self.match(SquirrelParser.NULL)
                pass
            elif token in [73]:
                self.enterOuterAlt(localctx, 6)
                self.state = 378
                self.match(SquirrelParser.THIS)
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ExpressionContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser


        def getRuleIndex(self):
            return SquirrelParser.RULE_expression

     
        def copyFrom(self, ctx:ParserRuleContext):
            super().copyFrom(ctx)


    class TableConstructionExprContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def tableConstruction(self):
            return self.getTypedRuleContext(SquirrelParser.TableConstructionContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterTableConstructionExpr" ):
                listener.enterTableConstructionExpr(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitTableConstructionExpr" ):
                listener.exitTableConstructionExpr(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitTableConstructionExpr" ):
                return visitor.visitTableConstructionExpr(self)
            else:
                return visitor.visitChildren(self)


    class PreincrementOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def INCREMENT(self):
            return self.getToken(SquirrelParser.INCREMENT, 0)
        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterPreincrementOp" ):
                listener.enterPreincrementOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitPreincrementOp" ):
                listener.exitPreincrementOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitPreincrementOp" ):
                return visitor.visitPreincrementOp(self)
            else:
                return visitor.visitChildren(self)


    class LessEqualOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def LESS_OR_EQUAL(self):
            return self.getToken(SquirrelParser.LESS_OR_EQUAL, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLessEqualOp" ):
                listener.enterLessEqualOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLessEqualOp" ):
                listener.exitLessEqualOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitLessEqualOp" ):
                return visitor.visitLessEqualOp(self)
            else:
                return visitor.visitChildren(self)


    class DivideOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def DIVIDE(self):
            return self.getToken(SquirrelParser.DIVIDE, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterDivideOp" ):
                listener.enterDivideOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitDivideOp" ):
                listener.exitDivideOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitDivideOp" ):
                return visitor.visitDivideOp(self)
            else:
                return visitor.visitChildren(self)


    class ModuloOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def MODULO(self):
            return self.getToken(SquirrelParser.MODULO, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterModuloOp" ):
                listener.enterModuloOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitModuloOp" ):
                listener.exitModuloOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitModuloOp" ):
                return visitor.visitModuloOp(self)
            else:
                return visitor.visitChildren(self)


    class ResumeExpressionContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def RESUME(self):
            return self.getToken(SquirrelParser.RESUME, 0)
        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterResumeExpression" ):
                listener.enterResumeExpression(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitResumeExpression" ):
                listener.exitResumeExpression(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitResumeExpression" ):
                return visitor.visitResumeExpression(self)
            else:
                return visitor.visitChildren(self)


    class LambdaContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def AT(self):
            return self.getToken(SquirrelParser.AT, 0)
        def L_PAREN(self):
            return self.getToken(SquirrelParser.L_PAREN, 0)
        def R_PAREN(self):
            return self.getToken(SquirrelParser.R_PAREN, 0)
        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)

        def args(self):
            return self.getTypedRuleContext(SquirrelParser.ArgsContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLambda" ):
                listener.enterLambda(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLambda" ):
                listener.exitLambda(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitLambda" ):
                return visitor.visitLambda(self)
            else:
                return visitor.visitChildren(self)


    class LogicalAndOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def LOGICAL_AND(self):
            return self.getToken(SquirrelParser.LOGICAL_AND, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLogicalAndOp" ):
                listener.enterLogicalAndOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLogicalAndOp" ):
                listener.exitLogicalAndOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitLogicalAndOp" ):
                return visitor.visitLogicalAndOp(self)
            else:
                return visitor.visitChildren(self)


    class LogicalOrOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def LOGICAL_OR(self):
            return self.getToken(SquirrelParser.LOGICAL_OR, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLogicalOrOp" ):
                listener.enterLogicalOrOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLogicalOrOp" ):
                listener.exitLogicalOrOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitLogicalOrOp" ):
                return visitor.visitLogicalOrOp(self)
            else:
                return visitor.visitChildren(self)


    class NewslotContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def NEWSLOT(self):
            return self.getToken(SquirrelParser.NEWSLOT, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterNewslot" ):
                listener.enterNewslot(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitNewslot" ):
                listener.exitNewslot(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitNewslot" ):
                return visitor.visitNewslot(self)
            else:
                return visitor.visitChildren(self)


    class ArrayConstructionContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def L_BRACKET(self):
            return self.getToken(SquirrelParser.L_BRACKET, 0)
        def R_BRACKET(self):
            return self.getToken(SquirrelParser.R_BRACKET, 0)
        def expressionList(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionListContext,0)

        def COMMA(self):
            return self.getToken(SquirrelParser.COMMA, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterArrayConstruction" ):
                listener.enterArrayConstruction(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitArrayConstruction" ):
                listener.exitArrayConstruction(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitArrayConstruction" ):
                return visitor.visitArrayConstruction(self)
            else:
                return visitor.visitChildren(self)


    class RightShiftOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def RIGHT_SHIFT(self):
            return self.getToken(SquirrelParser.RIGHT_SHIFT, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterRightShiftOp" ):
                listener.enterRightShiftOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitRightShiftOp" ):
                listener.exitRightShiftOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitRightShiftOp" ):
                return visitor.visitRightShiftOp(self)
            else:
                return visitor.visitChildren(self)


    class PostdecrementOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)

        def DECREMENT(self):
            return self.getToken(SquirrelParser.DECREMENT, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterPostdecrementOp" ):
                listener.enterPostdecrementOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitPostdecrementOp" ):
                listener.exitPostdecrementOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitPostdecrementOp" ):
                return visitor.visitPostdecrementOp(self)
            else:
                return visitor.visitChildren(self)


    class UnaryMinusOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def MINUS(self):
            return self.getToken(SquirrelParser.MINUS, 0)
        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterUnaryMinusOp" ):
                listener.enterUnaryMinusOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitUnaryMinusOp" ):
                listener.exitUnaryMinusOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitUnaryMinusOp" ):
                return visitor.visitUnaryMinusOp(self)
            else:
                return visitor.visitChildren(self)


    class IdentifierContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def Identifier(self):
            return self.getToken(SquirrelParser.Identifier, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterIdentifier" ):
                listener.enterIdentifier(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitIdentifier" ):
                listener.exitIdentifier(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitIdentifier" ):
                return visitor.visitIdentifier(self)
            else:
                return visitor.visitChildren(self)


    class NotEqualOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def NOT_EQUAL(self):
            return self.getToken(SquirrelParser.NOT_EQUAL, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterNotEqualOp" ):
                listener.enterNotEqualOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitNotEqualOp" ):
                listener.exitNotEqualOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitNotEqualOp" ):
                return visitor.visitNotEqualOp(self)
            else:
                return visitor.visitChildren(self)


    class SubEqualOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def ASSIGN_SUB(self):
            return self.getToken(SquirrelParser.ASSIGN_SUB, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterSubEqualOp" ):
                listener.enterSubEqualOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitSubEqualOp" ):
                listener.exitSubEqualOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitSubEqualOp" ):
                return visitor.visitSubEqualOp(self)
            else:
                return visitor.visitChildren(self)


    class PostincrementOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)

        def INCREMENT(self):
            return self.getToken(SquirrelParser.INCREMENT, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterPostincrementOp" ):
                listener.enterPostincrementOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitPostincrementOp" ):
                listener.exitPostincrementOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitPostincrementOp" ):
                return visitor.visitPostincrementOp(self)
            else:
                return visitor.visitChildren(self)


    class BaseExpressionContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def BASE(self):
            return self.getToken(SquirrelParser.BASE, 0)
        def DOT(self):
            return self.getToken(SquirrelParser.DOT, 0)
        def Identifier(self):
            return self.getToken(SquirrelParser.Identifier, 0)
        def L_PAREN(self):
            return self.getToken(SquirrelParser.L_PAREN, 0)
        def R_PAREN(self):
            return self.getToken(SquirrelParser.R_PAREN, 0)
        def expressionList(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionListContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterBaseExpression" ):
                listener.enterBaseExpression(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitBaseExpression" ):
                listener.exitBaseExpression(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitBaseExpression" ):
                return visitor.visitBaseExpression(self)
            else:
                return visitor.visitChildren(self)


    class BitwiseAndOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def BITWISE_AND(self):
            return self.getToken(SquirrelParser.BITWISE_AND, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterBitwiseAndOp" ):
                listener.enterBitwiseAndOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitBitwiseAndOp" ):
                listener.exitBitwiseAndOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitBitwiseAndOp" ):
                return visitor.visitBitwiseAndOp(self)
            else:
                return visitor.visitChildren(self)


    class LeftShiftOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def LEFT_SHIFT(self):
            return self.getToken(SquirrelParser.LEFT_SHIFT, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLeftShiftOp" ):
                listener.enterLeftShiftOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLeftShiftOp" ):
                listener.exitLeftShiftOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitLeftShiftOp" ):
                return visitor.visitLeftShiftOp(self)
            else:
                return visitor.visitChildren(self)


    class RightUnsignedShiftOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def RIGHT_UNSIGNED_SHIFT(self):
            return self.getToken(SquirrelParser.RIGHT_UNSIGNED_SHIFT, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterRightUnsignedShiftOp" ):
                listener.enterRightUnsignedShiftOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitRightUnsignedShiftOp" ):
                listener.exitRightUnsignedShiftOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitRightUnsignedShiftOp" ):
                return visitor.visitRightUnsignedShiftOp(self)
            else:
                return visitor.visitChildren(self)


    class DotAccessContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)

        def DOT(self):
            return self.getToken(SquirrelParser.DOT, 0)
        def Identifier(self):
            return self.getToken(SquirrelParser.Identifier, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterDotAccess" ):
                listener.enterDotAccess(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitDotAccess" ):
                listener.exitDotAccess(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitDotAccess" ):
                return visitor.visitDotAccess(self)
            else:
                return visitor.visitChildren(self)


    class IndexAccessContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def L_BRACKET(self):
            return self.getToken(SquirrelParser.L_BRACKET, 0)
        def R_BRACKET(self):
            return self.getToken(SquirrelParser.R_BRACKET, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterIndexAccess" ):
                listener.enterIndexAccess(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitIndexAccess" ):
                listener.exitIndexAccess(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitIndexAccess" ):
                return visitor.visitIndexAccess(self)
            else:
                return visitor.visitChildren(self)


    class ModEqualOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def ASSIGN_MOD(self):
            return self.getToken(SquirrelParser.ASSIGN_MOD, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterModEqualOp" ):
                listener.enterModEqualOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitModEqualOp" ):
                listener.exitModEqualOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitModEqualOp" ):
                return visitor.visitModEqualOp(self)
            else:
                return visitor.visitChildren(self)


    class FunctionCallContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)

        def L_PAREN(self):
            return self.getToken(SquirrelParser.L_PAREN, 0)
        def R_PAREN(self):
            return self.getToken(SquirrelParser.R_PAREN, 0)
        def expressionList(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionListContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFunctionCall" ):
                listener.enterFunctionCall(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFunctionCall" ):
                listener.exitFunctionCall(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFunctionCall" ):
                return visitor.visitFunctionCall(self)
            else:
                return visitor.visitChildren(self)


    class InstanceofOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def INSTANCEOF(self):
            return self.getToken(SquirrelParser.INSTANCEOF, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterInstanceofOp" ):
                listener.enterInstanceofOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitInstanceofOp" ):
                listener.exitInstanceofOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitInstanceofOp" ):
                return visitor.visitInstanceofOp(self)
            else:
                return visitor.visitChildren(self)


    class GreaterEqualOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def GREATER_OR_EQUAL(self):
            return self.getToken(SquirrelParser.GREATER_OR_EQUAL, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterGreaterEqualOp" ):
                listener.enterGreaterEqualOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitGreaterEqualOp" ):
                listener.exitGreaterEqualOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitGreaterEqualOp" ):
                return visitor.visitGreaterEqualOp(self)
            else:
                return visitor.visitChildren(self)


    class TernaryOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def QUESTION(self):
            return self.getToken(SquirrelParser.QUESTION, 0)
        def COLON(self):
            return self.getToken(SquirrelParser.COLON, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterTernaryOp" ):
                listener.enterTernaryOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitTernaryOp" ):
                listener.exitTernaryOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitTernaryOp" ):
                return visitor.visitTernaryOp(self)
            else:
                return visitor.visitChildren(self)


    class CloneExpressionContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def CLONE(self):
            return self.getToken(SquirrelParser.CLONE, 0)
        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterCloneExpression" ):
                listener.enterCloneExpression(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitCloneExpression" ):
                listener.exitCloneExpression(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitCloneExpression" ):
                return visitor.visitCloneExpression(self)
            else:
                return visitor.visitChildren(self)


    class MultiplyOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def MULTIPLY(self):
            return self.getToken(SquirrelParser.MULTIPLY, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMultiplyOp" ):
                listener.enterMultiplyOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMultiplyOp" ):
                listener.exitMultiplyOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMultiplyOp" ):
                return visitor.visitMultiplyOp(self)
            else:
                return visitor.visitChildren(self)


    class AssignOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def ASSIGN(self):
            return self.getToken(SquirrelParser.ASSIGN, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterAssignOp" ):
                listener.enterAssignOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitAssignOp" ):
                listener.exitAssignOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitAssignOp" ):
                return visitor.visitAssignOp(self)
            else:
                return visitor.visitChildren(self)


    class DeleteOperationContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def DELETE(self):
            return self.getToken(SquirrelParser.DELETE, 0)
        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterDeleteOperation" ):
                listener.enterDeleteOperation(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitDeleteOperation" ):
                listener.exitDeleteOperation(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitDeleteOperation" ):
                return visitor.visitDeleteOperation(self)
            else:
                return visitor.visitChildren(self)


    class GreaterOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def GREATER_THAN(self):
            return self.getToken(SquirrelParser.GREATER_THAN, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterGreaterOp" ):
                listener.enterGreaterOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitGreaterOp" ):
                listener.exitGreaterOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitGreaterOp" ):
                return visitor.visitGreaterOp(self)
            else:
                return visitor.visitChildren(self)


    class AnonymousFunctionContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def FUNCTION(self):
            return self.getToken(SquirrelParser.FUNCTION, 0)
        def functionDeclareEnd(self):
            return self.getTypedRuleContext(SquirrelParser.FunctionDeclareEndContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterAnonymousFunction" ):
                listener.enterAnonymousFunction(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitAnonymousFunction" ):
                listener.exitAnonymousFunction(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitAnonymousFunction" ):
                return visitor.visitAnonymousFunction(self)
            else:
                return visitor.visitChildren(self)


    class SubOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def MINUS(self):
            return self.getToken(SquirrelParser.MINUS, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterSubOp" ):
                listener.enterSubOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitSubOp" ):
                listener.exitSubOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitSubOp" ):
                return visitor.visitSubOp(self)
            else:
                return visitor.visitChildren(self)


    class LessOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def LESS_THAN(self):
            return self.getToken(SquirrelParser.LESS_THAN, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLessOp" ):
                listener.enterLessOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLessOp" ):
                listener.exitLessOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitLessOp" ):
                return visitor.visitLessOp(self)
            else:
                return visitor.visitChildren(self)


    class ParenExpressionContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def L_PAREN(self):
            return self.getToken(SquirrelParser.L_PAREN, 0)
        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)

        def R_PAREN(self):
            return self.getToken(SquirrelParser.R_PAREN, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterParenExpression" ):
                listener.enterParenExpression(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitParenExpression" ):
                listener.exitParenExpression(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitParenExpression" ):
                return visitor.visitParenExpression(self)
            else:
                return visitor.visitChildren(self)


    class PredecrementOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def DECREMENT(self):
            return self.getToken(SquirrelParser.DECREMENT, 0)
        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterPredecrementOp" ):
                listener.enterPredecrementOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitPredecrementOp" ):
                listener.exitPredecrementOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitPredecrementOp" ):
                return visitor.visitPredecrementOp(self)
            else:
                return visitor.visitChildren(self)


    class BitwiseOrOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def BITWISE_OR(self):
            return self.getToken(SquirrelParser.BITWISE_OR, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterBitwiseOrOp" ):
                listener.enterBitwiseOrOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitBitwiseOrOp" ):
                listener.exitBitwiseOrOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitBitwiseOrOp" ):
                return visitor.visitBitwiseOrOp(self)
            else:
                return visitor.visitChildren(self)


    class AddEqualOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def ASSIGN_ADD(self):
            return self.getToken(SquirrelParser.ASSIGN_ADD, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterAddEqualOp" ):
                listener.enterAddEqualOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitAddEqualOp" ):
                listener.exitAddEqualOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitAddEqualOp" ):
                return visitor.visitAddEqualOp(self)
            else:
                return visitor.visitChildren(self)


    class InOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def IN(self):
            return self.getToken(SquirrelParser.IN, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterInOp" ):
                listener.enterInOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitInOp" ):
                listener.exitInOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitInOp" ):
                return visitor.visitInOp(self)
            else:
                return visitor.visitChildren(self)


    class MulEqualOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def ASSIGN_MUL(self):
            return self.getToken(SquirrelParser.ASSIGN_MUL, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterMulEqualOp" ):
                listener.enterMulEqualOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitMulEqualOp" ):
                listener.exitMulEqualOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitMulEqualOp" ):
                return visitor.visitMulEqualOp(self)
            else:
                return visitor.visitChildren(self)


    class LogicalNotOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def LOGICAL_NOT(self):
            return self.getToken(SquirrelParser.LOGICAL_NOT, 0)
        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLogicalNotOp" ):
                listener.enterLogicalNotOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLogicalNotOp" ):
                listener.exitLogicalNotOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitLogicalNotOp" ):
                return visitor.visitLogicalNotOp(self)
            else:
                return visitor.visitChildren(self)


    class BitwiseNotOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def BITWISE_NOT(self):
            return self.getToken(SquirrelParser.BITWISE_NOT, 0)
        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterBitwiseNotOp" ):
                listener.enterBitwiseNotOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitBitwiseNotOp" ):
                listener.exitBitwiseNotOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitBitwiseNotOp" ):
                return visitor.visitBitwiseNotOp(self)
            else:
                return visitor.visitChildren(self)


    class AddOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def PLUS(self):
            return self.getToken(SquirrelParser.PLUS, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterAddOp" ):
                listener.enterAddOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitAddOp" ):
                listener.exitAddOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitAddOp" ):
                return visitor.visitAddOp(self)
            else:
                return visitor.visitChildren(self)


    class DivEqualOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def ASSIGN_DIV(self):
            return self.getToken(SquirrelParser.ASSIGN_DIV, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterDivEqualOp" ):
                listener.enterDivEqualOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitDivEqualOp" ):
                listener.exitDivEqualOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitDivEqualOp" ):
                return visitor.visitDivEqualOp(self)
            else:
                return visitor.visitChildren(self)


    class ScopeAccessContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def SCOPE(self):
            return self.getToken(SquirrelParser.SCOPE, 0)
        def Identifier(self):
            return self.getToken(SquirrelParser.Identifier, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterScopeAccess" ):
                listener.enterScopeAccess(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitScopeAccess" ):
                listener.exitScopeAccess(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitScopeAccess" ):
                return visitor.visitScopeAccess(self)
            else:
                return visitor.visitChildren(self)


    class CompareOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def COMPARE(self):
            return self.getToken(SquirrelParser.COMPARE, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterCompareOp" ):
                listener.enterCompareOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitCompareOp" ):
                listener.exitCompareOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitCompareOp" ):
                return visitor.visitCompareOp(self)
            else:
                return visitor.visitChildren(self)


    class TypeofOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def TYPEOF(self):
            return self.getToken(SquirrelParser.TYPEOF, 0)
        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterTypeofOp" ):
                listener.enterTypeofOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitTypeofOp" ):
                listener.exitTypeofOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitTypeofOp" ):
                return visitor.visitTypeofOp(self)
            else:
                return visitor.visitChildren(self)


    class FunctionDeclareContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def FUNCTION(self):
            return self.getToken(SquirrelParser.FUNCTION, 0)
        def funcname(self):
            return self.getTypedRuleContext(SquirrelParser.FuncnameContext,0)

        def functionDeclareEnd(self):
            return self.getTypedRuleContext(SquirrelParser.FunctionDeclareEndContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFunctionDeclare" ):
                listener.enterFunctionDeclare(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFunctionDeclare" ):
                listener.exitFunctionDeclare(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFunctionDeclare" ):
                return visitor.visitFunctionDeclare(self)
            else:
                return visitor.visitChildren(self)


    class BitwiseXOROpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def BITWISE_XOR(self):
            return self.getToken(SquirrelParser.BITWISE_XOR, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterBitwiseXOROp" ):
                listener.enterBitwiseXOROp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitBitwiseXOROp" ):
                listener.exitBitwiseXOROp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitBitwiseXOROp" ):
                return visitor.visitBitwiseXOROp(self)
            else:
                return visitor.visitChildren(self)


    class EqualOpContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)

        def EQUAL(self):
            return self.getToken(SquirrelParser.EQUAL, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterEqualOp" ):
                listener.enterEqualOp(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitEqualOp" ):
                listener.exitEqualOp(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitEqualOp" ):
                return visitor.visitEqualOp(self)
            else:
                return visitor.visitChildren(self)


    class LiteralExpressionContext(ExpressionContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a SquirrelParser.ExpressionContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def literal(self):
            return self.getTypedRuleContext(SquirrelParser.LiteralContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterLiteralExpression" ):
                listener.enterLiteralExpression(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitLiteralExpression" ):
                listener.exitLiteralExpression(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitLiteralExpression" ):
                return visitor.visitLiteralExpression(self)
            else:
                return visitor.visitChildren(self)



    def expression(self, _p:int=0):
        _parentctx = self._ctx
        _parentState = self.state
        localctx = SquirrelParser.ExpressionContext(self, self._ctx, _parentState)
        _prevctx = localctx
        _startState = 72
        self.enterRecursionRule(localctx, 72, self.RULE_expression, _p)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 438
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,38,self._ctx)
            if la_ == 1:
                localctx = SquirrelParser.LiteralExpressionContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx

                self.state = 382
                self.literal()
                pass

            elif la_ == 2:
                localctx = SquirrelParser.IdentifierContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 383
                self.match(SquirrelParser.Identifier)
                pass

            elif la_ == 3:
                localctx = SquirrelParser.ParenExpressionContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 384
                self.match(SquirrelParser.L_PAREN)
                self.state = 385
                self.expression(0)
                self.state = 386
                self.match(SquirrelParser.R_PAREN)
                pass

            elif la_ == 4:
                localctx = SquirrelParser.TableConstructionExprContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 388
                self.tableConstruction()
                pass

            elif la_ == 5:
                localctx = SquirrelParser.ArrayConstructionContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 389
                self.match(SquirrelParser.L_BRACKET)
                self.state = 391
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if (((_la) & ~0x3f) == 0 and ((1 << _la) & -2197719144548270030) != 0) or ((((_la - 67)) & ~0x3f) == 0 and ((1 << (_la - 67)) & 1687621) != 0):
                    self.state = 390
                    self.expressionList()


                self.state = 394
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if _la==40:
                    self.state = 393
                    self.match(SquirrelParser.COMMA)


                self.state = 396
                self.match(SquirrelParser.R_BRACKET)
                pass

            elif la_ == 6:
                localctx = SquirrelParser.FunctionDeclareContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 397
                self.match(SquirrelParser.FUNCTION)
                self.state = 398
                self.funcname()
                self.state = 399
                self.functionDeclareEnd()
                pass

            elif la_ == 7:
                localctx = SquirrelParser.AnonymousFunctionContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 401
                self.match(SquirrelParser.FUNCTION)
                self.state = 402
                self.functionDeclareEnd()
                pass

            elif la_ == 8:
                localctx = SquirrelParser.LambdaContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 403
                self.match(SquirrelParser.AT)
                self.state = 404
                self.match(SquirrelParser.L_PAREN)
                self.state = 406
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if _la==2 or _la==87:
                    self.state = 405
                    self.args()


                self.state = 408
                self.match(SquirrelParser.R_PAREN)
                self.state = 409
                self.expression(47)
                pass

            elif la_ == 9:
                localctx = SquirrelParser.BaseExpressionContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 410
                self.match(SquirrelParser.BASE)
                self.state = 411
                self.match(SquirrelParser.DOT)
                self.state = 412
                self.match(SquirrelParser.Identifier)
                self.state = 413
                self.match(SquirrelParser.L_PAREN)
                self.state = 415
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if (((_la) & ~0x3f) == 0 and ((1 << _la) & -2197719144548270030) != 0) or ((((_la - 67)) & ~0x3f) == 0 and ((1 << (_la - 67)) & 1687621) != 0):
                    self.state = 414
                    self.expressionList()


                self.state = 417
                self.match(SquirrelParser.R_PAREN)
                pass

            elif la_ == 10:
                localctx = SquirrelParser.ScopeAccessContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 418
                self.match(SquirrelParser.SCOPE)
                self.state = 419
                self.match(SquirrelParser.Identifier)
                pass

            elif la_ == 11:
                localctx = SquirrelParser.CloneExpressionContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 420
                self.match(SquirrelParser.CLONE)
                self.state = 421
                self.expression(39)
                pass

            elif la_ == 12:
                localctx = SquirrelParser.ResumeExpressionContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 422
                self.match(SquirrelParser.RESUME)
                self.state = 423
                self.expression(38)
                pass

            elif la_ == 13:
                localctx = SquirrelParser.DeleteOperationContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 424
                self.match(SquirrelParser.DELETE)
                self.state = 425
                self.expression(37)
                pass

            elif la_ == 14:
                localctx = SquirrelParser.UnaryMinusOpContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 426
                self.match(SquirrelParser.MINUS)
                self.state = 427
                self.expression(36)
                pass

            elif la_ == 15:
                localctx = SquirrelParser.BitwiseNotOpContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 428
                self.match(SquirrelParser.BITWISE_NOT)
                self.state = 429
                self.expression(35)
                pass

            elif la_ == 16:
                localctx = SquirrelParser.LogicalNotOpContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 430
                self.match(SquirrelParser.LOGICAL_NOT)
                self.state = 431
                self.expression(34)
                pass

            elif la_ == 17:
                localctx = SquirrelParser.TypeofOpContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 432
                self.match(SquirrelParser.TYPEOF)
                self.state = 433
                self.expression(33)
                pass

            elif la_ == 18:
                localctx = SquirrelParser.PreincrementOpContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 434
                self.match(SquirrelParser.INCREMENT)
                self.state = 435
                self.expression(32)
                pass

            elif la_ == 19:
                localctx = SquirrelParser.PredecrementOpContext(self, localctx)
                self._ctx = localctx
                _prevctx = localctx
                self.state = 436
                self.match(SquirrelParser.DECREMENT)
                self.state = 437
                self.expression(31)
                pass


            self._ctx.stop = self._input.LT(-1)
            self.state = 553
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,41,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    if self._parseListeners is not None:
                        self.triggerExitRuleEvent()
                    _prevctx = localctx
                    self.state = 551
                    self._errHandler.sync(self)
                    la_ = self._interp.adaptivePredict(self._input,40,self._ctx)
                    if la_ == 1:
                        localctx = SquirrelParser.DivideOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 440
                        if not self.precpred(self._ctx, 30):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 30)")
                        self.state = 441
                        self.match(SquirrelParser.DIVIDE)
                        self.state = 442
                        self.expression(31)
                        pass

                    elif la_ == 2:
                        localctx = SquirrelParser.MultiplyOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 443
                        if not self.precpred(self._ctx, 29):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 29)")
                        self.state = 444
                        self.match(SquirrelParser.MULTIPLY)
                        self.state = 445
                        self.expression(30)
                        pass

                    elif la_ == 3:
                        localctx = SquirrelParser.ModuloOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 446
                        if not self.precpred(self._ctx, 28):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 28)")
                        self.state = 447
                        self.match(SquirrelParser.MODULO)
                        self.state = 448
                        self.expression(29)
                        pass

                    elif la_ == 4:
                        localctx = SquirrelParser.AddOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 449
                        if not self.precpred(self._ctx, 27):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 27)")
                        self.state = 450
                        self.match(SquirrelParser.PLUS)
                        self.state = 451
                        self.expression(28)
                        pass

                    elif la_ == 5:
                        localctx = SquirrelParser.SubOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 452
                        if not self.precpred(self._ctx, 26):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 26)")
                        self.state = 453
                        self.match(SquirrelParser.MINUS)
                        self.state = 454
                        self.expression(27)
                        pass

                    elif la_ == 6:
                        localctx = SquirrelParser.LeftShiftOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 455
                        if not self.precpred(self._ctx, 25):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 25)")
                        self.state = 456
                        self.match(SquirrelParser.LEFT_SHIFT)
                        self.state = 457
                        self.expression(26)
                        pass

                    elif la_ == 7:
                        localctx = SquirrelParser.RightShiftOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 458
                        if not self.precpred(self._ctx, 24):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 24)")
                        self.state = 459
                        self.match(SquirrelParser.RIGHT_SHIFT)
                        self.state = 460
                        self.expression(25)
                        pass

                    elif la_ == 8:
                        localctx = SquirrelParser.RightUnsignedShiftOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 461
                        if not self.precpred(self._ctx, 23):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 23)")
                        self.state = 462
                        self.match(SquirrelParser.RIGHT_UNSIGNED_SHIFT)
                        self.state = 463
                        self.expression(24)
                        pass

                    elif la_ == 9:
                        localctx = SquirrelParser.LessOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 464
                        if not self.precpred(self._ctx, 22):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 22)")
                        self.state = 465
                        self.match(SquirrelParser.LESS_THAN)
                        self.state = 466
                        self.expression(23)
                        pass

                    elif la_ == 10:
                        localctx = SquirrelParser.LessEqualOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 467
                        if not self.precpred(self._ctx, 21):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 21)")
                        self.state = 468
                        self.match(SquirrelParser.LESS_OR_EQUAL)
                        self.state = 469
                        self.expression(22)
                        pass

                    elif la_ == 11:
                        localctx = SquirrelParser.GreaterOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 470
                        if not self.precpred(self._ctx, 20):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 20)")
                        self.state = 471
                        self.match(SquirrelParser.GREATER_THAN)
                        self.state = 472
                        self.expression(21)
                        pass

                    elif la_ == 12:
                        localctx = SquirrelParser.GreaterEqualOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 473
                        if not self.precpred(self._ctx, 19):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 19)")
                        self.state = 474
                        self.match(SquirrelParser.GREATER_OR_EQUAL)
                        self.state = 475
                        self.expression(20)
                        pass

                    elif la_ == 13:
                        localctx = SquirrelParser.EqualOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 476
                        if not self.precpred(self._ctx, 18):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 18)")
                        self.state = 477
                        self.match(SquirrelParser.EQUAL)
                        self.state = 478
                        self.expression(19)
                        pass

                    elif la_ == 14:
                        localctx = SquirrelParser.NotEqualOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 479
                        if not self.precpred(self._ctx, 17):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 17)")
                        self.state = 480
                        self.match(SquirrelParser.NOT_EQUAL)
                        self.state = 481
                        self.expression(18)
                        pass

                    elif la_ == 15:
                        localctx = SquirrelParser.CompareOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 482
                        if not self.precpred(self._ctx, 16):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 16)")
                        self.state = 483
                        self.match(SquirrelParser.COMPARE)
                        self.state = 484
                        self.expression(17)
                        pass

                    elif la_ == 16:
                        localctx = SquirrelParser.BitwiseAndOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 485
                        if not self.precpred(self._ctx, 15):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 15)")
                        self.state = 486
                        self.match(SquirrelParser.BITWISE_AND)
                        self.state = 487
                        self.expression(16)
                        pass

                    elif la_ == 17:
                        localctx = SquirrelParser.BitwiseXOROpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 488
                        if not self.precpred(self._ctx, 14):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 14)")
                        self.state = 489
                        self.match(SquirrelParser.BITWISE_XOR)
                        self.state = 490
                        self.expression(15)
                        pass

                    elif la_ == 18:
                        localctx = SquirrelParser.BitwiseOrOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 491
                        if not self.precpred(self._ctx, 13):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 13)")
                        self.state = 492
                        self.match(SquirrelParser.BITWISE_OR)
                        self.state = 493
                        self.expression(14)
                        pass

                    elif la_ == 19:
                        localctx = SquirrelParser.LogicalAndOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 494
                        if not self.precpred(self._ctx, 12):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 12)")
                        self.state = 495
                        self.match(SquirrelParser.LOGICAL_AND)
                        self.state = 496
                        self.expression(13)
                        pass

                    elif la_ == 20:
                        localctx = SquirrelParser.InOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 497
                        if not self.precpred(self._ctx, 11):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 11)")
                        self.state = 498
                        self.match(SquirrelParser.IN)
                        self.state = 499
                        self.expression(12)
                        pass

                    elif la_ == 21:
                        localctx = SquirrelParser.LogicalOrOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 500
                        if not self.precpred(self._ctx, 10):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 10)")
                        self.state = 501
                        self.match(SquirrelParser.LOGICAL_OR)
                        self.state = 502
                        self.expression(11)
                        pass

                    elif la_ == 22:
                        localctx = SquirrelParser.InstanceofOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 503
                        if not self.precpred(self._ctx, 9):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 9)")
                        self.state = 504
                        self.match(SquirrelParser.INSTANCEOF)
                        self.state = 505
                        self.expression(10)
                        pass

                    elif la_ == 23:
                        localctx = SquirrelParser.TernaryOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 506
                        if not self.precpred(self._ctx, 8):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 8)")
                        self.state = 507
                        self.match(SquirrelParser.QUESTION)
                        self.state = 508
                        self.expression(0)
                        self.state = 509
                        self.match(SquirrelParser.COLON)
                        self.state = 510
                        self.expression(9)
                        pass

                    elif la_ == 24:
                        localctx = SquirrelParser.NewslotContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 512
                        if not self.precpred(self._ctx, 7):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 7)")
                        self.state = 513
                        self.match(SquirrelParser.NEWSLOT)
                        self.state = 514
                        self.expression(8)
                        pass

                    elif la_ == 25:
                        localctx = SquirrelParser.MulEqualOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 515
                        if not self.precpred(self._ctx, 6):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 6)")
                        self.state = 516
                        self.match(SquirrelParser.ASSIGN_MUL)
                        self.state = 517
                        self.expression(7)
                        pass

                    elif la_ == 26:
                        localctx = SquirrelParser.DivEqualOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 518
                        if not self.precpred(self._ctx, 5):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 5)")
                        self.state = 519
                        self.match(SquirrelParser.ASSIGN_DIV)
                        self.state = 520
                        self.expression(6)
                        pass

                    elif la_ == 27:
                        localctx = SquirrelParser.ModEqualOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 521
                        if not self.precpred(self._ctx, 4):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 4)")
                        self.state = 522
                        self.match(SquirrelParser.ASSIGN_MOD)
                        self.state = 523
                        self.expression(5)
                        pass

                    elif la_ == 28:
                        localctx = SquirrelParser.AddEqualOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 524
                        if not self.precpred(self._ctx, 3):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 3)")
                        self.state = 525
                        self.match(SquirrelParser.ASSIGN_ADD)
                        self.state = 526
                        self.expression(4)
                        pass

                    elif la_ == 29:
                        localctx = SquirrelParser.AssignOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 527
                        if not self.precpred(self._ctx, 2):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 2)")
                        self.state = 528
                        self.match(SquirrelParser.ASSIGN)
                        self.state = 529
                        self.expression(3)
                        pass

                    elif la_ == 30:
                        localctx = SquirrelParser.SubEqualOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 530
                        if not self.precpred(self._ctx, 1):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 1)")
                        self.state = 531
                        self.match(SquirrelParser.ASSIGN_SUB)
                        self.state = 532
                        self.expression(2)
                        pass

                    elif la_ == 31:
                        localctx = SquirrelParser.DotAccessContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 533
                        if not self.precpred(self._ctx, 44):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 44)")
                        self.state = 534
                        self.match(SquirrelParser.DOT)
                        self.state = 535
                        self.match(SquirrelParser.Identifier)
                        pass

                    elif la_ == 32:
                        localctx = SquirrelParser.IndexAccessContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 536
                        if not self.precpred(self._ctx, 43):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 43)")
                        self.state = 537
                        self.match(SquirrelParser.L_BRACKET)
                        self.state = 538
                        self.expression(0)
                        self.state = 539
                        self.match(SquirrelParser.R_BRACKET)
                        pass

                    elif la_ == 33:
                        localctx = SquirrelParser.FunctionCallContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 541
                        if not self.precpred(self._ctx, 42):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 42)")
                        self.state = 542
                        self.match(SquirrelParser.L_PAREN)
                        self.state = 544
                        self._errHandler.sync(self)
                        _la = self._input.LA(1)
                        if (((_la) & ~0x3f) == 0 and ((1 << _la) & -2197719144548270030) != 0) or ((((_la - 67)) & ~0x3f) == 0 and ((1 << (_la - 67)) & 1687621) != 0):
                            self.state = 543
                            self.expressionList()


                        self.state = 546
                        self.match(SquirrelParser.R_PAREN)
                        pass

                    elif la_ == 34:
                        localctx = SquirrelParser.PostincrementOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 547
                        if not self.precpred(self._ctx, 41):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 41)")
                        self.state = 548
                        self.match(SquirrelParser.INCREMENT)
                        pass

                    elif la_ == 35:
                        localctx = SquirrelParser.PostdecrementOpContext(self, SquirrelParser.ExpressionContext(self, _parentctx, _parentState))
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expression)
                        self.state = 549
                        if not self.precpred(self._ctx, 40):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 40)")
                        self.state = 550
                        self.match(SquirrelParser.DECREMENT)
                        pass

             
                self.state = 555
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,41,self._ctx)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.unrollRecursionContexts(_parentctx)
        return localctx


    class FunctionDeclareEndContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def L_PAREN(self):
            return self.getToken(SquirrelParser.L_PAREN, 0)

        def R_PAREN(self):
            return self.getToken(SquirrelParser.R_PAREN, 0)

        def statement(self):
            return self.getTypedRuleContext(SquirrelParser.StatementContext,0)


        def args(self):
            return self.getTypedRuleContext(SquirrelParser.ArgsContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_functionDeclareEnd

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFunctionDeclareEnd" ):
                listener.enterFunctionDeclareEnd(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFunctionDeclareEnd" ):
                listener.exitFunctionDeclareEnd(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFunctionDeclareEnd" ):
                return visitor.visitFunctionDeclareEnd(self)
            else:
                return visitor.visitChildren(self)




    def functionDeclareEnd(self):

        localctx = SquirrelParser.FunctionDeclareEndContext(self, self._ctx, self.state)
        self.enterRule(localctx, 74, self.RULE_functionDeclareEnd)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 556
            self.match(SquirrelParser.L_PAREN)
            self.state = 558
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            if _la==2 or _la==87:
                self.state = 557
                self.args()


            self.state = 560
            self.match(SquirrelParser.R_PAREN)
            self.state = 561
            self.statement()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class TableConstructionContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def L_CURLY_BRACKET(self):
            return self.getToken(SquirrelParser.L_CURLY_BRACKET, 0)

        def R_CURLY_BRACKET(self):
            return self.getToken(SquirrelParser.R_CURLY_BRACKET, 0)

        def tableSlot(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.TableSlotContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.TableSlotContext,i)


        def getRuleIndex(self):
            return SquirrelParser.RULE_tableConstruction

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterTableConstruction" ):
                listener.enterTableConstruction(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitTableConstruction" ):
                listener.exitTableConstruction(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitTableConstruction" ):
                return visitor.visitTableConstruction(self)
            else:
                return visitor.visitChildren(self)




    def tableConstruction(self):

        localctx = SquirrelParser.TableConstructionContext(self, self._ctx, self.state)
        self.enterRule(localctx, 76, self.RULE_tableConstruction)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 563
            self.match(SquirrelParser.L_CURLY_BRACKET)
            self.state = 567
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while ((((_la - 36)) & ~0x3f) == 0 and ((1 << (_la - 36)) & 2392537303089153) != 0):
                self.state = 564
                self.tableSlot()
                self.state = 569
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 570
            self.match(SquirrelParser.R_CURLY_BRACKET)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class TableSlotContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def basicTableSlot(self):
            return self.getTypedRuleContext(SquirrelParser.BasicTableSlotContext,0)


        def arrayTableSlot(self):
            return self.getTypedRuleContext(SquirrelParser.ArrayTableSlotContext,0)


        def jsonTableSlot(self):
            return self.getTypedRuleContext(SquirrelParser.JsonTableSlotContext,0)


        def COMMA(self):
            return self.getToken(SquirrelParser.COMMA, 0)

        def FUNCTION(self):
            return self.getToken(SquirrelParser.FUNCTION, 0)

        def funcname(self):
            return self.getTypedRuleContext(SquirrelParser.FuncnameContext,0)


        def functionDeclareEnd(self):
            return self.getTypedRuleContext(SquirrelParser.FunctionDeclareEndContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_tableSlot

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterTableSlot" ):
                listener.enterTableSlot(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitTableSlot" ):
                listener.exitTableSlot(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitTableSlot" ):
                return visitor.visitTableSlot(self)
            else:
                return visitor.visitChildren(self)




    def tableSlot(self):

        localctx = SquirrelParser.TableSlotContext(self, self._ctx, self.state)
        self.enterRule(localctx, 78, self.RULE_tableSlot)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 579
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [87]:
                self.state = 572
                self.basicTableSlot()
                pass
            elif token in [36]:
                self.state = 573
                self.arrayTableSlot()
                pass
            elif token in [83]:
                self.state = 574
                self.jsonTableSlot()
                pass
            elif token in [56]:
                self.state = 575
                self.match(SquirrelParser.FUNCTION)
                self.state = 576
                self.funcname()
                self.state = 577
                self.functionDeclareEnd()
                pass
            else:
                raise NoViableAltException(self)

            self.state = 582
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            if _la==40:
                self.state = 581
                self.match(SquirrelParser.COMMA)


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class BasicTableSlotContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def Identifier(self):
            return self.getToken(SquirrelParser.Identifier, 0)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def ASSIGN(self):
            return self.getToken(SquirrelParser.ASSIGN, 0)

        def COLON(self):
            return self.getToken(SquirrelParser.COLON, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_basicTableSlot

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterBasicTableSlot" ):
                listener.enterBasicTableSlot(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitBasicTableSlot" ):
                listener.exitBasicTableSlot(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitBasicTableSlot" ):
                return visitor.visitBasicTableSlot(self)
            else:
                return visitor.visitChildren(self)




    def basicTableSlot(self):

        localctx = SquirrelParser.BasicTableSlotContext(self, self._ctx, self.state)
        self.enterRule(localctx, 80, self.RULE_basicTableSlot)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 584
            self.match(SquirrelParser.Identifier)
            self.state = 585
            _la = self._input.LA(1)
            if not(_la==17 or _la==39):
                self._errHandler.recoverInline(self)
            else:
                self._errHandler.reportMatch(self)
                self.consume()
            self.state = 586
            self.expression(0)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ArrayTableSlotContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def L_BRACKET(self):
            return self.getToken(SquirrelParser.L_BRACKET, 0)

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)


        def R_BRACKET(self):
            return self.getToken(SquirrelParser.R_BRACKET, 0)

        def ASSIGN(self):
            return self.getToken(SquirrelParser.ASSIGN, 0)

        def getRuleIndex(self):
            return SquirrelParser.RULE_arrayTableSlot

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterArrayTableSlot" ):
                listener.enterArrayTableSlot(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitArrayTableSlot" ):
                listener.exitArrayTableSlot(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitArrayTableSlot" ):
                return visitor.visitArrayTableSlot(self)
            else:
                return visitor.visitChildren(self)




    def arrayTableSlot(self):

        localctx = SquirrelParser.ArrayTableSlotContext(self, self._ctx, self.state)
        self.enterRule(localctx, 82, self.RULE_arrayTableSlot)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 588
            self.match(SquirrelParser.L_BRACKET)
            self.state = 589
            self.expression(0)
            self.state = 590
            self.match(SquirrelParser.R_BRACKET)
            self.state = 591
            self.match(SquirrelParser.ASSIGN)
            self.state = 592
            self.expression(0)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class JsonTableSlotContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def stringLiteral(self):
            return self.getTypedRuleContext(SquirrelParser.StringLiteralContext,0)


        def COLON(self):
            return self.getToken(SquirrelParser.COLON, 0)

        def expression(self):
            return self.getTypedRuleContext(SquirrelParser.ExpressionContext,0)


        def getRuleIndex(self):
            return SquirrelParser.RULE_jsonTableSlot

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterJsonTableSlot" ):
                listener.enterJsonTableSlot(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitJsonTableSlot" ):
                listener.exitJsonTableSlot(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitJsonTableSlot" ):
                return visitor.visitJsonTableSlot(self)
            else:
                return visitor.visitChildren(self)




    def jsonTableSlot(self):

        localctx = SquirrelParser.JsonTableSlotContext(self, self._ctx, self.state)
        self.enterRule(localctx, 84, self.RULE_jsonTableSlot)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 594
            self.stringLiteral()
            self.state = 595
            self.match(SquirrelParser.COLON)
            self.state = 596
            self.expression(0)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ExpressionListContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def expression(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(SquirrelParser.ExpressionContext)
            else:
                return self.getTypedRuleContext(SquirrelParser.ExpressionContext,i)


        def COMMA(self, i:int=None):
            if i is None:
                return self.getTokens(SquirrelParser.COMMA)
            else:
                return self.getToken(SquirrelParser.COMMA, i)

        def getRuleIndex(self):
            return SquirrelParser.RULE_expressionList

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterExpressionList" ):
                listener.enterExpressionList(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitExpressionList" ):
                listener.exitExpressionList(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitExpressionList" ):
                return visitor.visitExpressionList(self)
            else:
                return visitor.visitChildren(self)




    def expressionList(self):

        localctx = SquirrelParser.ExpressionListContext(self, self._ctx, self.state)
        self.enterRule(localctx, 86, self.RULE_expressionList)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 598
            self.expression(0)
            self.state = 603
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,46,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    self.state = 599
                    self.match(SquirrelParser.COMMA)
                    self.state = 600
                    self.expression(0) 
                self.state = 605
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,46,self._ctx)

            self.state = 607
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,47,self._ctx)
            if la_ == 1:
                self.state = 606
                self.match(SquirrelParser.COMMA)


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx



    def sempred(self, localctx:RuleContext, ruleIndex:int, predIndex:int):
        if self._predicates == None:
            self._predicates = dict()
        self._predicates[36] = self.expression_sempred
        pred = self._predicates.get(ruleIndex, None)
        if pred is None:
            raise Exception("No predicate with index:" + str(ruleIndex))
        else:
            return pred(localctx, predIndex)

    def expression_sempred(self, localctx:ExpressionContext, predIndex:int):
            if predIndex == 0:
                return self.precpred(self._ctx, 30)
         

            if predIndex == 1:
                return self.precpred(self._ctx, 29)
         

            if predIndex == 2:
                return self.precpred(self._ctx, 28)
         

            if predIndex == 3:
                return self.precpred(self._ctx, 27)
         

            if predIndex == 4:
                return self.precpred(self._ctx, 26)
         

            if predIndex == 5:
                return self.precpred(self._ctx, 25)
         

            if predIndex == 6:
                return self.precpred(self._ctx, 24)
         

            if predIndex == 7:
                return self.precpred(self._ctx, 23)
         

            if predIndex == 8:
                return self.precpred(self._ctx, 22)
         

            if predIndex == 9:
                return self.precpred(self._ctx, 21)
         

            if predIndex == 10:
                return self.precpred(self._ctx, 20)
         

            if predIndex == 11:
                return self.precpred(self._ctx, 19)
         

            if predIndex == 12:
                return self.precpred(self._ctx, 18)
         

            if predIndex == 13:
                return self.precpred(self._ctx, 17)
         

            if predIndex == 14:
                return self.precpred(self._ctx, 16)
         

            if predIndex == 15:
                return self.precpred(self._ctx, 15)
         

            if predIndex == 16:
                return self.precpred(self._ctx, 14)
         

            if predIndex == 17:
                return self.precpred(self._ctx, 13)
         

            if predIndex == 18:
                return self.precpred(self._ctx, 12)
         

            if predIndex == 19:
                return self.precpred(self._ctx, 11)
         

            if predIndex == 20:
                return self.precpred(self._ctx, 10)
         

            if predIndex == 21:
                return self.precpred(self._ctx, 9)
         

            if predIndex == 22:
                return self.precpred(self._ctx, 8)
         

            if predIndex == 23:
                return self.precpred(self._ctx, 7)
         

            if predIndex == 24:
                return self.precpred(self._ctx, 6)
         

            if predIndex == 25:
                return self.precpred(self._ctx, 5)
         

            if predIndex == 26:
                return self.precpred(self._ctx, 4)
         

            if predIndex == 27:
                return self.precpred(self._ctx, 3)
         

            if predIndex == 28:
                return self.precpred(self._ctx, 2)
         

            if predIndex == 29:
                return self.precpred(self._ctx, 1)
         

            if predIndex == 30:
                return self.precpred(self._ctx, 44)
         

            if predIndex == 31:
                return self.precpred(self._ctx, 43)
         

            if predIndex == 32:
                return self.precpred(self._ctx, 42)
         

            if predIndex == 33:
                return self.precpred(self._ctx, 41)
         

            if predIndex == 34:
                return self.precpred(self._ctx, 40)
         




