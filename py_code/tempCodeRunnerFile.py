import tkinter as tk
from tkinter import filedialog
import csv
import json

root = tk.Tk()
root.withdraw()

file_path = filedialog.askopenfilename(
    initialdir="~/Desktop",
    title="Select CSV file",
    filetypes=(("CSV files", "*.csv"), ("All files", "*.*"))
)

if file_path:
    print(f"Selected file: {file_path}")
    with open(file_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        rows = list(reader)

        for row in rows[2:]:  # Skip headers
            if row and row[-1]:  # Check last column exists
                parts = row[-1].split(':')
                if len(parts) == 6:
                    item = {
                        "chalanNo": parts[0],
                        "itemName": parts[1],
                        "taka": parts[2],
                        "hsnCode": parts[3],
                        "qty": parts[4],
                        "rate": parts[5]
                    }
                    print(json.dumps([item], ensure_ascii=False))
                else:
                    print("⚠️ Skipped row due to unexpected format:", row[-1])
else:
    print("No file selected.")
