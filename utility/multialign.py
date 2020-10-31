from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Align import MultipleSeqAlignment

if __name__ == "__main__":
    with open("multialign.txt", "r") as f:
        lines = [line.strip() for line in f.readlines() if line.strip()]
        cnt = 0
        align = MultipleSeqAlignment([])
        for seq in lines:
            cnt += 1
            align.add_sequence(f"seq-{cnt}", seq)

        print(align)
