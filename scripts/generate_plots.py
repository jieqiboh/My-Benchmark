import numpy as np
import matplotlib.pyplot as plt
import glob
import pandas as pd

folder_path = './output/*.csv'  # Specify the folder path and file extension
save_path = './output/plots/'

# Get a list of all CSV files in the folder
csv_files = glob.glob(folder_path)

def parseInputs(file): #generates an array of arrays for bodysize, qps and tp99, tp999
    f = open(file, "r")

    lines = f.read().split('\n')

    data = [line.split(',') for line in lines if line]

    bodysizes = [arr[2] for arr in data]

    qps = [arr[3] for arr in data]

    tp99 = [arr[4] for arr in data]

    tp999 = [arr[5] for arr in data]

    return [bodysizes, qps, tp99, tp999]

def dataToBodyQPSPlot(data, name):
    bodysizes = [float(value) for value in data[0]]
    qps = [float(value) for value in data[1]]

    # Plot the graph
    plt.plot(bodysizes, qps, marker='o')
    plt.xlabel('bodysize (bytes)')
    plt.ylabel('qps')
    plt.title(name)
    plt.grid(True)
    
    # Save the plot as a PNG file
    plt.savefig(save_path + "/" + name + "_qps")

    # Display the graph
    plt.show()

def dataToBodyTP99Plot(data, name):
    bodysizes = [float(value) for value in data[0]]
    tp99 = [float(value) for value in data[2]]

    # Plot the graph
    plt.plot(bodysizes, tp99, marker='o')
    plt.xlabel('bodysize (bytes)')
    plt.ylabel('tp99')
    plt.title(name)
    plt.grid(True)
    
    # Save the plot as a PNG file
    plt.savefig(save_path + "/" + name + "_tp99")

    # Display the graph
    plt.show()

# Iterate over the CSV files and read them into a list of DataFrames
data_frames = []
for file in csv_files:
    data = parseInputs(file)
    name = file.split('/')[-1].split('.')[0]
    dataToBodyQPSPlot(data, name)
    dataToBodyTP99Plot(data, name)
    