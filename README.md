CUNY TV 
Mini DV Workflow
Fall 2021

Definitions:
* DV:  Stands for digital video.  Format includes Digital Video Cassette, Digital 8, Video8, MiniDV, DVCA, and DVCPRO.  This format is unique because the content, despite being digital, is still stored on magnetic tape.  Since the content is already digital, digitization will not be occurring but rather a transfer of the content.  
* dvrescue:  “Supports improving DV files that have already been created by allowing such files to be assessed, so that the software may selectively retry portions of the tape and incorporate any improvements into the existing file.”
   * dvmerge:  “Script that takes multiple transfers of the same tape containing errors and combines them to create one file with the best information available for each problematic frame. Part of dvrescue” 
   * dvplay:  “Script that plays back and visualizes the DV errors as a stack of images. Running with the -x flag will produce JPEGs instead of just playing them. Requires FFplay.”
* ffmpeg:  “Open-source software able to able to decode, encode, transcode, mux, demux, stream, filter and play video/audio”
* Packaging
* Verification
* Checksum 


Things to keep in mind
* Make sure there is enough space on your hard drive before you begin.  Files will not transfer/merge correctly if you run out of space.  
* Remember to take notes and update the metadata as you go!  
   * Problems are inevitable.  Keeping track of any errors you run into will help you (and others) solve problems faster.  
* Errors are inevitable!  Mistakes will be made!  Be gentle not only on the tapes but also on yourself 🥰 
* When in doubt, ask for help! 


Before Transferring MiniDV 
Overview - This process establishes what tapes are being digitized and their condition.  It also helps you stay organized!  
1. Create new Airtable for tracking metadata on each item.  Table should include:
   1. Format ID
   2. Status
   3. Drive 
   4. Digitization Notes 
   5. Date of Digitization 
   6. Quality Control (QC) Notes
   7. Date of QC
   8. PBCore Title Series
   9. PBCore Title Episode
   10. Description (if any) 
2. Create new folders in appropriate drives - always remember to check how much space is left!  
   1. GDRIVE10A
   2. GDRIVE10B 
3. Clean MiniDV players daily with head-cleaning tape
   1. Rewind tape to beginning, then play through (should take less than 5 minutes)
4. Assess condition of tapes to be transferred 
   1. Fully rewound?  Are the labels intact?  Do you notice any mold or flaking?  In proper housing?  Any weird smells?  Just plain broken?  
   2. If any tapes appear in bad condition, set aside for further assessment.  DO NOT try to transfer or play them back.  


Transferring MiniDV
Overview - This process takes the contents of the MiniDV tape and transfers it onto a computer 
1. Insert tape face up into the player.  Push tape into the player until sucked in.  
2. Open new Terminal window and run appropriate command
   1. ./dvc -------> script for two MDV transfers
   2. ./dvc_2 -----> script for only 1 MDV transfer 
3. Select an input device by number or enter ‘S’ to check the status of each device
   1. [0] DV-VCR (Sony HVR-M15U)
   2. [1] HDV-VCR (Sony HVR-M15U)
   3. [2] DV-VCR (Sony DSR-45)
4. Enter tape ID and press enter 
   1. Can be found on tape or case 
5. Add output folder and press enter
   1. Where you want these transfers to be saved 
   2. Drag + drop location directly into Terminal window 
6. Transfer will begin.  Time varies based on tape contents and the command run.
7. Once tape has finished and is fully rewound, double check the size of the file.  
   1. If two transfers were run, these should be very close in size (only off by a few MB)  
   2. If one transfer ran, compare new file to old ones (should be same/very close in size) 
8. If sizes look ok, move onto the next tape.
9. Repeat until the batch is done and then move onto the next phase.


DVRescue + DVPlay 
Overview - This process merges two MDV transfers into one file and then assesses any errors that may be present in the file.  
1. Navigate to folder you want to work in using the Terminal 
2. Create new folder for each tape and its associated files to live in 
   1. Should have:
   2. Two .dv files which will be subsequently merged together
   3. Two .vtt files
   4. Two .xml files 
3. Double-check sizes of two files to be merged
   1. If one file is significantly bigger than the other, mark as SUS skip to last step of this section
   2. If only bigger by a small amount (no more than .1 MB) then continue 
