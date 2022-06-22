# Bet_hedging_dormancy
To generate any of the figures, path_setup needs to be ran first.

The files in this folder are organized as follows:
- path_setup.m which needs to be ran first to set the path to current directory
- Manuscript which contains the latest version of the article in pdf form
- Generate figs which has all necessary code to generate all the figures
- Generate Data which has all necessary code to generate all the data for the figures
- Functions which has all the functions needed for Generate Data
- Figs which stores the final figures in the manuscript
- Data which sores the data generated in the scripts of Generate Data

To run the scripts from scratch, including generating the Data files, the 
number of runs can be changed in 'set_parameters.m'. With pars.n_runs = 1000
some scripts might take many hours or days to run depending on the computer