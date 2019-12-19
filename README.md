# reproducible_code_training

Version 0.1.0

here I will put all the scripts and data used and created in the course reproducible code writing


## Project organization

###What does the project do?

This script was designed to add **gene names** to genomic positions in output from the **structural variation caller Manta**.
It requires a *txt* input file, **the *vcf exported by Manta* therefore needs to be parsed and saved as *txt***. 
The gene names can help you filter the, often extensive, output provided by Manta.

### Before starting

Download the get_genes.R script from github/training_19-12-19/src.
For privacy reasons, I cannot share my input data here. 
The input data should at least contain three columns: chromosome (CHROM), start position (POS), end position (END). 
Make sure the column names match the names between the brackets. 
To run the script, change the input and output directories. 
For versioning and dependencies, please refer to requirements.txt
.
├── .gitignore
├── CITATION.md
├── LICENSE.md
├── README.md
├── requirements.txt
├── bin                <- Compiled and external code, ignored by git (PG)
│   └── external       <- Any external source code, ignored by git (RO)
├── config             <- Configuration files (HW)
├── data               <- All project data, ignored by git
│   ├── processed      <- The final, canonical data sets for modeling. (PG)
│   ├── raw            <- The original, immutable data dump. (RO)
│   └── temp           <- Intermediate data that has been transformed. (PG)
├── docs               <- Documentation notebook for users (HW)
│   ├── manuscript     <- Manuscript source, e.g., LaTeX, Markdown, etc. (HW)
│   └── reports        <- Other project reports and notebooks (e.g. Jupyter, .Rmd) (HW)
├── results
│   ├── figures        <- Figures for the manuscript or reports (PG)
│   └── output         <- Other output for the manuscript or reports (PG)
└── src                <- Source code for this project (HW)

```


## License

This project is licensed under the terms of the [MIT License](/LICENSE.md)

## Citation

Please [cite this project as described here](/CITATION.md).
