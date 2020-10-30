import code
from Bio import pairwise2
from Bio.pairwise2 import format_alignment

def separator():
    print("="*32, end="\n\n")

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
    print(
        '\n'.join([
            '\t'.join([str(cell) for cell in row]) 
            for row in result
        ])
    )

if __name__ == "__main__":
    separator()
    
    X = input("sequence 1: ")
    Y = input("sequence 2: ")
    match = int(input("match: "))
    mismatch = int(input("mismatch: "))
    gap = int(input("gap: "))
    
    separator()

    matrix(X,Y,match,mismatch,gap)

    separator()

    alignments = pairwise2.align.globalms(X, Y, match, mismatch, gap, gap)

    # print 5 best pair
    for i in range(min(5, len(alignments))):
        print(format_alignment(*alignments[i]))
