# CUNY TV # 
## Mini DV Workflow - Fall 2021 


###### This workflows covers the following:

  1.  [Before transferring](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#before-transferring-minidv) 

  2.  [Transferring](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#transferring-minidv) 

  3.  [Quality Control using](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#quality-control--dvrescue--dvplay) 
    
		* [DVRescue](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#merging-files-with-dvrescue)
    
		* [DVPlay](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#dvplay)
    
		* [FFMPEG](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#after) 

  4.  [Packaging](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#packaging) 
 
  5.  [Verification](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#verification) 

###### Equipment Used
* [Sony DSR-45](https://github.com/lem7931/CUNYTV-MiniDV-Workflow/blob/main/assets/Sony%20DSR-45%20manual.pdf)  
* [Sony HVR-M15U](https://github.com/lem7931/CUNYTV-MiniDV-Workflow/blob/main/assets/Sony%20HVR-M15U%20manual.pdf) 
* Mac Pro (Late 2013), running MacOS Mojave 

###### Definitions:

* [DV](https://mipops.github.io/dvrescue/sections/dv_formats.html):  Stands for digital video.  This format is unique because the content, despite being digital, is still stored on magnetic tape.  Since the content is already digital, digitization will not be occurring but rather a transfer of the content.  Format includes:
	* MiniDV
	* HDV
	* DVCAM
	* DVCPro
	* DVCPro HD

* [dvrescue](https://mediaarea.net/DVRescue):  “Supports improving DV files that have already been created by allowing such files to be assessed, so that the software may selectively retry portions of the tape and incorporate any improvements into the existing file.”

* [dvmerge](https://github.com/mipops/dvrescue#additional-tools):  “Script that takes multiple transfers of the same tape containing errors and combines them to create one file with the best information available for each problematic frame. Part of dvrescue” 

* [dvplay](https://github.com/mipops/dvrescue#additional-tools):  “Script that plays back and visualizes the DV errors as a stack of images. Running with the -x flag will produce JPEGs instead of just playing them. Requires FFplay.”

* [ffmpeg](https://www.ffmpeg.org/about.html#:~:text=FFmpeg%20is%20the%20leading%20multimedia,humans%20and%20machines%20have%20created):  “Open-source software able to able to decode, encode, transcode, mux, demux, stream, filter and play video/audio”

* [Terminal](https://en.wikipedia.org/wiki/Terminal_(macOS)): "Application provides text-based access to the operating system, in contrast to the mostly graphical nature of the user experience of macOS, by providing a command-line interface to the operating system"


###### Things to keep in mind

* Make sure there is enough space on your hard drive before you begin.  Files will not transfer/merge correctly if you run out of space.  

* Remember to take notes and update the metadata as you go!  

* Problems will occur.  Keeping track of any errors you run into will help you (and others) solve problems faster. 

* Errors are inevitable!  Mistakes will be made!  Be gentle not only on the tapes but also on yourself 🥰 

* When in doubt, ask for help! 

###### Additional Resources:

   * [DVRescue Github](https://github.com/mipops/dvrescue)  
   * [DVRescue Website](https://mediaarea.net/DVRescue) 
   * [CUNY TV Media Micro Services](https://github.com/mediamicroservices/mm) 
   * [DVRescue Index](https://mipops.github.io/dvrescue/index.html)
   * [A/V Artifact Atlas](https://www.avartifactatlas.com)
   * [ffmprovisr](https://amiaopensource.github.io/ffmprovisr/)
   * [Command Line Crash Course](https://learncodethehardway.org)
   * [NYPL Media Preservation Documentation Portal](https://nypl.github.io/ami-preservation/)


## [Before Transferring MiniDV](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#before-transferring-minidv)  


###### Overview - This process establishes what tapes are being digitized and their condition.  It also helps you stay organized!  

1. Create new [Airtable](https://airtable.com) for tracking metadata on each item.  Table should include:
   * Format ID
   * Status
   * Drive 
   * Digitization Notes 
   * Date of Digitization 
   * Quality Control (QC) Notes
   * Date of QC
   * PBCore Title Series
   * PBCore Title Episode
   * Description (if any) 

2. Create new folders in appropriate drives - always remember to check how much space is left!  
   * GDRIVE10A
   * GDRIVE10B 

3. Clean MiniDV players daily with head-cleaning tape
   * Rewind tape to beginning, then play through (should take less than 5 minutes)

4. Assess condition of tapes to be transferred 
   * Fully rewound?  Are the labels intact?  Do you notice any mold or flaking?  In proper housing?  Any weird smells?  Just plain broken?  
   * If any tapes appear in bad condition, set aside for further assessment.  DO NOT try to transfer or play them back.  


## [Transferring MiniDV](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#transferring-minidv) 

###### Overview - This process takes the contents of the MiniDV tape and transfers it onto a computer 

1. Insert tape face up into the player.  Push tape into the player until sucked in.  

2. Open new Terminal window and run appropriate command

```
./dvc
```
[*Script for two MDV transfers*](https://github.com/lem7931/CUNYTV-MiniDV-Workflow/blob/main/assets/dvc)

```
./dvc_2  
```
[*Script for only one MDV transfer*](https://github.com/lem7931/CUNYTV-MiniDV-Workflow/blob/main/assets/dvc_2.sh) 

3. Select an input device by number or enter ‘S’ to check the status of each device
   * [0] DV-VCR (Sony HVR-M15U)
   * [1] HDV-VCR (Sony HVR-M15U)
   * [2] DV-VCR (Sony DSR-45)

4. Enter tape ID and press enter 
   * Can be found on tape or case 

5. Add output folder and press enter
   * Where you want these transfers to be saved 
   * Drag + drop location directly into Terminal window 

6. Transfer will begin.  Time varies based on tape contents and the command run.

7. Once tape has finished and is fully rewound, double check the size of the file.  
   * If two transfers were run, these should be very close in size (only off by a few MB)  
   * If one transfer ran, compare new file to old ones (should be same/very close in size) 

8. If sizes look ok, move onto the next tape.

9. Repeat until the batch is done and then move onto the next phase.


## [Quality Control ~ DVRescue + DVPlay](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#quality-control--dvrescue--dvplay) 

###### Overview - This process merges two MDV transfers into one file and then assesses any errors that may be present in the file.  

1. Navigate to folder you want to work in using the Terminal 

2. Create new folder for each tape and its associated files to live in 
 
Folder should have:

![image](https://user-images.githubusercontent.com/74999102/145603445-9b76f23b-9c52-4547-884f-f27a628c45da.png)


3. Double-check sizes of two files to be merged
   * If one file is significantly bigger than the other, mark as SUS skip to [last step](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#after) of this section
   * If only bigger by a small amount (no more than .1 MB) then continue 

4. Play first and last 30 seconds of both videos to get an understanding of the content, paying close attention to any tape errors you may see.  Once finished, move onto DVRescue and DVPlay.  

###### [Merging Files with DVRescue](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#merging-files-with-dvrescue)  

   * Run the following command in Terminal:
 
```
   dvrescue $drag_first_take_file_here -m $drag_file_output_file_here
```

	* dvrescue starts the command
	* Replace $drag_first_take_file_here with path to Take 1 of tape 
		* Example:  /Volumes/GDRIVE10A/DV-Cat/MDVB000005/MDV00445/MDV00445_take1.dv
	* -m tells dvrescue to execute the merge command        
	* Replace $drag_file_output_file_here with intended file output name
		* Example:  /Volumes/GDRIVE10A/DV-Cat/MDVB000005/MDV00445/MDV00445_merge.dv 
	* Remember to change _take1.dv to _merge.dv
		* If you don’t Take 1 will be erased and transfer will need to be redone 
   
   * Wait for command to finish (can take a few minutes)

   * Confirm that merged file is same size as original files (some discretion) 

###### [DVPlay](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#dvplay) 

   * Run the following command in Terminal: 

```
      dvplay -x $drag_merged_file_here  
```
       
	* dvplay starts the command
	* -x tells the command to create JPEGs of every error
	* Replace $drag_merged_file_here with path to merged file 
	* Example:  /Volumes/GDRIVE10A/DV-Cat/MDVB000005/MDV00445/MDV00445_merge.dv 

   * Wait for command to finish 

   * Assess HTML + JPEGS that are generated

      * What kind of errors are you seeing?  Location within the frame?  

      * Stripes across screen vs. fragments at edge of frame, etc.

      * Are they located in the same place?  Or are they spread throughout the tape?

   * How many errors are there?  General guidelines 

      * More than 10 errors - SUS (aka get second opinion) 

      * More than 20 errors - FAIL

      * Less than 5 errors - PASS 

   * Reference [AVAA](https://www.avartifactatlas.com/formats/dv.html) 

   * When in doubt, ask someone!  

* Mark folder with color to denote status and move onto next tape 

   * Pass - Green

   * Need Second Opinion - Yellow 

   * Fail - Red
   
###### [After](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#after) 

* Document findings in Airtable 
* Get second opinions for problematic files.  If any files need to be retransfered, refer back to [Transferring MiniDV](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#transferring-minidv) section 
* If needed, use FFMPEG to create a small clip that best shows the errors seen

```
    ffmpeg -i FILE -c copy -f rawvideo -map 0:v:0 -ss 00:00:00 -to 00:00:00 FILE.title.dv
```

	* ffmpeg = starts ffmpeg
	* -i = input file 
	* FILE = path to file that is being trimmed 
	* -c = Codec name 
	* copy = copies codec name 
	* -f = force format 
	* rawvideo = keeps Codec the same as original file 
	* -map = manual control of stream selection in each output file 
	* 0:v:0 = stream specifier (v matches all video streams)
	* -ss = decodes but discards input until the timestamps reach position
	* 00:00:00 -to 00:00:00 = timespan of clip 
	* FILE.title.dv = name of final file and location to be saved to 

## Packaging and Verification

###### Overview - This process ensures that every file is to the standards set by CUNY TV and gets files ready for their ingestion into the archive.  

Once all files have passed QC, packaging and verification can begin

###### [Packaging](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#packaging)  

Run the following command in a new Terminal window:
        
```
          dvpackager -v $drag_merged_file_here
```
	 
Make sure .mov file is slightly larger than DV file and that audio is in sync 

Keep Take 1+2 xml 
* Keep new .mov 
* Keep Merged .dv

*Note: DVPackager may create multiple files if there is a change in aspect ratio at any point during the content.  If multiple files are created after running dvpackager -v, assess sizes/general content to make sure this is the case* 

Package should look something like this:

![image](https://user-images.githubusercontent.com/74999102/145602975-ec620f1f-34ba-4718-b473-52e49520bcda.png)


###### [Verification](https://github.com/lem7931/CUNYTV-MiniDV-Workflow#verification)  

Run the following command in a new Terminal window:  
```
	 checksumpackage -c $package
``` 	
*This script verifies a package's checksum* 

If there are any mismatches in the checksums, flag the faulty file and investigate.  

Once all checksums have been verified, run the next command in the same terminal window 
```
         verifytree $package 
```
*This script verifies the contents of the package and will fail if anything is missing* 

For example:

No capture file/submission documentation in the wrong place?  Run this command:
	  
```
         aipupgrade $drag_list_of_packages_here
```

Will ask you what type of package, pick Preservation-Video 

Next, run this command to check the audio levels (best to run this overnight as it takes a bit of time):
```
	 verifypackage -a  
```

If any files fail, delete Service file and Youtube Access Copy from package  

Then create new ones using these two commands :

```
	   makebroadcast $drag_package_here
```
*For creating new service files* 

```
           makeyoutube $drag_package_here
```
*For creating new Youtube Access copies* 

Double-check to make sure the new audio passes by verifying the packages overnight:
	  
	  
```
           verifypackage -a 
```

Then update the checksum!  

```
	   checksumpackage -v $drag_package_here
```

*Terminal will yell at you because the checksum does not match!  But that is to be expected because we made changes to the packages*   

Finally, let's create a manifest with all the checksums!  Move all packages out of parent folders and then run:
```
	  collectionchecksum $drag_package_here
```

*Command gathers all checksums and creates a new manifest*
 


