"""
Multiple Sequence Alignment
---

Code untuk membantu menyelesaikan soal 
multiple sequence alignment dengan 
menginput pivot sequence nya.

"""
import os
from pathlib import Path

os.chdir(Path(__file__).parent.absolute())

import numpy as np
from itertools import combinations
from tabulate import tabulate

def separator(cnt: int = 1):
    print("="* 14 * cnt, end="\n\n")

def build_result_matrix(seqs: list = [], match: int = 0, mismatch: int = 0, gap: int = 0):
    piv_mtx = np.matrix(seqs)
    [row, col] = piv_mtx.shape
    comb = list(combinations(range(row), 2))
    
    res_mtx = np.zeros([col, len(comb)], dtype=int)
    
    for i in range(col):
      for j in range(len(comb)):

        val1 = piv_mtx[comb[j][0], i]
        val2 = piv_mtx[comb[j][1], i]

        if val1 == '-' and val2 == '-':
          continue
        elif val1 == '-' or val2 == '-':
          res_mtx[i, j] = res_mtx[i, j] + gap
        elif val1 != val2:
          res_mtx[i, j] = res_mtx[i, j] + mismatch
        else:
          res_mtx[i, j] = res_mtx[i, j] + match
    
    sum_col = res_mtx.sum(axis=1)
    numbering = np.arange(1, col+1)
    return [np.column_stack((numbering, res_mtx, sum_col)), comb, sum_col]

if __name__ == "__main__":
  with open("multiseq.txt", "r") as f:
    
    lines = [line.strip() for line in f.readlines() if line.strip()]
    [match, mismatch, gap] = lines.pop(0).split(',')

    match = int(match, 10)
    mismatch = int(mismatch, 10)
    gap = int(gap, 10)

    seqs = [
      [y for y in x]
      for x in lines
    ]

    [result, comb, sum_col] = build_result_matrix(seqs, match, mismatch, gap)
    
    headers = ["No"] + comb + ["Jumlah"]
    table = tabulate(result, headers, tablefmt="fancy_grid")

    print()
    separator(len(comb))
    
    print("Matrix nilai : ", end="\n\n")
    print(table)
    
    print(f"==> Jumlah Total : {sum_col.sum()}", end="\n\n\n")
    separator(len(comb))
    print()

