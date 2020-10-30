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
from Bio import pairwise2
from Bio.pairwise2 import format_alignment

def separator(cnt: int = 1):
    print("="* 14 * cnt, end="\n\n")

def matrix(s1, s2, match, mismatch, gap):
    seq1 = "x" + s1
    seq2 = "x" + s2
    result = [
        [0 for j in range(len(seq2))]
        for i in range(len(seq1))
    ]

    for i in range(len(seq1)):
        for j in range(len(seq2)):
            if i == 0 and j == 0:
                result[i][j] = 0
            elif i == 0:
                result[i][j] = result[i][j-1] + gap
            elif j == 0:
                result[i][j] = result[i-1][j] + gap
            else:
                result[i][j] = max(
                    result[i-1][j] + gap,
                    result[i][j-1] + gap,
                    result[i-1][j-1] + (match if seq1[i] == seq2[j] else mismatch)
                )

    # print matrix
    return result

if __name__ == "__main__":
    with open("pairwise.txt", "r") as f:

        lines = [line.strip() for line in f.readlines() if line.strip()]
        [match, mismatch, gap] = lines.pop(0).split(',')
        [X, Y] = lines

        match = int(match)
        mismatch = int(mismatch)
        gap = int(gap)
        
        result = matrix(X,Y,match,mismatch,gap)
        separator(len(result[0]))
        print(
            '\n\n'.join([
                '\t|\t'.join([str(cell) for cell in row]) 
                for row in result
            ])
        )
        separator(len(result[0]))

        alignments = pairwise2.align.globalms(X, Y, match, mismatch, gap, gap)

        # print 10 best pair if possible
        for i in range(min(10, len(alignments))):
            print(format_alignment(*alignments[i]))
