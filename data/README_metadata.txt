Data structure and metadata:

Files
- species_site_occ.csv

Bird occurrence (0 to 4 detections) of 180 species in 92 sites, 23 landscapes (4 sites per landscape).

Species code follows the "sp" column in species_information.csv file.
Sites and landscape code follows the columns "site" and "landscape", respectively, in sites_information.csv file.

- sites_information.csv

Site information:

matrix: matrix quality classification, high_quality and low_quality
landscape: landscape code
site: site code
latitude: site latitude in decimal degree, coordinate system WGS84 
longitude: site longitude in decimal degree, coordinate system WGS84
n.visit: number of visits in each site, there is only one site with less than 4 visits (3,  "215.P35")
forest_site400: local forest cover from a circular buffer of 400m around site.
forest_site600: local forest cover from a circular buffer of 600m around site.
forest_site800: local forest cover from a circular buffer of 800m around site.

- landscapes_information.csv

Land uses for the landscapes, buffer 2km around the centroid of the landscape.


matrix: matrix quality classification, high_quality and low_quality
landscape: landscape code 
latitude: latitude in decimal degree for the centroid of the landscape, coordinate system WGS84 
longitude: longitude in decimal degree for the centroid of the landscape, coordinate system WGS84

Land use covers in percentage of area from a circular buffer of 2 km around the centroid of the landscape for 8 land use types:

forest
pasture
coffee
eucalyptus
sugarcane
urban
Water
other



- species_information.csv

For the sources of information on traits, please, see references in Appendix 2.

Species names and trait information:

common_name: English common name of the species
species_name: Species name
sp: species code
habitat_specif: habitat specificity of the species, (forest) generalist and (forest) specialist.
body_size: mean body weight of the species in grams
diet: main diet
nest: main nest type
stratum: main foraging stratum
frugivory: percentage of fruits in diet
insectivory: percentage of insects in diet
lower_stratum: percentage of use of lower foraging stratum
Handwing: Hand-wing index 




