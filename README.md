This is a GUI to plot time-domain simulation data generated using Dome.


Requirements (python libraries):

    pandas. (for handling the data, particularly reading the CSV file)
    PyQt5. (for the GUI)
    matplotlib.
    sip.

How to use:

1) Convert the simulation results file "example.dat" to ascii format: "example_ascii.dat" with the usual --ascii parameter of dome command.

2) Combine the information of the LST file with the ASCII dat file to create a single .CSV with the simulation data where the column names are the names of the variables of the model. Note that by default, the column name for the time column is "time".
This is done by the command "dome_csv.sh".

The syntax would be: $ dome_csv.sh example

*This script will fail if the lst file is not in the same folder as the ascii data file.

3) Another script reads the CSV file with the results and opens the GUI.

The syntax would be $ python3 dome_gui_plotter.py example.csv.
