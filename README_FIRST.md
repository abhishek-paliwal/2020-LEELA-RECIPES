# README FOR THIS WEBSITE AND OTHER INFO ABOUT THE THEME USED

## Hugo Theme website on Github
https://github.com/themefisher/parsa-hugo

## How to use this theme?
```
$ git clone git@github.com:themefisher/parsa-hugo.git
$ cd parsa-hugo/exampleSite/
$ hugo server --themesDir ../..
```

## How to make a new post, edit images, and make the final website?

```
## Make the post template first prefilled with all details
## based upon the recipe name provided  
frontl_leelasrecipes "RECIPE NAME HERE"

## Fill the post md file with all the necessary details, then
## check for any spelling mistakes, by running_:
leelasrecipes_check_spellings

## Put all recipe images in Y directory and rename them by running
leelasrecipes_rename_images-with-custom-prefix-and-counters

## Then, move all these images into the proper HUGO project
## images directory, by running
leelasrecipes-MOVE-ALL-PWD-IMAGES-TO-PROPER-WEBSITE-FOLDER

## Put one primary image for this recipe to _LROOM directory.
## Rename it according to the post URL.
## Then, make 1x1, 4x3 and 16x9 images from it by running:
1x1

## Now, you will need to move all the files from _LROOM directory to their
## corresponding HUGO project directory.
## STEP-A: GOTO the Y directory. Select proper 1x1, 4x3, 16x9 images, 
## and move them to the _LROOM directory.
## STEP-B: After performing STEP-A, check the CLI prompt.
## You will see that the 1x1 command listed above will also display 4 move commands in output.
## Paste those 4 commands as it is on CLI. You can also copy-paste the above command
## block to perform STEP-B.
DIR_LROOM="$HOME_WINDOWS/Desktop/_LROOM" ;
DIR_HUGO_MARKUP="$DIR_GITHUB/2020-LEELA-RECIPES/static/rich-markup-images" ;
mv $DIR_LROOM/1x1*.jpg $DIR_HUGO_MARKUP/1x1/
mv $DIR_LROOM/4x3*.jpg $DIR_HUGO_MARKUP/4x3/
mv $DIR_LROOM/16x9*.jpg $DIR_HUGO_MARKUP/16x9/
mv $DIR_LROOM/*.jpg $DIR_HUGO_MARKUP/original_copied/

## Finally, make the hugo website and upload it to server, by running:
leelasrecipes_makesite_hugo

```