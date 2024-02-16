#!/bin/bash

# Set default values
file=""

# Function to display help
function display_help {
    echo "Usage: dome_csv [-h] file"
    echo "Options:"
    echo "  -h, --help                      Show this help message"
    echo "  file                            Name of the model"
    exit 0
}

file="$1"

# Optional parameters
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -h|--help)
        display_help
        ;;
        *)    # unknown option
        shift
        ;;
    esac
done

python -c "import os;
import pandas as pd;
import subprocess;
import platform;
import os;
def from_dome_ascii(file):
    df = pd.read_csv(file, sep=' ', header=None);
    df = df.rename(columns={0: 'time'});
    df = df.dropna(how='all', axis=1);
    return df;
def from_dome_lst(file):
    df = pd.read_csv(file, sep=',', header=None, skiprows=1, index_col=0);
    df.columns = ['var', 'latex_var', 'unit', 'base'];
    return df;
def rename_vars(df_lst, df):
    varnames = df_lst['var'].str.strip(' ');
    varnames = varnames.str.replace(' ', '_');
    return df.rename(columns=varnames);
filename = '$file'
filename_lst = filename + '.lst';
filename_dat = filename + '_ascii.dat';
if not os.path.exists(filename_lst):
    raise FileNotFoundError(f'The file {filename_lst} does not exist.')
if not os.path.exists(filename_dat):
    raise FileNotFoundError(f'The file {filename_dat} does not exist.')
df_lst = from_dome_lst(filename_lst);
df = rename_vars(df_lst, from_dome_ascii(filename_dat));
df.to_csv('$file' + '.csv', index=False);
print(f'Generated $file.csv')
"