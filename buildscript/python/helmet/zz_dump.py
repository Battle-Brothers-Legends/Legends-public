import csv
from collections import defaultdict
from .defs import Defs

# Example data with different types of items grouped by "layer"
layers = Defs.layers

# Group items by the "layer" key
grouped_by_layer = defaultdict(list)
for layer in layers:
    grouped_by_layer[layer["layer"]].append(layer)

# Process each group and write it to a separate CSV file
for layer_name, group in grouped_by_layer.items():
    # Find all unique keys from all dictionaries in the group
    all_keys = set()
    for item in group:
        all_keys.update(item.keys())

    # Convert to a sorted list of keys (optional)
    all_keys = sorted(all_keys)

    # Define the filename for the CSV based on the layer
    filename = f'{layer_name}_layers.csv'

    # Open the file in write mode
    with open(filename, mode='w', newline='', encoding='utf-8') as file:
        # Create a CSV DictWriter object, which writes rows as dictionaries
        writer = csv.DictWriter(file, fieldnames=all_keys)

        # Write the header (fieldnames)
        writer.writeheader()

        # Write the data (each dictionary in the group)
        writer.writerows(group)

    print(f"Data written to {filename}")