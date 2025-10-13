# PDAC MIBI
**Spatial Proteomics Uncovers Immune Cell Neighborhoods and Tumor-Immune Interfaces in Pancreatic Ductal Adenocarcinoma**

Jason Yeung<sup>1,\*</sup>, Yunhao Bai<sup>2,3,\*</sup>, Huaying Qiu<sup>1</sup>, Yao Yu Yeo<sup>1,4</sup>, Yuzhou Chang<sup>1,5</sup>, Melissa S. F. Ng<sup>6</sup>, Lara Rosaline Heij<sup>7,8,9,10</sup>, Enas Abu Shah<sup>11</sup>, Qin Ma<sup>5</sup>, David Reiss<sup>12</sup>, Garry Nolan<sup>13</sup>, Shivan Sivakumar<sup>14,15,#</sup>, Sizun Jiang<sup>1,2,4,16,17,#</sup>

1. Center for Virology and Vaccine Research, Beth Israel Deaconess Medical Center, Harvard Medical School, Boston, MA, United States
2. Broad Institute of MIT and Harvard, Boston, MA, United States
3. Department of Stem Cell and Regenerative Biology, Harvard University, Boston, MA, United States
4. Program in Virology, Division of Medical Sciences, Harvard Medical School, Boston, MA, United States
5. Pelotonia Institute for Immuno-Oncology, The James Comprehensive Cancer Center, The Ohio State University, Columbus, OH, USA
6. Singapore Immunology Network (SIgN), Agency for Science, Technology and Research (A∗STAR), Singapore, Republic of Singapore
7. Department of General, Visceral and Transplantation Surgery, Universitats Klinikum Essen, Essen, Germany
8. Department of Pathology, Erasmus University Medical Center, Rotterdam, The Netherlands
9. Institute of Experimental Medicine and Systems Biology, RWTH Aachen University, Aachen, Germany
10. Institute of Pathology, University Hospital Essen, Essen, Germany
11. Kennedy Institute of Rheumatology, & Dunn School of Pathology, University of Oxford, Oxford, United Kingdom
12. Informatics and Predictive Sciences, Bristol Myers Squibb, Seattle, WA, United States
13. Department of Pathology, Stanford University, Stanford, CA, United States
14. Department of Immunology and Immunotherapy, School of Infection, Inflammation and Immunology, College of Medicine and Health, University of Birmingham, Birmingham, UK
15. Department of Oncology, Queen Elizabeth Hospital, University Hospitals of Birmingham NHS Trust, Mindelsohn Way, Birmingham, UK
16. Department of Pathology, Brigham and Women's Hospital, Harvard Medical School, Boston, MA, United States
17. Department of Pathology, Dana Farber Cancer Institute, Boston, MA, United States

\* Co-first authors  
\# Co-senior authors. Correspondence to s.sivakumar@bham.ac.uk or sjiang3@bidmc.harvard.edu
## Abstract

Pancreatic ductal adenocarcinoma (PDAC) remains one of the most lethal malignancies with dismal prognosis and limited treatment options. The complex interplay between tumor cells and their microenvironment contributes significantly to treatment resistance, yet technological challenges have hindered comprehensive spatial characterization of immune components in PDAC tissues. Here, we performed high-dimensional spatial proteomics using multiplexed ion beam imaging (MIBI) to quantify 32 protein markers across tissues from twelve treatment-naïve PDAC patients who subsequently underwent adjuvant chemotherapy. We achieved confident single-cell phenotypic mapping of the PDAC ecosystem through deep-learning based segmentation and expert-validated phenotypic annotation. Our analysis revealed significant enrichment of immunosuppressive myeloid populations and regulatory T cells in patients who eventually experienced disease relapse. Conversely, cytotoxic CD8+ T cells were depleted in these relapse-prone tumors. Using spatial probabilistic topic modeling, we identified eight distinct cellular neighborhoods with unique compositions and functional states, including the enrichment of distinct immune infiltrating neighborhoods in patients who remained relapse-free. Cell neighborhood interface analysis further demonstrated altered functional marker expression profiles at tumor-immune boundaries in relapsed versus non-relapsed patients. Our findings provide a high-resolution spatial atlas of the PDAC immune landscape and identify prognostic microenvironmental signatures that may inform the development of novel immunotherapeutic strategies for this recalcitrant disease.

## Code Overview

The following is an overview of the code in this repository. Please note that since this repository doesn't contain the necessary data that was used for the analysis, if one wishes to reproduce the result, one will need to download the data from Zenodo (10.5281/zenodo.15109931) and change the file path accordingly in the code.

| File Name | Description |
| :---------- | :---------- |
| Figure2.rmd | Scripts for generating plots as shown in Figure 2 |
| Figure3.rmd | Scripts for generating plots as shown in Figure 3 |
| Figure4.ipynb | Scripts for generating plots as shown in Figure 4 |
| cell_maps.Rmd | Script for generating cell annotation maps |
| model_fitting.Rmd | Scripts for fitting model in Figure 4 |
| model_fitting.html | Scripts for fitting model in Figure 4 |
| pdac_lda.ipynb | Notebook for running Spatial LDA and generating related plots |
| helpers/ | Helper scripts for generating plots in main figure scripts |
