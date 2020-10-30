"""
Pairwise Alignment
---

Code untuk membantu menyelesaikan soal 
pairwise alignment versi Needleman-Wunsch
"""
import os
from pathlib import Path

os.chdir(Path(__file__).parent.absolute())

import code
import numpy as np
from Bio import pairwise2
from Bio.pairwise2 import format_alignment
from tabulate import tabulate

def separator(cnt: int = 1):
    print("="* 14 * cnt, end="\n\n")

def matrix(s1, s2, match, mismatch, gap):
    seq1 = "x" + s1
    seq2 = "x" + s2
    mtx = [
        [0 for j in range(len(seq2))]
        for i in range(len(seq1))
    ]

    for i in range(len(seq1)):
        for j in range(len(seq2)):
            if i == 0 and j == 0:
                mtx[i][j] = 0
            elif i == 0:
                mtx[i][j] = mtx[i][j-1] + gap
            elif j == 0:
                mtx[i][j] = mtx[i-1][j] + gap
            else:
                mtx[i][j] = max(
                    mtx[i-1][j] + gap,
                    mtx[i][j-1] + gap,
                    mtx[i-1][j-1] + (match if seq1[i] == seq2[j] else mismatch)
                )

    # print matrix
    return mtx

if __name__ == "__main__":
    with open("pairwise.txt", "r") as f:

        lines = [line.strip() for line in f.readlines() if line.strip()]
        [match, mismatch, gap] = lines.pop(0).split(',')
        [X, Y] = lines

        match = int(match, 10)
        mismatch = int(mismatch, 10)
        gap = int(gap, 10)
        
        mtx = matrix(X,Y,match,mismatch,gap)
        print()
        separator(len(mtx[0]))
        print("Matrix nilai : ", end="\n\n")

        headers =  [""] + [x for x in X]
        numbering =  [""] + [y for y in Y]
        result = np.column_stack((numbering, mtx))
        table = tabulate(result, headers, tablefmt="fancy_grid")
        print(table)
        
        separator(len(mtx[0]))
        print()
        print("Hasil pairwise alignment : ", end="\n\n")

        alignments = pairwise2.align.globalms(X, Y, match, mismatch, gap, gap)

        # print 10 best pair if possible
        for i in range(min(10, len(alignments))):
            print(format_alignment(*alignments[i]))

        separator(len(mtx[0]))
        print()
