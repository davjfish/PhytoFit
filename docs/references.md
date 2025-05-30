# References and data sources

**Bloom fitting models (Shifted Gaussian, Rate of Change, and Threshold methods):**  
[Layton, C., Devred, E., DeTracey B.. 2022. A comparison of phytoplankton spring bloom fitting methods using MODIS satellite-derived chlorophyll-a concentration for the Maritimes region. Can. Tech. Rep. Hydrogr. Ocean Sci. 340: vii + 22 p.](https://publications.gc.ca/collections/collection_2022/mpo-dfo/Fs97-18-340-eng.pdf)  

**Chlorophyll-a algorithm OCx:**  
[O'Reilly, John & Maritorena, S. & Mitchell, B.G. & Siegel, David & Carder, Kendall & Garver, S.A. & Kahru, Mati & Mcclain, Charles. (1998). Ocean color chlorophyll algorithms for SeaWiFS. Journal of Geophysical Research. 103. 937-953.](https://www.researchgate.net/publication/284463756_Ocean_color_chlorophyll_algorithms_for_SeaWiFS)   

**Chlorophyll-a algorithm GSM:**  
[Maritorena, Stéphane & Siegel, David & Peterson, Alan. (2002). Optimization of a semianalytical ocean color model for global-scale application. Applied optics. 41. 2705-14. 10.1364/AO.41.002705.](https://www.researchgate.net/publication/11345370_Optimization_of_a_semianalytical_ocean_color_model_for_global-scale_application)   

**Chlorophyll-a algorithms OCI, POLY4, and GSM_GS (regional tuning):**  
[Clay, S.; Peña, A.; DeTracey, B.; Devred, E. Evaluation of Satellite-Based Algorithms to Retrieve Chlorophyll-a Concentration in the Canadian Atlantic and Pacific Oceans. Remote Sens. 2019, 11, 2609.](https://www.mdpi.com/2072-4292/11/22/2609) 

**Chlorophyll-a algorithm EOF:**  
[Laliberté, J.; Larouche, P.; Devred, E.; Craig, S. Chlorophyll-a Concentration Retrieval in the Optically Complex Waters of the St. Lawrence Estuary and Gulf Using Principal Component Analysis. Remote Sens. 2018, 10, 265.](https://www.mdpi.com/2072-4292/10/2/265)

**Phytoplankton cell size model 1 (small/large cells):**  
[Devred, Emmanuel & Sathyendranath, S & Stuart, V & Maass, H & Ulloa, Osvaldo & Platt, T. (2006). A two-component model of phytoplankton absorption in the open ocean: Theory and applications. Journal of Geophysical Research. 111. 10.1029/2005JC002880.](https://www.researchgate.net/publication/229086123_A_two-component_model_of_phytoplankton_absorption_in_the_open_ocean_Theory_and_applications)    

**Phytoplankton cell size model 2 (small/medium/large cells):**  
[Devred, Emmanuel & Sathyendranath, Shubha & Stuart, Venetia & Platt, Trevor. (2011). A three component classification of phytoplankton absorption spectra: Application to ocean-color data. Remote Sensing of Environment - REMOTE SENS ENVIRON. 115. 2255-2266. 10.1016/j.rse.2011.04.025.](https://www.researchgate.net/publication/251494326_A_three_component_classification_of_phytoplankton_absorption_spectra_Application_to_ocean-color_data) 

**Phytoplankton cell size models (updated coefficients):**  
[Liu, Xiaohan & Devred, Emmanuel & Johnson, Catherine. (2018). Remote Sensing of Phytoplankton Size Class in Northwest Atlantic from 1998 to 2016: Bio-Optical Algorithms Comparison and Application. Remote Sensing. 10. 10.3390/rs10071028.](https://www.researchgate.net/publication/326033452_Remote_Sensing_of_Phytoplankton_Size_Class_in_Northwest_Atlantic_from_1998_to_2016_Bio-Optical_Algorithms_Comparison_and_Application#pf18) 

**Raw data:**  
Daily level-3 binned files are downloaded from [NASA OBPG](https://oceancolor.gsfc.nasa.gov), and weekly composites are generated by taking a simple arithmetic average of each pixel over the selected composite period (e.g. 4 days or 8 days). The binned data is used for statistics and bloom fitting, projected onto a regular grid on the map for display.

[NASA OCI chlorophyll-a algorithm](https://oceancolor.gsfc.nasa.gov/resources/atbd/chlor_a)  
[Level-3 binned files](https://oceancolor.gsfc.nasa.gov/l3)  
[Binning scheme](https://oceancolor.gsfc.nasa.gov/resources/docs/format/l3bins)  
[Level-2 and 3 default flags](https://oceancolor.gsfc.nasa.gov/resources/atbd/ocl2flags)  (PhytoFit data uses these default flags + FILTER flag)
