# Landslide susceptibility mapping based on matlab
This code is based on Matlab R2019a

Input: .tif picture with __same size__ (Obtain by Arcgis software)  
and put them in the __same path__ of this codess

## Prepare Material: 
a0.tif (Represent the have landslides or not in target area)<br>
a1.tif (lithology class in traget area)<br>
a2.tif (Soil)<br>
a3.tif (Distance to fault)<br>
a4.tif (Slope)<br>
a5.tif (Aspect)<br>
a6.tif (Curvature)<br>
a7.tif (Distance to Road)<br>
a8.tif (Distance to River)<br>
a9.tif (Land-use)<br>
a10.tif (2018.8 Precipitation class)<br>
a11.tif (PGA 3d synthesis)<br>
a12.tif (Japan seismic intensity)<br>
a13.tif (Earthquake-induced earthquake)<br>

## Code flowchart
All code has already packed in __MainCode__<br>
Flowchart of code is shown below<br>
	1. LoadPicture.m  <br>
	2. Reclassify.m <br>
	3. FrHistcount.m<br>
	4. EntIgain.m<br>
	5. Frmethod.m<br>
	6. ANNDNNanalysis.m<br>
	6.1. ReduceSample<br>
	6.2. LearningAnnre<br>
	6.3. TestingAnnre<br>
	6.4 CovertRocToExcel<br>
	7. PRCpicture<br>
  8. RecoverModelLSM<br>

## Result of code
__LSMv0/AUCACCsenF/Result.xlxs__
