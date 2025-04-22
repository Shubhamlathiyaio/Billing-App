import tkinter as tk
from tkinter import filedialog
import csv
import json

def select_and_convert():
    root = tk.Tk()
    root.withdraw()

    # Select input file
    file_path = filedialog.askopenfilename(
        title="Select CSV file",
        filetypes=(("CSV files", "*.csv"), ("All files", "*.*"))
    )

    if not file_path:
        print("No file selected.")
        return

    # Select output file
    output_path = filedialog.asksaveasfilename(
        title="Save Output CSV",
        defaultextension=".csv",
        filetypes=[("CSV files", "*.csv")]
    )

    if not output_path:
        print("No output file selected.")
        return

    all_json_rows = []

    with open(file_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        rows = list(reader)

        for row in rows[2:]:  # Skip header rows
            if row and row[-1]:
                items = []
                parts_list = row[-1].split('},{')  # Handle multiple objects
                parts_list = [p.strip('{}') for p in parts_list]

                for part in parts_list:
                    values = part.split(':')
                    if len(values) == 6:
                        item = {
                            "chalanNo": values[0],
                            "itemName": values[1],
                            "taka": values[2],
                            "hsnCode": values[3],
                            "qty": values[4],
                            "rate": values[5]
                        }
                        items.append(item)
                if items:
                    all_json_rows.append([json.dumps(items, ensure_ascii=False)])
                else:
                    print("⚠️ Skipped row due to bad format:", row[-1])

    # Write to new CSV file
    with open(output_path, 'w', newline='', encoding='utf-8') as outfile:
        writer = csv.writer(outfile)
        writer.writerow([""])
        writer.writerow(["[chalan, itemName, taka, hsnCode, qty, rate]"])
        writer.writerows(all_json_rows)

    print(f"✅ Output saved to: {output_path}")

if __name__ == "__main__":
    select_and_convert()
