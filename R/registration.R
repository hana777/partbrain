Skip to content
 
Search or jump to…

Pull requests
Issues
Marketplace
Explore
 
@hana777 
0
0 0 kwaaksnavel/partbrain Private
 Code  Issues 0  Pull requests 0  Projects 0  Security  Insights
partbrain
/
R
/

registration.R
 

1
data(EPSatlas, envir=environment())
2
data(SAGITTALatlas, envir=environment())
3
​
4
data(atlasIndex, envir=environment())
5
#data(atlasOntology, envir=environment())
6
data(ontology, envir=environment())
7
​
8
​
9
#' Get atlas binary image
10
#'
11
#' 
12
#' @param coordinate matching coordinates in the main plane to be registered to (in millimeters).
13
#' @param directory either an absolute path or the default TEMPORARY which will save the tif output to .
14
#' @param plate if true coordinate indicates plate number out of 132 plates.
15
#' @param width the pixel width to save as TIFF, default is 456px, but 11300 is high res.
16
#' @param verbose boolean value. If true diagnostic output is written to the R console. Deafult is true.
17
#' @examples
18
#' #path to image
19
#' image<-'/Volumes/microscope/animal001/slide001/section001.tif'
20
#' #register the image
21
#' registration(image, AP=1.05, brain.threshold=220)
22
​
23
get.atlas.image<-function(coordinate, directory='TEMPORARY', width=456, plane='coronal', plate=FALSE, right.hemisphere=NULL, close.image=TRUE, save.image=TRUE){
24
plate.width<-1
25
#get cutting plane
26
if(plane=="sagittal"){
27
 EPSatlas<-SAGITTALatlas
28
 atlasIndex<-atlasIndex[atlasIndex$plane=="sagittal", ]
29
 plate.width<-1.159292
30
}else{
31
   atlasIndex<-atlasIndex[atlasIndex$plane=="coronal", ]
32
}
33
​
34
#get closest coordinate in millimeters
35
if(plate){
36
  k<-coordinate
37
}else{
38
  k<-which(abs(coordinate-atlasIndex$mm.from.bregma)==min(abs(coordinate-atlasIndex$mm.from.bregma)))
39
  plate<-atlasIndex$plate.id[which(abs(coordinate-atlasIndex$mm.from.bregma)==min(abs(coordinate-atlasIndex$mm.from.bregma)))]
40
}
41
  
42
​
43
  
44
ventricles <-c(which(EPSatlas$plate.info[[k]]$style=='#aaaaaa')) #117 is optic chiasm och   which(EPSatlas$plate.info[[k]]$structure_id== 117)
45
if(atlasIndex$plate.id[k] %in%c(100960309, 100960312, 100960316, 100960320)){
46
  fibertracts<-c(which(EPSatlas$plate.info[[k]]$style=='#cccccc'))
47
  fibertracts <-fibertracts[which.min(sapply(fibertracts, function(x){min(EPSatlas$plates[[k]][[x]]@paths$path@y )}))]
48
  ventricles<-append(ventricles, fibertracts) 
49
}
@hana777
Commit changes
Commit summary 
Update registration.R
Optional extended description

Add an optional extended description…
  Commit directly to the master branch.
  Create a new branch for this commit and start a pull request. Learn more about pull requests.
 
© 2019 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About