4. Play first and last 30 seconds of both videos to get an understanding of the content, paying close attention to any tape errors you may see
5. Merging Files with DVRescue 
   1. Run the following command in Terminal: 
      1. dvrescue $drag_first_take_file_here -m $drag_file_output_file_here
         1. dvrescue starts the command
         2. Replace $drag_first_take_file_here with path to Take 1 of tape 
            1. Example:  /Volumes/GDRIVE10A/DV-Cat/MDVB000005/MDV00445/MDV00445_take1.dv
         3. -m tells dvrescue to execute the merge command
         4. Replace $drag_file_output_file_here with intended file output name
            1. Example:  /Volumes/GDRIVE10A/DV-Cat/MDVB000005/MDV00445/MDV00445_merge.dv 
            2. *Remember to change ‘_take1.dv’ to ‘_merge.dv’
               1. If you don’t Take 1 will be erased and transfer will need to be redone 
   2. Wait for command to finish (can take a few minutes)
   3. Confirm that merged file is same size as original files (some discretion) 
6. DVPlay 
   1. Run the following command in Terminal: 
      1. dvplay -x $drag_merged_file_here
         1. dvplay starts the command
         2. -x tells the command to create JPEGs of every error
         3. Replace $drag_merged_file_here with path to merged file 
            1. Example:  /Volumes/GDRIVE10A/DV-Cat/MDVB000005/MDV00445/MDV00445_merge.dv 
   2. Wait for command to finish 
   3. Assess HTML + JPEGS that are generated
      1. What kind of errors are you seeing?  Location within the frame?  
         1. Stripes across screen vs. fragments at edge of frame, etc. 
            1.               2.               3.      2. Are they located in the same place?  Or are they spread throughout the tape?  
   3. How many errors are there?  General guidelines 
   1. More than 10 errors - SUS (aka get second opinion) 
   2. More than 20 errors - FAIL
   3. Less than 5 errors - PASS 
   4. Reference AVAA - https://www.avartifactatlas.com/formats/dv.html 
   5. When in doubt, ask someone!  
   4. Mark folder with color to denote status and move onto next tape 
   1. Pass - Green
   2. Need Second Opinion - Yellow 
   3. Fail - Red
   5. If needed, use FFMPEG to create a small clip that best shows the errors seen
   1. ffmpeg -i FILE -c copy -f rawvideo -map 0:v:0 -ss 00:00:00 -to 00:00:00 FILE.title.dv
   1. ffmpeg = starts ffmpeg
   2. -i = input file 
   3. FILE = path to file that is being trimmed 
   4. -c = Codec name 
   5. copy = copies codec name 
   6. -f = force format 
   7. rawvideo = keeps Codec the same as original file 
   8. -map = manual control of stream selection in each output file 
   9. 0:v:0 = stream specifier (v matches all video streams)
   10. -ss = decodes but discards input until the timestamps reach position
   11. 00:00:00 -to 00:00:00 = timespan of clip 
   12. FILE.title.dv = name of final file and location to be saved to 
   6. Document findings in Airtable 
   7. Get second opinions for problematic files.  If any files need to be retransfered, refer back to Transferring MiniDV section 


Packaging and Verification
Overview - This process ensures that every file is to the standards set by CUNY TV and gets files ready for their ingestion into the archive.  
   1. Once all files have passed QC, packaging and verification can begin
   2. Packaging 
   1. Run the following command in a new Terminal window:
   1. dvpackager -v $drag_merged_file_here
   1. Make sure .mov file is slightly larger than DV file and that audio is in sync 
   2. Keep Take 1+2 xml 
   3. Keep new .mov 
   4. Keep Merged .dv 
   3. Verification 
   1. checksumpackage -c $package   
   2. verifytree $package 
   4. No capture file/submission documentation in the wrong place?
   1. Run aipupgrade on list of packages
   2. Will ask you what type of package, pick Preservation-Video 
   5. Verification Cont. 
   1. verifypackage -a (best run overnight) 
   1. If any files fail, delete service file and youtube access copy 
   1. Then create new ones:
   1. makebroadcast $drag_package_here
   2. makeyoutube $drag_package_here 
   2. Double-check:
   1. verifypackage -a (overnight again)
   3. Then update the checksum!  
   1. checksumpackage -v $drag_package_here
   1. Terminal will yell at you because the checksum does not match!  But that is to be expected because we got rid of things and are now updating.  
   2. collectionchecksum $drag_package_here 
   1. Run this on parent folders - gathers all checksums and creates a new manifest 


Resources:
   * DVRescue Github - https://github.com/mipops/dvrescue 
   * DVRescue - https://mediaarea.net/DVRescue 
   * CUNY TV Media Micro Services - https://github.com/mediamicroservices/mm 
   * DVRescue - https://mipops.github.io/dvrescue/index.html 
   * A/V Artifact Atlas - https://www.avartifactatlas.com 
   * ffmprovisr - https://amiaopensource.github.io/ffmprovisr/
   * Command Line Crash Course - https://learncodethehardway.org 
   * NYPL Media Preservation Documentation Portal - https://nypl.github.io/ami-preservation/
