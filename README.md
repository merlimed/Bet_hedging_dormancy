# Bet_hedging_dormancy
The files in this folder are organized as follows:
 - 4 files '.m' starting with 'C_' which generate all the files in folder 'Data'
 - Functions folder which has all necessary functions to run all the scripts, 
    inlcuding a 'set_parameters.m' in which the parameters 'pars' can be changed
 - 6 'Fig' scripts and one 'Supp1' script which generate all the figures aside from the schematic
 - Figs folder which has all the figrues in pdf and ppx format

To run the scripts from scratch, including generating the Data files, the 
number of runs can be changed in 'set_parameters.m'. With pars.n_runs = 1000
some scripts might take many hours or days to run depending on the computer