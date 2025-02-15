## Prerequisites ##

1. Install git bash
2. Install python3
3. Install 7zip
4. Add all above to PATH variable (if you don't know how, check this [webpage](https://www.computerhope.com/issues/ch000549.htm))
5. Make sure you have microsoft web runtime
6. Download adam's [modkit](http://www.adammil.net/blog/v133_Battle_Brothers_mod_kit.html#modkit) and unpack it at the same level that legends project is (see screenshot).

![dir_structure.webp](dir_structure.webp)

7. Install python dependencies `pip install Pillow`
8. Copy `build_compile_poss.sh` and name it something like `build_compile_yourname.sh`
9. Inside the `build_compile_yourname.sh` replace the destination variable with your own

## How to build Legends ##

1. Open git bash in the legends repo and run bash `build_compile_yourname.sh`

## Note when adding brushes ## 
Adding images to the make_ scripts is not always enough. 
While it will create a new brush xml automatically when its reached the limit of images per sheet, it won't build those into brushes unless you also add a line to the build_brushes file
so if you add more images than fit in the current number of sheets,  or if you want to change the size of the sheets,   you can't just change the imagecount and run the whole build script.
you've got to:
1. change the imagecount in the make_armor script
2. delete your local numbered armor directories and xml files
3. run just the make script
4. check how many directories it created
5. update the build_brushes script to reference that number of directories

Only then can you run the whole build script 


## Explaination of the python build scripts ##
These scripts can seem daunting, but they are much easier than maintaining all armor and helmet layers by hand. 


**make_legends_helmets** 

this script takes the place of all the *.nut files and .XML files that would otherwise be need to be maintained seperately. 

Each of these item entries is essentially a .nut file waiting to be born. 

{"name" : "goblin_scarf"                     , "layer" : "hood", "min" : 1, "max" : 4, "base" : True, "value" : 5, "con" : 5, "stam" : 0, "vis" : 0, "hair" : "true", "beard" : "false",  \
 "title" :  "Goblin Scarf", \
 "desc" :  "Goblin Scarf." \
},

- Name is the filename which will have legend_helmets prepended to it.   
- Layer is what number on the helmet stack it will coccupy
- Min and max define how many visual variants there are 
- base defines if other layers can go on top of it, this is true for all hood layers, and false for all others 
- value is how much it costs 
- con is how much durability it has
- stam is how much it weights 
- vis is the penalty to sight range
- hair determines if hair is hidden while this is worn 
- beard determines if beards are hidden while this is worn 
- title is the item name players see in game 
- description is meant to be the description that shows in the tooltip when items are layered 


These entries are for stacking unlayered helmets, they are copied verbatim into the first helmet brush
<sprite id="italo_norman_helm_named_01" offsetY="35" ic="FF383D5F" width="104" height="142" img="entity\legend_helmets\italo_norman_helm_named_01.png" left="-31" right="30" top="-18" bottom="70" />
these should all be phased out and bigrated into the defintions as they are turned into visual layers. 
- id is the brush name you call from within squirrel files 
- offsets, width, heigh, left and right all define the image size and offsets. There is an image guide on the discord for these 
- img is the actual image of the helmet which needs to be in the unpacked directory 


checkForIcon function verifies that each item defined above has a icon and inventory image file saved into gfx/ui/items/legend_helmets. 

makeSheet function creates the .XML files which store the metadata for the brush files Battle Brothers uses to store spritesheets. 

makebrushes function goes through each value set in the item entires, and writes tehm into the XML metadata file for the brush. When it reaches the imacount value it will finish the current sheet and write a new one

main function iterates through all the item entries and creates the nut files. 