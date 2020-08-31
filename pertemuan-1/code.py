from pathlib import Path
import csv
import os

"""
Mengganti working directory ke file ini
"""
os.chdir(Path(__file__).parent.absolute())


"""
Mengambil data nama-nama asam amino
dari file amino-acid.csv
"""
amino_name = {}
with open("amino-acid.csv") as file:
    reader = csv.DictReader(file)
    for row in reader:
        amino_name[row["kode1"]] = row["nama"]

"""
Variable untuk menyimpan nilai-nilai 
asam amino
"""
amino_data = {}


def read_from_file(filename, result):
    """
    Fungsi untuk mencari persentase asam 
    amino dari file yang diberikan
    """
    with open(filename, "r") as file:
        """
        Ambil nama asam amino
        """
        name = file.readline().split("|")[0][1:]

        """
        Ambil sequence karakternya dan 
        hitung persentase tiap karakter
        """
        sequence = [char for char in file.readline().rstrip("\r\n")]
        percentage = {}
        for char in set(sequence):
            percentage[char] = 0
        for char in sequence:
            percentage[char] += 1
        for char in set(sequence):
            percentage[char] /= len(sequence)

        """
        Simpan hasil pada variabel
        """
        result[name] = percentage


"""
Mencari persentasi asam amino 3W6A
"""
read_from_file("rcsb_pdb_3W6A.fasta", amino_data)

"""
Mencari persentasi asam amino 3BEQ
"""
read_from_file("rcsb_pdb_3BEQ.fasta", amino_data)

"""
Mencari persentasi asam amino 2LW7
"""
read_from_file("rcsb_pdb_2LW7.fasta", amino_data)

"""
Menampilkan hasil
"""
for name in amino_data:
    print(f"Kode: {name}")
    for data in amino_data[name]:
        print(f"{amino_name[data]}: {amino_data[name][data]}")
    print()

"""
Referensi:
[-] https://www.rcsb.org/
[-] http://www.fao.org/3/y2775e/y2775e0e.htm
"""
