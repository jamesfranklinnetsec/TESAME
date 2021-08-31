
::  TES Advanced Mod Editor Readme  ::


==== First words ====================================

  I'm swedish and although I might think I'm good at english, I'm quite 
  sure I'm not. So oversee any grammar errors and whats-they're-called. thanx.
  oh yeah, there's a reason why this is called an ->Advanced<- mod editor,
  newbies beware. =P
  
==== Important ======================================

  (A) TES AME cleans mods by physically chopping out information from
      the ESP-file. These changes can't be reversed. I can't take any
      responsability for what might happen when removing certain information.
  
  (B) TES AME is written for maximum safety of your work. TES AME always creates
      a copy of the file you're editing, and uses the copy for reading and writing.
      The original file isn't changed whatsoever, unless you overwrite it when saving.

  (C) The Hardcore edit function enables you to change pretty much anything.
      This means you can mess up pretty much everything. Never overwrite your
      original file after working with hardcore edit.
  
  (D) This is a program written for the Morrowind Mod community. It's absolutely
      free of charge. Everyone is free to copy it and host it on their website.
      If there's something you're missing, email me. I'm very much open to suggestions.
      

==== Changes ========================================

  In version 1.2:
  
  * Added Autocleaner. (Cleaner 4 dummies)
  * All itemtypes are now recognized.
  * Added Hardcore edit. Edit down to the tiniest byte. 
    For extreme modders and ESP crackers only.
  

==== "Dirty" mods (no pun intended) =================

  When creating a mod you often change stuff that shouldn't be changed.
  A good example is when I added a script to a door with ID in_hlaalu_loaddoor_01.
  That perticular door is very common so I ended up having lots of doors with
  my script. I realised the problem and changed it back, removed the script from
  the door. Now you might think that the problem is solved. Wrong. The door
  is still marked as changed and it's still saved in the mod. This may (or may not)
  create difficulties in the game. Especially when playing with multiple mods.
  
  
==== About Modifications ============================

  The plugins of Morrowind doesn't contain a new version of the game (duh), it
  only stores information about additions and changes compared with the original.
  In the Mod-items list you can see all the items in the game that has been changed by
  your mod. A Mod-item can be anything, from NPC's to Textures and Landscape changes.
  An item is simply a batch of information, stored in your mod.
  

==== Difference between "selecting" and "marking" ===

  I will talk about "marking" items in this readme. Marking items means that
  you first selects it from the list and then - by either pressing space or
  rightclicking on it - mark it. Marked items are black with white text.
  You can only Delete/Save marked items.


==== Cleaning mods ( Manually ) =====================

  To remove any unwanted items. Select them in the list and press Space.
  They get "marked", as mentioned above. 
  Click on the Items-menu and then on "Delete". Or press the Delete key on your
  keyboard. Read the list below to see which items are okay to remove.
  
  By deleting items in the list you're NOT removing them from the mod completely.
  Plugins only store references to items in the game. A "deleted" NPC can still be
  seen in the game. You're only making sure that the original data (in this case,
  the NPC) are not being changed by your mod. 
  
  IMPORTANT: Deleting items that's exclusive to your mod WILL remove it completely
  from the game since your mod has the only existing reference to it.


==== Some important Item types ======================

  Type		Description
  -----------------------------------------------------
  Header		Includes information about the mod. Can't be removed.
  
  Static,		Objects in the mod. Remove if they carry their
  Activator,		original ID and recreate with new (own) ID in TES CS.
  Door,
  Container,
  Light,
  Ingredient,
  etc..		
  
  Cell			Game Cell. Remove all cells that shouldn't be changed/added by 
                  	your mod. If you've edited an original common object, all cells
                  	with that object will be changed. Remove the object and the cells.
  
  Landscape		Heightmap changes. Shouldn't be removed unless you really
                  	want to undo any changes you've made.
  
  Script		Remove if not added/edited by your mod. 
  
  Texture		Causes error in TES CS if removed. (Only if applied to any landscape
                        in the mod)
  		
  NPC			Non playing character. Remove if not added/edited by your mod.
  
  Topic,		Dialogue items. Remove to undo any changes you've made.
  Info/Response	
  
  Global		Global variable. Remove if not added/edited by your mod. 


==== Cleaning mods ( Automatic )=====================

  A new function in TES AME is the Autocleaner. It search for potentially "dirty"
  items in your mod. Some changes to original objects are perfectly ok, such as for most   cells. So you can toggle searches on cells, NPCs and Items. 
  
  Click on Mods->Autoclean->Start and it will initiate the search.
  
  When the search is done, you will be asked if you want to; "Remove all",
  "Rename all" or "Manual edit".
  
  "Remove all" removes all found items. 
  "Rename all" gives all found items a new name. This will eliminate any conflict with
  other mods.
  "Manual edit" does nothing and leaves the editing to you.


==== Merging Mods ===================================

  Before merging two mods, save any mod you're working on with TES AME.
  TES AME will close any open mods without saving before merging.
  
  Click on Mods->Merge.. You get to select a primary mod and a secondary mod. 
  The secondary mod will be added to the primary.
  Click on the Merge button, enter a destination filename. You've got a hybrid!
  
  I'm not sure what consequences mashing two different mods together might have,
  so use common sence and don't merge two megamods. For best control, export and
  import individual items between mods. 
  

==== Sharing Mod resources ==========================

  The TES Advanced Mod Editor allows you to export specific objects from the mods.
  You can export anything, NPC's, scripts, items, whole Cells!
  Now I've got an idea that this would be great for the Morrowind Modding community.
  Instead of writing lengthy instructions in a forum people can share their
  solutions in file form. Just for anyone to download and insert into their mod.
  The file extention of a "module" is *.ESD.
  

==== Exporting / Importing modules ==================

  Mark the files you want to export.
  Click on Items->Save module.. Enter a filename, done!
  
  To insert a module into a mod. Click Items->Insert Module.. and select the module. Done.
  
  
==== Using Hardcore Edit ============================

  First of all, using hardcore edit isn't recommended for anyone who hasn't 
  used a hexeditor or isn't familiar with binary files in general.
  
  Double click on the item you wish to edit. This will list
  it's raw data. The raw data consists of the selected items "subitems".
  A subitem contain information, and they store it in several different format.
  A subitem can be a string, a float value or even both. 
  
  Double click on a subitem in the raw data list and you'll open up the Hardcore
  edit window. Since the information can be represented in so many ways, you'll notice
  that there are a number of tabs. Each tab present the information in a different way.

  [Information tab]
    Displays some information about the current subitem.
     Item   : The 4 byte type of the subitem, it's name basically.
     Type   : The above translated into plain english.
     Owner  : Information about the subitems owner (top item)
     Size   : Size of the entire subitem in bytes. The size is fixed.
     Offset : Subitems position in the file in bytes. Converted to hex in paranthesis.
  
  [String tab]
    Displays the information as a single line string. Edit the string 
    by writing in the textbox and pressing ENTER.
  
    Important: When editing a script, TES AME confuses null bytes (0x00) with spaces
    and replaces them with spaces (0x20). Some ajustments from the Hex tab might
    be necessary. This also applies to the Strings tab
  
  [Strings tab]
    Displays the information as a multilined string. Useful when editing scripts
    and Journals. Edit by writing in the textbox. Finish by pressing Shift+ENTER.
  
  [HEX tab]
    This is the real power with hcedit. It displays 8 bytes at a time.
    To scroll through the bytes use the Position buttons at the bottom.
  
    Each byte is displayed in four formats: HEX value, Character, Integer and Float.
    Integers and Floats are 4 bytes.
  
    To edit the bytes, just write into the textboxes and press either TAB or ENTER.

  [Bitmask]
    Some subitems store a bitmask. That is a number of bits that each represent either
    true or false. This is still rather unexplored as no official bitmask description
    is available. You can edit and add bitmasks in "\dbase\bitmasks.txt"
    Available bitmasks are for FLAG(NPC) and DATA(Cells).

==== Contact ========================================

  Created by Erik Benerdal AKA Scarabus

  Email: fudge_e@hotmail.com
  Web: http://www.fudge.dot.nu/


==== Final word =====================================

  I eat poodles.